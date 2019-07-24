From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 24 Jul 2019 14:06:09 +0800
Subject: [Intel-wired-lan] [PATCH net-next v2 4/8] e1000e: Use
 dev_get_drvdata where possible
Message-ID: <20190724060609.24116-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Change pci_set_drvdata to dev_set_drvdata
    to keep consistency.

 drivers/net/ethernet/intel/e1000e/netdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index e4baa13b3cda..ad203a2a64c4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6297,7 +6297,7 @@ static void e1000e_flush_lpic(struct pci_dev *pdev)
 
 static int e1000e_pm_freeze(struct device *dev)
 {
-	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
+	struct net_device *netdev = dev_get_drvdata(dev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 
 	netif_device_detach(netdev);
@@ -6630,7 +6630,7 @@ static int __e1000_resume(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int e1000e_pm_thaw(struct device *dev)
 {
-	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
+	struct net_device *netdev = dev_get_drvdata(dev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 
 	e1000e_set_interrupt_capability(adapter);
@@ -6679,8 +6679,7 @@ static int e1000e_pm_resume(struct device *dev)
 
 static int e1000e_pm_runtime_idle(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct net_device *netdev = dev_get_drvdata(dev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	u16 eee_lp;
 
@@ -7105,7 +7104,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netdev->irq = pdev->irq;
 
-	pci_set_drvdata(pdev, netdev);
+	dev_set_drvdata(&pdev->dev, netdev);
 	adapter = netdev_priv(netdev);
 	hw = &adapter->hw;
 	adapter->netdev = netdev;
-- 
2.20.1

