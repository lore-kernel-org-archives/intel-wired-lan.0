From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:34 -0800
Subject: [Intel-wired-lan] [PATCH S11 07/16] ice: fix issue where host
 reboots on unload when iommu=on
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-8-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently if the kernel has the intel_iommu=on parameter set, on some
platforms removing the driver causes a system reboot. In initialization
we associate the control queue interrupts with the pf->hw_oicr_idx and
enable the interrupts by setting the CAUSE_ENA bit. The problem comes
on teardown because we are not clearing the CAUSE_ENA bit for the
control queues, but the vector at pf->hw_oicr_idx (miscellaneous
interrupt vector) gets disabled.

Fix this by clearing the CAUSE_ENA bit in the appropriate control queue
registers on when freeing the misceallaneous interrupt vector. Also,
move the call to ice_free_irq_msix_misc() to after ice_deinit_sw() in
ice_remove() because ice_deinit_sw() makes an AQ call, but
ice_free_irq_msix_misc() disables the miscellaneous vector and it's
associated interrupts.

Also, create two small helper functions to enable and disable the
control queue interrupts respectively.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 71 +++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index aff348e42562..fb04a5ebdc0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1355,15 +1355,40 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 	return ret;
 }
 
+/**
+ * ice_dis_ctrlq_interrupts - disable control queue interrupts
+ * @hw: pointer to HW structure
+ */
+static void ice_dis_ctrlq_interrupts(struct ice_hw *hw)
+{
+	/* disable Admin queue Interrupt causes */
+	wr32(hw, PFINT_FW_CTL,
+	     rd32(hw, PFINT_FW_CTL) & ~PFINT_FW_CTL_CAUSE_ENA_M);
+
+	/* disable Mailbox queue Interrupt causes */
+	wr32(hw, PFINT_MBX_CTL,
+	     rd32(hw, PFINT_MBX_CTL) & ~PFINT_MBX_CTL_CAUSE_ENA_M);
+
+	/* disable Control queue Interrupt causes */
+	wr32(hw, PFINT_OICR_CTL,
+	     rd32(hw, PFINT_OICR_CTL) & ~PFINT_OICR_CTL_CAUSE_ENA_M);
+
+	ice_flush(hw);
+}
+
 /**
  * ice_free_irq_msix_misc - Unroll misc vector setup
  * @pf: board private structure
  */
 static void ice_free_irq_msix_misc(struct ice_pf *pf)
 {
+	struct ice_hw *hw = &pf->hw;
+
+	ice_dis_ctrlq_interrupts(hw);
+
 	/* disable OICR interrupt */
-	wr32(&pf->hw, PFINT_OICR_ENA, 0);
-	ice_flush(&pf->hw);
+	wr32(hw, PFINT_OICR_ENA, 0);
+	ice_flush(hw);
 
 	if (test_bit(ICE_FLAG_MSIX_ENA, pf->flags) && pf->msix_entries) {
 		synchronize_irq(pf->msix_entries[pf->sw_oicr_idx].vector);
@@ -1377,6 +1402,32 @@ static void ice_free_irq_msix_misc(struct ice_pf *pf)
 	ice_free_res(pf->hw_irq_tracker, pf->hw_oicr_idx, ICE_RES_MISC_VEC_ID);
 }
 
+/**
+ * ice_ena_ctrlq_interrupts - enable control queue interrupts
+ * @hw: pointer to HW structure
+ * @v_idx: HW vector index to associate the control queue interrupts with
+ */
+static void ice_ena_ctrlq_interrupts(struct ice_hw *hw, u16 v_idx)
+{
+	u32 val;
+
+	val = ((v_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
+	       PFINT_OICR_CTL_CAUSE_ENA_M);
+	wr32(hw, PFINT_OICR_CTL, val);
+
+	/* enable Admin queue Interrupt causes */
+	val = ((v_idx & PFINT_FW_CTL_MSIX_INDX_M) |
+	       PFINT_FW_CTL_CAUSE_ENA_M);
+	wr32(hw, PFINT_FW_CTL, val);
+
+	/* enable Mailbox queue Interrupt causes */
+	val = ((v_idx & PFINT_MBX_CTL_MSIX_INDX_M) |
+	       PFINT_MBX_CTL_CAUSE_ENA_M);
+	wr32(hw, PFINT_MBX_CTL, val);
+
+	ice_flush(hw);
+}
+
 /**
  * ice_req_irq_msix_misc - Setup the misc vector to handle non queue events
  * @pf: board private structure
@@ -1389,7 +1440,6 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
 	int oicr_idx, err = 0;
-	u32 val;
 
 	if (!pf->int_name[0])
 		snprintf(pf->int_name, sizeof(pf->int_name) - 1, "%s-%s:misc",
@@ -1438,20 +1488,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 skip_req_irq:
 	ice_ena_misc_vector(pf);
 
-	val = ((pf->hw_oicr_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
-	       PFINT_OICR_CTL_CAUSE_ENA_M);
-	wr32(hw, PFINT_OICR_CTL, val);
-
-	/* This enables Admin queue Interrupt causes */
-	val = ((pf->hw_oicr_idx & PFINT_FW_CTL_MSIX_INDX_M) |
-	       PFINT_FW_CTL_CAUSE_ENA_M);
-	wr32(hw, PFINT_FW_CTL, val);
-
-	/* This enables Mailbox queue Interrupt causes */
-	val = ((pf->hw_oicr_idx & PFINT_MBX_CTL_MSIX_INDX_M) |
-	       PFINT_MBX_CTL_CAUSE_ENA_M);
-	wr32(hw, PFINT_MBX_CTL, val);
-
+	ice_ena_ctrlq_interrupts(hw, pf->hw_oicr_idx);
 	wr32(hw, GLINT_ITR(ICE_RX_ITR, pf->hw_oicr_idx),
 	     ITR_REG_ALIGN(ICE_ITR_8K) >> ICE_ITR_GRAN_S);
 
-- 
2.14.5

