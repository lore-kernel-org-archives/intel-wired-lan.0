From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Tue, 18 Jan 2022 13:18:54 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add usage of new
 virtchnl format to set default MAC
Message-ID: <20220118121854.9577-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use new type field of VIRTCHNL_OP_ADD_ETH_ADDR and
VIRTCHNL_OP_DEL_ETH_ADDR requests to indicate that
VF wants to change its default MAC address.

Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 12 +++++++++---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ec4f85a..7fa29a8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -876,6 +876,7 @@ struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
 		list_add_tail(&f->list, &adapter->mac_filter_list);
 		f->add = true;
 		f->is_new_mac = true;
+		f->is_primary = false;
 		adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
 	} else {
 		f->remove = false;
@@ -909,17 +910,22 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 	f = iavf_find_filter(adapter, hw->mac.addr);
 	if (f) {
 		f->remove = true;
+		f->is_primary = true;
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_MAC_FILTER;
 	}
 
 	f = iavf_add_filter(adapter, addr->sa_data);
-
-	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-
 	if (f) {
+		f->is_primary = true;
 		ether_addr_copy(hw->mac.addr, addr->sa_data);
 	}
 
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
+	/* schedule the watchdog task to immediately process the request */
+	if (f)
+		queue_work(iavf_wq, &adapter->watchdog_task.work);
+
 	return (f == NULL) ? -ENOMEM : 0;
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 5ee1d11..1889eca 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -453,6 +453,20 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 	kfree(vimi);
 }
 
+/**
+ * iavf_set_mac_addr_type - Set the correct request type basing on the filter type
+ * @virtchnl_ether_addr: pointer to requested list element
+ * @filter: pointer to requested filter
+ **/
+static void
+iavf_set_mac_addr_type(struct virtchnl_ether_addr *virtchnl_ether_addr,
+		       const struct iavf_mac_filter *filter)
+{
+	virtchnl_ether_addr->type = filter->is_primary ?
+		VIRTCHNL_ETHER_ADDR_PRIMARY :
+		VIRTCHNL_ETHER_ADDR_EXTRA;
+}
+
 /**
  * iavf_add_ether_addrs
  * @adapter: adapter structure
@@ -508,6 +522,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
 		if (f->add) {
 			ether_addr_copy(veal->list[i].addr, f->macaddr);
+			iavf_set_mac_addr_type(&veal->list[i], f);
 			i++;
 			f->add = false;
 			if (i == count)
@@ -577,6 +592,7 @@ void iavf_del_ether_addrs(struct iavf_adapter *adapter)
 	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
 		if (f->remove) {
 			ether_addr_copy(veal->list[i].addr, f->macaddr);
+			iavf_set_mac_addr_type(&veal->list[i], f);
 			i++;
 			list_del(&f->list);
 			kfree(f);
-- 
2.27.0

