From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:47 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 09/13] i40e: Added code to
	prevent double resets
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-10-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Clear the VFLR bit after reset processing, instead of before. This
prevents double resets on VF init.

Testing Hints: Should be no functional change but a large number
of VFs will initialize more quickly. Mostly look for no
loss of functionality.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index acd2693..6a6fc28 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -787,9 +787,9 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
 {
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
+	u32 reg, reg_idx, bit_idx;
 	bool rsd = false;
 	int i;
-	u32 reg;
 
 	if (test_and_set_bit(__I40E_VF_DISABLE, &pf->state))
 		return;
@@ -856,6 +856,11 @@ complete_reset:
 	}
 	/* tell the VF the reset is done */
 	wr32(hw, I40E_VFGEN_RSTAT1(vf->vf_id), I40E_VFR_VFACTIVE);
+
+	/* clear the VFLR bit in GLGEN_VFLRSTAT */
+	reg_idx = (hw->func_caps.vf_base_id + vf->vf_id) / 32;
+	bit_idx = (hw->func_caps.vf_base_id + vf->vf_id) % 32;
+	wr32(hw, I40E_GLGEN_VFLRSTAT(reg_idx), BIT(bit_idx));
 	i40e_flush(hw);
 	clear_bit(__I40E_VF_DISABLE, &pf->state);
 }
@@ -2056,9 +2061,7 @@ int i40e_vc_process_vflr_event(struct i40e_pf *pf)
 		vf = &pf->vf[vf_id];
 		reg = rd32(hw, I40E_GLGEN_VFLRSTAT(reg_idx));
 		if (reg & BIT(bit_idx)) {
-			/* clear the bit in GLGEN_VFLRSTAT */
-			wr32(hw, I40E_GLGEN_VFLRSTAT(reg_idx), BIT(bit_idx));
-
+			/* i40e_reset_vf will clear the bit in GLGEN_VFLRSTAT */
 			if (!test_bit(__I40E_DOWN, &pf->state))
 				i40e_reset_vf(vf, true);
 		}
-- 
2.4.3

