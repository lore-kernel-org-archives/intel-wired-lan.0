From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 22 Mar 2018 10:03:07 +0100
Subject: [Intel-wired-lan] [PATCH v2 2/2] i40e: add support for XDP_REDIRECT
In-Reply-To: <20180322090307.14409-1-bjorn.topel@gmail.com>
References: <20180322090307.14409-1-bjorn.topel@gmail.com>
Message-ID: <20180322090307.14409-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The driver now acts upon the XDP_REDIRECT return action. Two new ndos
are implemented, ndo_xdp_xmit and ndo_xdp_flush.

XDP_REDIRECT action enables XDP program to redirect frames to other
netdevs.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 74 +++++++++++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +
 3 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 79ab52276d12..2fb4261b4fd9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11815,6 +11815,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_bridge_getlink	= i40e_ndo_bridge_getlink,
 	.ndo_bridge_setlink	= i40e_ndo_bridge_setlink,
 	.ndo_bpf		= i40e_xdp,
+	.ndo_xdp_xmit		= i40e_xdp_xmit,
+	.ndo_xdp_flush		= i40e_xdp_flush,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2f817d1466eb..0168611312df 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2214,7 +2214,7 @@ static int i40e_xmit_xdp_ring(struct xdp_buff *xdp,
 static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 				    struct xdp_buff *xdp)
 {
-	int result = I40E_XDP_PASS;
+	int err, result = I40E_XDP_PASS;
 	struct i40e_ring *xdp_ring;
 	struct bpf_prog *xdp_prog;
 	u32 act;
@@ -2233,6 +2233,10 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
 		result = i40e_xmit_xdp_ring(xdp, xdp_ring);
 		break;
+	case XDP_REDIRECT:
+		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
+		result = !err ? I40E_XDP_TX : I40E_XDP_CONSUMED;
+		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 	case XDP_ABORTED:
@@ -2268,6 +2272,15 @@ static void i40e_rx_buffer_flip(struct i40e_ring *rx_ring,
 #endif
 }
 
+static inline void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
+{
+	/* Force memory writes to complete before letting h/w
+	 * know there are new descriptors to fetch.
+	 */
+	wmb();
+	writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
+}
+
 /**
  * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
  * @rx_ring: rx descriptor ring to transact packets on
@@ -2402,16 +2415,11 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	}
 
 	if (xdp_xmit) {
-		struct i40e_ring *xdp_ring;
+		struct i40e_ring *xdp_ring =
+			rx_ring->vsi->xdp_rings[rx_ring->queue_index];
 
-		xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
-
-		/* Force memory writes to complete before letting h/w
-		 * know there are new descriptors to fetch.
-		 */
-		wmb();
-
-		writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
+		i40e_xdp_ring_update_tail(xdp_ring);
+		xdp_do_flush_map();
 	}
 
 	rx_ring->skb = skb;
@@ -3659,3 +3667,49 @@ netdev_tx_t i40e_lan_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 
 	return i40e_xmit_frame_ring(skb, tx_ring);
 }
+
+/**
+ * i40e_xdp_xmit - Implements ndo_xdp_xmit
+ * @dev: netdev
+ * @xdp: XDP buffer
+ *
+ * Returns Zero if sent, else an error code
+ **/
+int i40e_xdp_xmit(struct net_device *dev, struct xdp_buff *xdp)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	unsigned int queue_index = smp_processor_id();
+	struct i40e_vsi *vsi = np->vsi;
+	int err;
+
+	if (test_bit(__I40E_VSI_DOWN, vsi->state))
+		return -EINVAL;
+
+	if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
+		return -EINVAL;
+
+	err = i40e_xmit_xdp_ring(xdp, vsi->xdp_rings[queue_index]);
+	if (err != I40E_XDP_TX)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * i40e_xdp_flush - Implements ndo_xdp_flush
+ * @dev: netdev
+ **/
+void i40e_xdp_flush(struct net_device *dev)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	unsigned int queue_index = smp_processor_id();
+	struct i40e_vsi *vsi = np->vsi;
+
+	if (test_bit(__I40E_VSI_DOWN, vsi->state))
+		return;
+
+	if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
+		return;
+
+	i40e_xdp_ring_update_tail(vsi->xdp_rings[queue_index]);
+}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 2444f338bb0c..a97e59721393 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -510,6 +510,8 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw);
 void i40e_detect_recover_hung(struct i40e_vsi *vsi);
 int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
 bool __i40e_chk_linearize(struct sk_buff *skb);
+int i40e_xdp_xmit(struct net_device *dev, struct xdp_buff *xdp);
+void i40e_xdp_flush(struct net_device *dev);
 
 /**
  * i40e_get_head - Retrieve head from head writeback
-- 
2.7.4

