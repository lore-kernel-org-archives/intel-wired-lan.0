From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 Feb 2020 01:20:03 -0800
Subject: [Intel-wired-lan] [PATCH S37 v3 05/15] ice: Remove
 ice_dev_onetime_setup()
In-Reply-To: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
Message-ID: <20200206092013.23388-5-anthony.l.nguyen@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_common.c     | 16 ----------------
 drivers/net/ethernet/intel/ice/ice_common.h     |  2 --
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  1 -
 drivers/net/ethernet/intel/ice/ice_lib.c        |  1 -
 4 files changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e0f9108e42f3..151bec82bc0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -24,20 +24,6 @@ static enum ice_status ice_set_mac_type(struct ice_hw *hw)
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
@@ -763,8 +749,6 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_sched;
 
-	ice_dev_onetime_setup(hw);
-
 	/* Get MAC information */
 	/* A single port can report up to two (LAN and WoL) addresses */
 	mac_buf = devm_kcalloc(ice_hw_to_dev(hw), 2,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index dfec1105fd06..21b31cd33c41 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -54,8 +54,6 @@ enum ice_status ice_get_caps(struct ice_hw *hw);
 
 void ice_set_safe_mode_caps(struct ice_hw *hw);
 
-void ice_dev_onetime_setup(struct ice_hw *hw);
-
 enum ice_status
 ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		  u32 rxq_index);
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index b2502c7fd6ed..30f50b06173e 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -332,7 +332,6 @@
 #define GLV_TEPC(_VSI)				(0x00312000 + ((_VSI) * 4))
 #define GLV_UPRCL(_i)				(0x003B2000 + ((_i) * 8))
 #define GLV_UPTCL(_i)				(0x0030A000 + ((_i) * 8))
-#define PF_VT_PFALLOC_HIF			0x0009DD80
 #define VSIQF_HKEY_MAX_INDEX			12
 #define VSIQF_HLUT_MAX_INDEX			15
 #define VFINT_DYN_CTLN(_i)			(0x00003800 + ((_i) * 4))
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 75159b658098..90efa0e718b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2736,7 +2736,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 	ice_vsi_put_qs(vsi);
 	ice_vsi_clear_rings(vsi);
 	ice_vsi_free_arrays(vsi);
-	ice_dev_onetime_setup(&pf->hw);
 	if (vsi->type == ICE_VSI_VF)
 		ice_vsi_set_num_qs(vsi, vf->vf_id);
 	else
-- 
2.20.1

