From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri,  4 Sep 2020 15:53:30 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 5/6] ice,
 xsk: finish napi loop if AF_XDP Rx queue is full
In-Reply-To: <20200904135332.60259-1-bjorn.topel@gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
Message-ID: <20200904135332.60259-6-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Make the AF_XDP zero-copy path aware that the reason for redirect
failure was due to full Rx queue. If so, exit the napi loop as soon as
possible (exit the softirq processing), so that the userspace AF_XDP
process can hopefully empty the Rx queue. This mainly helps the "one
core scenario", where the userland process and Rx softirq processing
is on the same core.

Note that the early exit can only be performed if the "need wakeup"
feature is enabled, because otherwise there is no notification
mechanism available from the kernel side.

This requires that the driver starts using the newly introduced
xdp_do_redirect_ext() and xsk_do_redirect_rx_full() functions.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 797886524054..f698d0199b0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -502,13 +502,15 @@ ice_construct_skb_zc(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
  * ice_run_xdp_zc - Executes an XDP program in zero-copy path
  * @rx_ring: Rx ring
  * @xdp: xdp_buff used as input to the XDP program
+ * @early_exit: true means that the napi loop should exit early
  *
  * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
  */
 static int
-ice_run_xdp_zc(struct ice_ring *rx_ring, struct xdp_buff *xdp)
+ice_run_xdp_zc(struct ice_ring *rx_ring, struct xdp_buff *xdp, bool *early_exit)
 {
 	int err, result = ICE_XDP_PASS;
+	enum bpf_map_type map_type;
 	struct bpf_prog *xdp_prog;
 	struct ice_ring *xdp_ring;
 	u32 act;
@@ -529,8 +531,13 @@ ice_run_xdp_zc(struct ice_ring *rx_ring, struct xdp_buff *xdp)
 		result = ice_xmit_xdp_buff(xdp, xdp_ring);
 		break;
 	case XDP_REDIRECT:
-		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? ICE_XDP_REDIR : ICE_XDP_CONSUMED;
+		err = xdp_do_redirect_ext(rx_ring->netdev, xdp, xdp_prog, &map_type);
+		if (err) {
+			*early_exit = xsk_do_redirect_rx_full(err, map_type);
+			result = ICE_XDP_CONSUMED;
+		} else {
+			result = ICE_XDP_REDIR;
+		}
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
@@ -558,8 +565,8 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = ICE_DESC_UNUSED(rx_ring);
+	bool early_exit = false, failure = false;
 	unsigned int xdp_xmit = 0;
-	bool failure = false;
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		union ice_32b_rx_flex_desc *rx_desc;
@@ -597,7 +604,7 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 		rx_buf->xdp->data_end = rx_buf->xdp->data + size;
 		xsk_buff_dma_sync_for_cpu(rx_buf->xdp, rx_ring->xsk_pool);
 
-		xdp_res = ice_run_xdp_zc(rx_ring, rx_buf->xdp);
+		xdp_res = ice_run_xdp_zc(rx_ring, rx_buf->xdp, &early_exit);
 		if (xdp_res) {
 			if (xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))
 				xdp_xmit |= xdp_res;
@@ -610,6 +617,8 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 			cleaned_count++;
 
 			ice_bump_ntc(rx_ring);
+			if (early_exit)
+				break;
 			continue;
 		}
 
@@ -646,12 +655,12 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 	ice_update_rx_ring_stats(rx_ring, total_rx_packets, total_rx_bytes);
 
 	if (xsk_uses_need_wakeup(rx_ring->xsk_pool)) {
-		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
+		if (early_exit || failure || rx_ring->next_to_clean == rx_ring->next_to_use)
 			xsk_set_rx_need_wakeup(rx_ring->xsk_pool);
 		else
 			xsk_clear_rx_need_wakeup(rx_ring->xsk_pool);
 
-		return (int)total_rx_packets;
+		return early_exit ? 0 : (int)total_rx_packets;
 	}
 
 	return failure ? budget : (int)total_rx_packets;
-- 
2.25.1

