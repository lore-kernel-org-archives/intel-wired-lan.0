From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed,  2 Dec 2020 16:07:22 +0100
Subject: [Intel-wired-lan] [PATCH net-next 1/3] i40: optimize for
 XDP_REDIRECT in xsk path
In-Reply-To: <20201202150724.31439-1-magnus.karlsson@gmail.com>
References: <20201202150724.31439-1-magnus.karlsson@gmail.com>
Message-ID: <20201202150724.31439-2-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Optimize i40e_run_xdp_zc() for the XDP program verdict being
XDP_REDIRECT in the zsk zero-copy path. This path is only used when
having AF_XDP zero-copy on and in that case most packets will be
directed to user space. This provides a little over 100k extra packets
in throughput on my server when running l2fwd in xdpsock.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 67febc7b6798..fbf76c67d77d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -159,6 +159,13 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
+	if (likely(act == XDP_REDIRECT)) {
+		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
+		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
+		rcu_read_unlock();
+		return result;
+	}
+
 	switch (act) {
 	case XDP_PASS:
 		break;
@@ -166,10 +173,6 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
 		result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
 		break;
-	case XDP_REDIRECT:
-		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
-		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
-- 
2.29.0

