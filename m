From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 02:54:00 -0700
Subject: [Intel-wired-lan] [PATCH S25 11/12] ice: Remove
 ice_dev_onetime_setup()
In-Reply-To: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725095401.24590-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

ice_dev_onetime_setup contains driver workarounds needed for
firmware limitations. These issues have now been resolved in newer
NVMs so remove the function.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 16 ----------------
 drivers/net/ethernet/intel/ice/ice_common.h |  2 --
 drivers/net/ethernet/intel/ice/ice_lib.c    |  1 -
 3 files changed, 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 302ad981129c..847ddd9a7449 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -42,20 +42,6 @@ static enum ice_status ice_set_mac_type(struct ice_hw *hw)
 	return 0;
 }
 
-/**
- * ice_dev_onetime_setup - Temporary HW/FW workarounds
- * @hw: pointer to the HW structure
- *
- * This function provides temporary workarounds for certain issues
- * that are expected to be fixed in the HW/FW.
- */
-void ice_dev_onetime_setup(struct ice_hw *hw)
-{
-#define MBX_PF_VT_PFALLOC	0x00231E80
-	/* set VFs per PF */
-	wr32(hw, MBX_PF_VT_PFALLOC, rd32(hw, PF_VT_PFALLOC_HIF));
-}
-
 /**
  * ice_clear_pf_cfg - Clear PF configuration
  * @hw: pointer to the hardware structure
@@ -837,8 +823,6 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_sched;
 
-	ice_dev_onetime_setup(hw);
-
 	/* Get MAC information */
 	/* A single port can report up to two (LAN and WoL) addresses */
 	mac_buf = devm_kcalloc(ice_hw_to_dev(hw), 2,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index e376d1eadba4..89b5125ad64c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -41,8 +41,6 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 void ice_clear_pxe_mode(struct ice_hw *hw);
 enum ice_status ice_get_caps(struct ice_hw *hw);
 
-void ice_dev_onetime_setup(struct ice_hw *hw);
-
 enum ice_status
 ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		  u32 rxq_index);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index df28597f2e52..751f9f1f6367 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2978,7 +2978,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 
 	ice_vsi_clear_rings(vsi);
 	ice_vsi_free_arrays(vsi);
-	ice_dev_onetime_setup(&pf->hw);
 	if (vsi->req_txq || vsi->req_rxq)
 		ice_vsi_put_qs(vsi);
 	if (vsi->type == ICE_VSI_VF)
-- 
2.20.1

