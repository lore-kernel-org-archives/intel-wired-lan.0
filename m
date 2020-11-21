From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 20 Nov 2020 16:39:30 -0800
Subject: [Intel-wired-lan] [PATCH S54 06/14] ice: Optimize AF_XDP zero-copy
 TX completion path
In-Reply-To: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
References: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
Message-ID: <20201121003938.48514-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

Improve the performance of the AF_XDP zero-copy Tx completion path.
When there are no XDP buffers being sent using XDP_TX or XDP_REDIRECT,
we do not have go through the SW ring to clean up any entries since
the AF_XDP path does not use these. In these cases, just fast forward
the next-to-use counter and skip going through the SW ring.

Removed an unused 1bit field in struct ice_ring 'ring_active' and used
the 16bit hole in the 2nd cache line for the newly introduced field
'xdp_tx_active' to track XDP buffers that are being set using XDP_TX or
XDP_REDIRECT.

This is based on a similar patch for i40e by Magnus Karlsson.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c      |  2 --
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 -
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  3 +--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 17 ++++++++++++++---
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1288a7718f34..4a6ad5ca99e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1263,7 +1263,6 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 
 		ring->q_index = i;
 		ring->reg_idx = vsi->txq_map[i];
-		ring->ring_active = false;
 		ring->vsi = vsi;
 		ring->dev = dev;
 		ring->count = vsi->num_tx_desc;
@@ -1281,7 +1280,6 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 
 		ring->q_index = i;
 		ring->reg_idx = vsi->rxq_map[i];
-		ring->ring_active = false;
 		ring->vsi = vsi;
 		ring->netdev = vsi->netdev;
 		ring->dev = dev;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fe2dd773902a..617e5c5f42cb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2279,7 +2279,6 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
 
 		xdp_ring->q_index = xdp_q_idx;
 		xdp_ring->reg_idx = vsi->txq_map[xdp_q_idx];
-		xdp_ring->ring_active = false;
 		xdp_ring->vsi = vsi;
 		xdp_ring->netdev = NULL;
 		xdp_ring->dev = dev;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index d7ca82871b7c..471c098b3dfb 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -275,8 +275,6 @@ struct ice_ring {
 	u16 q_index;			/* Queue number of ring */
 	u16 q_handle;			/* Queue handle per TC */
 
-	u8 ring_active:1;		/* is ring online or not */
-
 	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
 
@@ -287,6 +285,7 @@ struct ice_ring {
 		u16 next_to_alloc;
 		u16 next_rs_idx;
 	};
+	u16 xdp_tx_active;
 
 	/* stats structs */
 	struct ice_q_stats	stats;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index bc2f4390b51d..6da78be9ae8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -240,6 +240,7 @@ int ice_xmit_xdp_ring(void *data, u16 size, struct ice_ring *xdp_ring)
 	 */
 	smp_wmb();
 
+	xdp_ring->xdp_tx_active++;
 	i++;
 	if (i == xdp_ring->count)
 		i = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index d32a8c338366..793e39e30d4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -616,6 +616,7 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
  */
 static bool ice_xmit_zc(struct ice_ring *xdp_ring, int budget)
 {
+	unsigned int sent_frames = 0, total_bytes = 0;
 	struct ice_tx_desc *tx_desc = NULL;
 	u16 ntu = xdp_ring->next_to_use;
 	struct xdp_desc desc;
@@ -644,6 +645,8 @@ static bool ice_xmit_zc(struct ice_ring *xdp_ring, int budget)
 		ntu++;
 		if (ntu == xdp_ring->count)
 			ntu = 0;
+		sent_frames++;
+		total_bytes += tx_buf->bytecount;
 	}
 
 	if (tx_desc) {
@@ -653,6 +656,7 @@ static bool ice_xmit_zc(struct ice_ring *xdp_ring, int budget)
 			cpu_to_le64(ICE_TX_DESC_CMD_RS << ICE_TXD_QW1_CMD_S);
 		ice_xdp_ring_update_tail(xdp_ring);
 		xsk_tx_release(xdp_ring->xsk_pool);
+		ice_update_tx_ring_stats(xdp_ring, sent_frames, total_bytes);
 	}
 
 	return budget > 0;
@@ -667,6 +671,7 @@ static void
 ice_clean_xdp_tx_buf(struct ice_ring *xdp_ring, struct ice_tx_buf *tx_buf)
 {
 	xdp_return_frame((struct xdp_frame *)tx_buf->raw_buf);
+	xdp_ring->xdp_tx_active--;
 	dma_unmap_single(xdp_ring->dev, dma_unmap_addr(tx_buf, dma),
 			 dma_unmap_len(tx_buf, len), DMA_TO_DEVICE);
 	dma_unmap_len_set(tx_buf, len, 0);
@@ -701,6 +706,11 @@ bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring)
 	if (!frames_ready)
 		goto out_xmit;
 
+	if (likely(!xdp_ring->xdp_tx_active)) {
+		xsk_frames = frames_ready;
+		goto skip;
+	}
+
 	for (i = 0; i < frames_ready; i++) {
 		tx_buf = &xdp_ring->tx_buf[ntc];
 
@@ -718,13 +728,14 @@ bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring)
 			ntc = 0;
 	}
 
-	xdp_ring->next_to_clean = ntc;
+skip:
+	xdp_ring->next_to_clean += frames_ready;
+	if (unlikely(xdp_ring->next_to_clean >= xdp_ring->count))
+		xdp_ring->next_to_clean -= xdp_ring->count;
 
 	if (xsk_frames)
 		xsk_tx_completed(xdp_ring->xsk_pool, xsk_frames);
 
-	ice_update_tx_ring_stats(xdp_ring, frames_ready, total_bytes);
-
 out_xmit:
 	if (xsk_uses_need_wakeup(xdp_ring->xsk_pool))
 		xsk_set_tx_need_wakeup(xdp_ring->xsk_pool);
-- 
2.20.1

