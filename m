From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:45 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 10/10] ixgbe: Avoid
 performing unnecessary resets for macvlan offload
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211645.7880.13012.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The original implementation for macvlan offload has us performing a full
port reset every time we added a new macvlan. This shouldn't be necessary
and can be avoided with a few behavior changes.

This patches updates the logic for the queues so that we have essentially 3
possible configurations for macvlan offload. They consist of 15 macvlans
with 4 queues per macvlan, 31 macvlans with 2 queues per macvlan, and 63
macvlans with 1 queue per macvlan. As macvlans are added you will encounter
up to 3 total resets if you add all the way up to 63, and after that the
device will stay in the mode supporting up to 63 macvlans until the L2FW
flag is cleared.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  192 +++++++++++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    5 -
 2 files changed, 135 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 56772d6..01c95bf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5336,15 +5336,11 @@ static int ixgbe_fwd_ring_up(struct ixgbe_adapter *adapter,
 	struct net_device *vdev = accel->netdev;
 	int i, baseq, err;
 
-	if (!test_bit(accel->pool, adapter->fwd_bitmask))
-		return 0;
-
 	baseq = accel->pool * adapter->num_rx_queues_per_pool;
 	netdev_dbg(vdev, "pool %i:%i queues %i:%i\n",
 		   accel->pool, adapter->num_rx_pools,
 		   baseq, baseq + adapter->num_rx_queues_per_pool);
 
-	accel->netdev = vdev;
 	accel->rx_base_queue = baseq;
 	accel->tx_base_queue = baseq;
 
@@ -5364,9 +5360,17 @@ static int ixgbe_fwd_ring_up(struct ixgbe_adapter *adapter,
 	if (err >= 0)
 		return 0;
 
+	/* if we cannot add the MAC rule then disable the offload */
+	macvlan_release_l2fw_offload(vdev);
+
 	for (i = 0; i < adapter->num_rx_queues_per_pool; i++)
 		adapter->rx_ring[baseq + i]->netdev = NULL;
 
+	netdev_err(vdev, "L2FW offload disabled due to L2 filter error\n");
+
+	clear_bit(accel->pool, adapter->fwd_bitmask);
+	kfree(accel);
+
 	return err;
 }
 
@@ -8783,6 +8787,49 @@ static void ixgbe_set_prio_tc_map(struct ixgbe_adapter *adapter)
 }
 
 #endif /* CONFIG_IXGBE_DCB */
+static int ixgbe_reassign_macvlan_pool(struct net_device *vdev, void *data)
+{
+	struct ixgbe_adapter *adapter = data;
+	struct ixgbe_fwd_adapter *accel;
+	int pool;
+
+	/* we only care about macvlans... */
+	if (!netif_is_macvlan(vdev))
+		return 0;
+
+	/* that have hardware offload enabled... */
+	accel = macvlan_accel_priv(vdev);
+	if (!accel)
+		return 0;
+
+	/* If we can relocate to a different bit do so */
+	pool = find_first_zero_bit(adapter->fwd_bitmask, adapter->num_rx_pools);
+	if (pool < adapter->num_rx_pools) {
+		set_bit(pool, adapter->fwd_bitmask);
+		accel->pool = pool;
+		return 0;
+	}
+
+	/* if we cannot find a free pool then disable the offload */
+	netdev_err(vdev, "L2FW offload disabled due to lack of queue resources\n");
+	macvlan_release_l2fw_offload(vdev);
+	kfree(accel);
+
+	return 0;
+}
+
+static void ixgbe_defrag_macvlan_pools(struct net_device *dev)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(dev);
+
+	/* flush any stale bits out of the fwd bitmask */
+	bitmap_clear(adapter->fwd_bitmask, 1, 63);
+
+	/* walk through upper devices reassigning pools */
+	netdev_walk_all_upper_dev_rcu(dev, ixgbe_reassign_macvlan_pool,
+				      adapter);
+}
+
 /**
  * ixgbe_setup_tc - configure net_device for multiple traffic classes
  *
@@ -8850,6 +8897,8 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 #endif /* CONFIG_IXGBE_DCB */
 	ixgbe_init_interrupt_scheme(adapter);
 
+	ixgbe_defrag_macvlan_pools(dev);
+
 	if (netif_running(dev))
 		return ixgbe_open(dev);
 
@@ -9399,6 +9448,22 @@ static netdev_features_t ixgbe_fix_features(struct net_device *netdev,
 	return features;
 }
 
+static void ixgbe_reset_l2fw_offload(struct ixgbe_adapter *adapter)
+{
+	int rss = min_t(int, ixgbe_max_rss_indices(adapter),
+			num_online_cpus());
+
+	/* go back to full RSS if we're not running SR-IOV */
+	if (!adapter->ring_feature[RING_F_VMDQ].offset)
+		adapter->flags &= ~(IXGBE_FLAG_VMDQ_ENABLED |
+				    IXGBE_FLAG_SRIOV_ENABLED);
+
+	adapter->ring_feature[RING_F_RSS].limit = rss;
+	adapter->ring_feature[RING_F_VMDQ].limit = 1;
+
+	ixgbe_setup_tc(adapter->netdev, adapter->hw_tcs);
+}
+
 static int ixgbe_set_features(struct net_device *netdev,
 			      netdev_features_t features)
 {
@@ -9479,7 +9544,9 @@ static int ixgbe_set_features(struct net_device *netdev,
 		}
 	}
 
-	if (need_reset)
+	if ((changed & NETIF_F_HW_L2FW_DOFFLOAD) && adapter->num_rx_pools > 1)
+		ixgbe_reset_l2fw_offload(adapter);
+	else if (need_reset)
 		ixgbe_do_reset(netdev);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER))
@@ -9742,11 +9809,9 @@ static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 {
-	struct ixgbe_fwd_adapter *fwd_adapter = NULL;
 	struct ixgbe_adapter *adapter = netdev_priv(pdev);
-	int used_pools = adapter->num_vfs + adapter->num_rx_pools;
+	struct ixgbe_fwd_adapter *accel;
 	int tcs = adapter->hw_tcs ? : 1;
-	unsigned int limit;
 	int pool, err;
 
 	/* The hardware supported by ixgbe only filters on the destination MAC
@@ -9756,47 +9821,73 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	if (!macvlan_supports_dest_filter(vdev))
 		return ERR_PTR(-EMEDIUMTYPE);
 
-	/* Hardware has a limited number of available pools. Each VF, and the
-	 * PF require a pool. Check to ensure we don't attempt to use more
-	 * then the available number of pools.
-	 */
-	if (used_pools >= IXGBE_MAX_VF_FUNCTIONS)
-		return ERR_PTR(-EINVAL);
+	pool = find_first_zero_bit(adapter->fwd_bitmask, adapter->num_rx_pools);
+	if (pool == adapter->num_rx_pools) {
+		u16 used_pools = adapter->num_vfs + adapter->num_rx_pools;
+		u16 reserved_pools;
+
+		if (((adapter->flags & IXGBE_FLAG_DCB_ENABLED) &&
+		     adapter->num_rx_pools >= (MAX_TX_QUEUES / tcs)) ||
+		    adapter->num_rx_pools > IXGBE_MAX_MACVLANS)
+			return ERR_PTR(-EBUSY);
+
+		/* Hardware has a limited number of available pools. Each VF,
+		 * and the PF require a pool. Check to ensure we don't
+		 * attempt to use more then the available number of pools.
+		 */
+		if (used_pools >= IXGBE_MAX_VF_FUNCTIONS)
+			return ERR_PTR(-EBUSY);
 
-	if (((adapter->flags & IXGBE_FLAG_DCB_ENABLED) &&
-	      adapter->num_rx_pools >= (MAX_TX_QUEUES / tcs)) ||
-	    (adapter->num_rx_pools > IXGBE_MAX_MACVLANS))
-		return ERR_PTR(-EBUSY);
+		/* Enable VMDq flag so device will be set in VM mode */
+		adapter->flags |= IXGBE_FLAG_VMDQ_ENABLED |
+				  IXGBE_FLAG_SRIOV_ENABLED;
 
-	fwd_adapter = kzalloc(sizeof(*fwd_adapter), GFP_KERNEL);
-	if (!fwd_adapter)
-		return ERR_PTR(-ENOMEM);
+		/* Try to reserve as many queues per pool as possible,
+		 * we start with the configurations that support 4 queues
+		 * per pools, followed by 2, and then by just 1 per pool.
+		 */
+		if (used_pools < 32 && adapter->num_rx_pools < 16)
+			reserved_pools = min_t(u16,
+					       32 - used_pools,
+					       16 - adapter->num_rx_pools);
+		else if (adapter->num_rx_pools < 32)
+			reserved_pools = min_t(u16,
+					       64 - used_pools,
+					       32 - adapter->num_rx_pools);
+		else
+			reserved_pools = 64 - used_pools;
 
-	pool = find_first_zero_bit(adapter->fwd_bitmask, adapter->num_rx_pools);
-	set_bit(pool, adapter->fwd_bitmask);
-	limit = find_last_bit(adapter->fwd_bitmask, adapter->num_rx_pools + 1);
 
-	/* Enable VMDq flag so device will be set in VM mode */
-	adapter->flags |= IXGBE_FLAG_VMDQ_ENABLED | IXGBE_FLAG_SRIOV_ENABLED;
-	adapter->ring_feature[RING_F_VMDQ].limit = limit + 1;
+		if (!reserved_pools)
+			return ERR_PTR(-EBUSY);
 
-	fwd_adapter->pool = pool;
+		adapter->ring_feature[RING_F_VMDQ].limit += reserved_pools;
 
-	/* Force reinit of ring allocation with VMDQ enabled */
-	err = ixgbe_setup_tc(pdev, adapter->hw_tcs);
+		/* Force reinit of ring allocation with VMDQ enabled */
+		err = ixgbe_setup_tc(pdev, adapter->hw_tcs);
+		if (err)
+			return ERR_PTR(err);
 
-	if (!err && netif_running(pdev))
-		err = ixgbe_fwd_ring_up(adapter, fwd_adapter);
+		if (pool >= adapter->num_rx_pools)
+			return ERR_PTR(-ENOMEM);
+	}
 
-	if (!err)
-		return fwd_adapter;
+	accel = kzalloc(sizeof(*accel), GFP_KERNEL);
+	if (!accel)
+		return ERR_PTR(-ENOMEM);
+
+	set_bit(pool, adapter->fwd_bitmask);
+	accel->pool = pool;
+	accel->netdev = vdev;
 
-	/* unwind counter and free adapter struct */
-	netdev_info(pdev,
-		    "%s: dfwd hardware acceleration failed\n", vdev->name);
-	clear_bit(pool, adapter->fwd_bitmask);
-	kfree(fwd_adapter);
-	return ERR_PTR(err);
+	if (!netif_running(pdev))
+		return accel;
+
+	err = ixgbe_fwd_ring_up(adapter, accel);
+	if (err)
+		return ERR_PTR(err);
+
+	return accel;
 }
 
 static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
@@ -9804,7 +9895,7 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	struct ixgbe_fwd_adapter *accel = priv;
 	struct ixgbe_adapter *adapter = netdev_priv(pdev);
 	unsigned int rxbase = accel->rx_base_queue;
-	unsigned int limit, i;
+	unsigned int i;
 
 	/* delete unicast filter associated with offloaded interface */
 	ixgbe_del_mac_filter(adapter, accel->netdev->dev_addr,
@@ -9828,25 +9919,6 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	}
 
 	clear_bit(accel->pool, adapter->fwd_bitmask);
-	limit = find_last_bit(adapter->fwd_bitmask, adapter->num_rx_pools);
-	adapter->ring_feature[RING_F_VMDQ].limit = limit + 1;
-
-	/* go back to full RSS if we're done with our VMQs */
-	if (adapter->ring_feature[RING_F_VMDQ].limit == 1) {
-		int rss = min_t(int, ixgbe_max_rss_indices(adapter),
-				num_online_cpus());
-
-		adapter->flags &= ~IXGBE_FLAG_VMDQ_ENABLED;
-		adapter->flags &= ~IXGBE_FLAG_SRIOV_ENABLED;
-		adapter->ring_feature[RING_F_RSS].limit = rss;
-	}
-
-	ixgbe_setup_tc(pdev, adapter->hw_tcs);
-	netdev_dbg(pdev, "pool %i:%i queues %i:%i\n",
-		   accel->pool, adapter->num_rx_pools,
-		   accel->rx_base_queue,
-		   accel->rx_base_queue +
-		   adapter->num_rx_queues_per_pool);
 	kfree(accel);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 008aa07..bfc4171 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -266,7 +266,7 @@ int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 #endif
 
 	/* Disable VMDq flag so device will be set in VM mode */
-	if (adapter->ring_feature[RING_F_VMDQ].limit == 1) {
+	if (bitmap_weight(adapter->fwd_bitmask, adapter->num_rx_pools) == 1) {
 		adapter->flags &= ~IXGBE_FLAG_VMDQ_ENABLED;
 		adapter->flags &= ~IXGBE_FLAG_SRIOV_ENABLED;
 		rss = min_t(int, ixgbe_max_rss_indices(adapter),
@@ -312,7 +312,8 @@ static int ixgbe_pci_sriov_enable(struct pci_dev *dev, int num_vfs)
 	 * other values out of range.
 	 */
 	num_tc = adapter->hw_tcs;
-	num_rx_pools = adapter->num_rx_pools;
+	num_rx_pools = bitmap_weight(adapter->fwd_bitmask,
+				     adapter->num_rx_pools);
 	limit = (num_tc > 4) ? IXGBE_MAX_VFS_8TC :
 		(num_tc > 1) ? IXGBE_MAX_VFS_4TC : IXGBE_MAX_VFS_1TC;
 

