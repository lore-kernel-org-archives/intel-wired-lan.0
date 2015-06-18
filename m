From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 17 Jun 2015 20:59:59 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add get_bus_info method
	for X550
Message-ID: <20150618005959.27460.11244.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Don Skidmore <donald.c.skidmore@intel.com>

Added ixgbe_get_bus_info_X550em to X550 code. ixgbe_get_bus_info_X550em
sets bus.width to ixgbe_bus_width_unknown and bus.speed to
ixgbe_bus_speed_unknown, because IOSF does not report a PCIe bus
width or speed.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index ae164da..50e0b05 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -611,6 +611,22 @@ static s32 ixgbe_update_flash_X550(struct ixgbe_hw *hw)
 	return status;
 }
 
+/** ixgbe_get_bus_info_X550em - Set PCI bus info
+  * @hw: pointer to hardware structure
+  *
+  * Sets bus link width and speed to unknown because X550em is
+  * not a PCI device.
+  **/
+static s32 ixgbe_get_bus_info_X550em(struct ixgbe_hw *hw)
+{
+	hw->bus.width = ixgbe_bus_width_unknown;
+	hw->bus.speed = ixgbe_bus_speed_unknown;
+
+	hw->mac.ops.set_lan_id(hw);
+
+	return 0;
+}
+
 /** ixgbe_disable_rx_x550 - Disable RX unit
  *
  *  Enables the Rx DMA unit for x550
@@ -1965,6 +1981,7 @@ static struct ixgbe_mac_operations mac_ops_X550 = {
 	.get_wwn_prefix		= &ixgbe_get_wwn_prefix_generic,
 	.setup_link		= &ixgbe_setup_mac_link_X540,
 	.get_link_capabilities	= &ixgbe_get_copper_link_capabilities_generic,
+	.get_bus_info		= &ixgbe_get_bus_info_generic,
 	.setup_sfp		= NULL,
 };
 
@@ -1976,6 +1993,7 @@ static struct ixgbe_mac_operations mac_ops_X550EM_x = {
 	.get_wwn_prefix		= NULL,
 	.setup_link		= NULL, /* defined later */
 	.get_link_capabilities	= &ixgbe_get_link_capabilities_X550em,
+	.get_bus_info		= &ixgbe_get_bus_info_X550em,
 	.setup_sfp		= ixgbe_setup_sfp_modules_X550em,
 
 };

