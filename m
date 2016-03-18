From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Fri, 18 Mar 2016 12:18:09 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v4 05/12] i40e: Make VF resets
	more reliable
In-Reply-To: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458328696-135941-6-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Clear the VFLR bit immediately after triggering a reset instead of
waiting until after cleanup is complete. Make sure to trigger a reset
every time, not just if the PF is up.

These changes fix a problem where VF resets would get lost by the PF,
preventing the VF driver from initializing.

Testing Hints: Do VF driver load/unload test with
lots of VFs in the system.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I5945cf2884095b7b0554867c64df8617e71d9d29
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 80174de..66763c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -807,6 +807,10 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
 		wr32(hw, I40E_VPGEN_VFRTRIG(vf->vf_id), reg);
 		i40e_flush(hw);
 	}
+	/* clear the VFLR bit in GLGEN_VFLRSTAT */
+	reg_idx = (hw->func_caps.vf_base_id + vf->vf_id) / 32;
+	bit_idx = (hw->func_caps.vf_base_id + vf->vf_id) % 32;
+	wr32(hw, I40E_GLGEN_VFLRSTAT(reg_idx), BIT(bit_idx));
 
 	if (i40e_quiesce_vf_pci(vf))
 		dev_err(&pf->pdev->dev, "VF %d PCI transactions stuck\n",
@@ -857,10 +861,6 @@ complete_reset:
 	/* tell the VF the reset is done */
 	wr32(hw, I40E_VFGEN_RSTAT1(vf->vf_id), I40E_VFR_VFACTIVE);
 
-	/* clear the VFLR bit in GLGEN_VFLRSTAT */
-	reg_idx = (hw->func_caps.vf_base_id + vf->vf_id) / 32;
-	bit_idx = (hw->func_caps.vf_base_id + vf->vf_id) % 32;
-	wr32(hw, I40E_GLGEN_VFLRSTAT(reg_idx), BIT(bit_idx));
 	i40e_flush(hw);
 	clear_bit(__I40E_VF_DISABLE, &pf->state);
 }
@@ -2059,11 +2059,9 @@ int i40e_vc_process_vflr_event(struct i40e_pf *pf)
 		/* read GLGEN_VFLRSTAT register to find out the flr VFs */
 		vf = &pf->vf[vf_id];
 		reg = rd32(hw, I40E_GLGEN_VFLRSTAT(reg_idx));
-		if (reg & BIT(bit_idx)) {
+		if (reg & BIT(bit_idx))
 			/* i40e_reset_vf will clear the bit in GLGEN_VFLRSTAT */
-			if (!test_bit(__I40E_DOWN, &pf->state))
-				i40e_reset_vf(vf, true);
-		}
+			i40e_reset_vf(vf, true);
 	}
 
 	return 0;
-- 
2.4.3

