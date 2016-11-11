From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:27 -0800
Subject: [Intel-wired-lan] [next PATCH S54 03/15] i40e: refactor
	i40e_update_filter_state to avoid passing aq_err
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The current caller of i40e_update_filter_state incorrectly passes
aq_ret, an i40e_status variable, instead of the expected aq_err. This
happens to work because i40e_status is actually just a typedef integer,
and 0 is still the successful return. However i40e_update_filter_state
has special handling for ENOSPC which is currently being ignored.

Also notice that firmware does not update the per-filter response for
many types of errors, such as EINVAL. Thus, modify the filter setup so
that the firmware response memory is pre-set with I40E_AQC_MM_ERR_NO_RES.

This enables us to refactor i40e_update_filter_state, removing the need
to pass aq_err and avoiding a need for having 3 different flows for
checking the filter state.

The resulting code for i40e_update_filter_state is much simpler, only
a single loop and we always check each filter response value every time.
Since we pre-set the response value to match our expected error this
correctly works for all success and error flows.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Ie292c9511f34ee18c6ef40f955ad13e28b7aea7d
---
Testing-hints:
  This shouldn't have any visible side effects, but it may help detect
  some errors from firmware more accurately. Ensure that adding and
  deleting many MAC/VLAN filters works as expected without issue and
  that the added filters function correctly.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 58 +++++++++++------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 42b6d73..8f176d0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1756,7 +1756,6 @@ static void i40e_undo_filter_entries(struct i40e_vsi *vsi,
  * @count: Number of filters added
  * @add_list: return data from fw
  * @head: pointer to first filter in current batch
- * @aq_err: status from fw
  *
  * MAC filter entries from list were slated to be added to device. Returns
  * number of successful filters. Note that 0 does NOT mean success!
@@ -1764,47 +1763,30 @@ static void i40e_undo_filter_entries(struct i40e_vsi *vsi,
 static int
 i40e_update_filter_state(int count,
 			 struct i40e_aqc_add_macvlan_element_data *add_list,
-			 struct i40e_mac_filter *add_head, int aq_err)
+			 struct i40e_mac_filter *add_head)
 {
 	int retval = 0;
 	int i;
 
-
-	if (!aq_err) {
-		retval = count;
-		/* Everything's good, mark all filters active. */
-		for (i = 0; i < count ; i++) {
-			add_head->state = I40E_FILTER_ACTIVE;
-			add_head = hlist_entry(add_head->hlist.next,
-					       typeof(struct i40e_mac_filter),
-					       hlist);
-		}
-	} else if (aq_err == I40E_AQ_RC_ENOSPC) {
-		/* Device ran out of filter space. Check the return value
-		 * for each filter to see which ones are active.
+	for (i = 0; i < count; i++) {
+		/* Always check status of each filter. We don't need to check
+		 * the firmware return status because we pre-set the filter
+		 * status to I40E_AQC_MM_ERR_NO_RES when sending the filter
+		 * request to the adminq. Thus, if it no longer matches then
+		 * we know the filter is active.
 		 */
-		for (i = 0; i < count ; i++) {
-			if (add_list[i].match_method ==
-			    I40E_AQC_MM_ERR_NO_RES) {
-				add_head->state = I40E_FILTER_FAILED;
-			} else {
-				add_head->state = I40E_FILTER_ACTIVE;
-				retval++;
-			}
-			add_head = hlist_entry(add_head->hlist.next,
-					       typeof(struct i40e_mac_filter),
-					       hlist);
-		}
-	} else {
-		/* Some other horrible thing happened, fail all filters */
-		retval = 0;
-		for (i = 0; i < count ; i++) {
+		if (add_list[i].match_method == I40E_AQC_MM_ERR_NO_RES) {
 			add_head->state = I40E_FILTER_FAILED;
-			add_head = hlist_entry(add_head->hlist.next,
-					       typeof(struct i40e_mac_filter),
-					       hlist);
+		} else {
+			add_head->state = I40E_FILTER_ACTIVE;
+			retval++;
 		}
+
+		add_head = hlist_entry(add_head->hlist.next,
+				       typeof(struct i40e_mac_filter),
+				       hlist);
 	}
+
 	return retval;
 }
 
@@ -1863,12 +1845,11 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 			  int num_add, bool *promisc_changed)
 {
 	struct i40e_hw *hw = &vsi->back->hw;
-	i40e_status aq_ret;
 	int aq_err, fcnt;
 
-	aq_ret = i40e_aq_add_macvlan(hw, vsi->seid, list, num_add, NULL);
+	i40e_aq_add_macvlan(hw, vsi->seid, list, num_add, NULL);
 	aq_err = hw->aq.asq_last_status;
-	fcnt = i40e_update_filter_state(num_add, list, add_head, aq_ret);
+	fcnt = i40e_update_filter_state(num_add, list, add_head);
 
 	if (fcnt != num_add) {
 		*promisc_changed = true;
@@ -2167,6 +2148,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 					cpu_to_le16((u16)(f->vlan));
 			}
 			add_list[num_add].queue_number = 0;
+			/* set invalid match method for later detection */
+			add_list[num_add].match_method =
+				cpu_to_le16((u16)I40E_AQC_MM_ERR_NO_RES);
 			cmd_flags |= I40E_AQC_MACVLAN_ADD_PERFECT_MATCH;
 			add_list[num_add].flags = cpu_to_le16(cmd_flags);
 			num_add++;
-- 
2.4.11

