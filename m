From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:52 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 07/16] ixgbe: Drop
 l2_accel_priv data pointer from ring struct
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185652.29785.75613.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The l2 acceleration private pointer isn't needed in the ring struct. It
isn't really used anywhere other than to test and see if we are supporting
an offloaded macvlan netdev, and it is much easier to test netdev for not
being ixgbe based to verify that.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   23 +++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 7a421b70afce..09def116bb48 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -332,7 +332,6 @@ struct ixgbe_ring {
 	struct net_device *netdev;	/* netdev ring belongs to */
 	struct bpf_prog *xdp_prog;
 	struct device *dev;		/* device for DMA mapping */
-	struct ixgbe_fwd_adapter *l2_accel_priv;
 	void *desc;			/* descriptor ring memory */
 	union {
 		struct ixgbe_tx_buffer *tx_buffer_info;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 69bababc0cf6..09754519a0d9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -192,6 +192,13 @@ static int ixgbe_notify_dca(struct notifier_block *, unsigned long event,
 static bool ixgbe_check_cfg_remove(struct ixgbe_hw *hw, struct pci_dev *pdev);
 static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *);
 
+static const struct net_device_ops ixgbe_netdev_ops;
+
+static bool netif_is_ixgbe(struct net_device *dev)
+{
+	return dev && (dev->netdev_ops == &ixgbe_netdev_ops);
+}
+
 static int ixgbe_read_pci_cfg_word_parent(struct ixgbe_adapter *adapter,
 					  u32 reg, u16 *value)
 {
@@ -4479,8 +4486,9 @@ static void ixgbe_vlan_strip_disable(struct ixgbe_adapter *adapter)
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			struct ixgbe_ring *ring = adapter->rx_ring[i];
 
-			if (ring->l2_accel_priv)
+			if (!netif_is_ixgbe(ring->netdev))
 				continue;
+
 			j = ring->reg_idx;
 			vlnctrl = IXGBE_READ_REG(hw, IXGBE_RXDCTL(j));
 			vlnctrl &= ~IXGBE_RXDCTL_VME;
@@ -4516,8 +4524,9 @@ static void ixgbe_vlan_strip_enable(struct ixgbe_adapter *adapter)
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			struct ixgbe_ring *ring = adapter->rx_ring[i];
 
-			if (ring->l2_accel_priv)
+			if (!netif_is_ixgbe(ring->netdev))
 				continue;
+
 			j = ring->reg_idx;
 			vlnctrl = IXGBE_READ_REG(hw, IXGBE_RXDCTL(j));
 			vlnctrl |= IXGBE_RXDCTL_VME;
@@ -5331,7 +5340,6 @@ static void ixgbe_disable_fwd_ring(struct ixgbe_fwd_adapter *vadapter,
 	usleep_range(10000, 20000);
 	ixgbe_irq_disable_queues(adapter, BIT_ULL(index));
 	ixgbe_clean_rx_ring(rx_ring);
-	rx_ring->l2_accel_priv = NULL;
 }
 
 static int ixgbe_fwd_ring_down(struct net_device *vdev,
@@ -5349,10 +5357,8 @@ static int ixgbe_fwd_ring_down(struct net_device *vdev,
 		adapter->rx_ring[rxbase + i]->netdev = adapter->netdev;
 	}
 
-	for (i = 0; i < adapter->num_rx_queues_per_pool; i++) {
-		adapter->tx_ring[txbase + i]->l2_accel_priv = NULL;
+	for (i = 0; i < adapter->num_rx_queues_per_pool; i++)
 		adapter->tx_ring[txbase + i]->netdev = adapter->netdev;
-	}
 
 
 	return 0;
@@ -5382,14 +5388,11 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 
 	for (i = 0; i < adapter->num_rx_queues_per_pool; i++) {
 		adapter->rx_ring[rxbase + i]->netdev = vdev;
-		adapter->rx_ring[rxbase + i]->l2_accel_priv = accel;
 		ixgbe_configure_rx_ring(adapter, adapter->rx_ring[rxbase + i]);
 	}
 
-	for (i = 0; i < adapter->num_rx_queues_per_pool; i++) {
+	for (i = 0; i < adapter->num_rx_queues_per_pool; i++)
 		adapter->tx_ring[txbase + i]->netdev = vdev;
-		adapter->tx_ring[txbase + i]->l2_accel_priv = accel;
-	}
 
 	queues = min_t(unsigned int,
 		       adapter->num_rx_queues_per_pool, vdev->num_tx_queues);

