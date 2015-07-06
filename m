From: Raanan Avargil <raanan.avargil@intel.com>
Date: Mon,  6 Jul 2015 17:57:36 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix incorrect ASPM locking
Message-ID: <1436194656-31370-1-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes wrong locking usage.
In the context of slot reset, we should use lock.
And during resume, there is no need of lock.

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6c153c1..7abe000 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6466,7 +6466,7 @@ static int __e1000_resume(struct pci_dev *pdev)
 	if (adapter->flags2 & FLAG2_DISABLE_ASPM_L1)
 		aspm_disable_flag |= PCIE_LINK_STATE_L1;
 	if (aspm_disable_flag)
-		e1000e_disable_aspm_locked(pdev, aspm_disable_flag);
+		e1000e_disable_aspm(pdev, aspm_disable_flag);
 
 	pci_set_master(pdev);
 
@@ -6744,7 +6744,7 @@ static pci_ers_result_t e1000_io_slot_reset(struct pci_dev *pdev)
 	if (adapter->flags2 & FLAG2_DISABLE_ASPM_L1)
 		aspm_disable_flag |= PCIE_LINK_STATE_L1;
 	if (aspm_disable_flag)
-		e1000e_disable_aspm(pdev, aspm_disable_flag);
+		e1000e_disable_aspm_locked(pdev, aspm_disable_flag);
 
 	err = pci_enable_device_mem(pdev);
 	if (err) {
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

