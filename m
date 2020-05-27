From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 May 2020 15:47:00 +0200
Subject: [Intel-wired-lan] [PATCH] [net-next] e1000e: fix unused-function
 warning
Message-ID: <20200527134716.948148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The CONFIG_PM_SLEEP #ifdef checks in this file are inconsistent,
leading to a warning about sometimes unused function:

drivers/net/ethernet/intel/e1000e/netdev.c:137:13: error: unused function 'e1000e_check_me' [-Werror,-Wunused-function]

Rather than adding more #ifdefs, just remove them completely
and mark the PM functions as __maybe_unused to let the compiler
work it out on it own.

Fixes: e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9cc8ec5421d5..66ca083b95f9 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6351,7 +6351,6 @@ static void e1000e_flush_lpic(struct pci_dev *pdev)
 	pm_runtime_put_sync(netdev->dev.parent);
 }
 
-#ifdef CONFIG_PM_SLEEP
 /* S0ix implementation */
 static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 {
@@ -6573,7 +6572,6 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 	mac_data &= ~E1000_CTRL_EXT_FORCE_SMBUS;
 	ew32(CTRL_EXT, mac_data);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static int e1000e_pm_freeze(struct device *dev)
 {
@@ -6871,7 +6869,6 @@ static int e1000e_pm_thaw(struct device *dev)
 	return rc;
 }
 
-#ifdef CONFIG_PM
 static int __e1000_resume(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -6937,8 +6934,7 @@ static int __e1000_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int e1000e_pm_suspend(struct device *dev)
+static __maybe_unused int e1000e_pm_suspend(struct device *dev)
 {
 	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
 	struct e1000_adapter *adapter = netdev_priv(netdev);
@@ -6962,7 +6958,7 @@ static int e1000e_pm_suspend(struct device *dev)
 	return rc;
 }
 
-static int e1000e_pm_resume(struct device *dev)
+static __maybe_unused int e1000e_pm_resume(struct device *dev)
 {
 	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
 	struct e1000_adapter *adapter = netdev_priv(netdev);
@@ -6981,9 +6977,8 @@ static int e1000e_pm_resume(struct device *dev)
 
 	return e1000e_pm_thaw(dev);
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static int e1000e_pm_runtime_idle(struct device *dev)
+static __maybe_unused int e1000e_pm_runtime_idle(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
@@ -6999,7 +6994,7 @@ static int e1000e_pm_runtime_idle(struct device *dev)
 	return -EBUSY;
 }
 
-static int e1000e_pm_runtime_resume(struct device *dev)
+static __maybe_unused int e1000e_pm_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7016,7 +7011,7 @@ static int e1000e_pm_runtime_resume(struct device *dev)
 	return rc;
 }
 
-static int e1000e_pm_runtime_suspend(struct device *dev)
+static __maybe_unused int e1000e_pm_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7041,7 +7036,6 @@ static int e1000e_pm_runtime_suspend(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static void e1000_shutdown(struct pci_dev *pdev)
 {
-- 
2.26.2

