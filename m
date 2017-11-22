From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:57:23 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 12/16] ixgbe: Do not
 manipulate macvlan Tx queues when performing macvlan offload
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185723.29785.8129.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

We should not be stopping/starting the upper devices Tx queues when
handling a macvlan offload. Instead we should be stopping and starting
traffic on our own queues.

In order to prevent us from doing this I am updating the code so that we no
longer change the queue configuration on the upper device, nor do we update
the queue_index on our own device. Instead we can just use the queue index
for our local device and not update the netdev in the case of the transmit
rings.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   12 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  121 +++++--------------------
 2 files changed, 25 insertions(+), 108 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index df23a57ddb56..dc7f3ef2957b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -920,11 +920,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 
 		/* apply Tx specific ring traits */
 		ring->count = adapter->tx_ring_count;
-		if (adapter->num_rx_pools > 1)
-			ring->queue_index =
-				txr_idx % adapter->num_rx_queues_per_pool;
-		else
-			ring->queue_index = txr_idx;
+		ring->queue_index = txr_idx;
 
 		/* assign ring to adapter */
 		adapter->tx_ring[txr_idx] = ring;
@@ -994,11 +990,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 #endif /* IXGBE_FCOE */
 		/* apply Rx specific ring traits */
 		ring->count = adapter->rx_ring_count;
-		if (adapter->num_rx_pools > 1)
-			ring->queue_index =
-				rxr_idx % adapter->num_rx_queues_per_pool;
-		else
-			ring->queue_index = rxr_idx;
+		ring->queue_index = rxr_idx;
 
 		/* assign ring to adapter */
 		adapter->rx_ring[rxr_idx] = ring;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 825d093ebf2e..c21fd98bd45a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5339,12 +5339,11 @@ static void ixgbe_disable_fwd_ring(struct ixgbe_fwd_adapter *vadapter,
 				   struct ixgbe_ring *rx_ring)
 {
 	struct ixgbe_adapter *adapter = vadapter->real_adapter;
-	int index = rx_ring->queue_index + vadapter->rx_base_queue;
 
 	/* shutdown specific queue receive and wait for dma to settle */
 	ixgbe_disable_rx_queue(adapter, rx_ring);
 	usleep_range(10000, 20000);
-	ixgbe_irq_disable_queues(adapter, BIT_ULL(index));
+	ixgbe_irq_disable_queues(adapter, BIT_ULL(rx_ring->queue_index));
 	ixgbe_clean_rx_ring(rx_ring);
 }
 
@@ -5353,20 +5352,13 @@ static int ixgbe_fwd_ring_down(struct net_device *vdev,
 {
 	struct ixgbe_adapter *adapter = accel->real_adapter;
 	unsigned int rxbase = accel->rx_base_queue;
-	unsigned int txbase = accel->tx_base_queue;
 	int i;
 
-	netif_tx_stop_all_queues(vdev);
-
 	for (i = 0; i < adapter->num_rx_queues_per_pool; i++) {
 		ixgbe_disable_fwd_ring(accel, adapter->rx_ring[rxbase + i]);
 		adapter->rx_ring[rxbase + i]->netdev = adapter->netdev;
 	}
 
-	for (i = 0; i < adapter->num_rx_queues_per_pool; i++)
-		adapter->tx_ring[txbase + i]->netdev = adapter->netdev;
-
-
 	return 0;
 }
 
@@ -5374,8 +5366,7 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 			     struct ixgbe_fwd_adapter *accel)
 {
 	struct ixgbe_adapter *adapter = accel->real_adapter;
-	unsigned int rxbase, txbase, queues;
-	int i, baseq, err = 0;
+	int i, baseq, err;
 
 	if (!test_bit(accel->pool, adapter->fwd_bitmask))
 		return 0;
@@ -5386,30 +5377,17 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 		   baseq, baseq + adapter->num_rx_queues_per_pool);
 
 	accel->netdev = vdev;
-	accel->rx_base_queue = rxbase = baseq;
-	accel->tx_base_queue = txbase = baseq;
+	accel->rx_base_queue = baseq;
+	accel->tx_base_queue = baseq;
 
 	for (i = 0; i < adapter->num_rx_queues_per_pool; i++)
-		ixgbe_disable_fwd_ring(accel, adapter->rx_ring[rxbase + i]);
+		ixgbe_disable_fwd_ring(accel, adapter->rx_ring[baseq + i]);
 
 	for (i = 0; i < adapter->num_rx_queues_per_pool; i++) {
-		adapter->rx_ring[rxbase + i]->netdev = vdev;
-		ixgbe_configure_rx_ring(adapter, adapter->rx_ring[rxbase + i]);
+		adapter->rx_ring[baseq + i]->netdev = vdev;
+		ixgbe_configure_rx_ring(adapter, adapter->rx_ring[baseq + i]);
 	}
 
-	for (i = 0; i < adapter->num_rx_queues_per_pool; i++)
-		adapter->tx_ring[txbase + i]->netdev = vdev;
-
-	queues = min_t(unsigned int,
-		       adapter->num_rx_queues_per_pool, vdev->num_tx_queues);
-	err = netif_set_real_num_tx_queues(vdev, queues);
-	if (err)
-		goto fwd_queue_err;
-
-	err = netif_set_real_num_rx_queues(vdev, queues);
-	if (err)
-		goto fwd_queue_err;
-
 	/* ixgbe_add_mac_filter will return an index if it succeeds, so we
 	 * need to only treat it as an error value if it is negative.
 	 */
@@ -5897,21 +5875,6 @@ static void ixgbe_fdir_filter_exit(struct ixgbe_adapter *adapter)
 	spin_unlock(&adapter->fdir_perfect_lock);
 }
 
-static int ixgbe_disable_macvlan(struct net_device *upper, void *data)
-{
-	if (netif_is_macvlan(upper)) {
-		struct macvlan_dev *vlan = netdev_priv(upper);
-
-		if (vlan->fwd_priv) {
-			netif_tx_stop_all_queues(upper);
-			netif_carrier_off(upper);
-			netif_tx_disable(upper);
-		}
-	}
-
-	return 0;
-}
-
 void ixgbe_down(struct ixgbe_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -5941,10 +5904,6 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 
-	/* disable any upper devices */
-	netdev_walk_all_upper_dev_rcu(adapter->netdev,
-				      ixgbe_disable_macvlan, NULL);
-
 	ixgbe_irq_disable(adapter);
 
 	ixgbe_napi_disable_all(adapter);
@@ -7254,18 +7213,6 @@ static void ixgbe_update_default_up(struct ixgbe_adapter *adapter)
 #endif
 }
 
-static int ixgbe_enable_macvlan(struct net_device *upper, void *data)
-{
-	if (netif_is_macvlan(upper)) {
-		struct macvlan_dev *vlan = netdev_priv(upper);
-
-		if (vlan->fwd_priv)
-			netif_tx_wake_all_queues(upper);
-	}
-
-	return 0;
-}
-
 /**
  * ixgbe_watchdog_link_is_up - update netif_carrier status and
  *                             print link up message
@@ -7346,12 +7293,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	/* enable transmits */
 	netif_tx_wake_all_queues(adapter->netdev);
 
-	/* enable any upper devices */
-	rtnl_lock();
-	netdev_walk_all_upper_dev_rcu(adapter->netdev,
-				      ixgbe_enable_macvlan, NULL);
-	rtnl_unlock();
-
 	/* update the default user priority for VFs */
 	ixgbe_update_default_up(adapter);
 
@@ -8312,14 +8253,19 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
 			      void *accel_priv, select_queue_fallback_t fallback)
 {
 	struct ixgbe_fwd_adapter *fwd_adapter = accel_priv;
-#ifdef IXGBE_FCOE
 	struct ixgbe_adapter *adapter;
-	struct ixgbe_ring_feature *f;
 	int txq;
+#ifdef IXGBE_FCOE
+	struct ixgbe_ring_feature *f;
 #endif
 
-	if (fwd_adapter)
-		return skb->queue_mapping + fwd_adapter->tx_base_queue;
+	if (fwd_adapter) {
+		adapter = netdev_priv(dev);
+		txq = reciprocal_scale(skb_get_hash(skb),
+				       adapter->num_rx_queues_per_pool);
+
+		return txq + fwd_adapter->tx_base_queue;
+	}
 
 #ifdef IXGBE_FCOE
 
@@ -9806,22 +9752,6 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	if (used_pools >= IXGBE_MAX_VF_FUNCTIONS)
 		return ERR_PTR(-EINVAL);
 
-#ifdef CONFIG_RPS
-	if (vdev->num_rx_queues != vdev->num_tx_queues) {
-		netdev_info(pdev, "%s: Only supports a single queue count for TX and RX\n",
-			    vdev->name);
-		return ERR_PTR(-EINVAL);
-	}
-#endif
-	/* Check for hardware restriction on number of rx/tx queues */
-	if (vdev->num_tx_queues > IXGBE_MAX_L2A_QUEUES ||
-	    vdev->num_tx_queues == IXGBE_BAD_L2A_QUEUE) {
-		netdev_info(pdev,
-			    "%s: Supports RX/TX Queue counts 1,2, and 4\n",
-			    pdev->name);
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (((adapter->flags & IXGBE_FLAG_DCB_ENABLED) &&
 	      adapter->num_rx_pools >= (MAX_TX_QUEUES / tcs)) ||
 	    (adapter->num_rx_pools > IXGBE_MAX_MACVLANS))
@@ -9838,24 +9768,19 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	/* Enable VMDq flag so device will be set in VM mode */
 	adapter->flags |= IXGBE_FLAG_VMDQ_ENABLED | IXGBE_FLAG_SRIOV_ENABLED;
 	adapter->ring_feature[RING_F_VMDQ].limit = limit + 1;
-	adapter->ring_feature[RING_F_RSS].limit = vdev->num_tx_queues;
 
-	/* Force reinit of ring allocation with VMDQ enabled */
-	err = ixgbe_setup_tc(pdev, adapter->hw_tcs);
-	if (err)
-		goto fwd_add_err;
 	fwd_adapter->pool = pool;
 	fwd_adapter->real_adapter = adapter;
 
-	if (netif_running(pdev)) {
+	/* Force reinit of ring allocation with VMDQ enabled */
+	err = ixgbe_setup_tc(pdev, adapter->hw_tcs);
+
+	if (!err && netif_running(pdev))
 		err = ixgbe_fwd_ring_up(vdev, fwd_adapter);
-		if (err)
-			goto fwd_add_err;
-		netif_tx_start_all_queues(vdev);
-	}
 
-	return fwd_adapter;
-fwd_add_err:
+	if (!err)
+		return fwd_adapter;
+
 	/* unwind counter and free adapter struct */
 	netdev_info(pdev,
 		    "%s: dfwd hardware acceleration failed\n", vdev->name);

