From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon, 23 Jul 2018 16:13:47 -0700
Subject: [Intel-wired-lan] [PATCH 12/13] ice: Make ice_vsi_kill_vlan return
 an error code
In-Reply-To: <20180723231348.14838-1-anirudh.venkataramanan@intel.com>
References: <20180723231348.14838-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180723231348.14838-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Prior to this patch ice_vsi_kill_vlan has a void return value and we
were ignoring if it fails. Make ice_vsi_kill_vlan return an integer
value so its return value can be checked and used to determine whether
or not to update VLAN counts, structures, pruning bits.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 94 ++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e1ec525138ac..cb1145515f98 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -349,6 +349,63 @@ static bool ice_vsi_fltr_changed(struct ice_vsi *vsi)
 	       test_bit(ICE_VSI_FLAG_VLAN_FLTR_CHANGED, vsi->flags);
 }
 
+/**
+ * ice_cfg_vlan_pruning - enable or disable VLAN pruning on the VSI
+ * @vsi: VSI to enable or disable VLAN pruning on
+ * @ena: set to true to enable VLAN pruning and false to disable it
+ *
+ * returns 0 if VSI is updated, negative otherwise
+ */
+static int ice_cfg_vlan_pruning(struct ice_vsi *vsi, bool ena)
+{
+	struct ice_vsi_ctx *ctxt;
+	struct device *dev;
+	int status;
+
+	if (!vsi)
+		return -EINVAL;
+
+	dev = &vsi->back->pdev->dev;
+	ctxt = devm_kzalloc(dev, sizeof(*ctxt), GFP_KERNEL);
+	if (!ctxt)
+		return -ENOMEM;
+
+	ctxt->info = vsi->info;
+
+	if (ena) {
+		ctxt->info.sec_flags |=
+			ICE_AQ_VSI_SEC_TX_VLAN_PRUNE_ENA <<
+			ICE_AQ_VSI_SEC_TX_PRUNE_ENA_S;
+		ctxt->info.sw_flags2 |= ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
+	} else {
+		ctxt->info.sec_flags &=
+			~(ICE_AQ_VSI_SEC_TX_VLAN_PRUNE_ENA <<
+			  ICE_AQ_VSI_SEC_TX_PRUNE_ENA_S);
+		ctxt->info.sw_flags2 &= ~ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
+	}
+
+	ctxt->info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_SECURITY_VALID |
+						ICE_AQ_VSI_PROP_SW_VALID);
+	ctxt->vsi_num = vsi->vsi_num;
+	status = ice_aq_update_vsi(&vsi->back->hw, ctxt, NULL);
+	if (status) {
+		netdev_err(vsi->netdev, "%sabling VLAN pruning on VSI %d failed, err = %d, aq_err = %d\n",
+			   ena ? "Ena" : "Dis", vsi->vsi_num, status,
+			   vsi->back->hw.adminq.sq_last_status);
+		goto err_out;
+	}
+
+	vsi->info.sec_flags = ctxt->info.sec_flags;
+	vsi->info.sw_flags2 = ctxt->info.sw_flags2;
+
+	devm_kfree(dev, ctxt);
+	return 0;
+
+err_out:
+	devm_kfree(dev, ctxt);
+	return -EIO;
+}
+
 /**
  * ice_vsi_sync_fltr - Update the VSI filter list to the HW
  * @vsi: ptr to the VSI
@@ -3128,7 +3185,7 @@ static int ice_vlan_rx_add_vid(struct net_device *netdev,
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
-	int ret = 0;
+	int ret;
 
 	if (vid >= VLAN_N_VID) {
 		netdev_err(netdev, "VLAN id requested %d is out of range %d\n",
@@ -3139,6 +3196,13 @@ static int ice_vlan_rx_add_vid(struct net_device *netdev,
 	if (vsi->info.pvid)
 		return -EINVAL;
 
+	/* Enable VLAN pruning when VLAN 0 is added */
+	if (unlikely(!vid)) {
+		ret = ice_cfg_vlan_pruning(vsi, true);
+		if (ret)
+			return ret;
+	}
+
 	/* Add all VLAN ids including 0 to the switch filter. VLAN id 0 is
 	 * needed to continue allowing all untagged packets since VLAN prune
 	 * list is applied to all packets by the switch
@@ -3155,16 +3219,19 @@ static int ice_vlan_rx_add_vid(struct net_device *netdev,
  * ice_vsi_kill_vlan - Remove VSI membership for a given VLAN
  * @vsi: the VSI being configured
  * @vid: VLAN id to be removed
+ *
+ * Returns 0 on success and negative on failure
  */
-static void ice_vsi_kill_vlan(struct ice_vsi *vsi, u16 vid)
+static int ice_vsi_kill_vlan(struct ice_vsi *vsi, u16 vid)
 {
 	struct ice_fltr_list_entry *list;
 	struct ice_pf *pf = vsi->back;
 	LIST_HEAD(tmp_add_list);
+	int status = 0;
 
 	list = devm_kzalloc(&pf->pdev->dev, sizeof(*list), GFP_KERNEL);
 	if (!list)
-		return;
+		return -ENOMEM;
 
 	list->fltr_info.lkup_type = ICE_SW_LKUP_VLAN;
 	list->fltr_info.fwd_id.vsi_id = vsi->vsi_num;
@@ -3176,11 +3243,14 @@ static void ice_vsi_kill_vlan(struct ice_vsi *vsi, u16 vid)
 	INIT_LIST_HEAD(&list->list_entry);
 	list_add(&list->list_entry, &tmp_add_list);
 
-	if (ice_remove_vlan(&pf->hw, &tmp_add_list))
+	if (ice_remove_vlan(&pf->hw, &tmp_add_list)) {
 		dev_err(&pf->pdev->dev, "Error removing VLAN %d on vsi %i\n",
 			vid, vsi->vsi_num);
+		status = -EIO;
+	}
 
 	ice_free_fltr_list(&pf->pdev->dev, &tmp_add_list);
+	return status;
 }
 
 /**
@@ -3196,19 +3266,25 @@ static int ice_vlan_rx_kill_vid(struct net_device *netdev,
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
+	int status;
 
 	if (vsi->info.pvid)
 		return -EINVAL;
 
-	/* return code is ignored as there is nothing a user
-	 * can do about failure to remove and a log message was
-	 * already printed from the other function
+	/* Make sure ice_vsi_kill_vlan is successful before updating VLAN
+	 * information
 	 */
-	ice_vsi_kill_vlan(vsi, vid);
+	status = ice_vsi_kill_vlan(vsi, vid);
+	if (status)
+		return status;
 
 	clear_bit(vid, vsi->active_vlans);
 
-	return 0;
+	/* Disable VLAN pruning when VLAN 0 is removed */
+	if (unlikely(!vid))
+		status = ice_cfg_vlan_pruning(vsi, false);
+
+	return status;
 }
 
 /**
-- 
2.14.3

