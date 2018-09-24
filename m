From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon, 24 Sep 2018 18:35:53 +0200
Subject: [Intel-wired-lan] [PATCH 1/5] ixgbe: added Rx/Tx ring
 disable/enable functions
In-Reply-To: <20180924163557.1187-1-bjorn.topel@gmail.com>
References: <20180924163557.1187-1-bjorn.topel@gmail.com>
Message-ID: <20180924163557.1187-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Add functions for Rx/Tx ring enable/disable. Instead of resetting the
whole device, only the affected ring is disabled or enabled.

This plumbing is used in later commits, when zero-copy AF_XDP support
is introduced.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 158 ++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 5c6fd42e90ed..265db172042a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -271,6 +271,7 @@ enum ixgbe_ring_state_t {
 	__IXGBE_TX_DETECT_HANG,
 	__IXGBE_HANG_CHECK_ARMED,
 	__IXGBE_TX_XDP_RING,
+	__IXGBE_TX_DISABLED,
 };
 
 #define ring_uses_build_skb(ring) \
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d4d47707662f..3b68e20c067d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8688,6 +8688,8 @@ static netdev_tx_t __ixgbe_xmit_frame(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 
 	tx_ring = ring ? ring : adapter->tx_ring[skb->queue_mapping];
+	if (unlikely(test_bit(__IXGBE_TX_DISABLED, &tx_ring->state)))
+		return NETDEV_TX_BUSY;
 
 	return ixgbe_xmit_frame_ring(skb, adapter, tx_ring);
 }
@@ -10256,6 +10258,9 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
 	if (unlikely(!ring))
 		return -ENXIO;
 
+	if (unlikely(test_bit(__IXGBE_TX_DISABLED, &ring->state)))
+		return -ENXIO;
+
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
 		int err;
@@ -10322,6 +10327,159 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_xdp_xmit		= ixgbe_xdp_xmit,
 };
 
+static void ixgbe_disable_txr_hw(struct ixgbe_adapter *adapter,
+				 struct ixgbe_ring *tx_ring)
+{
+	unsigned long wait_delay, delay_interval;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u8 reg_idx = tx_ring->reg_idx;
+	int wait_loop;
+	u32 txdctl;
+
+	IXGBE_WRITE_REG(hw, IXGBE_TXDCTL(reg_idx), IXGBE_TXDCTL_SWFLSH);
+
+	/* delay mechanism from ixgbe_disable_tx */
+	delay_interval = ixgbe_get_completion_timeout(adapter) / 100;
+
+	wait_loop = IXGBE_MAX_RX_DESC_POLL;
+	wait_delay = delay_interval;
+
+	while (wait_loop--) {
+		usleep_range(wait_delay, wait_delay + 10);
+		wait_delay += delay_interval * 2;
+		txdctl = IXGBE_READ_REG(hw, IXGBE_TXDCTL(reg_idx));
+
+		if (!(txdctl & IXGBE_TXDCTL_ENABLE))
+			return;
+	}
+
+	e_err(drv, "TXDCTL.ENABLE not cleared within the polling period\n");
+}
+
+static void ixgbe_disable_txr(struct ixgbe_adapter *adapter,
+			      struct ixgbe_ring *tx_ring)
+{
+	set_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
+	ixgbe_disable_txr_hw(adapter, tx_ring);
+}
+
+static void ixgbe_disable_rxr_hw(struct ixgbe_adapter *adapter,
+				 struct ixgbe_ring *rx_ring)
+{
+	unsigned long wait_delay, delay_interval;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u8 reg_idx = rx_ring->reg_idx;
+	int wait_loop;
+	u32 rxdctl;
+
+	rxdctl = IXGBE_READ_REG(hw, IXGBE_RXDCTL(reg_idx));
+	rxdctl &= ~IXGBE_RXDCTL_ENABLE;
+	rxdctl |= IXGBE_RXDCTL_SWFLSH;
+
+	/* write value back with RXDCTL.ENABLE bit cleared */
+	IXGBE_WRITE_REG(hw, IXGBE_RXDCTL(reg_idx), rxdctl);
+
+	/* RXDCTL.EN may not change on 82598 if link is down, so skip it */
+	if (hw->mac.type == ixgbe_mac_82598EB &&
+	    !(IXGBE_READ_REG(hw, IXGBE_LINKS) & IXGBE_LINKS_UP))
+		return;
+
+	/* delay mechanism from ixgbe_disable_rx */
+	delay_interval = ixgbe_get_completion_timeout(adapter) / 100;
+
+	wait_loop = IXGBE_MAX_RX_DESC_POLL;
+	wait_delay = delay_interval;
+
+	while (wait_loop--) {
+		usleep_range(wait_delay, wait_delay + 10);
+		wait_delay += delay_interval * 2;
+		rxdctl = IXGBE_READ_REG(hw, IXGBE_RXDCTL(reg_idx));
+
+		if (!(rxdctl & IXGBE_RXDCTL_ENABLE))
+			return;
+	}
+
+	e_err(drv, "RXDCTL.ENABLE not cleared within the polling period\n");
+}
+
+static void ixgbe_reset_txr_stats(struct ixgbe_ring *tx_ring)
+{
+	memset(&tx_ring->stats, 0, sizeof(tx_ring->stats));
+	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
+}
+
+static void ixgbe_reset_rxr_stats(struct ixgbe_ring *rx_ring)
+{
+	memset(&rx_ring->stats, 0, sizeof(rx_ring->stats));
+	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
+}
+
+/**
+ * ixgbe_txrx_ring_disable - Disable Rx/Tx/XDP Tx rings
+ * @adapter: adapter structure
+ * @ring: ring index
+ *
+ * This function disables a certain Rx/Tx/XDP Tx ring. The function
+ * assumes that the netdev is running.
+ **/
+void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
+{
+	struct ixgbe_ring *rx_ring, *tx_ring, *xdp_ring;
+
+	rx_ring = adapter->rx_ring[ring];
+	tx_ring = adapter->tx_ring[ring];
+	xdp_ring = adapter->xdp_ring[ring];
+
+	ixgbe_disable_txr(adapter, tx_ring);
+	if (xdp_ring)
+		ixgbe_disable_txr(adapter, xdp_ring);
+	ixgbe_disable_rxr_hw(adapter, rx_ring);
+
+	if (xdp_ring)
+		synchronize_sched();
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
+	ixgbe_clean_tx_ring(tx_ring);
+	if (xdp_ring)
+		ixgbe_clean_tx_ring(xdp_ring);
+	ixgbe_clean_rx_ring(rx_ring);
+
+	ixgbe_reset_txr_stats(tx_ring);
+	if (xdp_ring)
+		ixgbe_reset_txr_stats(xdp_ring);
+	ixgbe_reset_rxr_stats(rx_ring);
+}
+
+/**
+ * ixgbe_txrx_ring_enable - Enable Rx/Tx/XDP Tx rings
+ * @adapter: adapter structure
+ * @ring: ring index
+ *
+ * This function enables a certain Rx/Tx/XDP Tx ring. The function
+ * assumes that the netdev is running.
+ **/
+void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
+{
+	struct ixgbe_ring *rx_ring, *tx_ring, *xdp_ring;
+
+	rx_ring = adapter->rx_ring[ring];
+	tx_ring = adapter->tx_ring[ring];
+	xdp_ring = adapter->xdp_ring[ring];
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+
+	ixgbe_configure_tx_ring(adapter, tx_ring);
+	if (xdp_ring)
+		ixgbe_configure_tx_ring(adapter, xdp_ring);
+	ixgbe_configure_rx_ring(adapter, rx_ring);
+
+	clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
+	clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
+}
+
 /**
  * ixgbe_enumerate_functions - Get the number of ports this device has
  * @adapter: adapter structure
-- 
2.17.1

