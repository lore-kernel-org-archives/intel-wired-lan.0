From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  1 Jun 2017 15:40:49 -0700
Subject: [Intel-wired-lan] [PATCH 13/15] fm10k: use generic PM hooks instead
	of legacy PCIe power hooks
In-Reply-To: <20170601224051.6106-1-jacob.e.keller@intel.com>
References: <20170601224051.6106-1-jacob.e.keller@intel.com>
Message-ID: <20170601224051.6106-14-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace the PCI specific legacy power management hooks with the new
generic power management hooks which work properly for both suspend and
hibernate. The new generic system is better and properly handles the
lower level PCIe power management rather than forcing the driver to
handle it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 67 +++++++++-------------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 17f3913e4bf7..d14cfe76e58b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2228,36 +2228,19 @@ static int fm10k_handle_resume(struct fm10k_intfc *interface)
 
 #ifdef CONFIG_PM
 /**
- * fm10k_resume - Restore device to pre-sleep state
- * @pdev: PCI device information struct
+ * fm10k_resume - Generic PM resume hook
+ * @dev: generic device structure
  *
- * fm10k_resume is called after the system has powered back up from a sleep
- * state and is ready to resume operation.  This function is meant to restore
- * the device back to its pre-sleep state.
+ * Generic PM hook used when waking the device from a low power state after
+ * suspend or hibernation. This function does not need to handle lower PCIe
+ * device state as the stack takes care of that for us.
  **/
-static int fm10k_resume(struct pci_dev *pdev)
+static int fm10k_resume(struct device *dev)
 {
-	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
+	struct fm10k_intfc *interface = pci_get_drvdata(to_pci_dev(dev));
 	struct net_device *netdev = interface->netdev;
 	struct fm10k_hw *hw = &interface->hw;
-	u32 err;
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
-	/* pci_restore_state clears dev->state_saved so call
-	 * pci_save_state to restore it.
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
-	pci_wake_from_d3(pdev, false);
+	int err;
 
 	/* refresh hw_addr in case it was dropped */
 	hw->hw_addr = interface->uc_addr;
@@ -2272,36 +2255,27 @@ static int fm10k_resume(struct pci_dev *pdev)
 }
 
 /**
- * fm10k_suspend - Prepare the device for a system sleep state
- * @pdev: PCI device information struct
+ * fm10k_suspend - Generic PM suspend hook
+ * @dev: generic device structure
  *
- * fm10k_suspend is meant to shutdown the device prior to the system entering
- * a sleep state.  The fm10k hardware does not support wake on lan so the
- * driver simply needs to shut down the device so it is in a low power state.
+ * Generic PM hook used when setting the device into a low power state for
+ * system suspend or hibernation. This function does not need to handle lower
+ * PCIe device state as the stack takes care of that for us.
  **/
-static int fm10k_suspend(struct pci_dev *pdev,
-			 pm_message_t __always_unused state)
+static int fm10k_suspend(struct device *dev)
 {
-	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
+	struct fm10k_intfc *interface = pci_get_drvdata(to_pci_dev(dev));
 	struct net_device *netdev = interface->netdev;
-	int err = 0;
 
 	netif_device_detach(netdev);
 
 	fm10k_prepare_suspend(interface);
 
-	err = pci_save_state(pdev);
-	if (err)
-		return err;
-
-	pci_disable_device(pdev);
-	pci_wake_from_d3(pdev, false);
-	pci_set_power_state(pdev, PCI_D3hot);
-
 	return 0;
 }
 
 #endif /* CONFIG_PM */
+
 /**
  * fm10k_io_error_detected - called when PCI error is detected
  * @pdev: Pointer to PCI device
@@ -2421,15 +2395,18 @@ static const struct pci_error_handlers fm10k_err_handler = {
 	.reset_notify = fm10k_io_reset_notify,
 };
 
+static SIMPLE_DEV_PM_OPS(fm10k_pm_ops, fm10k_suspend, fm10k_resume);
+
 static struct pci_driver fm10k_driver = {
 	.name			= fm10k_driver_name,
 	.id_table		= fm10k_pci_tbl,
 	.probe			= fm10k_probe,
 	.remove			= fm10k_remove,
 #ifdef CONFIG_PM
-	.suspend		= fm10k_suspend,
-	.resume			= fm10k_resume,
-#endif
+	.driver = {
+		.pm		= &fm10k_pm_ops,
+	},
+#endif /* CONFIG_PM */
 	.sriov_configure	= fm10k_iov_configure,
 	.err_handler		= &fm10k_err_handler
 };
-- 
2.13.0.598.gf927b9495246

