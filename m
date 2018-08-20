From: Alice Michael <alice.michael@intel.com>
Date: Mon, 20 Aug 2018 08:12:28 -0700
Subject: [Intel-wired-lan] [next PATCH S95 07/12] i40e: Unset promiscuous
 settings on VF reset
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <20180820151233.14629-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch cleans up promiscuous configuration when a VF reset occurs.
Previously the promiscuous mode settings were still there after the VF
driver removal.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 267 ++++++++++++---------
 1 file changed, 157 insertions(+), 110 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f56c645..ca423be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1084,6 +1084,136 @@ static int i40e_quiesce_vf_pci(struct i40e_vf *vf)
 	return -EIO;
 }
 
+static inline int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi);
+
+/**
+ * i40e_config_vf_promiscuous_mode
+ * @vf: pointer to the VF info
+ * @vsi_id: VSI id
+ * @allmulti: set MAC L2 layer multicast promiscuous enable/disable
+ * @alluni: set MAC L2 layer unicast promiscuous enable/disable
+ *
+ * Called from the VF to configure the promiscuous mode of
+ * VF vsis and from the VF reset path to reset promiscuous mode.
+ **/
+static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
+						   u16 vsi_id,
+						   bool allmulti,
+						   bool alluni)
+{
+	i40e_status aq_ret = 0;
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_hw *hw = &pf->hw;
+	struct i40e_mac_filter *f;
+	struct i40e_vsi *vsi;
+	int bkt;
+
+	vsi = i40e_find_vsi_from_id(pf, vsi_id);
+	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id) || !vsi)
+		return I40E_ERR_PARAM;
+
+	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
+		dev_err(&pf->pdev->dev,
+			"Unprivileged VF %d is attempting to configure promiscuous mode\n",
+			vf->vf_id);
+		/* Lie to the VF on purpose. */
+		return 0;
+	}
+
+	if (vf->port_vlan_id) {
+		aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw, vsi->seid,
+							    allmulti,
+							    vf->port_vlan_id,
+							    NULL);
+		if (aq_ret) {
+			int aq_err = pf->hw.aq.asq_last_status;
+
+			dev_err(&pf->pdev->dev,
+				"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
+				vf->vf_id,
+				i40e_stat_str(&pf->hw, aq_ret),
+				i40e_aq_str(&pf->hw, aq_err));
+			return aq_ret;
+		}
+
+		aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw, vsi->seid,
+							    alluni,
+							    vf->port_vlan_id,
+							    NULL);
+		if (aq_ret) {
+			int aq_err = pf->hw.aq.asq_last_status;
+
+			dev_err(&pf->pdev->dev,
+				"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
+				vf->vf_id,
+				i40e_stat_str(&pf->hw, aq_ret),
+				i40e_aq_str(&pf->hw, aq_err));
+		}
+		return aq_ret;
+	} else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
+		hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
+			if (f->vlan < 0 || f->vlan > I40E_MAX_VLANID)
+				continue;
+			aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw,
+								    vsi->seid,
+								    allmulti,
+								    f->vlan,
+								    NULL);
+			if (aq_ret) {
+				int aq_err = pf->hw.aq.asq_last_status;
+
+				dev_err(&pf->pdev->dev,
+					"Could not add VLAN %d to multicast promiscuous domain err %s aq_err %s\n",
+					f->vlan,
+					i40e_stat_str(&pf->hw, aq_ret),
+					i40e_aq_str(&pf->hw, aq_err));
+			}
+
+			aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw,
+								    vsi->seid,
+								    alluni,
+								    f->vlan,
+								    NULL);
+			if (aq_ret) {
+				int aq_err = pf->hw.aq.asq_last_status;
+
+				dev_err(&pf->pdev->dev,
+					"Could not add VLAN %d to Unicast promiscuous domain err %s aq_err %s\n",
+					f->vlan,
+					i40e_stat_str(&pf->hw, aq_ret),
+					i40e_aq_str(&pf->hw, aq_err));
+			}
+		}
+		return aq_ret;
+	}
+	aq_ret = i40e_aq_set_vsi_multicast_promiscuous(hw, vsi->seid, allmulti,
+						       NULL);
+	if (aq_ret) {
+		int aq_err = pf->hw.aq.asq_last_status;
+
+		dev_err(&pf->pdev->dev,
+			"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
+			vf->vf_id,
+			i40e_stat_str(&pf->hw, aq_ret),
+			i40e_aq_str(&pf->hw, aq_err));
+		return aq_ret;
+	}
+
+	aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, vsi->seid, alluni,
+						     NULL, true);
+	if (aq_ret) {
+		int aq_err = pf->hw.aq.asq_last_status;
+
+		dev_err(&pf->pdev->dev,
+			"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
+			vf->vf_id,
+			i40e_stat_str(&pf->hw, aq_ret),
+			i40e_aq_str(&pf->hw, aq_err));
+	}
+
+	return aq_ret;
+}
+
 /**
  * i40e_trigger_vf_reset
  * @vf: pointer to the VF structure
@@ -1145,6 +1275,9 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
 	struct i40e_hw *hw = &pf->hw;
 	u32 reg;
 
+	/* disable promisc modes in case they were enabled */
+	i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_id, false, false);
+
 	/* free VF resources to begin resetting the VSI state */
 	i40e_free_vf_res(vf);
 
@@ -1851,132 +1984,46 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf,
 	struct virtchnl_promisc_info *info =
 	    (struct virtchnl_promisc_info *)msg;
 	struct i40e_pf *pf = vf->pf;
-	struct i40e_hw *hw = &pf->hw;
-	struct i40e_mac_filter *f;
 	i40e_status aq_ret = 0;
 	bool allmulti = false;
-	struct i40e_vsi *vsi;
 	bool alluni = false;
-	int aq_err = 0;
-	int bkt;
 
-	vsi = i40e_find_vsi_from_id(pf, info->vsi_id);
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
-	    !i40e_vc_isvalid_vsi_id(vf, info->vsi_id) ||
-	    !vsi) {
-		aq_ret = I40E_ERR_PARAM;
-		goto error_param;
-	}
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
-		dev_err(&pf->pdev->dev,
-			"Unprivileged VF %d is attempting to configure promiscuous mode\n",
-			vf->vf_id);
-		/* Lie to the VF on purpose. */
-		aq_ret = 0;
-		goto error_param;
-	}
+	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states))
+		return I40E_ERR_PARAM;
+
 	/* Multicast promiscuous handling*/
 	if (info->flags & FLAG_VF_MULTICAST_PROMISC)
 		allmulti = true;
 
-	if (vf->port_vlan_id) {
-		aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw, vsi->seid,
-							    allmulti,
-							    vf->port_vlan_id,
-							    NULL);
-	} else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
-		hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
-			if (f->vlan < 0 || f->vlan > I40E_MAX_VLANID)
-				continue;
-			aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw,
-								    vsi->seid,
-								    allmulti,
-								    f->vlan,
-								    NULL);
-			aq_err = pf->hw.aq.asq_last_status;
-			if (aq_ret) {
-				dev_err(&pf->pdev->dev,
-					"Could not add VLAN %d to multicast promiscuous domain err %s aq_err %s\n",
-					f->vlan,
-					i40e_stat_str(&pf->hw, aq_ret),
-					i40e_aq_str(&pf->hw, aq_err));
-				break;
-			}
-		}
-	} else {
-		aq_ret = i40e_aq_set_vsi_multicast_promiscuous(hw, vsi->seid,
-							       allmulti, NULL);
-		aq_err = pf->hw.aq.asq_last_status;
-		if (aq_ret) {
-			dev_err(&pf->pdev->dev,
-				"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
-				vf->vf_id,
-				i40e_stat_str(&pf->hw, aq_ret),
-				i40e_aq_str(&pf->hw, aq_err));
-			goto error_param;
-		}
-	}
-
+	if (info->flags & FLAG_VF_UNICAST_PROMISC)
+		alluni = true;
+	aq_ret = i40e_config_vf_promiscuous_mode(vf, info->vsi_id, allmulti,
+						 alluni);
 	if (!aq_ret) {
-		dev_info(&pf->pdev->dev,
-			 "VF %d successfully set multicast promiscuous mode\n",
-			 vf->vf_id);
-		if (allmulti)
+		if (allmulti) {
+			dev_info(&pf->pdev->dev,
+				 "VF %d successfully set multicast promiscuous mode\n",
+				 vf->vf_id);
 			set_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states);
-		else
+		} else {
+			dev_info(&pf->pdev->dev,
+				 "VF %d successfully unset multicast promiscuous mode\n",
+				 vf->vf_id);
 			clear_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states);
-	}
-
-	if (info->flags & FLAG_VF_UNICAST_PROMISC)
-		alluni = true;
-	if (vf->port_vlan_id) {
-		aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw, vsi->seid,
-							    alluni,
-							    vf->port_vlan_id,
-							    NULL);
-	} else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
-		hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
-			if (f->vlan < 0 || f->vlan > I40E_MAX_VLANID)
-				continue;
-			aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw,
-								    vsi->seid,
-								    alluni,
-								    f->vlan,
-								    NULL);
-			aq_err = pf->hw.aq.asq_last_status;
-			if (aq_ret)
-				dev_err(&pf->pdev->dev,
-					"Could not add VLAN %d to Unicast promiscuous domain err %s aq_err %s\n",
-					f->vlan,
-					i40e_stat_str(&pf->hw, aq_ret),
-					i40e_aq_str(&pf->hw, aq_err));
 		}
-	} else {
-		aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, vsi->seid,
-							     alluni, NULL,
-							     true);
-		aq_err = pf->hw.aq.asq_last_status;
-		if (aq_ret) {
-			dev_err(&pf->pdev->dev,
-				"VF %d failed to set unicast promiscuous mode %8.8x err %s aq_err %s\n",
-				vf->vf_id, info->flags,
-				i40e_stat_str(&pf->hw, aq_ret),
-				i40e_aq_str(&pf->hw, aq_err));
-			goto error_param;
-		}
-	}
-
-	if (!aq_ret) {
-		dev_info(&pf->pdev->dev,
-			 "VF %d successfully set unicast promiscuous mode\n",
-			 vf->vf_id);
-		if (alluni)
+		if (alluni) {
+			dev_info(&pf->pdev->dev,
+				 "VF %d successfully set unicast promiscuous mode\n",
+				 vf->vf_id);
 			set_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states);
-		else
+		} else {
+			dev_info(&pf->pdev->dev,
+				 "VF %d successfully unset unicast promiscuous mode\n",
+				 vf->vf_id);
 			clear_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states);
+		}
 	}
 
-error_param:
 	/* send the response to the VF */
 	return i40e_vc_send_resp_to_vf(vf,
 				       VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE,
-- 
2.9.5

