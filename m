From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 23 Jul 2019 22:15:33 +0800
Subject: [Intel-wired-lan] [PATCH] fm10k: Use dev_get_drvdata
Message-ID: <20190723141533.5803-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index e49fb51d3613..7bfc8a5b6f55 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2352,7 +2352,7 @@ static int fm10k_handle_resume(struct fm10k_intfc *interface)
  **/
 static int __maybe_unused fm10k_resume(struct device *dev)
 {
-	struct fm10k_intfc *interface = pci_get_drvdata(to_pci_dev(dev));
+	struct fm10k_intfc *interface = dev_get_drvdata(dev);
 	struct net_device *netdev = interface->netdev;
 	struct fm10k_hw *hw = &interface->hw;
 	int err;
@@ -2379,7 +2379,7 @@ static int __maybe_unused fm10k_resume(struct device *dev)
  **/
 static int __maybe_unused fm10k_suspend(struct device *dev)
 {
-	struct fm10k_intfc *interface = pci_get_drvdata(to_pci_dev(dev));
+	struct fm10k_intfc *interface = dev_get_drvdata(dev);
 	struct net_device *netdev = interface->netdev;
 
 	netif_device_detach(netdev);
-- 
2.20.1

