From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:15 -0700
Subject: [Intel-wired-lan] [PATCH S57 12/14] ice: Use local variable instead
 of pointer derefs
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Replace multiple instances of vsi->back and pi->phy with equivalent
local variables

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 32 ++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d54e88cb9600..d84a0e05a0c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1876,27 +1876,24 @@ static int ice_init_phy_user_cfg(struct ice_port_info *pi)
 static int ice_configure_phy(struct ice_vsi *vsi)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
+	struct ice_port_info *pi = vsi->port_info;
 	struct ice_aqc_get_phy_caps_data *pcaps;
 	struct ice_aqc_set_phy_cfg_data *cfg;
-	struct ice_port_info *pi;
+	struct ice_phy_info *phy = &pi->phy;
+	struct ice_pf *pf = vsi->back;
 	enum ice_status status;
 	int err = 0;
 
-	pi = vsi->port_info;
-	if (!pi)
-		return -EINVAL;
-
 	/* Ensure we have media as we cannot configure a medialess port */
-	if (!(pi->phy.link_info.link_info & ICE_AQ_MEDIA_AVAILABLE))
+	if (!(phy->link_info.link_info & ICE_AQ_MEDIA_AVAILABLE))
 		return -EPERM;
 
 	ice_print_topo_conflict(vsi);
 
-	if (vsi->port_info->phy.link_info.topo_media_conflict ==
-	    ICE_AQ_LINK_TOPO_UNSUPP_MEDIA)
+	if (phy->link_info.topo_media_conflict == ICE_AQ_LINK_TOPO_UNSUPP_MEDIA)
 		return -EPERM;
 
-	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags))
+	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags))
 		return ice_force_phys_link_state(vsi, true);
 
 	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
@@ -1917,7 +1914,7 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 	 * there's nothing to do
 	 */
 	if (pcaps->caps & ICE_AQC_PHY_EN_LINK &&
-	    ice_phy_caps_equals_cfg(pcaps, &pi->phy.curr_user_phy_cfg))
+	    ice_phy_caps_equals_cfg(pcaps, &phy->curr_user_phy_cfg))
 		goto done;
 
 	/* Use PHY topology as baseline for configuration */
@@ -1946,15 +1943,14 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 	/* Speed - If default override pending, use curr_user_phy_cfg set in
 	 * ice_init_phy_user_cfg_ldo.
 	 */
-	if (test_and_clear_bit(ICE_LINK_DEFAULT_OVERRIDE_PENDING,
-			       vsi->back->state)) {
-		cfg->phy_type_low = pi->phy.curr_user_phy_cfg.phy_type_low;
-		cfg->phy_type_high = pi->phy.curr_user_phy_cfg.phy_type_high;
+	if (test_and_clear_bit(ICE_LINK_DEFAULT_OVERRIDE_PENDING, pf->state)) {
+		cfg->phy_type_low = phy->curr_user_phy_cfg.phy_type_low;
+		cfg->phy_type_high = phy->curr_user_phy_cfg.phy_type_high;
 	} else {
 		u64 phy_low = 0, phy_high = 0;
 
 		ice_update_phy_type(&phy_low, &phy_high,
-				    pi->phy.curr_user_speed_req);
+				    phy->curr_user_speed_req);
 		cfg->phy_type_low = pcaps->phy_type_low & cpu_to_le64(phy_low);
 		cfg->phy_type_high = pcaps->phy_type_high &
 				     cpu_to_le64(phy_high);
@@ -1967,7 +1963,7 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 	}
 
 	/* FEC */
-	ice_cfg_phy_fec(pi, cfg, pi->phy.curr_user_fec_req);
+	ice_cfg_phy_fec(pi, cfg, phy->curr_user_fec_req);
 
 	/* Can't provide what was requested; use PHY capabilities */
 	if (cfg->link_fec_opt !=
@@ -1979,12 +1975,12 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 	/* Flow Control - always supported; no need to check against
 	 * capabilities
 	 */
-	ice_cfg_phy_fc(pi, cfg, pi->phy.curr_user_fc_req);
+	ice_cfg_phy_fc(pi, cfg, phy->curr_user_fc_req);
 
 	/* Enable link and link update */
 	cfg->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT | ICE_AQ_PHY_ENA_LINK;
 
-	status = ice_aq_set_phy_cfg(&vsi->back->hw, pi, cfg, NULL);
+	status = ice_aq_set_phy_cfg(&pf->hw, pi, cfg, NULL);
 	if (status) {
 		dev_err(dev, "Failed to set phy config, VSI %d error %s\n",
 			vsi->vsi_num, ice_stat_str(status));
-- 
2.20.1

