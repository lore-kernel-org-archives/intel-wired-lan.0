From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Mon, 10 Jan 2022 13:11:41 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 3/4] i40e: Fix race condition
 while adding/deleting MAC/VLAN filters
In-Reply-To: <20220110131142.8481-1-jedrzej.jagielski@intel.com>
References: <20220110131142.8481-1-jedrzej.jagielski@intel.com>
Message-ID: <20220110131142.8481-4-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There was a race condition in access to hw->aq.asq_last_status
while adding and deleting  MAC/VLAN filters causing
incorrect error status to be printed as ERROR OK instead of
the correct error.

Change calls to i40e_aq_add_macvlan in i40e_aqc_add_filters
and i40e_aq_remove_macvlan in i40e_aqc_del_filters
to  _v2 versions that return Admin Queue status on the stack
to avoid race conditions in access to hw->aq.asq_last_status.

Fixes: 0093631966aa ("i40e: remove duplicate add/delete adminq command code for filters")
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++++++----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d80b758a1423..304d7f1296ed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2187,19 +2187,19 @@ void i40e_aqc_del_filters(struct i40e_vsi *vsi, const char *vsi_name,
 			  int num_del, int *retval)
 {
 	struct i40e_hw *hw = &vsi->back->hw;
+	enum i40e_admin_queue_err aq_status;
 	i40e_status aq_ret;
-	int aq_err;
 
-	aq_ret = i40e_aq_remove_macvlan(hw, vsi->seid, list, num_del, NULL);
-	aq_err = hw->aq.asq_last_status;
+	aq_ret = i40e_aq_remove_macvlan_v2(hw, vsi->seid, list, num_del, NULL,
+					   &aq_status);
 
 	/* Explicitly ignore and do not report when firmware returns ENOENT */
-	if (aq_ret && !(aq_err == I40E_AQ_RC_ENOENT)) {
+	if (aq_ret && !(aq_status == I40E_AQ_RC_ENOENT)) {
 		*retval = -EIO;
 		dev_info(&vsi->back->pdev->dev,
 			 "ignoring delete macvlan error on %s, err %s, aq_err %s\n",
 			 vsi_name, i40e_stat_str(hw, aq_ret),
-			 i40e_aq_str(hw, aq_err));
+			 i40e_aq_str(hw, aq_status));
 	}
 }
 
@@ -2222,10 +2222,10 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 			  int num_add)
 {
 	struct i40e_hw *hw = &vsi->back->hw;
-	int aq_err, fcnt;
+	enum i40e_admin_queue_err aq_status;
+	int fcnt;
 
-	i40e_aq_add_macvlan(hw, vsi->seid, list, num_add, NULL);
-	aq_err = hw->aq.asq_last_status;
+	i40e_aq_add_macvlan_v2(hw, vsi->seid, list, num_add, NULL, &aq_status);
 	fcnt = i40e_update_filter_state(num_add, list, add_head);
 
 	if (fcnt != num_add) {
@@ -2233,17 +2233,19 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
 			dev_warn(&vsi->back->pdev->dev,
 				 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
-				 i40e_aq_str(hw, aq_err), vsi_name);
+				 i40e_aq_str(hw, aq_status), vsi_name);
 		} else if (vsi->type == I40E_VSI_SRIOV ||
 			   vsi->type == I40E_VSI_VMDQ1 ||
 			   vsi->type == I40E_VSI_VMDQ2) {
 			dev_warn(&vsi->back->pdev->dev,
 				 "Error %s adding RX filters on %s, please set promiscuous on manually for %s\n",
-				 i40e_aq_str(hw, aq_err), vsi_name, vsi_name);
+				 i40e_aq_str(hw, aq_status), vsi_name,
+					     vsi_name);
 		} else {
 			dev_warn(&vsi->back->pdev->dev,
 				 "Error %s adding RX filters on %s, incorrect VSI type: %i.\n",
-				 i40e_aq_str(hw, aq_err), vsi_name, vsi->type);
+				 i40e_aq_str(hw, aq_status), vsi_name,
+					     vsi->type);
 		}
 	}
 }
-- 
2.27.0

