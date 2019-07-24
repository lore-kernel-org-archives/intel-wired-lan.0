From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 24 Jul 2019 14:06:26 +0800
Subject: [Intel-wired-lan] [PATCH net-next v2 6/8] i40e: Use dev_get_drvdata
Message-ID: <20190724060626.24226-1-hslester96@gmail.com>
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

 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9ebbe3da61bb..a83198a0ba51 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14938,7 +14938,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (is_valid_ether_addr(hw->mac.port_addr))
 		pf->hw_features |= I40E_HW_PORT_ID_VALID;
 
-	pci_set_drvdata(pdev, pf);
+	dev_set_drvdata(&pdev->dev, pf);
 	pci_save_state(pdev);
 
 	dev_info(&pdev->dev,
@@ -15605,8 +15605,7 @@ static void i40e_shutdown(struct pci_dev *pdev)
  **/
 static int __maybe_unused i40e_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct i40e_pf *pf = pci_get_drvdata(pdev);
+	struct i40e_pf *pf = dev_get_drvdata(dev);
 	struct i40e_hw *hw = &pf->hw;
 
 	/* If we're already suspended, then there is nothing to do */
@@ -15656,8 +15655,7 @@ static int __maybe_unused i40e_suspend(struct device *dev)
  **/
 static int __maybe_unused i40e_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct i40e_pf *pf = pci_get_drvdata(pdev);
+	struct i40e_pf *pf = dev_get_drvdata(dev);
 	int err;
 
 	/* If we're not suspended, then there is nothing to do */
@@ -15674,7 +15672,7 @@ static int __maybe_unused i40e_resume(struct device *dev)
 	 */
 	err = i40e_restore_interrupt_scheme(pf);
 	if (err) {
-		dev_err(&pdev->dev, "Cannot restore interrupt scheme: %d\n",
+		dev_err(dev, "Cannot restore interrupt scheme: %d\n",
 			err);
 	}
 
-- 
2.20.1

