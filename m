From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 29 Jun 2020 14:59:41 +0530
Subject: [Intel-wired-lan] [PATCH v1 3/5] ixgbe: use generic power management
In-Reply-To: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
References: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
Message-ID: <20200629092943.227910-4-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With legacy PM hooks, it was the responsibility of a driver to manage PCI
states and also the device's power state. The generic approach is to let
PCI core handle the work.

ixgbe_suspend() calls __ixgbe_shutdown() to perform intermediate tasks.
__ixgbe_shutdown() modifies the value of "wake" (device should be wakeup
enabled or not), responsible for controlling the flow of legacy PM.

Since, PCI core has no idea about the value of "wake", new code for generic
PM may produce unexpected results. Thus, use "device_set_wakeup_enable()"
to wakeup-enable the device accordingly.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 61 +++++--------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 97a423ecf808..145296825e64 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6861,32 +6861,20 @@ int ixgbe_close(struct net_device *netdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ixgbe_resume(struct pci_dev *pdev)
+static int __maybe_unused ixgbe_resume(struct device *dev_d)
 {
+	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 	struct net_device *netdev = adapter->netdev;
 	u32 err;
 
 	adapter->hw.hw_addr = adapter->io_addr;
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	/*
-	 * pci_restore_state clears dev->state_saved so call
-	 * pci_save_state to restore it.
-	 */
-	pci_save_state(pdev);
 
-	err = pci_enable_device_mem(pdev);
-	if (err) {
-		e_dev_err("Cannot enable PCI device from suspend\n");
-		return err;
-	}
 	smp_mb__before_atomic();
 	clear_bit(__IXGBE_DISABLED, &adapter->state);
 	pci_set_master(pdev);
 
-	pci_wake_from_d3(pdev, false);
+	device_wakeup_disable(dev_d);
 
 	ixgbe_reset(adapter);
 
@@ -6904,7 +6892,6 @@ static int ixgbe_resume(struct pci_dev *pdev)
 
 	return err;
 }
-#endif /* CONFIG_PM */
 
 static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 {
@@ -6913,9 +6900,6 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 ctrl;
 	u32 wufc = adapter->wol;
-#ifdef CONFIG_PM
-	int retval = 0;
-#endif
 
 	rtnl_lock();
 	netif_device_detach(netdev);
@@ -6926,12 +6910,6 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	ixgbe_clear_interrupt_scheme(adapter);
 	rtnl_unlock();
 
-#ifdef CONFIG_PM
-	retval = pci_save_state(pdev);
-	if (retval)
-		return retval;
-
-#endif
 	if (hw->mac.ops.stop_link_on_d3)
 		hw->mac.ops.stop_link_on_d3(hw);
 
@@ -6986,26 +6964,18 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ixgbe_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused ixgbe_suspend(struct device *dev_d)
 {
+	struct pci_dev *pdev = to_pci_dev(dev_d);
 	int retval;
 	bool wake;
 
 	retval = __ixgbe_shutdown(pdev, &wake);
-	if (retval)
-		return retval;
 
-	if (wake) {
-		pci_prepare_to_sleep(pdev);
-	} else {
-		pci_wake_from_d3(pdev, false);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
+	device_set_wakeup_enable(dev_d, wake);
 
-	return 0;
+	return retval;
 }
-#endif /* CONFIG_PM */
 
 static void ixgbe_shutdown(struct pci_dev *pdev)
 {
@@ -11489,16 +11459,15 @@ static const struct pci_error_handlers ixgbe_err_handler = {
 	.resume = ixgbe_io_resume,
 };
 
+static SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);
+
 static struct pci_driver ixgbe_driver = {
-	.name     = ixgbe_driver_name,
-	.id_table = ixgbe_pci_tbl,
-	.probe    = ixgbe_probe,
-	.remove   = ixgbe_remove,
-#ifdef CONFIG_PM
-	.suspend  = ixgbe_suspend,
-	.resume   = ixgbe_resume,
-#endif
-	.shutdown = ixgbe_shutdown,
+	.name      = ixgbe_driver_name,
+	.id_table  = ixgbe_pci_tbl,
+	.probe     = ixgbe_probe,
+	.remove    = ixgbe_remove,
+	.driver.pm = &ixgbe_pm_ops,
+	.shutdown  = ixgbe_shutdown,
 	.sriov_configure = ixgbe_pci_sriov_configure,
 	.err_handler = &ixgbe_err_handler
 };
-- 
2.27.0

