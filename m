From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:27:02 -0400
Subject: [Intel-wired-lan] [next PATCH S77-V3 03/10] i40e: use separate
	state bit for miscellaneous IRQ setup
In-Reply-To: <20170714132709.52657-1-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
Message-ID: <20170714132709.52657-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We currently (mis)use the __I40E_RECOVERY_PENDING bit to determine when
we should actually request a new IRQ in i40e_setup_misc_vector().

This led to a design mistake where we open-coded the re-setup of the
miscellaneous vector in i40e_resume() instead of using the function
provided. If we did not open-code this and instead tried to use the
i40e_setup_misc_vector() function, it would lead to never reallocating
the IRQ.

This would lead to a second i40e_suspend() call failing to free the
vector due to a NULL pointer dereference.

A future patch is going to re-work how the i40e_suspend() and
i40e_resume() flows work to clear all IRQ vectors, which would require
us to use i40e_setup_misc_vector() directly. Since during this time the
__I40E_RECOVERY_PENDING bit is set, we'll never re-allocate the vector.

Rather than leaving the open-coded setup in i40e_resume() lets just fix
the problem properly in i40e_setup_misc_vector().

Introduce a new state bit which indicates when the IRQ has been
assigned, which will be set when i40e_setup_misc_vector is first called.
This ultimately resolves the issue of re-requesting the vector, without
overloading the __I40E_RECOVERY_PENDING state. This ensures that the
suspend/resume cycle can use the setup function instead of open-coding
the re-request during resume.

Additionally, since the only callers of i40e_stop_misc_vector also want
to free it, move this code directly into the function to avoid
duplication. Due to the new functionality, rename it to
i40e_free_misc_vector().

This lets us drop the extra calls to free and re-enable the vector
during i40e_suspend() and i40e_resume(). We don't need to call
i40e_setup_misc_Vector() in i40e_resume() because it gets called by the
i40e_rebuild() call.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 39 +++++++++++------------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5f75e67..2f1f65e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -136,6 +136,7 @@ enum i40e_state_t {
 	__I40E_MDD_EVENT_PENDING,
 	__I40E_VFLR_EVENT_PENDING,
 	__I40E_RESET_RECOVERY_PENDING,
+	__I40E_MISC_IRQ_REQUESTED,
 	__I40E_RESET_INTR_RECEIVED,
 	__I40E_REINIT_REQUESTED,
 	__I40E_PF_RESET_REQUESTED,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 43ed431..c41815f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3605,14 +3605,20 @@ static int i40e_vsi_enable_irq(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_stop_misc_vector - Stop the vector that handles non-queue events
+ * i40e_free_misc_vector - Free the vector that handles non-queue events
  * @pf: board private structure
  **/
-static void i40e_stop_misc_vector(struct i40e_pf *pf)
+static void i40e_free_misc_vector(struct i40e_pf *pf)
 {
 	/* Disable ICR 0 */
 	wr32(&pf->hw, I40E_PFINT_ICR0_ENA, 0);
 	i40e_flush(&pf->hw);
+
+	if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries) {
+		synchronize_irq(pf->msix_entries[0].vector);
+		free_irq(pf->msix_entries[0].vector, pf);
+		clear_bit(__I40E_MISC_IRQ_REQUESTED, pf->state);
+	}
 }
 
 /**
@@ -4467,11 +4473,7 @@ static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)
 {
 	int i;
 
-	i40e_stop_misc_vector(pf);
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries) {
-		synchronize_irq(pf->msix_entries[0].vector);
-		free_irq(pf->msix_entries[0].vector, pf);
-	}
+	i40e_free_misc_vector(pf);
 
 	i40e_put_lump(pf->irq_pile, pf->iwarp_base_vector,
 		      I40E_IWARP_IRQ_PILE_ID);
@@ -8351,13 +8353,12 @@ static int i40e_setup_misc_vector(struct i40e_pf *pf)
 	struct i40e_hw *hw = &pf->hw;
 	int err = 0;
 
-	/* Only request the irq if this is the first time through, and
-	 * not when we're rebuilding after a Reset
-	 */
-	if (!test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state)) {
+	/* Only request the IRQ once, the first time through. */
+	if (!test_and_set_bit(__I40E_MISC_IRQ_REQUESTED, pf->state)) {
 		err = request_irq(pf->msix_entries[0].vector,
 				  i40e_intr, 0, pf->int_name, pf);
 		if (err) {
+			clear_bit(__I40E_MISC_IRQ_REQUESTED, pf->state);
 			dev_info(&pf->pdev->dev,
 				 "request_irq for %s failed: %d\n",
 				 pf->int_name, err);
@@ -12055,11 +12056,8 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
 	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
 
-	i40e_stop_misc_vector(pf);
-	if (pf->msix_entries) {
-		synchronize_irq(pf->msix_entries[0].vector);
-		free_irq(pf->msix_entries[0].vector, pf);
-	}
+	i40e_free_misc_vector(pf);
+
 	retval = pci_save_state(pdev);
 	if (retval)
 		return retval;
@@ -12099,15 +12097,6 @@ static int i40e_resume(struct pci_dev *pdev)
 	/* handling the reset will rebuild the device state */
 	if (test_and_clear_bit(__I40E_SUSPENDED, pf->state)) {
 		clear_bit(__I40E_DOWN, pf->state);
-		if (pf->msix_entries) {
-			err = request_irq(pf->msix_entries[0].vector,
-					  i40e_intr, 0, pf->int_name, pf);
-			if (err) {
-				dev_err(&pf->pdev->dev,
-					"request_irq for %s failed: %d\n",
-					pf->int_name, err);
-			}
-		}
 		i40e_reset_and_rebuild(pf, false, false);
 	}
 
-- 
2.9.3

