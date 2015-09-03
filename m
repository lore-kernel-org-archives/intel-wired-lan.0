From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:51 -0400
Subject: [Intel-wired-lan] [next PATCH S15 04/15] i40e: Lock for VSI's MAC
	filter list
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

This patch introduces a spinlock which is to be used for synchronizing
access to VSI's MAC filter list.

This patch also synchronizes execution of other codepaths which are
accessing VSI's MAC filter list with execution of
service_task:sync_vsi_filters.

In function i40e_add_vsi, copied out LAA MAC address instead of cloning
MAC filter entry because only MAC address is needed to remove MAC VLAN
filter from FW/HW.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I0e10ac7c715d44aa994239642aa4d57c998573a2
---
 drivers/net/ethernet/intel/i40e/i40e.h             |   2 +
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 326 +++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  26 +-
 4 files changed, 300 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 77148f3..a2a1d22 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -469,6 +469,8 @@ struct i40e_vsi {
 #define I40E_VSI_FLAG_VEB_OWNER		BIT(1)
 	unsigned long flags;
 
+	/* Per VSI lock to protect elements/list (MAC filter) */
+	spinlock_t mac_filter_list_lock;
 	struct list_head mac_filter_list;
 
 	/* VSI stats */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
index 2ec2411..61df19e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
@@ -1516,10 +1516,12 @@ void i40e_fcoe_config_netdev(struct net_device *netdev, struct i40e_vsi *vsi)
 	 * same PCI function.
 	 */
 	netdev->dev_port = 1;
+	spin_lock(&vsi->mac_filter_list_lock);
 	i40e_add_filter(vsi, hw->mac.san_addr, 0, false, false);
 	i40e_add_filter(vsi, (u8[6]) FC_FCOE_FLOGI_MAC, 0, false, false);
 	i40e_add_filter(vsi, FIP_ALL_FCOE_MACS, 0, false, false);
 	i40e_add_filter(vsi, FIP_ALL_ENODE_MACS, 0, false, false);
+	spin_unlock(&vsi->mac_filter_list_lock);
 
 	/* use san mac */
 	ether_addr_copy(netdev->dev_addr, hw->mac.san_addr);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 23f36be..a323d6d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1212,6 +1212,9 @@ static struct i40e_mac_filter *i40e_find_filter(struct i40e_vsi *vsi,
 {
 	struct i40e_mac_filter *f;
 
+	WARN(!spin_is_locked(&vsi->mac_filter_list_lock),
+	     "Missing mac_filter_list_lock\n");
+
 	if (!vsi || !macaddr)
 		return NULL;
 
@@ -1240,6 +1243,9 @@ struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, u8 *macaddr,
 {
 	struct i40e_mac_filter *f;
 
+	WARN(!spin_is_locked(&vsi->mac_filter_list_lock),
+	     "Missing mac_filter_list_lock\n");
+
 	if (!vsi || !macaddr)
 		return NULL;
 
@@ -1262,6 +1268,9 @@ bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi)
 {
 	struct i40e_mac_filter *f;
 
+	WARN(!spin_is_locked(&vsi->mac_filter_list_lock),
+	     "Missing mac_filter_list_lock\n");
+
 	/* Only -1 for all the filters denotes not in vlan mode
 	 * so we have to go through all the list in order to make sure
 	 */
@@ -1290,6 +1299,9 @@ struct i40e_mac_filter *i40e_put_mac_in_vlan(struct i40e_vsi *vsi, u8 *macaddr,
 {
 	struct i40e_mac_filter *f;
 
+	WARN(!spin_is_locked(&vsi->mac_filter_list_lock),
+	     "Missing mac_filter_list_lock\n");
+
 	list_for_each_entry(f, &vsi->mac_filter_list, list) {
 		if (vsi->info.pvid)
 			f->vlan = le16_to_cpu(vsi->info.pvid);
@@ -1344,6 +1356,10 @@ static int i40e_rm_default_mac_filter(struct i40e_vsi *vsi, u8 *macaddr)
  * @is_netdev: make sure its a netdev filter, else doesn't matter
  *
  * Returns ptr to the filter object or NULL when no memory available.
+ *
+ * NOTE: This function is expected to be called with mac_filter_list_lock
+ * being held. If needed could add WARN/BUG_ON if lock is not held for debug
+ * purpose.
  **/
 struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 					u8 *macaddr, s16 vlan,
@@ -1351,6 +1367,9 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 {
 	struct i40e_mac_filter *f;
 
+	WARN(!spin_is_locked(&vsi->mac_filter_list_lock),
+	     "Missing mac_filter_list_lock\n");
+
 	if (!vsi || !macaddr)
 		return NULL;
 
@@ -1402,6 +1421,10 @@ add_filter_out:
  * @vlan: the vlan
  * @is_vf: make sure it's a VF filter, else doesn't matter
  * @is_netdev: make sure it's a netdev filter, else doesn't matter
+ *
+ * NOTE: This function is expected to be called with mac_filter_list_lock
+ * being held. If needed could add WARN/BUG_ON if lock is not held for debug
+ * purpose.
  **/
 void i40e_del_filter(struct i40e_vsi *vsi,
 		     u8 *macaddr, s16 vlan,
@@ -1409,6 +1432,9 @@ void i40e_del_filter(struct i40e_vsi *vsi,
 {
 	struct i40e_mac_filter *f;
 
+	WARN(!spin_is_locked(&vsi->mac_filter_list_lock),
+	     "Missing mac_filter_list_lock\n");
+
 	if (!vsi || !macaddr)
 		return;
 
@@ -1520,10 +1546,12 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 		element.flags = cpu_to_le16(I40E_AQC_MACVLAN_ADD_PERFECT_MATCH);
 		i40e_aq_add_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
 	} else {
+		spin_lock(&vsi->mac_filter_list_lock);
 		f = i40e_add_filter(vsi, addr->sa_data, I40E_VLAN_ANY,
 				    false, false);
 		if (f)
 			f->is_laa = true;
+		spin_unlock(&vsi->mac_filter_list_lock);
 	}
 
 	i40e_sync_vsi_filters(vsi);
@@ -1696,6 +1724,8 @@ static void i40e_set_rx_mode(struct net_device *netdev)
 	struct netdev_hw_addr *mca;
 	struct netdev_hw_addr *ha;
 
+	spin_lock(&vsi->mac_filter_list_lock);
+
 	/* add addr if not already in the filter list */
 	netdev_for_each_uc_addr(uca, netdev) {
 		if (!i40e_find_mac(vsi, uca->addr, false, true)) {
@@ -1743,6 +1773,7 @@ static void i40e_set_rx_mode(struct net_device *netdev)
 bottom_of_search_loop:
 		continue;
 	}
+	spin_unlock(&vsi->mac_filter_list_lock);
 
 	/* check for other flag changes */
 	if (vsi->current_netdev_flags != vsi->netdev->flags) {
@@ -1752,6 +1783,79 @@ bottom_of_search_loop:
 }
 
 /**
+ * i40e_mac_filter_entry_clone - Clones a MAC filter entry
+ * @src: source MAC filter entry to be clones
+ *
+ * Returns the pointer to newly cloned MAC filter entry or NULL
+ * in case of error
+ **/
+static struct i40e_mac_filter *i40e_mac_filter_entry_clone(
+					struct i40e_mac_filter *src)
+{
+	struct i40e_mac_filter *f;
+
+	f = kzalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return NULL;
+	*f = *src;
+
+	INIT_LIST_HEAD(&f->list);
+
+	return f;
+}
+
+/**
+ * i40e_undo_del_filter_entries - Undo the changes made to MAC filter entries
+ * @from: Pointer to list which contains MAC filter entries - changes to
+ *        those entries needs to be undone.
+ *
+ * MAC filter entries from list were slated to be removed from device.
+ **/
+static void i40e_undo_del_filter_entries(struct i40e_vsi *vsi,
+					 struct list_head *from)
+{
+	struct i40e_mac_filter *f, *ftmp;
+
+	list_for_each_entry_safe(f, ftmp, from, list) {
+		f->changed = true;
+		/* Move the element back into MAC filter list*/
+		list_move_tail(&f->list, &vsi->mac_filter_list);
+	}
+}
+
+/**
+ * i40e_undo_add_filter_entries - Undo the changes made to MAC filter entries
+ * @from: Pointer to list which contains MAC filter entries - changes to
+ *        those entries needs to be undone.
+ *
+ * MAC filter entries from list were slated to be added from device.
+ **/
+static void i40e_undo_add_filter_entries(struct i40e_vsi *vsi)
+{
+	struct i40e_mac_filter *f, *ftmp;
+
+	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
+		if (!f->changed && f->counter)
+			f->changed = true;
+	}
+}
+
+/**
+ * i40e_cleanup_add_list - Deletes the element from add list and release
+ *			memory
+ * @from: Pointer to list which contains MAC filter entries
+ **/
+static void i40e_cleanup_add_list(struct list_head *add_list)
+{
+	struct i40e_mac_filter *f, *ftmp;
+
+	list_for_each_entry_safe(f, ftmp, add_list, list) {
+		list_del(&f->list);
+		kfree(f);
+	}
+}
+
+/**
  * i40e_sync_vsi_filters - Update the VSI filter list to the HW
  * @vsi: ptr to the VSI
  *
@@ -1761,11 +1865,13 @@ bottom_of_search_loop:
  **/
 int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 {
-	struct i40e_mac_filter *f, *ftmp;
+	struct list_head tmp_del_list, tmp_add_list;
+	struct i40e_mac_filter *f, *ftmp, *fclone;
 	bool promisc_forced_on = false;
 	bool add_happened = false;
 	int filter_list_len = 0;
 	u32 changed_flags = 0;
+	bool err_cond = false;
 	i40e_status ret = 0;
 	struct i40e_pf *pf;
 	int num_add = 0;
@@ -1786,17 +1892,13 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		vsi->current_netdev_flags = vsi->netdev->flags;
 	}
 
+	INIT_LIST_HEAD(&tmp_del_list);
+	INIT_LIST_HEAD(&tmp_add_list);
+
 	if (vsi->flags & I40E_VSI_FLAG_FILTER_CHANGED) {
 		vsi->flags &= ~I40E_VSI_FLAG_FILTER_CHANGED;
 
-		filter_list_len = pf->hw.aq.asq_buf_size /
-			    sizeof(struct i40e_aqc_remove_macvlan_element_data);
-		del_list = kcalloc(filter_list_len,
-			    sizeof(struct i40e_aqc_remove_macvlan_element_data),
-			    GFP_KERNEL);
-		if (!del_list)
-			return -ENOMEM;
-
+		spin_lock(&vsi->mac_filter_list_lock);
 		list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
 			if (!f->changed)
 				continue;
@@ -1804,6 +1906,58 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			if (f->counter != 0)
 				continue;
 			f->changed = false;
+
+			/* Move the element into temporary del_list */
+			list_move_tail(&f->list, &tmp_del_list);
+		}
+
+		list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
+			if (!f->changed)
+				continue;
+
+			if (f->counter == 0)
+				continue;
+			f->changed = false;
+
+			/* Clone MAC filter entry and add into temporary list */
+			fclone = i40e_mac_filter_entry_clone(f);
+			if (!fclone) {
+				err_cond = true;
+				break;
+			}
+			list_add_tail(&fclone->list, &tmp_add_list);
+		}
+
+		/* if failed to clone MAC filter entry - undo */
+		if (err_cond) {
+			i40e_undo_del_filter_entries(vsi, &tmp_del_list);
+			i40e_undo_add_filter_entries(vsi);
+		}
+		spin_unlock(&vsi->mac_filter_list_lock);
+
+		if (err_cond)
+			i40e_cleanup_add_list(&tmp_add_list);
+	}
+
+	/* Now process 'del_list' outside the lock */
+	if (!list_empty(&tmp_del_list)) {
+		filter_list_len = pf->hw.aq.asq_buf_size /
+			    sizeof(struct i40e_aqc_remove_macvlan_element_data);
+		del_list = kcalloc(filter_list_len,
+			    sizeof(struct i40e_aqc_remove_macvlan_element_data),
+			    GFP_KERNEL);
+		if (!del_list) {
+			i40e_cleanup_add_list(&tmp_add_list);
+
+			/* Undo VSI's MAC filter entry element updates */
+			spin_lock(&vsi->mac_filter_list_lock);
+			i40e_undo_del_filter_entries(vsi, &tmp_del_list);
+			i40e_undo_add_filter_entries(vsi);
+			spin_unlock(&vsi->mac_filter_list_lock);
+			return -ENOMEM;
+		}
+
+		list_for_each_entry_safe(f, ftmp, &tmp_del_list, list) {
 			cmd_flags = 0;
 
 			/* add to delete list */
@@ -1816,10 +1970,6 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			del_list[num_del].flags = cmd_flags;
 			num_del++;
 
-			/* unlink from filter list */
-			list_del(&f->list);
-			kfree(f);
-
 			/* flush a full buffer */
 			if (num_del == filter_list_len) {
 				ret = i40e_aq_remove_macvlan(&pf->hw,
@@ -1830,12 +1980,18 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				memset(del_list, 0, sizeof(*del_list));
 
 				if (ret && aq_err != I40E_AQ_RC_ENOENT)
-					dev_info(&pf->pdev->dev,
-						 "ignoring delete macvlan error, err %s, aq_err %s while flushing a full buffer\n",
-						 i40e_stat_str(&pf->hw, ret),
-						 i40e_aq_str(&pf->hw, aq_err));
+					dev_err(&pf->pdev->dev,
+						"ignoring delete macvlan error, err %s, aq_err %s while flushing a full buffer\n",
+						i40e_stat_str(&pf->hw, ret),
+						i40e_aq_str(&pf->hw, aq_err));
 			}
+			/* Release memory for MAC filter entries which were
+			 * synced up with HW.
+			 */
+			list_del(&f->list);
+			kfree(f);
 		}
+
 		if (num_del) {
 			ret = i40e_aq_remove_macvlan(&pf->hw, vsi->seid,
 						     del_list, num_del, NULL);
@@ -1851,6 +2007,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 
 		kfree(del_list);
 		del_list = NULL;
+	}
+
+	if (!list_empty(&tmp_add_list)) {
 
 		/* do all the adds now */
 		filter_list_len = pf->hw.aq.asq_buf_size /
@@ -1858,16 +2017,19 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		add_list = kcalloc(filter_list_len,
 			       sizeof(struct i40e_aqc_add_macvlan_element_data),
 			       GFP_KERNEL);
-		if (!add_list)
+		if (!add_list) {
+			/* Purge element from temporary lists */
+			i40e_cleanup_add_list(&tmp_add_list);
+
+			/* Undo add filter entries from VSI MAC filter list */
+			spin_lock(&vsi->mac_filter_list_lock);
+			i40e_undo_add_filter_entries(vsi);
+			spin_unlock(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
+		}
 
-		list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
-			if (!f->changed)
-				continue;
+		list_for_each_entry_safe(f, ftmp, &tmp_add_list, list) {
 
-			if (f->counter == 0)
-				continue;
-			f->changed = false;
 			add_happened = true;
 			cmd_flags = 0;
 
@@ -1894,7 +2056,13 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 					break;
 				memset(add_list, 0, sizeof(*add_list));
 			}
+			/* Entries from tmp_add_list were cloned from MAC
+			 * filter list, hence clean those cloned entries
+			 */
+			list_del(&f->list);
+			kfree(f);
 		}
+
 		if (num_add) {
 			ret = i40e_aq_add_macvlan(&pf->hw, vsi->seid,
 						  add_list, num_add, NULL);
@@ -2122,6 +2290,9 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 	is_vf = (vsi->type == I40E_VSI_SRIOV);
 	is_netdev = !!(vsi->netdev);
 
+	/* Locked once because all functions invoked below iterates list*/
+	spin_lock(&vsi->mac_filter_list_lock);
+
 	if (is_netdev) {
 		add_f = i40e_add_filter(vsi, vsi->netdev->dev_addr, vid,
 					is_vf, is_netdev);
@@ -2129,6 +2300,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 			dev_info(&vsi->back->pdev->dev,
 				 "Could not add vlan filter %d for %pM\n",
 				 vid, vsi->netdev->dev_addr);
+			spin_unlock(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
 		}
 	}
@@ -2139,6 +2311,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 			dev_info(&vsi->back->pdev->dev,
 				 "Could not add vlan filter %d for %pM\n",
 				 vid, f->macaddr);
+			spin_unlock(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
 		}
 	}
@@ -2160,6 +2333,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 				dev_info(&vsi->back->pdev->dev,
 					 "Could not add filter 0 for %pM\n",
 					 vsi->netdev->dev_addr);
+				spin_unlock(&vsi->mac_filter_list_lock);
 				return -ENOMEM;
 			}
 		}
@@ -2168,22 +2342,28 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 	/* Do not assume that I40E_VLAN_ANY should be reset to VLAN 0 */
 	if (vid > 0 && !vsi->info.pvid) {
 		list_for_each_entry(f, &vsi->mac_filter_list, list) {
-			if (i40e_find_filter(vsi, f->macaddr, I40E_VLAN_ANY,
-					     is_vf, is_netdev)) {
-				i40e_del_filter(vsi, f->macaddr, I40E_VLAN_ANY,
-						is_vf, is_netdev);
-				add_f = i40e_add_filter(vsi, f->macaddr,
-							0, is_vf, is_netdev);
-				if (!add_f) {
-					dev_info(&vsi->back->pdev->dev,
-						 "Could not add filter 0 for %pM\n",
-						 f->macaddr);
-					return -ENOMEM;
-				}
+			if (!i40e_find_filter(vsi, f->macaddr, I40E_VLAN_ANY,
+					      is_vf, is_netdev))
+				continue;
+			i40e_del_filter(vsi, f->macaddr, I40E_VLAN_ANY,
+					is_vf, is_netdev);
+			add_f = i40e_add_filter(vsi, f->macaddr,
+						0, is_vf, is_netdev);
+			if (!add_f) {
+				dev_info(&vsi->back->pdev->dev,
+					 "Could not add filter 0 for %pM\n",
+					f->macaddr);
+				spin_unlock(&vsi->mac_filter_list_lock);
+				return -ENOMEM;
 			}
 		}
 	}
 
+	/* Make sure to release before sync_vsi_filter because that
+	 * function will lock/unlock as necessary
+	 */
+	spin_unlock(&vsi->mac_filter_list_lock);
+
 	if (test_bit(__I40E_DOWN, &vsi->back->state) ||
 	    test_bit(__I40E_RESET_RECOVERY_PENDING, &vsi->back->state))
 		return 0;
@@ -2208,6 +2388,9 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 	is_vf = (vsi->type == I40E_VSI_SRIOV);
 	is_netdev = !!(netdev);
 
+	/* Locked once because all functions invoked below iterates list */
+	spin_lock(&vsi->mac_filter_list_lock);
+
 	if (is_netdev)
 		i40e_del_filter(vsi, netdev->dev_addr, vid, is_vf, is_netdev);
 
@@ -2238,6 +2421,7 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 			dev_info(&vsi->back->pdev->dev,
 				 "Could not add filter %d for %pM\n",
 				 I40E_VLAN_ANY, netdev->dev_addr);
+			spin_unlock(&vsi->mac_filter_list_lock);
 			return -ENOMEM;
 		}
 	}
@@ -2246,16 +2430,22 @@ int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid)
 		list_for_each_entry(f, &vsi->mac_filter_list, list) {
 			i40e_del_filter(vsi, f->macaddr, 0, is_vf, is_netdev);
 			add_f = i40e_add_filter(vsi, f->macaddr, I40E_VLAN_ANY,
-					    is_vf, is_netdev);
+						is_vf, is_netdev);
 			if (!add_f) {
 				dev_info(&vsi->back->pdev->dev,
 					 "Could not add filter %d for %pM\n",
 					 I40E_VLAN_ANY, f->macaddr);
+				spin_unlock(&vsi->mac_filter_list_lock);
 				return -ENOMEM;
 			}
 		}
 	}
 
+	/* Make sure to release before sync_vsi_filter because that
+	 * function with lock/unlock as necessary
+	 */
+	spin_unlock(&vsi->mac_filter_list_lock);
+
 	if (test_bit(__I40E_DOWN, &vsi->back->state) ||
 	    test_bit(__I40E_RESET_RECOVERY_PENDING, &vsi->back->state))
 		return 0;
@@ -6987,6 +7177,8 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 	/* Setup default MSIX irq handler for VSI */
 	i40e_vsi_setup_irqhandler(vsi, i40e_msix_clean_rings);
 
+	/* Initialize VSI lock */
+	spin_lock_init(&vsi->mac_filter_list_lock);
 	pf->vsi[vsi_idx] = vsi;
 	ret = vsi_idx;
 	goto unlock_pf;
@@ -8510,17 +8702,26 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 		 * default a MAC-VLAN filter that accepts any tagged packet
 		 * which must be replaced by a normal filter.
 		 */
-		if (!i40e_rm_default_mac_filter(vsi, mac_addr))
+		if (!i40e_rm_default_mac_filter(vsi, mac_addr)) {
+			spin_lock(&vsi->mac_filter_list_lock);
 			i40e_add_filter(vsi, mac_addr,
 					I40E_VLAN_ANY, false, true);
+			spin_unlock(&vsi->mac_filter_list_lock);
+		}
 	} else {
 		/* relate the VSI_VMDQ name to the VSI_MAIN name */
 		snprintf(netdev->name, IFNAMSIZ, "%sv%%d",
 			 pf->vsi[pf->lan_vsi]->netdev->name);
 		random_ether_addr(mac_addr);
+
+		spin_lock(&vsi->mac_filter_list_lock);
 		i40e_add_filter(vsi, mac_addr, I40E_VLAN_ANY, false, false);
+		spin_unlock(&vsi->mac_filter_list_lock);
 	}
+
+	spin_lock(&vsi->mac_filter_list_lock);
 	i40e_add_filter(vsi, brdcast, I40E_VLAN_ANY, false, false);
+	spin_unlock(&vsi->mac_filter_list_lock);
 
 	ether_addr_copy(netdev->dev_addr, mac_addr);
 	ether_addr_copy(netdev->perm_addr, mac_addr);
@@ -8594,10 +8795,13 @@ int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi)
 static int i40e_add_vsi(struct i40e_vsi *vsi)
 {
 	int ret = -ENODEV;
-	struct i40e_mac_filter *f, *ftmp;
+	u8 laa_macaddr[ETH_ALEN];
+	bool found_laa_mac_filter = false;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vsi_context ctxt;
+	struct i40e_mac_filter *f, *ftmp;
+
 	u8 enabled_tc = 0x1; /* TC0 enabled */
 	int f_count = 0;
 
@@ -8769,32 +8973,41 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 		vsi->id = ctxt.vsi_number;
 	}
 
+	spin_lock(&vsi->mac_filter_list_lock);
 	/* If macvlan filters already exist, force them to get loaded */
 	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list) {
 		f->changed = true;
 		f_count++;
 
+		/* Expected to have only one MAC filter entry for LAA in list */
 		if (f->is_laa && vsi->type == I40E_VSI_MAIN) {
-			struct i40e_aqc_remove_macvlan_element_data element;
+			ether_addr_copy(laa_macaddr, f->macaddr);
+			found_laa_mac_filter = true;
+		}
+	}
+	spin_unlock(&vsi->mac_filter_list_lock);
 
-			memset(&element, 0, sizeof(element));
-			ether_addr_copy(element.mac_addr, f->macaddr);
-			element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH;
-			ret = i40e_aq_remove_macvlan(hw, vsi->seid,
-						     &element, 1, NULL);
-			if (ret) {
-				/* some older FW has a different default */
-				element.flags |=
-					       I40E_AQC_MACVLAN_DEL_IGNORE_VLAN;
-				i40e_aq_remove_macvlan(hw, vsi->seid,
-						       &element, 1, NULL);
-			}
+	if (found_laa_mac_filter) {
+		struct i40e_aqc_remove_macvlan_element_data element;
 
-			i40e_aq_mac_address_write(hw,
-						  I40E_AQC_WRITE_TYPE_LAA_WOL,
-						  f->macaddr, NULL);
+		memset(&element, 0, sizeof(element));
+		ether_addr_copy(element.mac_addr, laa_macaddr);
+		element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH;
+		ret = i40e_aq_remove_macvlan(hw, vsi->seid,
+					     &element, 1, NULL);
+		if (ret) {
+			/* some older FW has a different default */
+			element.flags |=
+				       I40E_AQC_MACVLAN_DEL_IGNORE_VLAN;
+			i40e_aq_remove_macvlan(hw, vsi->seid,
+					       &element, 1, NULL);
 		}
+
+		i40e_aq_mac_address_write(hw,
+					  I40E_AQC_WRITE_TYPE_LAA_WOL,
+					  laa_macaddr, NULL);
 	}
+
 	if (f_count) {
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 		pf->flags |= I40E_FLAG_FILTER_SYNC;
@@ -8857,9 +9070,12 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 		i40e_vsi_disable_irq(vsi);
 	}
 
+	spin_lock(&vsi->mac_filter_list_lock);
 	list_for_each_entry_safe(f, ftmp, &vsi->mac_filter_list, list)
 		i40e_del_filter(vsi, f->macaddr, f->vlan,
 				f->is_vf, f->is_netdev);
+	spin_unlock(&vsi->mac_filter_list_lock);
+
 	i40e_sync_vsi_filters(vsi);
 
 	i40e_vsi_delete(vsi);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 17c21b9..4e383f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -547,6 +547,8 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 		 */
 		if (vf->port_vlan_id)
 			i40e_vsi_add_pvid(vsi, vf->port_vlan_id);
+
+		spin_lock(&vsi->mac_filter_list_lock);
 		f = i40e_add_filter(vsi, vf->default_lan_addr.addr,
 				    vf->port_vlan_id ? vf->port_vlan_id : -1,
 				    true, false);
@@ -559,6 +561,7 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 		if (!f)
 			dev_info(&pf->pdev->dev,
 				 "Could not allocate VF broadcast filter\n");
+		spin_unlock(&vsi->mac_filter_list_lock);
 	}
 
 	/* program mac filter */
@@ -1592,6 +1595,11 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	}
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
+	/* Lock once, because all function inside for loop accesses VSI's
+	 * MAC filter list which needs to be protected using same lock.
+	 */
+	spin_lock(&vsi->mac_filter_list_lock);
+
 	/* add new addresses to the list */
 	for (i = 0; i < al->num_elements; i++) {
 		struct i40e_mac_filter *f;
@@ -1610,9 +1618,11 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 			dev_err(&pf->pdev->dev,
 				"Unable to add VF MAC filter\n");
 			ret = I40E_ERR_PARAM;
+			spin_unlock(&vsi->mac_filter_list_lock);
 			goto error_param;
 		}
 	}
+	spin_unlock(&vsi->mac_filter_list_lock);
 
 	/* program the updated filter list */
 	if (i40e_sync_vsi_filters(vsi))
@@ -1660,10 +1670,12 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	}
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
+	spin_lock(&vsi->mac_filter_list_lock);
 	/* delete addresses from the list */
 	for (i = 0; i < al->num_elements; i++)
 		i40e_del_filter(vsi, al->list[i].addr,
 				I40E_VLAN_ANY, true, false);
+	spin_unlock(&vsi->mac_filter_list_lock);
 
 	/* program the updated filter list */
 	if (i40e_sync_vsi_filters(vsi))
@@ -2060,6 +2072,11 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		goto error_param;
 	}
 
+	/* Lock once because below invoked function add/del_filter requires
+	 * mac_filter_list_lock to be held
+	 */
+	spin_lock(&vsi->mac_filter_list_lock);
+
 	/* delete the temporary mac address */
 	i40e_del_filter(vsi, vf->default_lan_addr.addr,
 			vf->port_vlan_id ? vf->port_vlan_id : -1,
@@ -2071,6 +2088,8 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	list_for_each_entry(f, &vsi->mac_filter_list, list)
 		i40e_del_filter(vsi, f->macaddr, f->vlan, true, false);
 
+	spin_unlock(&vsi->mac_filter_list_lock);
+
 	dev_info(&pf->pdev->dev, "Setting MAC %pM on VF %d\n", mac, vf_id);
 	/* program mac filter */
 	if (i40e_sync_vsi_filters(vsi)) {
@@ -2103,6 +2122,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 	u16 vlanprio = vlan_id | (qos << I40E_VLAN_PRIORITY_SHIFT);
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
+	bool is_vsi_in_vlan = false;
 	struct i40e_vsi *vsi;
 	struct i40e_vf *vf;
 	int ret = 0;
@@ -2132,7 +2152,11 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 		/* duplicate request, so just return success */
 		goto error_pvid;
 
-	if (le16_to_cpu(vsi->info.pvid) == 0 && i40e_is_vsi_in_vlan(vsi)) {
+	spin_lock(&vsi->mac_filter_list_lock);
+	is_vsi_in_vlan = i40e_is_vsi_in_vlan(vsi);
+	spin_unlock(&vsi->mac_filter_list_lock);
+
+	if (le16_to_cpu(vsi->info.pvid) == 0 && is_vsi_in_vlan) {
 		dev_err(&pf->pdev->dev,
 			"VF %d has already configured VLAN filters and the administrator is requesting a port VLAN override.\nPlease unload and reload the VF driver for this change to take effect.\n",
 			vf_id);
-- 
1.9.3

