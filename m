From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Thu, 18 Jun 2015 13:24:06 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add new bus type for
 intergrated I/O interface (IOSF)
Message-ID: <20150618172406.28298.88836.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With this patch we add support for a new bus type ixgbe_bus_type_internal.
X550em devices use IOSF and not PCIe bus so this new type is to accommodate
them.

Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   11 ++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5f1b06a..dd53abd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -246,11 +246,19 @@ static inline bool ixgbe_pcie_from_parent(struct ixgbe_hw *hw)
 static void ixgbe_check_minimum_link(struct ixgbe_adapter *adapter,
 				     int expected_gts)
 {
+	struct ixgbe_hw *hw = &adapter->hw;
 	int max_gts = 0;
 	enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;
 	enum pcie_link_width width = PCIE_LNK_WIDTH_UNKNOWN;
 	struct pci_dev *pdev;
 
+	/* Some devices are not connected over PCIe and thus do not negotiate
+	 * speed. These devices do not have valid bus info, and thus any report
+	 * we generate may not be correct.
+	 */
+	if (hw->bus.type == ixgbe_bus_type_internal)
+		return;
+
 	/* determine whether to use the parent device */
 	if (ixgbe_pcie_from_parent(&adapter->hw))
 		pdev = adapter->pdev->bus->parent->self;
@@ -8844,9 +8852,10 @@ skip_sriov:
 	hw->eeprom.ops.read(hw, 0x2d, &adapter->eeprom_verl);
 
 	/* pick up the PCI bus settings for reporting later */
-	hw->mac.ops.get_bus_info(hw);
 	if (ixgbe_pcie_from_parent(hw))
 		ixgbe_get_parent_bus_info(adapter);
+	else
+		 hw->mac.ops.get_bus_info(hw);
 
 	/* calculate the expected PCIe bandwidth required for optimal
 	 * performance. Note that some older parts will never have enough
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 19271e5..37df15f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3067,6 +3067,7 @@ enum ixgbe_bus_type {
 	ixgbe_bus_type_pci,
 	ixgbe_bus_type_pcix,
 	ixgbe_bus_type_pci_express,
+	ixgbe_bus_type_internal,
 	ixgbe_bus_type_reserved
 };
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 50e0b05..9257dbc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -619,6 +619,7 @@ static s32 ixgbe_update_flash_X550(struct ixgbe_hw *hw)
   **/
 static s32 ixgbe_get_bus_info_X550em(struct ixgbe_hw *hw)
 {
+	hw->bus.type  = ixgbe_bus_type_internal;
 	hw->bus.width = ixgbe_bus_width_unknown;
 	hw->bus.speed = ixgbe_bus_speed_unknown;
 

