From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  5 Oct 2016 09:30:36 -0700
Subject: [Intel-wired-lan] [next PATCH S49-V2 06/15] i40e: implement
	__i40e_del_filter and use where applicable
In-Reply-To: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475685046-16900-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When inside a loop where we call i40e_del_filter we use an O(n^2)
pattern where i40e_del_filter calls i40e_find_filter for us. We can
avoid this O(n^2) logic by factoring a function, __i40e_del_filter() out
from the i40e_del_filter code. This allows us to re-use the delete logic
where appropriate without having to search for the filter twice.

This new function benefits several functions including i40e_vsi_add_vlan,
i40e_vsi_kill_vlan, i40e_del_mac_vlan_all, and i40e_vsi_release.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I75fabe0f53bf73f56b80d342e5fdcfcc28f4d3eb
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 92 ++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d365652..5692390 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1271,10 +1271,13 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 }
 
 /**
- * i40e_del_filter - Remove a mac/vlan filter from the VSI
- * @vsi: the VSI to be searched
- * @macaddr: the MAC address
- * @vlan: the vlan
+ * __i40e_del_filter - Remove a specific filter from the VSI
+ * @vsi: VSI to remove from
+ * @f: the filter to remove from the list
+ *
+ * This function should be called instead of i40e_del_filter only if you know
+ * the exact filter you will remove already, such as via i40e_find_filter or
+ * i40e_find_mac.
  *
  * NOTE: This function is expected to be called with mac_filter_list_lock
  * being held.
@@ -1282,14 +1285,8 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
  * the "safe" variants of any list iterators, e.g. list_for_each_entry_safe()
  * instead of list_for_each_entry().
  **/
-void i40e_del_filter(struct i40e_vsi *vsi, const u8 *macaddr, s16 vlan)
+static void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f)
 {
-	struct i40e_mac_filter *f;
-
-	if (!vsi || !macaddr)
-		return;
-
-	f = i40e_find_filter(vsi, macaddr, vlan);
 	if (!f)
 		return;
 
@@ -1308,6 +1305,29 @@ void i40e_del_filter(struct i40e_vsi *vsi, const u8 *macaddr, s16 vlan)
 }
 
 /**
+ * i40e_del_filter - Remove a mac/vlan filter from the VSI
+ * @vsi: the VSI to be searched
+ * @macaddr: the MAC address
+ * @vlan: the vlan
+ *
+ * NOTE: This function is expected to be called with mac_filter_list_lock
+ * being held.
+ * ANOTHER NOTE: This function MUST be called from within the context of
+ * the "safe" variants of any list iterators, e.g. list_for_each_entry_safe()
+ * instead of list_for_each_entry().
+ **/
+void i40e_del_filter(struct i40e_vsi *vsi, const u8 *macaddr, s16 vlan)
+{
+	struct i40e_mac_filter *f;
+
+	if (!vsi || !macaddr)
+		return;
+
+	f = i40e_find_filter(vsi, macaddr, vlan);
+	__i40e_del_filter(vsi, f);
+}
+
+/**
  * i40e_put_mac_in_vlan - Make macvlan filters from macaddrs and vlans
  * @vsi: the VSI to be searched
  * @macaddr: the mac address to be filtered
@@ -1349,21 +1369,22 @@ struct i40e_mac_filter *i40e_put_mac_in_vlan(struct i40e_vsi *vsi,
  **/
 int i40e_del_mac_all_vlan(struct i40e_vsi *vsi, const u8 *macaddr)
 {
-	struct i40e_mac_filter *f = NULL;
-	int changed = 0;
+	struct i40e_mac_filter *f, *ftmp;
+	bool found = false;
 
 	WARN(!spin_is_locked(&vsi->mac_filter_list_lock),
 	     "Missing mac_filter_list_lock\n");
-	list_for_each_entry(f, &vsi->mac_filter_list, list) {
-		if (ether_addr_equal(macaddr, f->macaddr))
-			f->state = I40E_FILTER_REMOVE;
+	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
+		if (ether_addr_equal(macaddr, f->macaddr)) {
+			__i40e_del_filter(vsi, f);
+			found = true;
+		}
 	}
-	if (changed) {
-		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
-		vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
+
+	if (found)
 		return 0;
-	}
-	return -ENOENT;
+	else
+		return -ENOENT;
 }
 
 /**
@@ -2249,7 +2270,7 @@ static void i40e_vlan_rx_register(struct net_device *netdev, u32 features)
  **/
 int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 {
-	struct i40e_mac_filter *f, *ftmp, *add_f;
+	struct i40e_mac_filter *f, *ftmp, *add_f, *del_f;
 
 	/* Locked once because all functions invoked below iterates list*/
 	spin_lock_bh(&vsi->mac_filter_list_lock);
@@ -2283,11 +2304,11 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 	 * with 0, so we now accept untagged and specified tagged traffic
 	 * (and not all tags along with untagged)
 	 */
-	if (vid > 0) {
-		if (vsi->netdev && i40e_find_filter(vsi, vsi->netdev->dev_addr,
-						    I40E_VLAN_ANY)) {
-			i40e_del_filter(vsi, vsi->netdev->dev_addr,
-					I40E_VLAN_ANY);
+	if (vid > 0 && vsi->netdev) {
+		del_f = i40e_find_filter(vsi, vsi->netdev->dev_addr,
+					 I40E_VLAN_ANY);
+		if (del_f) {
+			__i40e_del_filter(vsi, del_f);
 			add_f = i40e_add_filter(vsi, vsi->netdev->dev_addr, 0);
 			if (!add_f) {
 				dev_info(&vsi->back->pdev->dev,
@@ -2304,9 +2325,11 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 		list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
 			if (f->state == I40E_FILTER_REMOVE)
 				continue;
-			if (!i40e_find_filter(vsi, f->macaddr, I40E_VLAN_ANY))
+			del_f = i40e_find_filter(vsi, f->macaddr,
+						 I40E_VLAN_ANY);
+			if (!del_f)
 				continue;
-			i40e_del_filter(vsi, f->macaddr, I40E_VLAN_ANY);
+			__i40e_del_filter(vsi, del_f);
 			add_f = i40e_add_filter(vsi, f->macaddr, 0);
 			if (!add_f) {
 				dev_info(&vsi->back->pdev->dev,
@@ -2346,8 +2369,10 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 	if (vsi->netdev)
 		i40e_del_filter(vsi, netdev->dev_addr, vid);
 
-	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list)
-		i40e_del_filter(vsi, f->macaddr, vid);
+	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
+		if (f->vlan == vid)
+			__i40e_del_filter(vsi, f);
+	}
 
 	/* go through all the filters for this VSI and if there is only
 	 * vid == 0 it means there are no other filters, so vid 0 must
@@ -2379,7 +2404,8 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 
 	if (!filter_count) {
 		list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
-			i40e_del_filter(vsi, f->macaddr, 0);
+			if (!f->vlan)
+				__i40e_del_filter(vsi, f);
 			add_f = i40e_add_filter(vsi, f->macaddr, I40E_VLAN_ANY);
 			if (!add_f) {
 				dev_info(&vsi->back->pdev->dev,
@@ -9442,7 +9468,7 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 
 	/* make sure any remaining filters are marked for deletion */
 	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list)
-		i40e_del_filter(vsi, f->macaddr, f->vlan);
+		__i40e_del_filter(vsi, f);
 
 	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
-- 
2.4.11

