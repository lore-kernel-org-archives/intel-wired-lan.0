From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  9 Jun 2016 12:02:03 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: fix PCI device enable_cnt leak in
	.io_slot_reset
Message-ID: <20160609190203.19082-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A previous patch removed the pci_disable_device() call in
.io_error_detected. This call corresponded to a pci_enable_device_mem()
call within .io_slot_reset handler. Change the call here to
a pci_reenable_device() so that it does not increment and leak the
enable_cnt reference count for the device. Without this change, VF
devices may fail during an unbind/bind, and we'll never zero the
reference counter for the pci_dev structure.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index b8245c734c96..8a47953d928d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2280,7 +2280,7 @@ static pci_ers_result_t fm10k_io_slot_reset(struct pci_dev *pdev)
 {
 	pci_ers_result_t result;
 
-	if (pci_enable_device_mem(pdev)) {
+	if (pci_reenable_device(pdev)) {
 		dev_err(&pdev->dev,
 			"Cannot re-enable PCI device after reset.\n");
 		result = PCI_ERS_RESULT_DISCONNECT;
-- 
2.9.0.rc1.405.g81f467e

