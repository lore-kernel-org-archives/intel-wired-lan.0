From: Alice Michael <alice.michael@intel.com>
Date: Mon, 22 Jan 2018 12:00:35 -0500
Subject: [Intel-wired-lan] [next PATCH S86-V2 4/8] i40e: refactor
 promisc_changed in i40e_sync_vsi_filters
In-Reply-To: <20180122170039.14144-1-alice.michael@intel.com>
References: <20180122170039.14144-1-alice.michael@intel.com>
Message-ID: <20180122170039.14144-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

This code here is quite complex and easy to screw up.  Let's see if we
can't improve the readability and maintainability a bit.  This refactors
out promisc_changed into two variables 'old_overflow' and 'new_overflow'
which makes it a bit clearer when we're concerned about when and how
overflow promiscuous is changed.  This also makes so that we no longer
need to pass a boolean pointer to i40e_aqc_add_filters.  Instead we can
simply check if we changed the overflow promiscuous flag since the
function start.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 42 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9e1d708..315eb93 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2109,17 +2109,16 @@ void i40e_aqc_del_filters(struct i40e_vsi *vsi, const char *vsi_name,
  * @list: the list of filters to send to firmware
  * @add_head: Position in the add hlist
  * @num_add: the number of filters to add
- * @promisc_change: set to true on exit if promiscuous mode was forced on
  *
  * Send a request to firmware via AdminQ to add a chunk of filters. Will set
- * promisc_changed to true if the firmware has run out of space for more
- * filters.
+ * __I40E_VSI_OVERFLOW_PROMISC bit in vsi->state if the firmware has run out of
+ * space for more filters.
  */
 static
 void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 			  struct i40e_aqc_add_macvlan_element_data *list,
 			  struct i40e_new_mac_filter *add_head,
-			  int num_add, bool *promisc_changed)
+			  int num_add)
 {
 	struct i40e_hw *hw = &vsi->back->hw;
 	int aq_err, fcnt;
@@ -2129,7 +2128,6 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 	fcnt = i40e_update_filter_state(num_add, list, add_head);
 
 	if (fcnt != num_add) {
-		*promisc_changed = true;
 		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
 		dev_warn(&vsi->back->pdev->dev,
 			 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
@@ -2262,9 +2260,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	struct i40e_mac_filter *f;
 	struct i40e_new_mac_filter *new, *add_head = NULL;
 	struct i40e_hw *hw = &vsi->back->hw;
+	bool old_overflow, new_overflow;
 	unsigned int failed_filters = 0;
 	unsigned int vlan_filters = 0;
-	bool promisc_changed = false;
 	char vsi_name[16] = "PF";
 	int filter_list_len = 0;
 	i40e_status aq_ret = 0;
@@ -2286,6 +2284,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		usleep_range(1000, 2000);
 	pf = vsi->back;
 
+	old_overflow = test_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
+
 	if (vsi->netdev) {
 		changed_flags = vsi->current_netdev_flags ^ vsi->netdev->flags;
 		vsi->current_netdev_flags = vsi->netdev->flags;
@@ -2459,15 +2459,14 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			/* flush a full buffer */
 			if (num_add == filter_list_len) {
 				i40e_aqc_add_filters(vsi, vsi_name, add_list,
-						     add_head, num_add,
-						     &promisc_changed);
+						     add_head, num_add);
 				memset(add_list, 0, list_size);
 				num_add = 0;
 			}
 		}
 		if (num_add) {
 			i40e_aqc_add_filters(vsi, vsi_name, add_list, add_head,
-					     num_add, &promisc_changed);
+					     num_add);
 		}
 		/* Now move all of the filters from the temp add list back to
 		 * the VSI's list.
@@ -2496,24 +2495,16 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	}
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
-	/* If promiscuous mode has changed, we need to calculate a new
-	 * threshold for when we are safe to exit
-	 */
-	if (promisc_changed)
-		vsi->promisc_threshold = (vsi->active_filters * 3) / 4;
-
 	/* Check if we are able to exit overflow promiscuous mode. We can
 	 * safely exit if we didn't just enter, we no longer have any failed
 	 * filters, and we have reduced filters below the threshold value.
 	 */
-	if (test_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state) &&
-	    !promisc_changed && !failed_filters &&
-	    (vsi->active_filters < vsi->promisc_threshold)) {
+	if (old_overflow && !failed_filters &&
+	    vsi->active_filters < vsi->promisc_threshold) {
 		dev_info(&pf->pdev->dev,
 			 "filter logjam cleared on %s, leaving overflow promiscuous mode\n",
 			 vsi_name);
 		clear_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
-		promisc_changed = true;
 		vsi->promisc_threshold = 0;
 	}
 
@@ -2523,6 +2514,14 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		goto out;
 	}
 
+	new_overflow = test_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
+
+	/* If we are entering overflow promiscuous, we need to calculate a new
+	 * threshold for when we are safe to exit
+	 */
+	if (!old_overflow && new_overflow)
+		vsi->promisc_threshold = (vsi->active_filters * 3) / 4;
+
 	/* check for changes in promiscuous modes */
 	if (changed_flags & IFF_ALLMULTI) {
 		bool cur_multipromisc;
@@ -2543,12 +2542,11 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		}
 	}
 
-	if ((changed_flags & IFF_PROMISC) || promisc_changed) {
+	if ((changed_flags & IFF_PROMISC) || old_overflow != new_overflow) {
 		bool cur_promisc;
 
 		cur_promisc = (!!(vsi->current_netdev_flags & IFF_PROMISC) ||
-			       test_bit(__I40E_VSI_OVERFLOW_PROMISC,
-					vsi->state));
+			       new_overflow);
 		aq_ret = i40e_set_promiscuous(pf, cur_promisc);
 		if (aq_ret) {
 			retval = i40e_aq_rc_to_posix(aq_ret,
-- 
2.9.5

