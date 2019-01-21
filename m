From: bjorn.topel@gmail.com <bjorn.topel@gmail.com>
Date: Mon, 21 Jan 2019 17:33:56 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: replace switch-statement with
 if-clause
Message-ID: <20190121163356.31332-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

GCC will generate jump tables for switch-statements with more than 5
case statements. An entry into the jump table is an indirect call,
which means that for CONFIG_RETPOLINE builds, this is rather
expensive.

This commit replaces the switch-statement that acts on the XDP program
result with an if-clause.

The if-clause was also refactored into a common function that can be
used by AF_XDP zero-copy and non-zero-copy code.

Performance prior this patch:
$ sudo ./xdp_rxq_info --dev enp134s0f0 --action XDP_DROP
Running XDP on dev:enp134s0f0 (ifindex:7) action:XDP_DROP options:no_touch
XDP stats       CPU     pps         issue-pps
XDP-RX CPU      20      18983018    0
XDP-RX CPU      total   18983018

RXQ stats       RXQ:CPU pps         issue-pps
rx_queue_index   20:20  18983012    0
rx_queue_index   20:sum 18983012

$ sudo ./xdpsock -i enp134s0f0 -q 20 -n 2 -z -r
 sock0 at enp134s0f0:20 rxdrop
                pps         pkts        2.00
rx              14,641,496  144,751,092
tx              0           0

And after:
$ sudo ./xdp_rxq_info --dev enp134s0f0 --action XDP_DROP
Running XDP on dev:enp134s0f0 (ifindex:7) action:XDP_DROP options:no_touch
XDP stats       CPU     pps         issue-pps
XDP-RX CPU      20      24000986    0
XDP-RX CPU      total   24000986

RXQ stats       RXQ:CPU pps         issue-pps
rx_queue_index   20:20  24000985    0
rx_queue_index   20:sum 24000985

  +26%

$ sudo ./xdpsock -i enp134s0f0 -q 20 -n 2 -z -r
 sock0 at enp134s0f0:20 rxdrop
                pps         pkts        2.00
rx              17,623,578  163,503,263
tx              0           0

  +20%

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 31 ++++---------------
 .../ethernet/intel/i40e/i40e_txrx_common.h    | 27 ++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 24 ++------------
 3 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index a7e14e98889f..b339b7ee6380 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2,7 +2,6 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/prefetch.h>
-#include <linux/bpf_trace.h>
 #include <net/xdp.h>
 #include "i40e.h"
 #include "i40e_trace.h"
@@ -2195,41 +2194,23 @@ int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring)
 static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 				    struct xdp_buff *xdp)
 {
-	int err, result = I40E_XDP_PASS;
-	struct i40e_ring *xdp_ring;
 	struct bpf_prog *xdp_prog;
+	int result;
 	u32 act;
 
 	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
-	if (!xdp_prog)
+	if (!xdp_prog) {
+		result = I40E_XDP_PASS;
 		goto xdp_out;
+	}
 
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
-	switch (act) {
-	case XDP_PASS:
-		break;
-	case XDP_TX:
-		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
-		result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
-		break;
-	case XDP_REDIRECT:
-		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
-		break;
-	default:
-		bpf_warn_invalid_xdp_action(act);
-		/* fall through */
-	case XDP_ABORTED:
-		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
-		/* fall through -- handle aborts by dropping packet */
-	case XDP_DROP:
-		result = I40E_XDP_CONSUMED;
-		break;
-	}
+	i40e_xdp_do_action(act, &result, rx_ring, xdp, xdp_prog);
+
 xdp_out:
 	rcu_read_unlock();
 	return ERR_PTR(-result);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index 8af0e99c6c0d..8cc4d8365f9e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -4,6 +4,8 @@
 #ifndef I40E_TXRX_COMMON_
 #define I40E_TXRX_COMMON_
 
+#include <linux/bpf_trace.h>
+
 void i40e_fd_handle_status(struct i40e_ring *rx_ring,
 			   union i40e_rx_desc *rx_desc, u8 prog_id);
 int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring);
@@ -88,4 +90,29 @@ void i40e_xsk_clean_rx_ring(struct i40e_ring *rx_ring);
 void i40e_xsk_clean_tx_ring(struct i40e_ring *tx_ring);
 bool i40e_xsk_any_rx_ring_enabled(struct i40e_vsi *vsi);
 
+static inline void i40e_xdp_do_action(u32 act, int *result,
+				      struct i40e_ring *rx_ring,
+				      struct xdp_buff *xdp,
+				      struct bpf_prog *xdp_prog)
+{
+	struct i40e_ring *xdp_ring;
+	int err;
+
+	if (act == XDP_TX) {
+		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
+		*result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
+	} else if (act == XDP_REDIRECT) {
+		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
+		*result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
+	} else if (act == XDP_PASS) {
+		*result = I40E_XDP_PASS;
+	} else if (act == XDP_DROP) {
+		*result = I40E_XDP_CONSUMED;
+	} else {
+		if (act != XDP_ABORTED)
+			bpf_warn_invalid_xdp_action(act);
+		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
+		*result = I40E_XDP_CONSUMED;
+	}
+}
 #endif /* I40E_TXRX_COMMON_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 870cf654e436..1ed56475ec78 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -282,9 +282,8 @@ int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
  **/
 static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 {
-	int err, result = I40E_XDP_PASS;
-	struct i40e_ring *xdp_ring;
 	struct bpf_prog *xdp_prog;
+	int result;
 	u32 act;
 
 	rcu_read_lock();
@@ -294,26 +293,7 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	xdp->handle += xdp->data - xdp->data_hard_start;
-	switch (act) {
-	case XDP_PASS:
-		break;
-	case XDP_TX:
-		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
-		result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
-		break;
-	case XDP_REDIRECT:
-		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
-		break;
-	default:
-		bpf_warn_invalid_xdp_action(act);
-	case XDP_ABORTED:
-		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
-		/* fallthrough -- handle aborts by dropping packet */
-	case XDP_DROP:
-		result = I40E_XDP_CONSUMED;
-		break;
-	}
+	i40e_xdp_do_action(act, &result, rx_ring, xdp, xdp_prog);
 	rcu_read_unlock();
 	return result;
 }
-- 
2.19.1

