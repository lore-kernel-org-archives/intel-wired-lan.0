From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 09 Jul 2018 12:19:43 -0400
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 3/7] ixgbe: Add
 code to populate and use macvlan tc to Tx queue map
In-Reply-To: <20180709161743.8383.97754.stgit@ahduyck-green-test.jf.intel.com>
References: <20180709161743.8383.97754.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180709161943.8383.34753.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch makes it so that we use the tc_to_txq mapping in the macvlan
device in order to select the Tx queue for outgoing packets.

The idea here is to try and move away from using ixgbe_select_queue and to
come up with a generic way to make this work for devices going forward. By
encoding this information in the netdev this can become something that can
be used generically as a solution for similar setups going forward.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   44 ++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c265963..3ff34ca 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5275,6 +5275,8 @@ static void ixgbe_clean_rx_ring(struct ixgbe_ring *rx_ring)
 static int ixgbe_fwd_ring_up(struct ixgbe_adapter *adapter,
 			     struct ixgbe_fwd_adapter *accel)
 {
+	u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
+	int num_tc = netdev_get_num_tc(adapter->netdev);
 	struct net_device *vdev = accel->netdev;
 	int i, baseq, err;
 
@@ -5286,6 +5288,11 @@ static int ixgbe_fwd_ring_up(struct ixgbe_adapter *adapter,
 	accel->rx_base_queue = baseq;
 	accel->tx_base_queue = baseq;
 
+	/* record configuration for macvlan interface in vdev */
+	for (i = 0; i < num_tc; i++)
+		netdev_bind_sb_channel_queue(adapter->netdev, vdev,
+					     i, rss_i, baseq + (rss_i * i));
+
 	for (i = 0; i < adapter->num_rx_queues_per_pool; i++)
 		adapter->rx_ring[baseq + i]->netdev = vdev;
 
@@ -5310,6 +5317,10 @@ static int ixgbe_fwd_ring_up(struct ixgbe_adapter *adapter,
 
 	netdev_err(vdev, "L2FW offload disabled due to L2 filter error\n");
 
+	/* unbind the queues and drop the subordinate channel config */
+	netdev_unbind_sb_channel(adapter->netdev, vdev);
+	netdev_set_sb_channel(vdev, 0);
+
 	clear_bit(accel->pool, adapter->fwd_bitmask);
 	kfree(accel);
 
@@ -8206,18 +8217,22 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
 			      void *accel_priv, select_queue_fallback_t fallback)
 {
 	struct ixgbe_fwd_adapter *fwd_adapter = accel_priv;
-	struct ixgbe_adapter *adapter;
-	int txq;
 #ifdef IXGBE_FCOE
+	struct ixgbe_adapter *adapter;
 	struct ixgbe_ring_feature *f;
 #endif
+	int txq;
 
 	if (fwd_adapter) {
-		adapter = netdev_priv(dev);
-		txq = reciprocal_scale(skb_get_hash(skb),
-				       adapter->num_rx_queues_per_pool);
+		u8 tc = netdev_get_num_tc(dev) ?
+			netdev_get_prio_tc_map(dev, skb->priority) : 0;
+		struct net_device *vdev = fwd_adapter->netdev;
+
+		txq = vdev->tc_to_txq[tc].offset;
+		txq += reciprocal_scale(skb_get_hash(skb),
+					vdev->tc_to_txq[tc].count);
 
-		return txq + fwd_adapter->tx_base_queue;
+		return txq;
 	}
 
 #ifdef IXGBE_FCOE
@@ -8771,6 +8786,11 @@ static int ixgbe_reassign_macvlan_pool(struct net_device *vdev, void *data)
 	/* if we cannot find a free pool then disable the offload */
 	netdev_err(vdev, "L2FW offload disabled due to lack of queue resources\n");
 	macvlan_release_l2fw_offload(vdev);
+
+	/* unbind the queues and drop the subordinate channel config */
+	netdev_unbind_sb_channel(adapter->netdev, vdev);
+	netdev_set_sb_channel(vdev, 0);
+
 	kfree(accel);
 
 	return 0;
@@ -9779,6 +9799,13 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	if (!macvlan_supports_dest_filter(vdev))
 		return ERR_PTR(-EMEDIUMTYPE);
 
+	/* We need to lock down the macvlan to be a single queue device so that
+	 * we can reuse the tc_to_txq field in the macvlan netdev to represent
+	 * the queue mapping to our netdev.
+	 */
+	if (netif_is_multiqueue(vdev))
+		return ERR_PTR(-ERANGE);
+
 	pool = find_first_zero_bit(adapter->fwd_bitmask, adapter->num_rx_pools);
 	if (pool == adapter->num_rx_pools) {
 		u16 used_pools = adapter->num_vfs + adapter->num_rx_pools;
@@ -9835,6 +9862,7 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 		return ERR_PTR(-ENOMEM);
 
 	set_bit(pool, adapter->fwd_bitmask);
+	netdev_set_sb_channel(vdev, pool);
 	accel->pool = pool;
 	accel->netdev = vdev;
 
@@ -9876,6 +9904,10 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 		ring->netdev = NULL;
 	}
 
+	/* unbind the queues and drop the subordinate channel config */
+	netdev_unbind_sb_channel(pdev, accel->netdev);
+	netdev_set_sb_channel(accel->netdev, 0);
+
 	clear_bit(accel->pool, adapter->fwd_bitmask);
 	kfree(accel);
 }

