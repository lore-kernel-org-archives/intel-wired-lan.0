From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 29 Jun 2020 14:59:43 +0530
Subject: [Intel-wired-lan] [PATCH v1 5/5] e100: use generic power management
In-Reply-To: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
References: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
Message-ID: <20200629092943.227910-6-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With legacy PM hooks, it was the responsibility of a driver to manage PCI
states and also the device's power state. The generic approach is to let
PCI core handle the work.

e100_suspend() calls __e100_shutdown() to perform intermediate tasks.
__e100_shutdown() calls pci_save_state() which is not recommended.

e100_suspend() also calls __e100_power_off() which is calling PCI helper
functions, pci_prepare_to_sleep(), pci_set_power_state(), along with
pci_wake_from_d3(...,false). Hence, the functin call is removed and wol is
disabled as earlier using device_wakeup_disable().

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 1b8d015ebfb0..7506fb5eca8f 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2997,8 +2997,6 @@ static void __e100_shutdown(struct pci_dev *pdev, bool *enable_wake)
 		e100_down(nic);
 	netif_device_detach(netdev);
 
-	pci_save_state(pdev);
-
 	if ((nic->flags & wol_magic) | e100_asf(nic)) {
 		/* enable reverse auto-negotiation */
 		if (nic->phy == phy_82552_v) {
@@ -3028,24 +3026,21 @@ static int __e100_power_off(struct pci_dev *pdev, bool wake)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int e100_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused e100_suspend(struct device *dev_d)
 {
 	bool wake;
-	__e100_shutdown(pdev, &wake);
-	return __e100_power_off(pdev, wake);
+	__e100_shutdown(to_pci_dev(dev_d), &wake);
+
+	device_wakeup_disable(dev_d);
+
+	return 0;
 }
 
-static int e100_resume(struct pci_dev *pdev)
+static int __maybe_unused e100_resume(struct device *dev_d)
 {
-	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct net_device *netdev = dev_get_drvdata(dev_d);
 	struct nic *nic = netdev_priv(netdev);
 
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	/* ack any pending wake events, disable PME */
-	pci_enable_wake(pdev, PCI_D0, 0);
-
 	/* disable reverse auto-negotiation */
 	if (nic->phy == phy_82552_v) {
 		u16 smartspeed = mdio_read(netdev, nic->mii.phy_id,
@@ -3062,7 +3057,6 @@ static int e100_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static void e100_shutdown(struct pci_dev *pdev)
 {
@@ -3150,16 +3144,17 @@ static const struct pci_error_handlers e100_err_handler = {
 	.resume = e100_io_resume,
 };
 
+static SIMPLE_DEV_PM_OPS(e100_pm_ops, e100_suspend, e100_resume);
+
 static struct pci_driver e100_driver = {
 	.name =         DRV_NAME,
 	.id_table =     e100_id_table,
 	.probe =        e100_probe,
 	.remove =       e100_remove,
-#ifdef CONFIG_PM
+
 	/* Power Management hooks */
-	.suspend =      e100_suspend,
-	.resume =       e100_resume,
-#endif
+	.driver.pm =	&e100_pm_ops,
+
 	.shutdown =     e100_shutdown,
 	.err_handler = &e100_err_handler,
 };
-- 
2.27.0

