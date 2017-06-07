From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:13 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 13/13] i40e: don't hold RTNL
	lock for the entire reset
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-13-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We recently refactored i40e_do_reset() and its friends to be able to
hold the RTNL lock only for the portions that actually need to be
protected. However, a separate refactoring added several new callers of
these functions during the PCIe error recovery and suspend/resume
cycles.

When merging the changes together, it was not noticed that we could
reduce the RTNL scope by letting the reset function handle the lock
itself, as previously it was not possible.

Fix this by replacing these call sites to indicate that the reset
function should handle its own lock. This enables multiple PFs to reset
or resume simultaneously without serializing the resets via the RTNL
lock. The end result is that on systems with lots of PFs and VFs the
resets don't stall waiting for each other to finish.

It is probable that we can also do the same for i40e_do_reset_safe, but
this author did not research that change carefully enough to be
confident.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6db448e..67b4e09 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6565,9 +6565,7 @@ static void i40e_reset_subtask(struct i40e_pf *pf)
 	if (reset_flags &&
 	    !test_bit(__I40E_DOWN, pf->state) &&
 	    !test_bit(__I40E_CONFIG_BUSY, pf->state)) {
-		rtnl_lock();
-		i40e_do_reset(pf, reset_flags, true);
-		rtnl_unlock();
+		i40e_do_reset(pf, reset_flags, false);
 	}
 }
 
@@ -11905,11 +11903,8 @@ static pci_ers_result_t i40e_pci_error_detected(struct pci_dev *pdev,
 	}
 
 	/* shutdown all operations */
-	if (!test_bit(__I40E_SUSPENDED, pf->state)) {
-		rtnl_lock();
-		i40e_prep_for_reset(pf, true);
-		rtnl_unlock();
-	}
+	if (!test_bit(__I40E_SUSPENDED, pf->state))
+		i40e_prep_for_reset(pf, false);
 
 	/* Request a slot reset */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -11975,9 +11970,7 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 	if (test_bit(__I40E_SUSPENDED, pf->state))
 		return;
 
-	rtnl_lock();
-	i40e_handle_reset_warning(pf, true);
-	rtnl_unlock();
+	i40e_handle_reset_warning(pf, false);
 }
 
 /**
@@ -12057,9 +12050,7 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	if (pf->wol_en && (pf->flags & I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE))
 		i40e_enable_mc_magic_wake(pf);
 
-	rtnl_lock();
-	i40e_prep_for_reset(pf, true);
-	rtnl_unlock();
+	i40e_prep_for_reset(pf, false);
 
 	wr32(hw, I40E_PFPM_APM,
 	     (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
@@ -12091,9 +12082,7 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 	if (pf->wol_en && (pf->flags & I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE))
 		i40e_enable_mc_magic_wake(pf);
 
-	rtnl_lock();
-	i40e_prep_for_reset(pf, true);
-	rtnl_unlock();
+	i40e_prep_for_reset(pf, false);
 
 	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
 	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
@@ -12139,9 +12128,7 @@ static int i40e_resume(struct pci_dev *pdev)
 	/* handling the reset will rebuild the device state */
 	if (test_and_clear_bit(__I40E_SUSPENDED, pf->state)) {
 		clear_bit(__I40E_DOWN, pf->state);
-		rtnl_lock();
-		i40e_reset_and_rebuild(pf, false, true);
-		rtnl_unlock();
+		i40e_reset_and_rebuild(pf, false, false);
 	}
 
 	return 0;
-- 
2.9.3

