From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Mon, 25 Apr 2022 08:27:56 +0200
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: remove VLAN representor
 specific ops
In-Reply-To: <20220425062756.14987-1-michal.swiatkowski@linux.intel.com>
References: <20220425062756.14987-1-michal.swiatkowski@linux.intel.com>
Message-ID: <20220425062756.14987-3-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As in switchdev mode VF VLAN caps will not be set there is no need
to have specific VLAN ops for representor that only returns not
supported error.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 44 ++-----------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 5d07e009bc84..ba38b76fd305 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3520,42 +3520,6 @@ ice_vc_repr_del_mac(struct ice_vf __always_unused *vf, u8 __always_unused *msg)
 				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
 }
 
-static int ice_vc_repr_add_vlan(struct ice_vf *vf, u8 __always_unused *msg)
-{
-	dev_dbg(ice_pf_to_dev(vf->pf),
-		"Can't add VLAN in switchdev mode for VF %d\n", vf->vf_id);
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ADD_VLAN,
-				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
-}
-
-static int ice_vc_repr_del_vlan(struct ice_vf *vf, u8 __always_unused *msg)
-{
-	dev_dbg(ice_pf_to_dev(vf->pf),
-		"Can't delete VLAN in switchdev mode for VF %d\n", vf->vf_id);
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DEL_VLAN,
-				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
-}
-
-static int ice_vc_repr_ena_vlan_stripping(struct ice_vf *vf)
-{
-	dev_dbg(ice_pf_to_dev(vf->pf),
-		"Can't enable VLAN stripping in switchdev mode for VF %d\n",
-		vf->vf_id);
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
-				     VIRTCHNL_STATUS_ERR_NOT_SUPPORTED,
-				     NULL, 0);
-}
-
-static int ice_vc_repr_dis_vlan_stripping(struct ice_vf *vf)
-{
-	dev_dbg(ice_pf_to_dev(vf->pf),
-		"Can't disable VLAN stripping in switchdev mode for VF %d\n",
-		vf->vf_id);
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
-				     VIRTCHNL_STATUS_ERR_NOT_SUPPORTED,
-				     NULL, 0);
-}
-
 static int
 ice_vc_repr_cfg_promiscuous_mode(struct ice_vf *vf, u8 __always_unused *msg)
 {
@@ -3582,10 +3546,10 @@ static const struct ice_virtchnl_ops ice_virtchnl_repr_ops = {
 	.config_rss_lut = ice_vc_config_rss_lut,
 	.get_stats_msg = ice_vc_get_stats_msg,
 	.cfg_promiscuous_mode_msg = ice_vc_repr_cfg_promiscuous_mode,
-	.add_vlan_msg = ice_vc_repr_add_vlan,
-	.remove_vlan_msg = ice_vc_repr_del_vlan,
-	.ena_vlan_stripping = ice_vc_repr_ena_vlan_stripping,
-	.dis_vlan_stripping = ice_vc_repr_dis_vlan_stripping,
+	.add_vlan_msg = ice_vc_add_vlan_msg,
+	.remove_vlan_msg = ice_vc_remove_vlan_msg,
+	.ena_vlan_stripping = ice_vc_ena_vlan_stripping,
+	.dis_vlan_stripping = ice_vc_dis_vlan_stripping,
 	.handle_rss_cfg_msg = ice_vc_handle_rss_cfg,
 	.add_fdir_fltr_msg = ice_vc_add_fdir_fltr,
 	.del_fdir_fltr_msg = ice_vc_del_fdir_fltr,
-- 
2.31.1

