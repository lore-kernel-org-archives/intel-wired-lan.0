From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:26:05 -0800
Subject: [Intel-wired-lan] [next PATCH S21 07/14] i40e: propagate properly
In-Reply-To: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446852372-25480-8-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

i40e_sync_vsi_filters() is the surly teenager of this driver. It says
it's going to report errors, but it doesn't actually do that most of the
time. And when it does, it leaves a mess.

Change this function to have a common exit point so it will properly
release the busy lock on the VSI. Propagate errors to the callers.
Finally, adjust a few callers to check for and deal with errors from
this function.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ic6af4956491e72402ebb3c538a3c31a0ad7f8667
---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 109 +++++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  14 +--
 2 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d748431..c6d4da4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1552,10 +1552,9 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 		spin_unlock_bh(&vsi->mac_filter_list_lock);
 	}
 
-	i40e_sync_vsi_filters(vsi, false);
 	ether_addr_copy(netdev->dev_addr, addr->sa_data);
 
-	return 0;
+	return i40e_sync_vsi_filters(vsi, false);
 }
 
 /**
@@ -1871,8 +1870,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 	bool add_happened = false;
 	int filter_list_len = 0;
 	u32 changed_flags = 0;
+	i40e_status aq_ret = 0;
 	bool err_cond = false;
-	i40e_status ret = 0;
+	int retval = 0;
 	struct i40e_pf *pf;
 	int num_add = 0;
 	int num_del = 0;
@@ -1935,8 +1935,11 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 		}
 		spin_unlock_bh(&vsi->mac_filter_list_lock);
 
-		if (err_cond)
+		if (err_cond) {
 			i40e_cleanup_add_list(&tmp_add_list);
+			retval = -ENOMEM;
+			goto out;
+		}
 	}
 
 	/* Now process 'del_list' outside the lock */
@@ -1954,7 +1957,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 			i40e_undo_del_filter_entries(vsi, &tmp_del_list);
 			i40e_undo_add_filter_entries(vsi);
 			spin_unlock_bh(&vsi->mac_filter_list_lock);
-			return -ENOMEM;
+			retval = -ENOMEM;
+			goto out;
 		}
 
 		list_for_each_entry_safe(f, ftmp, &tmp_del_list, list) {
@@ -1972,18 +1976,22 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 
 			/* flush a full buffer */
 			if (num_del == filter_list_len) {
-				ret = i40e_aq_remove_macvlan(&pf->hw,
-						  vsi->seid, del_list, num_del,
-						  NULL);
+				aq_ret = i40e_aq_remove_macvlan(&pf->hw,
+								vsi->seid,
+								del_list,
+								num_del,
+								NULL);
 				aq_err = pf->hw.aq.asq_last_status;
 				num_del = 0;
 				memset(del_list, 0, sizeof(*del_list));
 
-				if (ret && aq_err != I40E_AQ_RC_ENOENT)
+				if (aq_ret && aq_err != I40E_AQ_RC_ENOENT) {
+					retval = -EIO;
 					dev_err(&pf->pdev->dev,
 						"ignoring delete macvlan error, err %s, aq_err %s while flushing a full buffer\n",
-						i40e_stat_str(&pf->hw, ret),
+						i40e_stat_str(&pf->hw, aq_ret),
 						i40e_aq_str(&pf->hw, aq_err));
+				}
 			}
 			/* Release memory for MAC filter entries which were
 			 * synced up with HW.
@@ -1993,15 +2001,16 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 		}
 
 		if (num_del) {
-			ret = i40e_aq_remove_macvlan(&pf->hw, vsi->seid,
-						     del_list, num_del, NULL);
+			aq_ret = i40e_aq_remove_macvlan(&pf->hw, vsi->seid,
+							del_list, num_del,
+							NULL);
 			aq_err = pf->hw.aq.asq_last_status;
 			num_del = 0;
 
-			if (ret && aq_err != I40E_AQ_RC_ENOENT)
+			if (aq_ret && aq_err != I40E_AQ_RC_ENOENT)
 				dev_info(&pf->pdev->dev,
 					 "ignoring delete macvlan error, err %s aq_err %s\n",
-					 i40e_stat_str(&pf->hw, ret),
+					 i40e_stat_str(&pf->hw, aq_ret),
 					 i40e_aq_str(&pf->hw, aq_err));
 		}
 
@@ -2025,7 +2034,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 			spin_lock_bh(&vsi->mac_filter_list_lock);
 			i40e_undo_add_filter_entries(vsi);
 			spin_unlock_bh(&vsi->mac_filter_list_lock);
-			return -ENOMEM;
+			retval = -ENOMEM;
+			goto out;
 		}
 
 		list_for_each_entry_safe(f, ftmp, &tmp_add_list, list) {
@@ -2046,13 +2056,13 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 
 			/* flush a full buffer */
 			if (num_add == filter_list_len) {
-				ret = i40e_aq_add_macvlan(&pf->hw, vsi->seid,
-							  add_list, num_add,
-							  NULL);
+				aq_ret = i40e_aq_add_macvlan(&pf->hw, vsi->seid,
+							     add_list, num_add,
+							     NULL);
 				aq_err = pf->hw.aq.asq_last_status;
 				num_add = 0;
 
-				if (ret)
+				if (aq_ret)
 					break;
 				memset(add_list, 0, sizeof(*add_list));
 			}
@@ -2064,18 +2074,19 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 		}
 
 		if (num_add) {
-			ret = i40e_aq_add_macvlan(&pf->hw, vsi->seid,
-						  add_list, num_add, NULL);
+			aq_ret = i40e_aq_add_macvlan(&pf->hw, vsi->seid,
+						     add_list, num_add, NULL);
 			aq_err = pf->hw.aq.asq_last_status;
 			num_add = 0;
 		}
 		kfree(add_list);
 		add_list = NULL;
 
-		if (add_happened && ret && aq_err != I40E_AQ_RC_EINVAL) {
+		if (add_happened && aq_ret && aq_err != I40E_AQ_RC_EINVAL) {
+			retval = i40e_aq_rc_to_posix(aq_ret, aq_err);
 			dev_info(&pf->pdev->dev,
 				 "add filter failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 i40e_stat_str(&pf->hw, aq_ret),
 				 i40e_aq_str(&pf->hw, aq_err));
 			if ((pf->hw.aq.asq_last_status == I40E_AQ_RC_ENOSPC) &&
 			    !test_bit(__I40E_FILTER_OVERFLOW_PROMISC,
@@ -2093,16 +2104,19 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 		bool cur_multipromisc;
 
 		cur_multipromisc = !!(vsi->current_netdev_flags & IFF_ALLMULTI);
-		ret = i40e_aq_set_vsi_multicast_promiscuous(&vsi->back->hw,
-							    vsi->seid,
-							    cur_multipromisc,
-							    NULL);
-		if (ret)
+		aq_ret = i40e_aq_set_vsi_multicast_promiscuous(&vsi->back->hw,
+							       vsi->seid,
+							       cur_multipromisc,
+							       NULL);
+		if (aq_ret) {
+			retval = i40e_aq_rc_to_posix(aq_ret,
+						     pf->hw.aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
 				 "set multi promisc failed, err %s aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 i40e_stat_str(&pf->hw, aq_ret),
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
+		}
 	}
 	if ((changed_flags & IFF_PROMISC) || promisc_forced_on) {
 		bool cur_promisc;
@@ -2126,36 +2140,47 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi, bool grab_rtnl)
 						BIT(__I40E_PF_RESET_REQUESTED));
 			}
 		} else {
-			ret = i40e_aq_set_vsi_unicast_promiscuous(
+			aq_ret = i40e_aq_set_vsi_unicast_promiscuous(
 							  &vsi->back->hw,
 							  vsi->seid,
 							  cur_promisc, NULL);
-			if (ret)
+			if (aq_ret) {
+				retval =
+				i40e_aq_rc_to_posix(aq_ret,
+						    pf->hw.aq.asq_last_status);
 				dev_info(&pf->pdev->dev,
 					 "set unicast promisc failed, err %d, aq_err %d\n",
-					 ret, pf->hw.aq.asq_last_status);
-			ret = i40e_aq_set_vsi_multicast_promiscuous(
+					 aq_ret, pf->hw.aq.asq_last_status);
+			}
+			aq_ret = i40e_aq_set_vsi_multicast_promiscuous(
 							  &vsi->back->hw,
 							  vsi->seid,
 							  cur_promisc, NULL);
-			if (ret)
+			if (aq_ret) {
+				retval =
+				i40e_aq_rc_to_posix(aq_ret,
+						    pf->hw.aq.asq_last_status);
 				dev_info(&pf->pdev->dev,
 					 "set multicast promisc failed, err %d, aq_err %d\n",
-					 ret, pf->hw.aq.asq_last_status);
+					 aq_ret, pf->hw.aq.asq_last_status);
+			}
 		}
-		ret = i40e_aq_set_vsi_broadcast(&vsi->back->hw,
-						vsi->seid,
-						cur_promisc, NULL);
-		if (ret)
+		aq_ret = i40e_aq_set_vsi_broadcast(&vsi->back->hw,
+						   vsi->seid,
+						   cur_promisc, NULL);
+		if (aq_ret) {
+			retval = i40e_aq_rc_to_posix(aq_ret,
+						     pf->hw.aq.asq_last_status);
 			dev_info(&pf->pdev->dev,
 				 "set brdcast promisc failed, err %s, aq_err %s\n",
-				 i40e_stat_str(&pf->hw, ret),
+				 i40e_stat_str(&pf->hw, aq_ret),
 				 i40e_aq_str(&pf->hw,
 					     pf->hw.aq.asq_last_status));
+		}
 	}
-
+out:
 	clear_bit(__I40E_CONFIG_BUSY, &vsi->state);
-	return 0;
+	return retval;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 26f247d..98aa9c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1633,9 +1633,10 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	/* program the updated filter list */
-	if (i40e_sync_vsi_filters(vsi, false))
-		dev_err(&pf->pdev->dev, "Unable to program VF %d MAC filters\n",
-			vf->vf_id);
+	ret = i40e_sync_vsi_filters(vsi, false);
+	if (ret)
+		dev_err(&pf->pdev->dev, "Unable to program VF %d MAC filters, error %d\n",
+			vf->vf_id, ret);
 
 error_param:
 	/* send the response to the VF */
@@ -1687,9 +1688,10 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
 	/* program the updated filter list */
-	if (i40e_sync_vsi_filters(vsi, false))
-		dev_err(&pf->pdev->dev, "Unable to program VF %d MAC filters\n",
-			vf->vf_id);
+	ret = i40e_sync_vsi_filters(vsi, false);
+	if (ret)
+		dev_err(&pf->pdev->dev, "Unable to program VF %d MAC filters, error %d\n",
+			vf->vf_id, ret);
 
 error_param:
 	/* send the response to the VF */
-- 
2.1.0

