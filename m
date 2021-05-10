From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 10 May 2021 11:38:49 +0200
Subject: [Intel-wired-lan] [PATCH intel-net v2 1/6] i40e: add correct
 exception tracing for XDP
In-Reply-To: <20210510093854.31652-1-magnus.karlsson@gmail.com>
References: <20210510093854.31652-1-magnus.karlsson@gmail.com>
Message-ID: <20210510093854.31652-2-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Add missing exception tracing to XDP when a number of different errors
can occur. The support was only partial. Several errors where not
logged which would confuse the user quite a lot not knowing where and
why the packets disappeared.

Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
Fixes: 0a714186d3c0 ("i40e: add AF_XDP zero-copy Rx support")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 7 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index de70c16ef619..b883ab809df3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2313,15 +2313,20 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	case XDP_TX:
 		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
 		result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
+		if (result == I40E_XDP_CONSUMED)
+			goto out_failure;
 		break;
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
+		if (err)
+			goto out_failure;
+		result = I40E_XDP_REDIR;
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
 	case XDP_ABORTED:
+out_failure:
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
 		fallthrough; /* handle aborts by dropping packet */
 	case XDP_DROP:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 46d884417c63..68f177a86403 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -162,9 +162,10 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 
 	if (likely(act == XDP_REDIRECT)) {
 		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
+		if (err)
+			goto out_failure;
 		rcu_read_unlock();
-		return result;
+		return I40E_XDP_REDIR;
 	}
 
 	switch (act) {
@@ -173,11 +174,14 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	case XDP_TX:
 		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
 		result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
+		if (result == I40E_XDP_CONSUMED)
+			goto out_failure;
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
 	case XDP_ABORTED:
+out_failure:
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
 		fallthrough; /* handle aborts by dropping packet */
 	case XDP_DROP:
-- 
2.29.0

