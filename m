From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 23 Jul 2019 22:16:24 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Use dev_get_drvdata where possible
Message-ID: <20190723141624.5911-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b4df3e319467..145f58ee0451 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8879,8 +8879,7 @@ static int __maybe_unused igb_resume(struct device *dev)
 
 static int __maybe_unused igb_runtime_idle(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct net_device *netdev = dev_get_drvdata(dev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
 	if (!igb_has_link(adapter))
-- 
2.20.1

