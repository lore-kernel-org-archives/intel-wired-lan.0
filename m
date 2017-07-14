From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:27:03 -0400
Subject: [Intel-wired-lan] [next PATCH S77-V3 04/10] i40e: use newer generic
	PM support instead of legacy PM callbacks
In-Reply-To: <20170714132709.52657-1-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
Message-ID: <20170714132709.52657-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Stop using the old legacy PM support, since we now have stable support
for the newer generic PM callbacks.

This has several advantages. First, we no longer have to manage our
own pci_save_state() and power changes, as it's preferred to have the
PCI stack do this. Second, these routines get called for both hibernate
and suspend to ram, so we can have the driver properly handle all the
suspend/resume flows that it needs to.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 54 +++++++++--------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c41815f..b47cc14 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12036,14 +12036,14 @@ static void i40e_shutdown(struct pci_dev *pdev)
 
 #ifdef CONFIG_PM
 /**
- * i40e_suspend - PCI callback for moving to D3
- * @pdev: PCI device information struct
+ * i40e_suspend - PM callback for moving to D3
+ * @dev: generic device information structure
  **/
-static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
+static int i40e_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 	struct i40e_hw *hw = &pf->hw;
-	int retval = 0;
 
 	set_bit(__I40E_SUSPENDED, pf->state);
 	set_bit(__I40E_DOWN, pf->state);
@@ -12058,41 +12058,17 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	i40e_free_misc_vector(pf);
 
-	retval = pci_save_state(pdev);
-	if (retval)
-		return retval;
-
-	pci_wake_from_d3(pdev, pf->wol_en);
-	pci_set_power_state(pdev, PCI_D3hot);
-
-	return retval;
+	return 0;
 }
 
 /**
- * i40e_resume - PCI callback for waking up from D3
- * @pdev: PCI device information struct
+ * i40e_resume - PM callback for waking up from D3
+ * @dev: generic device information structure
  **/
-static int i40e_resume(struct pci_dev *pdev)
+static int i40e_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
-	u32 err;
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	/* pci_restore_state() clears dev->state_saves, so
-	 * call pci_save_state() again to restore it.
-	 */
-	pci_save_state(pdev);
-
-	err = pci_enable_device_mem(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
-		return err;
-	}
-	pci_set_master(pdev);
-
-	/* no wakeup events while running */
-	pci_wake_from_d3(pdev, false);
 
 	/* handling the reset will rebuild the device state */
 	if (test_and_clear_bit(__I40E_SUSPENDED, pf->state)) {
@@ -12103,22 +12079,26 @@ static int i40e_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-#endif
+#endif /* CONFIG_PM */
+
 static const struct pci_error_handlers i40e_err_handler = {
 	.error_detected = i40e_pci_error_detected,
 	.slot_reset = i40e_pci_error_slot_reset,
 	.resume = i40e_pci_error_resume,
 };
 
+static SIMPLE_DEV_PM_OPS(i40e_pm_ops, i40e_suspend, i40e_resume);
+
 static struct pci_driver i40e_driver = {
 	.name     = i40e_driver_name,
 	.id_table = i40e_pci_tbl,
 	.probe    = i40e_probe,
 	.remove   = i40e_remove,
 #ifdef CONFIG_PM
-	.suspend  = i40e_suspend,
-	.resume   = i40e_resume,
-#endif
+	.driver   = {
+		.pm = &i40e_pm_ops,
+	},
+#endif /* CONFIG_PM */
 	.shutdown = i40e_shutdown,
 	.err_handler = &i40e_err_handler,
 	.sriov_configure = i40e_pci_sriov_configure,
-- 
2.9.3

