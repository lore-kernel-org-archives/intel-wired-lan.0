From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:14 -0700
Subject: [Intel-wired-lan] [PATCH S57 11/14] ice: Remove unnecessary variable
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

In ice_init_phy_user_cfg, vsi is used only to get to hw. Remove this
and just use pi->hw

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1e31940a4717..d54e88cb9600 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1810,16 +1810,11 @@ static int ice_init_phy_user_cfg(struct ice_port_info *pi)
 	struct ice_phy_info *phy = &pi->phy;
 	struct ice_pf *pf = pi->hw->back;
 	enum ice_status status;
-	struct ice_vsi *vsi;
 	int err = 0;
 
 	if (!(phy->link_info.link_info & ICE_AQ_MEDIA_AVAILABLE))
 		return -EIO;
 
-	vsi = ice_get_main_vsi(pf);
-	if (!vsi)
-		return -EINVAL;
-
 	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 	if (!pcaps)
 		return -ENOMEM;
@@ -1839,7 +1834,7 @@ static int ice_init_phy_user_cfg(struct ice_port_info *pi)
 	ice_copy_phy_caps_to_cfg(pi, pcaps, &pi->phy.curr_user_phy_cfg);
 
 	/* check if lenient mode is supported and enabled */
-	if (ice_fw_supports_link_override(&vsi->back->hw) &&
+	if (ice_fw_supports_link_override(pi->hw) &&
 	    !(pcaps->module_compliance_enforcement &
 	      ICE_AQC_MOD_ENFORCE_STRICT_MODE)) {
 		set_bit(ICE_FLAG_LINK_LENIENT_MODE_ENA, pf->flags);
-- 
2.20.1

