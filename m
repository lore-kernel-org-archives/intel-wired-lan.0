From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:38 -0800
Subject: [Intel-wired-lan] [PATCH S11 11/16] ice: clear VF ARQLEN register
 on reset
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

On older devices like X710 and X722, the VF's ARQLEN register is cleared
on reset, so the VF driver uses that register to detect an unannouced
reset. Unfortunately, on devices controlled by ice, this register is NOT
cleared on reset. This causes the VF to miss resets, and even on
properly-announced resets, the VF driver complains that it didn't see
the reset.

To fix this, we'll do it in software. When we handle a VF reset (whether
triggered by software or VFLR), clear this register after the HW reset
is complete.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  | 1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index f9a38f2cd470..6bf5cc064270 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -30,6 +30,7 @@
 #define PF_FW_ATQLEN_ATQVFE_M			BIT(28)
 #define PF_FW_ATQLEN_ATQOVFL_M			BIT(29)
 #define PF_FW_ATQLEN_ATQCRIT_M			BIT(30)
+#define VF_MBX_ARQLEN(_VF)			(0x0022BC00 + ((_VF) * 4))
 #define PF_FW_ATQLEN_ATQENABLE_M		BIT(31)
 #define PF_FW_ATQT				0x00080400
 #define PF_MBX_ARQBAH				0x0022E400
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 79d793a76042..458e179ea863 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -310,6 +310,11 @@ static void ice_trigger_vf_reset(struct ice_vf *vf, bool is_vflr)
 	 */
 	clear_bit(ICE_VF_STATE_INIT, vf->vf_states);
 
+	/* Clear the VF's ARQLEN register. This is how the VF detects reset,
+	 * since the VFGEN_RSTAT register doesn't stick at 0 after reset.
+	 */
+	wr32(hw, VF_MBX_ARQLEN(vf_abs_id), 0);
+
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
 	 */
-- 
2.14.5

