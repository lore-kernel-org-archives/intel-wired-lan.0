From: Arnd Bergmann <arnd@arndb.de>
Date: Tue,  2 Oct 2018 23:02:49 +0200
Subject: [Intel-wired-lan] [PATCH] XXX PCI/AER: remove unused variables
Message-ID: <20181002210426.2447078-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A couple of files now contain a function with a return
code variable that is no longer used:

drivers/net/ethernet/sfc/efx.c: In function 'efx_io_slot_reset':
drivers/net/ethernet/sfc/efx.c:3824:6: error: unused variable 'rc' [-Werror=unused-variable]
  int rc;
      ^~
drivers/net/ethernet/sfc/falcon/efx.c: In function 'ef4_io_slot_reset':
Oza Pawandeep <poza@codeaurora.org>
drivers/net/ethernet/sfc/falcon/efx.c:3163:6: error: unused variable 'rc' [-Werror=unused-variable]
  int rc;
      ^~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_io_slot_reset':
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11143:6: error: unused variable 'err' [-Werror=unused-variable]
  int err;
      ^~~
drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_pci_error_slot_reset':
drivers/net/ethernet/intel/i40e/i40e_main.c:14555:6: error: unused variable 'err' [-Werror=unused-variable]
  int err;

drivers/dma/ioat/init.c: In function 'ioat_pcie_error_slot_reset':
drivers/dma/ioat/init.c:1255:6: error: unused variable 'err' [-Werror=unused-variable]
  int err;

This removes all the ones I found during randconfig build testing.

Fixes: 6dcde3e574b2 ("XXX PCI/AER: Remove pci_cleanup_aer_uncorrect_error_status() calls")
Cc: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ioat/init.c                       | 1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 -
 drivers/net/ethernet/sfc/efx.c                | 1 -
 drivers/net/ethernet/sfc/falcon/efx.c         | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 80c475fb8ede..bd8db5c99597 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1252,7 +1252,6 @@ static pci_ers_result_t ioat_pcie_error_detected(struct pci_dev *pdev,
 static pci_ers_result_t ioat_pcie_error_slot_reset(struct pci_dev *pdev)
 {
 	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
-	int err;
 
 	dev_dbg(&pdev->dev, "%s post reset handling\n", DRV_NAME);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4654ac69dfb6..bc71a21c1dc2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14552,7 +14552,6 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 	pci_ers_result_t result;
-	int err;
 	u32 reg;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9bee51d900ac..0a2b9cad4b1c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11140,7 +11140,6 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
 {
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 	pci_ers_result_t result;
-	int err;
 
 	if (pci_enable_device_mem(pdev)) {
 		e_err(probe, "Cannot re-enable PCI device after reset.\n");
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index ec941ca967b3..98fe7e762e17 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -3821,7 +3821,6 @@ static pci_ers_result_t efx_io_slot_reset(struct pci_dev *pdev)
 {
 	struct efx_nic *efx = pci_get_drvdata(pdev);
 	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
-	int rc;
 
 	if (pci_enable_device(pdev)) {
 		netif_err(efx, hw, efx->net_dev,
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 9b728efd71a4..8b1f94d7a6c5 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -3160,7 +3160,6 @@ static pci_ers_result_t ef4_io_slot_reset(struct pci_dev *pdev)
 {
 	struct ef4_nic *efx = pci_get_drvdata(pdev);
 	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
-	int rc;
 
 	if (pci_enable_device(pdev)) {
 		netif_err(efx, hw, efx->net_dev,
-- 
2.18.0

