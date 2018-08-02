From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:33 -0700
Subject: [Intel-wired-lan] [next PATCH S94 10/13] i40e: Reinitialize
 interrupt scheme when going out of recovery mode
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

When we go out of recovery mode (after a reset is triggerred) we have
to free IRQ, clear and reinitialize the interrupt scheme to restore
full interrupt functionality.

This patch fixes a kernel panic in the event of driver being unloaded
after performing a recovery with nvmupdate - which was caused by calling
pci_disable_msi() while an interrupt was still registered in the system.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ca701e0..3b1740d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -45,6 +45,7 @@ static void i40e_prep_for_reset(struct i40e_pf *pf, bool lock_acquired);
 static int i40e_reset(struct i40e_pf *pf);
 static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired);
 static int i40e_setup_misc_vector_for_recovery_mode(struct i40e_pf *pf);
+static int i40e_restore_interrupt_scheme(struct i40e_pf *pf);
 static bool i40e_check_recovery_mode(struct i40e_pf *pf);
 static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw);
 static void i40e_fdir_sb_setup(struct i40e_pf *pf);
@@ -9375,15 +9376,32 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 		i40e_verify_eeprom(pf);
 	}
 
+	/* if we are going out of or into recovery mode we have to act
+	 * accordingly with regard to resources initialization
+	 * and deinitialization
+	 */
 	if (test_bit(__I40E_RECOVERY_MODE, pf->state) ||
 	    old_recovery_mode_bit) {
 		if (i40e_get_capabilities(pf,
 					  i40e_aqc_opc_list_func_capabilities))
 			goto end_unlock;
 
-		/* reinit the misc interrupt */
-		if (i40e_setup_misc_vector_for_recovery_mode(pf))
-			goto end_unlock;
+		if (test_bit(__I40E_RECOVERY_MODE, pf->state)) {
+			/* we're staying in recovery mode so we'll reinitialize
+			 * misc vector here
+			 */
+			if (i40e_setup_misc_vector_for_recovery_mode(pf))
+				goto end_unlock;
+		} else {
+			/* we're going out of recovery mode so we'll free
+			 * the IRQ allocated specifically for recovery mode
+			 * and restore the interrupt scheme
+			 */
+			free_irq(pf->pdev->irq, pf);
+			i40e_clear_interrupt_scheme(pf);
+			if (i40e_restore_interrupt_scheme(pf))
+				goto end_unlock;
+		}
 
 		/* tell the firmware that we're starting */
 		i40e_send_version(pf);
-- 
2.9.5

