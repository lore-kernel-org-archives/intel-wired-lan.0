From: Frederick Lawler <fred@fredlawl.com>
Date: Wed, 17 Jul 2019 21:07:39 -0500
Subject: [Intel-wired-lan] [PATCH] igc: Prefer pcie_capability_read_word()
In-Reply-To: <20190718020745.8867-1-fred@fredlawl.com>
References: <20190718020745.8867-1-fred@fredlawl.com>
Message-ID: <20190718020745.8867-4-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 34fa0e60a780..8e8ad07a5776 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3891,13 +3891,11 @@ void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
 s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
 {
 	struct igc_adapter *adapter = hw->back;
-	u16 cap_offset;
 
-	cap_offset = pci_find_capability(adapter->pdev, PCI_CAP_ID_EXP);
-	if (!cap_offset)
+	if (!pci_is_pcie(adapter->pdev))
 		return -IGC_ERR_CONFIG;
 
-	pci_read_config_word(adapter->pdev, cap_offset + reg, value);
+	pcie_capability_read_word(adapter->pdev, reg, value);
 
 	return IGC_SUCCESS;
 }
@@ -3905,13 +3903,11 @@ s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
 s32 igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
 {
 	struct igc_adapter *adapter = hw->back;
-	u16 cap_offset;
 
-	cap_offset = pci_find_capability(adapter->pdev, PCI_CAP_ID_EXP);
-	if (!cap_offset)
+	if (!pci_is_pcie(adapter->pdev))
 		return -IGC_ERR_CONFIG;
 
-	pci_write_config_word(adapter->pdev, cap_offset + reg, *value);
+	pcie_capability_write_word(adapter->pdev, reg, *value);
 
 	return IGC_SUCCESS;
 }
-- 
2.17.1

