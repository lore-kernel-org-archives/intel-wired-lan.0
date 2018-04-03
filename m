From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:03 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 02/10] macvlan: Rename
 fwd_priv to accel_priv and add accessor function
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211603.7880.2593.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change renames the fwd_priv member to accel_priv as this more
accurately reflects the actual purpose of this value. In addition I am
adding an accessor which will allow us to further abstract this in the
future if needed.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   10 +++-----
 drivers/net/macvlan.c                         |   31 +++++++++++++++----------
 include/linux/if_macvlan.h                    |    8 ++++++
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 4d2c0ed..c08e6b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5390,10 +5390,9 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 static int ixgbe_upper_dev_walk(struct net_device *upper, void *data)
 {
 	if (netif_is_macvlan(upper)) {
-		struct macvlan_dev *dfwd = netdev_priv(upper);
-		struct ixgbe_fwd_adapter *vadapter = dfwd->fwd_priv;
+		struct ixgbe_fwd_adapter *vadapter = macvlan_accel_priv(upper);
 
-		if (dfwd->fwd_priv)
+		if (vadapter)
 			ixgbe_fwd_ring_up(upper, vadapter);
 	}
 
@@ -8967,13 +8966,12 @@ struct upper_walk_data {
 static int get_macvlan_queue(struct net_device *upper, void *_data)
 {
 	if (netif_is_macvlan(upper)) {
-		struct macvlan_dev *dfwd = netdev_priv(upper);
-		struct ixgbe_fwd_adapter *vadapter = dfwd->fwd_priv;
+		struct ixgbe_fwd_adapter *vadapter = macvlan_accel_priv(upper);
 		struct upper_walk_data *data = _data;
 		struct ixgbe_adapter *adapter = data->adapter;
 		int ifindex = data->ifindex;
 
-		if (vadapter && vadapter->netdev->ifindex == ifindex) {
+		if (vadapter && upper->ifindex == ifindex) {
 			data->queue = adapter->rx_ring[vadapter->rx_base_queue]->reg_idx;
 			data->action = data->queue;
 			return 1;
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 725f4b4..7ddc94f 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -559,9 +559,9 @@ static netdev_tx_t macvlan_start_xmit(struct sk_buff *skb,
 	if (unlikely(netpoll_tx_running(dev)))
 		return macvlan_netpoll_send_skb(vlan, skb);
 
-	if (vlan->fwd_priv) {
+	if (vlan->accel_priv) {
 		skb->dev = vlan->lowerdev;
-		ret = dev_queue_xmit_accel(skb, vlan->fwd_priv);
+		ret = dev_queue_xmit_accel(skb, vlan->accel_priv);
 	} else {
 		ret = macvlan_queue_xmit(skb, dev);
 	}
@@ -613,16 +613,23 @@ static int macvlan_open(struct net_device *dev)
 		goto hash_add;
 	}
 
+	err = -EBUSY;
+	if (macvlan_addr_busy(vlan->port, dev->dev_addr))
+		goto out;
+
+	/* Attempt to populate accel_priv which is used to offload the L2
+	 * forwarding requests for unicast packets.
+	 */
 	if (lowerdev->features & NETIF_F_HW_L2FW_DOFFLOAD) {
-		vlan->fwd_priv =
+		vlan->accel_priv =
 		      lowerdev->netdev_ops->ndo_dfwd_add_station(lowerdev, dev);
 
 		/* If we get a NULL pointer back, or if we get an error
 		 * then we should just fall through to the non accelerated path
 		 */
-		if (IS_ERR_OR_NULL(vlan->fwd_priv)) {
-			vlan->fwd_priv = NULL;
-		} else
+		if (IS_ERR_OR_NULL(vlan->accel_priv))
+			vlan->accel_priv = NULL;
+		else
 			return 0;
 	}
 
@@ -655,10 +662,10 @@ static int macvlan_open(struct net_device *dev)
 del_unicast:
 	dev_uc_del(lowerdev, dev->dev_addr);
 out:
-	if (vlan->fwd_priv) {
+	if (vlan->accel_priv) {
 		lowerdev->netdev_ops->ndo_dfwd_del_station(lowerdev,
-							   vlan->fwd_priv);
-		vlan->fwd_priv = NULL;
+							   vlan->accel_priv);
+		vlan->accel_priv = NULL;
 	}
 	return err;
 }
@@ -668,10 +675,10 @@ static int macvlan_stop(struct net_device *dev)
 	struct macvlan_dev *vlan = netdev_priv(dev);
 	struct net_device *lowerdev = vlan->lowerdev;
 
-	if (vlan->fwd_priv) {
+	if (vlan->accel_priv) {
 		lowerdev->netdev_ops->ndo_dfwd_del_station(lowerdev,
-							   vlan->fwd_priv);
-		vlan->fwd_priv = NULL;
+							   vlan->accel_priv);
+		vlan->accel_priv = NULL;
 		return 0;
 	}
 
diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
index 4cb7aee..c5106ce 100644
--- a/include/linux/if_macvlan.h
+++ b/include/linux/if_macvlan.h
@@ -21,7 +21,7 @@ struct macvlan_dev {
 	struct hlist_node	hlist;
 	struct macvlan_port	*port;
 	struct net_device	*lowerdev;
-	void			*fwd_priv;
+	void			*accel_priv;
 	struct vlan_pcpu_stats __percpu *pcpu_stats;
 
 	DECLARE_BITMAP(mc_filter, MACVLAN_MC_FILTER_SZ);
@@ -86,4 +86,10 @@ extern void macvlan_count_rx(const struct macvlan_dev *vlan,
 }
 #endif
 
+static inline void *macvlan_accel_priv(struct net_device *dev)
+{
+	struct macvlan_dev *macvlan = netdev_priv(dev);
+
+	return macvlan->accel_priv;
+}
 #endif /* _LINUX_IF_MACVLAN_H */

