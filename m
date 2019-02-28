From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:57 -0800
Subject: [Intel-wired-lan] [PATCH S17 11/17] ice: Fix issue when adding more
 than allowed VLANs
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch fixes issue with non trusted VFs being able to add more than
permitted number of VLANs by adding a check in ice_vc_process_vlan_msg.
Also don't return an error in this case as the VF does not need to know
that it is not trusted.

Also rework ice_vsi_kill_vlan to use the right types.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_lib.c         | 15 +++++++++------
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8e0a23e6b563..6d9571c8826d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1598,7 +1598,8 @@ int ice_vsi_kill_vlan(struct ice_vsi *vsi, u16 vid)
 	struct ice_fltr_list_entry *list;
 	struct ice_pf *pf = vsi->back;
 	LIST_HEAD(tmp_add_list);
-	int status = 0;
+	enum ice_status status;
+	int err = 0;
 
 	list = devm_kzalloc(&pf->pdev->dev, sizeof(*list), GFP_KERNEL);
 	if (!list)
@@ -1614,14 +1615,16 @@ int ice_vsi_kill_vlan(struct ice_vsi *vsi, u16 vid)
 	INIT_LIST_HEAD(&list->list_entry);
 	list_add(&list->list_entry, &tmp_add_list);
 
-	if (ice_remove_vlan(&pf->hw, &tmp_add_list)) {
-		dev_err(&pf->pdev->dev, "Error removing VLAN %d on vsi %i\n",
-			vid, vsi->vsi_num);
-		status = -EIO;
+	status = ice_remove_vlan(&pf->hw, &tmp_add_list);
+	if (status) {
+		dev_err(&pf->pdev->dev,
+			"Error removing VLAN %d on vsi %i error: %d\n",
+			vid, vsi->vsi_num, status);
+		err = -EIO;
 	}
 
 	ice_free_fltr_list(&pf->pdev->dev, &tmp_add_list);
-	return status;
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 789b6f10b381..f52f0fc52f46 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2329,7 +2329,6 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 		/* There is no need to let VF know about being not trusted,
 		 * so we can just return success message here
 		 */
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
 	}
 
@@ -2370,6 +2369,18 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 		for (i = 0; i < vfl->num_elements; i++) {
 			u16 vid = vfl->vlan_id[i];
 
+			if (!ice_is_vf_trusted(vf) &&
+			    vf->num_vlan >= ICE_MAX_VLAN_PER_VF) {
+				dev_info(&pf->pdev->dev,
+					 "VF-%d is not trusted, switch the VF to trusted mode, in order to add more VLAN addresses\n",
+					 vf->vf_id);
+				/* There is no need to let VF know about being
+				 * not trusted, so we can just return success
+				 * message here as well.
+				 */
+				goto error_param;
+			}
+
 			if (ice_vsi_add_vlan(vsi, vid)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
-- 
2.14.5

