From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Aug 2017 11:14:37 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: prefer %s and __func__ for
	diagnostic prints
Message-ID: <20170811181437.30509-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Don't hardcode the function names in the diagnostic output when these
reset related routines fail. Instead, use %s and __func__ so that future
refactors don't need to change the print outs.

Additionally, while we are here, add missing function header comments
for the new reset_prepare and reset_done function handlers.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 3c79e6707cec..ba9d038f22e8 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2588,11 +2588,18 @@ static void fm10k_io_resume(struct pci_dev *pdev)
 
 	if (err)
 		dev_warn(&pdev->dev,
-			 "fm10k_io_resume failed: %d\n", err);
+			 "%s failed: %d\n", __func__, err);
 	else
 		netif_device_attach(netdev);
 }
 
+/**
+ * fm10k_io_reset_prepare - called when PCI function is about to be reset
+ * @pdev: Pointer to PCI device
+ *
+ * This callback is called when the PCI function is about to be reset,
+ * allowing the device driver to prepare for it.
+ */
 static void fm10k_io_reset_prepare(struct pci_dev *pdev)
 {
 	/* warn incase we have any active VF devices */
@@ -2602,6 +2609,13 @@ static void fm10k_io_reset_prepare(struct pci_dev *pdev)
 	fm10k_prepare_suspend(pci_get_drvdata(pdev));
 }
 
+/**
+ * fm10k_io_reset_done - called when PCI function has finished resetting
+ * @pdev: Pointer to PCI device
+ *
+ * This callback is called just after the PCI function is reset, such as via
+ * /sys/class/net/<enpX>/device/reset or similar.
+ */
 static void fm10k_io_reset_done(struct pci_dev *pdev)
 {
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
@@ -2609,7 +2623,7 @@ static void fm10k_io_reset_done(struct pci_dev *pdev)
 
 	if (err) {
 		dev_warn(&pdev->dev,
-			 "fm10k_io_reset_notify failed: %d\n", err);
+			 "%s failed: %d\n", __func__, err);
 		netif_device_detach(interface->netdev);
 	}
 }
-- 
2.14.0.rc1.251.g593d8d6362ce

