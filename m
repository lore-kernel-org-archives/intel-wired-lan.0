From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  7 Jun 2016 17:20:43 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state upon probe
Message-ID: <20160608002043.10367-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It seems that under some circumstances, such as after performing an
unbind following an AER injection recovery, the power state of a VF
isn't set to PCI_D0. Following the unbind if we attempt to bind the
device, the MSI-X initialization fails due to incorrect power state.

Fix this by always calling pci_set_power_state(pdev, PCI_D0) on driver
device probe.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index b8245c734c96..f2b7b8447cb7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1975,6 +1975,8 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_enable_pcie_error_reporting(pdev);
 
+	pci_set_power_state(pdev, PCI_D0);
+
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
-- 
2.9.0.rc1.405.g81f467e

