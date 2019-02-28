From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:58 -0800
Subject: [Intel-wired-lan] [PATCH S17 12/17] ice: Remove runtime change of
 PFINT_OICR_ENA register
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>

Runtime change of PFINT_OICR_ENA register is unnecessary.
The handlers should always clear the atomic bit for each
task as they start, because it will make sure that any late
interrupt will either 1) re-set the bit, or 2) be handled
directly in the "already running" task handler.

Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c        | 13 ++-----------
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 13 +------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 260ab69c2c00..94b2aa6b4c3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1096,7 +1096,7 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 	u32 reg;
 	int i;
 
-	if (!test_bit(__ICE_MDD_EVENT_PENDING, pf->state))
+	if (!test_and_clear_bit(__ICE_MDD_EVENT_PENDING, pf->state))
 		return;
 
 	/* find what triggered the MDD event */
@@ -1229,12 +1229,6 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		}
 	}
 
-	/* re-enable MDD interrupt cause */
-	clear_bit(__ICE_MDD_EVENT_PENDING, pf->state);
-	reg = rd32(hw, PFINT_OICR_ENA);
-	reg |= PFINT_OICR_MAL_DETECT_M;
-	wr32(hw, PFINT_OICR_ENA, reg);
-	ice_flush(hw);
 }
 
 /**
@@ -1523,7 +1517,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 			rd32(hw, PFHMC_ERRORDATA));
 	}
 
-	/* Report and mask off any remaining unexpected interrupts */
+	/* Report any remaining unexpected interrupts */
 	oicr &= ena_mask;
 	if (oicr) {
 		dev_dbg(&pf->pdev->dev, "unhandled interrupt oicr=0x%08x\n",
@@ -1537,12 +1531,9 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 			set_bit(__ICE_PFR_REQ, pf->state);
 			ice_service_task_schedule(pf);
 		}
-		ena_mask &= ~oicr;
 	}
 	ret = IRQ_HANDLED;
 
-	/* re-enable interrupt causes that are not handled during this pass */
-	wr32(hw, PFINT_OICR_ENA, ena_mask);
 	if (!test_bit(__ICE_DOWN, pf->state)) {
 		ice_service_task_schedule(pf);
 		ice_irq_dynamic_ena(hw, NULL, NULL);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f52f0fc52f46..abc958788267 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1273,21 +1273,10 @@ void ice_process_vflr_event(struct ice_pf *pf)
 	int vf_id;
 	u32 reg;
 
-	if (!test_bit(__ICE_VFLR_EVENT_PENDING, pf->state) ||
+	if (!test_and_clear_bit(__ICE_VFLR_EVENT_PENDING, pf->state) ||
 	    !pf->num_alloc_vfs)
 		return;
 
-	/* Re-enable the VFLR interrupt cause here, before looking for which
-	 * VF got reset. Otherwise, if another VF gets a reset while the
-	 * first one is being processed, that interrupt will be lost, and
-	 * that VF will be stuck in reset forever.
-	 */
-	reg = rd32(hw, PFINT_OICR_ENA);
-	reg |= PFINT_OICR_VFLR_M;
-	wr32(hw, PFINT_OICR_ENA, reg);
-	ice_flush(hw);
-
-	clear_bit(__ICE_VFLR_EVENT_PENDING, pf->state);
 	for (vf_id = 0; vf_id < pf->num_alloc_vfs; vf_id++) {
 		struct ice_vf *vf = &pf->vf[vf_id];
 		u32 reg_idx, bit_idx;
-- 
2.14.5

