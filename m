From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:44 -0700
Subject: [Intel-wired-lan] [next PATCH S37 14/15] i40e: add VSI info to
	macaddr messages
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-15-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Since the macaddr add and delete happens asynchronously, error
messages don't easily get associated to the actual request. Here
we add a bit of information to the error messages to help
determine the source of the error.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Id2d6df5287141c3579677d72d8bd21122823d79f
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 31 ++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 16197f9..5b9a64f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1842,6 +1842,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	struct i40e_hw *hw = &vsi->back->hw;
 	bool promisc_forced_on = false;
 	bool add_happened = false;
+	char vsi_name[16] = "PF";
 	int filter_list_len = 0;
 	u32 changed_flags = 0;
 	i40e_status aq_ret = 0;
@@ -1869,6 +1870,11 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	INIT_LIST_HEAD(&tmp_del_list);
 	INIT_LIST_HEAD(&tmp_add_list);
 
+	if (vsi->type == I40E_VSI_SRIOV)
+		snprintf(vsi_name, sizeof(vsi_name) - 1, "VF %d", vsi->vf_id);
+	else if (vsi->type != I40E_VSI_MAIN)
+		snprintf(vsi_name, sizeof(vsi_name) - 1, "vsi %d", vsi->seid);
+
 	if (vsi->flags & I40E_VSI_FLAG_FILTER_CHANGED) {
 		vsi->flags &= ~I40E_VSI_FLAG_FILTER_CHANGED;
 
@@ -1963,8 +1969,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				if (aq_ret && aq_err != I40E_AQ_RC_ENOENT) {
 					retval = -EIO;
 					dev_err(&pf->pdev->dev,
-						"ignoring delete macvlan error, err %s, aq_err %s while flushing a full buffer\n",
-
+						 "ignoring delete macvlan error on %s, err %s, aq_err %s while flushing a full buffer\n",
+						 vsi_name,
 						 i40e_stat_str(hw, aq_ret),
 						 i40e_aq_str(hw, aq_err));
 				}
@@ -1984,7 +1990,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 
 			if (aq_ret && aq_err != I40E_AQ_RC_ENOENT)
 				dev_info(&pf->pdev->dev,
-					 "ignoring delete macvlan error, err %s aq_err %s\n",
+					 "ignoring delete macvlan error on %s, err %s aq_err %s\n",
+					 vsi_name,
 					 i40e_stat_str(hw, aq_ret),
 					 i40e_aq_str(hw, aq_err));
 		}
@@ -2061,7 +2068,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		if (add_happened && aq_ret && aq_err != I40E_AQ_RC_EINVAL) {
 			retval = i40e_aq_rc_to_posix(aq_ret, aq_err);
 			dev_info(&pf->pdev->dev,
-				 "add filter failed, err %s aq_err %s\n",
+				 "add filter failed on %s, err %s aq_err %s\n",
+				 vsi_name,
 				 i40e_stat_str(hw, aq_ret),
 				 i40e_aq_str(hw, aq_err));
 			if ((hw->aq.asq_last_status == I40E_AQ_RC_ENOSPC) &&
@@ -2070,7 +2078,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				promisc_forced_on = true;
 				set_bit(__I40E_FILTER_OVERFLOW_PROMISC,
 					&vsi->state);
-				dev_info(&pf->pdev->dev, "promiscuous mode forced on\n");
+				dev_info(&pf->pdev->dev, "promiscuous mode forced on %s\n",
+					 vsi_name);
 			}
 		}
 	}
@@ -2094,7 +2103,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			retval = i40e_aq_rc_to_posix(aq_ret,
 						     hw->aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
-				 "set multi promisc failed, err %s aq_err %s\n",
+				 "set multi promisc failed on %s, err %s aq_err %s\n",
+				 vsi_name,
 				 i40e_stat_str(hw, aq_ret),
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
@@ -2129,7 +2139,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 					retval = i40e_aq_rc_to_posix(aq_ret,
 							hw->aq.asq_last_status);
 					dev_info(&pf->pdev->dev,
-						 "Set default VSI failed, err %s, aq_err %s\n",
+						 "Set default VSI failed on %s, err %s, aq_err %s\n",
+						 vsi_name,
 						 i40e_stat_str(hw, aq_ret),
 						 i40e_aq_str(hw,
 						     hw->aq.asq_last_status));
@@ -2146,7 +2157,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				i40e_aq_rc_to_posix(aq_ret,
 						    hw->aq.asq_last_status);
 				dev_info(&pf->pdev->dev,
-					 "set unicast promisc failed, err %s, aq_err %s\n",
+					 "set unicast promisc failed on %s, err %s, aq_err %s\n",
+					 vsi_name,
 					 i40e_stat_str(hw, aq_ret),
 					 i40e_aq_str(hw,
 						     hw->aq.asq_last_status));
@@ -2160,7 +2172,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				i40e_aq_rc_to_posix(aq_ret,
 						    hw->aq.asq_last_status);
 				dev_info(&pf->pdev->dev,
-					 "set multicast promisc failed, err %s, aq_err %s\n",
+					 "set multicast promisc failed on %s, err %s, aq_err %s\n",
+					 vsi_name,
 					 i40e_stat_str(hw, aq_ret),
 					 i40e_aq_str(hw,
 						     hw->aq.asq_last_status));
-- 
2.4.11

