From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri, 13 Nov 2015 15:47:11 -0800
Subject: [Intel-wired-lan] [next PATCH S22 11/14] i40e: clean whole mac
	filter list
In-Reply-To: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
References: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1447458434-4555-12-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Clean the whole mac filter list when resetting after an intermediate
add or delete push to the firmware.  The code had evolved from using
a list from the stack to a heap allocation, but the memset() didn't
follow the change correctly.  This now cleans the whole list rather
that just part of the first element.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I4cd03d5a103b7407dd8556a3a231e800f2d6f2d5
---
Testing Hints :
Compile and run the driver with basic ping tests. Also add and remove
additional address filters and make sure they work as expected.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7a6ce89..e8b5821 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1917,11 +1917,12 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 
 	/* Now process 'del_list' outside the lock */
 	if (!list_empty(&tmp_del_list)) {
+		int del_list_size;
 		filter_list_len = pf->hw.aq.asq_buf_size /
 			    sizeof(struct i40e_aqc_remove_macvlan_element_data);
-		del_list = kcalloc(filter_list_len,
-			    sizeof(struct i40e_aqc_remove_macvlan_element_data),
-			    GFP_KERNEL);
+		del_list_size = filter_list_len *
+			    sizeof(struct i40e_aqc_remove_macvlan_element_data);
+		del_list = kzalloc(del_list_size, GFP_KERNEL);
 		if (!del_list) {
 			i40e_cleanup_add_list(&tmp_add_list);
 
@@ -1956,7 +1957,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 								NULL);
 				aq_err = pf->hw.aq.asq_last_status;
 				num_del = 0;
-				memset(del_list, 0, sizeof(*del_list));
+				memset(del_list, 0, del_list_size);
 
 				if (aq_ret && aq_err != I40E_AQ_RC_ENOENT) {
 					retval = -EIO;
@@ -1992,13 +1993,14 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 	}
 
 	if (!list_empty(&tmp_add_list)) {
+		int add_list_size;
 
 		/* do all the adds now */
 		filter_list_len = pf->hw.aq.asq_buf_size /
 			       sizeof(struct i40e_aqc_add_macvlan_element_data),
-		add_list = kcalloc(filter_list_len,
-			       sizeof(struct i40e_aqc_add_macvlan_element_data),
-			       GFP_KERNEL);
+		add_list_size = filter_list_len *
+			       sizeof(struct i40e_aqc_add_macvlan_element_data);
+		add_list = kzalloc(add_list_size, GFP_KERNEL);
 		if (!add_list) {
 			/* Purge element from temporary lists */
 			i40e_cleanup_add_list(&tmp_add_list);
@@ -2037,7 +2039,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 
 				if (aq_ret)
 					break;
-				memset(add_list, 0, sizeof(*add_list));
+				memset(add_list, 0, add_list_size);
 			}
 			/* Entries from tmp_add_list were cloned from MAC
 			 * filter list, hence clean those cloned entries
-- 
2.1.0

