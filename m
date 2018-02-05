From: Alice Michael <alice.michael@intel.com>
Date: Mon,  5 Feb 2018 06:11:20 -0500
Subject: [Intel-wired-lan] [next PATCH S86 V3 7/8] i40evf: use
 __dev_[um]c_sync routines in .set_rx_mode
In-Reply-To: <20180205111121.59468-1-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
Message-ID: <20180205111121.59468-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Similar to changes done to the PF driver in commit 6622f5cdbaf3 ("i40e:
make use of __dev_uc_sync and __dev_mc_sync"), replace our
home-rolled method for updating the internal status of MAC filters with
__dev_uc_sync and __dev_mc_sync.

These new functions use internal state within the netdev struct in order
to efficiently break the question of "which filters in this list need to
be added or removed" into singular "add this filter" and "delete this
filter" requests.

This vastly improves our handling of .set_rx_mode especially with large
number of MAC filters being added to the device, and even results in
a simpler .set_rx_mode handler.

Under some circumstances, such as when attached to a bridge, we may
receive a request to delete our own permanent address. Prevent deletion
of this address during i40evf_addr_unsync so that we don't accidentally
stop receiving traffic.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 109 ++++++++++++++----------
 1 file changed, 64 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4f07469..d14b006 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -785,7 +785,7 @@ static int i40evf_vlan_rx_kill_vid(struct net_device *netdev,
  **/
 static struct
 i40evf_mac_filter *i40evf_find_filter(struct i40evf_adapter *adapter,
-				      u8 *macaddr)
+				      const u8 *macaddr)
 {
 	struct i40evf_mac_filter *f;
 
@@ -808,20 +808,18 @@ i40evf_mac_filter *i40evf_find_filter(struct i40evf_adapter *adapter,
  **/
 static struct
 i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
-				     u8 *macaddr)
+				     const u8 *macaddr)
 {
 	struct i40evf_mac_filter *f;
 
 	if (!macaddr)
 		return NULL;
 
-	spin_lock_bh(&adapter->mac_vlan_list_lock);
-
 	f = i40evf_find_filter(adapter, macaddr);
 	if (!f) {
 		f = kzalloc(sizeof(*f), GFP_ATOMIC);
 		if (!f)
-			goto clearout;
+			return f;
 
 		ether_addr_copy(f->macaddr, macaddr);
 
@@ -832,8 +830,6 @@ i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
 		f->remove = false;
 	}
 
-clearout:
-	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 	return f;
 }
 
@@ -868,9 +864,10 @@ static int i40evf_set_mac(struct net_device *netdev, void *p)
 		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_MAC_FILTER;
 	}
 
+	f = i40evf_add_filter(adapter, addr->sa_data);
+
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	f = i40evf_add_filter(adapter, addr->sa_data);
 	if (f) {
 		ether_addr_copy(hw->mac.addr, addr->sa_data);
 		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
@@ -880,50 +877,64 @@ static int i40evf_set_mac(struct net_device *netdev, void *p)
 }
 
 /**
- * i40evf_set_rx_mode - NDO callback to set the netdev filters
- * @netdev: network interface device structure
- **/
-static void i40evf_set_rx_mode(struct net_device *netdev)
+ * i40evf_addr_sync - Callback for dev_(mc|uc)_sync to add address
+ * @netdev: the netdevice
+ * @addr: address to add
+ *
+ * Called by __dev_(mc|uc)_sync when an address needs to be added. We call
+ * __dev_(uc|mc)_sync from .set_rx_mode and guarantee to hold the hash lock.
+ */
+static int i40evf_addr_sync(struct net_device *netdev, const u8 *addr)
 {
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
-	struct i40evf_mac_filter *f, *ftmp;
-	struct netdev_hw_addr *uca;
-	struct netdev_hw_addr *mca;
-	struct netdev_hw_addr *ha;
-
-	/* add addr if not already in the filter list */
-	netdev_for_each_uc_addr(uca, netdev) {
-		i40evf_add_filter(adapter, uca->addr);
-	}
-	netdev_for_each_mc_addr(mca, netdev) {
-		i40evf_add_filter(adapter, mca->addr);
-	}
-
-	spin_lock_bh(&adapter->mac_vlan_list_lock);
-
-	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
-		netdev_for_each_mc_addr(mca, netdev)
-			if (ether_addr_equal(mca->addr, f->macaddr))
-				goto bottom_of_search_loop;
 
-		netdev_for_each_uc_addr(uca, netdev)
-			if (ether_addr_equal(uca->addr, f->macaddr))
-				goto bottom_of_search_loop;
+	if (i40evf_add_filter(adapter, addr))
+		return 0;
+	else
+		return -ENOMEM;
+}
 
-		for_each_dev_addr(netdev, ha)
-			if (ether_addr_equal(ha->addr, f->macaddr))
-				goto bottom_of_search_loop;
+/**
+ * i40evf_addr_unsync - Callback for dev_(mc|uc)_sync to remove address
+ * @netdev: the netdevice
+ * @addr: address to add
+ *
+ * Called by __dev_(mc|uc)_sync when an address needs to be removed. We call
+ * __dev_(uc|mc)_sync from .set_rx_mode and guarantee to hold the hash lock.
+ */
+static int i40evf_addr_unsync(struct net_device *netdev, const u8 *addr)
+{
+	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct i40evf_mac_filter *f;
 
-		if (ether_addr_equal(f->macaddr, adapter->hw.mac.addr))
-			goto bottom_of_search_loop;
+	/* Under some circumstances, we might receive a request to delete
+	 * our own device address from our uc list. Because we store the
+	 * device address in the VSI's MAC/VLAN filter list, we need to ignore
+	 * such requests and not delete our device address from this list.
+	 */
+	if (ether_addr_equal(addr, netdev->dev_addr))
+		return 0;
 
-		/* f->macaddr wasn't found in uc, mc, or ha list so delete it */
+	f = i40evf_find_filter(adapter, addr);
+	if (f) {
 		f->remove = true;
 		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_MAC_FILTER;
-
-bottom_of_search_loop:
-		continue;
 	}
+	return 0;
+}
+
+/**
+ * i40evf_set_rx_mode - NDO callback to set the netdev filters
+ * @netdev: network interface device structure
+ **/
+static void i40evf_set_rx_mode(struct net_device *netdev)
+{
+	struct i40evf_adapter *adapter = netdev_priv(netdev);
+
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+	__dev_uc_sync(netdev, i40evf_addr_sync, i40evf_addr_unsync);
+	__dev_mc_sync(netdev, i40evf_addr_sync, i40evf_addr_unsync);
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	if (netdev->flags & IFF_PROMISC &&
 	    !(adapter->flags & I40EVF_FLAG_PROMISC_ON))
@@ -938,8 +949,6 @@ static void i40evf_set_rx_mode(struct net_device *netdev)
 	else if (!(netdev->flags & IFF_ALLMULTI) &&
 		 adapter->flags & I40EVF_FLAG_ALLMULTI_ON)
 		adapter->aq_required |= I40EVF_FLAG_AQ_RELEASE_ALLMULTI;
-
-	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
 /**
@@ -1041,10 +1050,15 @@ void i40evf_down(struct i40evf_adapter *adapter)
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
+	/* clear the sync flag on all filters */
+	__dev_uc_unsync(adapter->netdev, NULL);
+	__dev_mc_unsync(adapter->netdev, NULL);
+
 	/* remove all MAC filters */
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
 		f->remove = true;
 	}
+
 	/* remove all VLAN filters */
 	list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
 		f->remove = true;
@@ -2239,7 +2253,12 @@ static int i40evf_open(struct net_device *netdev)
 	if (err)
 		goto err_req_irq;
 
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	i40evf_add_filter(adapter, adapter->hw.mac.addr);
+
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	i40evf_configure(adapter);
 
 	i40evf_up_complete(adapter);
-- 
2.9.5

