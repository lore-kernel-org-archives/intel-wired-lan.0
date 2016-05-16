From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:32 -0700
Subject: [Intel-wired-lan] [next PATCH S37 02/15] i40e: add hw struct local
	variable
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This function uses the i40e_hw struct all over the place, so why doesn't
it keep a pointer to the struct? Add this pointer as a local variable
and use it consistently throughout the function.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I10eb688fe40909433fcb8ac7ac891cef67445d72
---
Testing Hints : No functionality change, just code simplification.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 79 +++++++++++++++--------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d091c76..ad2191c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1845,6 +1845,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 {
 	struct list_head tmp_del_list, tmp_add_list;
 	struct i40e_mac_filter *f, *ftmp, *fclone;
+	struct i40e_hw *hw = &vsi->back->hw;
 	bool promisc_forced_on = false;
 	bool add_happened = false;
 	int filter_list_len = 0;
@@ -1925,7 +1926,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	if (!list_empty(&tmp_del_list)) {
 		int del_list_size;
 
-		filter_list_len = pf->hw.aq.asq_buf_size /
+		filter_list_len = hw->aq.asq_buf_size /
 			    sizeof(struct i40e_aqc_remove_macvlan_element_data);
 		del_list_size = filter_list_len *
 			    sizeof(struct i40e_aqc_remove_macvlan_element_data);
@@ -1957,12 +1958,11 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 
 			/* flush a full buffer */
 			if (num_del == filter_list_len) {
-				aq_ret = i40e_aq_remove_macvlan(&pf->hw,
-								vsi->seid,
-								del_list,
-								num_del,
-								NULL);
-				aq_err = pf->hw.aq.asq_last_status;
+				aq_ret =
+					i40e_aq_remove_macvlan(hw, vsi->seid,
+							       del_list,
+							       num_del, NULL);
+				aq_err = hw->aq.asq_last_status;
 				num_del = 0;
 				memset(del_list, 0, del_list_size);
 
@@ -1970,8 +1970,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 					retval = -EIO;
 					dev_err(&pf->pdev->dev,
 						"ignoring delete macvlan error, err %s, aq_err %s while flushing a full buffer\n",
-						i40e_stat_str(&pf->hw, aq_ret),
-						i40e_aq_str(&pf->hw, aq_err));
+
+						 i40e_stat_str(hw, aq_ret),
+						 i40e_aq_str(hw, aq_err));
 				}
 			}
 			/* Release memory for MAC filter entries which were
@@ -1982,17 +1983,16 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		}
 
 		if (num_del) {
-			aq_ret = i40e_aq_remove_macvlan(&pf->hw, vsi->seid,
-							del_list, num_del,
-							NULL);
-			aq_err = pf->hw.aq.asq_last_status;
+			aq_ret = i40e_aq_remove_macvlan(hw, vsi->seid, del_list,
+							num_del, NULL);
+			aq_err = hw->aq.asq_last_status;
 			num_del = 0;
 
 			if (aq_ret && aq_err != I40E_AQ_RC_ENOENT)
 				dev_info(&pf->pdev->dev,
 					 "ignoring delete macvlan error, err %s aq_err %s\n",
-					 i40e_stat_str(&pf->hw, aq_ret),
-					 i40e_aq_str(&pf->hw, aq_err));
+					 i40e_stat_str(hw, aq_ret),
+					 i40e_aq_str(hw, aq_err));
 		}
 
 		kfree(del_list);
@@ -2003,7 +2003,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		int add_list_size;
 
 		/* do all the adds now */
-		filter_list_len = pf->hw.aq.asq_buf_size /
+		filter_list_len = hw->aq.asq_buf_size /
 			       sizeof(struct i40e_aqc_add_macvlan_element_data),
 		add_list_size = filter_list_len *
 			       sizeof(struct i40e_aqc_add_macvlan_element_data);
@@ -2038,10 +2038,10 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 
 			/* flush a full buffer */
 			if (num_add == filter_list_len) {
-				aq_ret = i40e_aq_add_macvlan(&pf->hw, vsi->seid,
+				aq_ret = i40e_aq_add_macvlan(hw, vsi->seid,
 							     add_list, num_add,
 							     NULL);
-				aq_err = pf->hw.aq.asq_last_status;
+				aq_err = hw->aq.asq_last_status;
 				num_add = 0;
 
 				if (aq_ret)
@@ -2056,9 +2056,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		}
 
 		if (num_add) {
-			aq_ret = i40e_aq_add_macvlan(&pf->hw, vsi->seid,
+			aq_ret = i40e_aq_add_macvlan(hw, vsi->seid,
 						     add_list, num_add, NULL);
-			aq_err = pf->hw.aq.asq_last_status;
+			aq_err = hw->aq.asq_last_status;
 			num_add = 0;
 		}
 		kfree(add_list);
@@ -2068,9 +2068,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			retval = i40e_aq_rc_to_posix(aq_ret, aq_err);
 			dev_info(&pf->pdev->dev,
 				 "add filter failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, aq_ret),
-				 i40e_aq_str(&pf->hw, aq_err));
-			if ((pf->hw.aq.asq_last_status == I40E_AQ_RC_ENOSPC) &&
+				 i40e_stat_str(hw, aq_ret),
+				 i40e_aq_str(hw, aq_err));
+			if ((hw->aq.asq_last_status == I40E_AQ_RC_ENOSPC) &&
 			    !test_bit(__I40E_FILTER_OVERFLOW_PROMISC,
 				      &vsi->state)) {
 				promisc_forced_on = true;
@@ -2098,12 +2098,11 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 							       NULL);
 		if (aq_ret) {
 			retval = i40e_aq_rc_to_posix(aq_ret,
-						     pf->hw.aq.asq_last_status);
+						     hw->aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
 				 "set multi promisc failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, aq_ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 i40e_stat_str(hw, aq_ret),
+				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 	}
 	if ((changed_flags & IFF_PROMISC) || promisc_forced_on) {
@@ -2126,29 +2125,33 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			}
 		} else {
 			aq_ret = i40e_aq_set_vsi_unicast_promiscuous(
-							  &vsi->back->hw,
+							  hw,
 							  vsi->seid,
 							  cur_promisc, NULL,
 							  true);
 			if (aq_ret) {
 				retval =
 				i40e_aq_rc_to_posix(aq_ret,
-						    pf->hw.aq.asq_last_status);
+						    hw->aq.asq_last_status);
 				dev_info(&pf->pdev->dev,
-					 "set unicast promisc failed, err %d, aq_err %d\n",
-					 aq_ret, pf->hw.aq.asq_last_status);
+					 "set unicast promisc failed, err %s, aq_err %s\n",
+					 i40e_stat_str(hw, aq_ret),
+					 i40e_aq_str(hw,
+						     hw->aq.asq_last_status));
 			}
 			aq_ret = i40e_aq_set_vsi_multicast_promiscuous(
-							  &vsi->back->hw,
+							  hw,
 							  vsi->seid,
 							  cur_promisc, NULL);
 			if (aq_ret) {
 				retval =
 				i40e_aq_rc_to_posix(aq_ret,
-						    pf->hw.aq.asq_last_status);
+						    hw->aq.asq_last_status);
 				dev_info(&pf->pdev->dev,
-					 "set multicast promisc failed, err %d, aq_err %d\n",
-					 aq_ret, pf->hw.aq.asq_last_status);
+					 "set multicast promisc failed, err %s, aq_err %s\n",
+					 i40e_stat_str(hw, aq_ret),
+					 i40e_aq_str(hw,
+						     hw->aq.asq_last_status));
 			}
 		}
 		aq_ret = i40e_aq_set_vsi_broadcast(&vsi->back->hw,
@@ -2159,9 +2162,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 						     pf->hw.aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
 				 "set brdcast promisc failed, err %s, aq_err %s\n",
-				 i40e_stat_str(&pf->hw, aq_ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+					 i40e_stat_str(hw, aq_ret),
+					 i40e_aq_str(hw,
+						     hw->aq.asq_last_status));
 		}
 	}
 out:
-- 
2.4.11

