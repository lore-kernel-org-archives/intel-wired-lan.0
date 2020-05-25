From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 25 May 2020 17:57:10 +0530
Subject: [Intel-wired-lan] [PATCH v2] e1000: use generic power management
Message-ID: <20200525122710.25064-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

compile-tested only

With legacy PM hooks, it was the responsibility of a driver to manage PCI
states and also the device's power state. The generic approach is to let PCI
core handle the work.

e1000_suspend() calls __e1000_shutdown() to perform intermediate tasks.
__e1000_shutdown() modifies the value of "wake" (device should be wakeup
enabled or not), responsible for controlling the flow of legacy PM.

Since, PCI core has no idea about the value of "wake", new code for generic
PM may produce unexpected results. Thus, use "device_set_wakeup_enable()"
to wakeup-enable the device accordingly.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 49 +++++--------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 0d51cbc88028..011509709b3f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -151,10 +151,8 @@ static int e1000_vlan_rx_kill_vid(struct net_device *netdev,
 				  __be16 proto, u16 vid);
 static void e1000_restore_vlan(struct e1000_adapter *adapter);
 
-#ifdef CONFIG_PM
-static int e1000_suspend(struct pci_dev *pdev, pm_message_t state);
-static int e1000_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused e1000_suspend(struct device *dev);
+static int __maybe_unused e1000_resume(struct device *dev);
 static void e1000_shutdown(struct pci_dev *pdev);
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -179,16 +177,16 @@ static const struct pci_error_handlers e1000_err_handler = {
 	.resume = e1000_io_resume,
 };
 
+static SIMPLE_DEV_PM_OPS(e1000_pm_ops, e1000_suspend, e1000_resume);
+
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
 	.id_table = e1000_pci_tbl,
 	.probe    = e1000_probe,
 	.remove   = e1000_remove,
-#ifdef CONFIG_PM
-	/* Power Management Hooks */
-	.suspend  = e1000_suspend,
-	.resume   = e1000_resume,
-#endif
+	.driver = {
+		.pm = &e1000_pm_ops,
+	},
 	.shutdown = e1000_shutdown,
 	.err_handler = &e1000_err_handler
 };
@@ -5048,9 +5046,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 ctrl, ctrl_ext, rctl, status;
 	u32 wufc = adapter->wol;
-#ifdef CONFIG_PM
-	int retval = 0;
-#endif
 
 	netif_device_detach(netdev);
 
@@ -5064,12 +5059,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 		e1000_down(adapter);
 	}
 
-#ifdef CONFIG_PM
-	retval = pci_save_state(pdev);
-	if (retval)
-		return retval;
-#endif
-
 	status = er32(STATUS);
 	if (status & E1000_STATUS_LU)
 		wufc &= ~E1000_WUFC_LNKC;
@@ -5130,37 +5119,26 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int e1000_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused e1000_suspend(struct device *dev)
 {
 	int retval;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	bool wake;
 
 	retval = __e1000_shutdown(pdev, &wake);
-	if (retval)
-		return retval;
-
-	if (wake) {
-		pci_prepare_to_sleep(pdev);
-	} else {
-		pci_wake_from_d3(pdev, false);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
+	device_set_wakeup_enable(dev, wake);
 
-	return 0;
+	return retval;
 }
 
-static int e1000_resume(struct pci_dev *pdev)
+static int __maybe_unused e1000_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 err;
 
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	pci_save_state(pdev);
-
 	if (adapter->need_ioport)
 		err = pci_enable_device(pdev);
 	else
@@ -5197,7 +5175,6 @@ static int e1000_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif
 
 static void e1000_shutdown(struct pci_dev *pdev)
 {
-- 
2.26.2

