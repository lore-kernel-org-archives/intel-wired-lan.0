From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 03 Jun 2015 20:14:14 -0400
Subject: [Intel-wired-lan] [net-next PATCH 11/11] ixgbe: Add support for
	another X550 device.
In-Reply-To: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
References: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150604001414.18893.20092.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Don Skidmore <dcskidmo@dcs-desk.jf.intel.com>

This patch adds support for another 10baseT X550 device.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    7 +++++++
 4 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cd782b2..784ec2b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -136,6 +136,7 @@ static const struct pci_device_id ixgbe_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550T), board_X550},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KX4), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KR), board_X550EM_x},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T), board_X550EM_x},
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 5011e46..51b47eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -347,6 +347,7 @@ static enum ixgbe_phy_type ixgbe_get_phy_type_from_id(u32 phy_id)
 	case TN1010_PHY_ID:
 		phy_type = ixgbe_phy_tn;
 		break;
+	case X550_PHY_ID:
 	case X540_PHY_ID:
 		phy_type = ixgbe_phy_aq;
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 970589b..196b7c7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1354,6 +1354,7 @@ struct ixgbe_thermal_sensor_data {
 #define TN1010_PHY_ID    0x00A19410
 #define TNX_FW_REV       0xB
 #define X540_PHY_ID      0x01540200
+#define X550_PHY_ID      0x01540220
 #define X557_PHY_ID      0x01540240
 #define QT2022_PHY_ID    0x0043A400
 #define ATH_PHY_ID       0x03429050
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 7b9b124..1933399 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1591,6 +1591,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	s32 status;
 	u32 ctrl = 0;
 	u32 i;
+	u32 hlreg0;
 	bool link_up = false;
 
 	/* Call adapter stop to disable Tx/Rx and clear interrupts */
@@ -1675,6 +1676,12 @@ mac_reset_top:
 	hw->mac.num_rar_entries = 128;
 	hw->mac.ops.init_rx_addrs(hw);
 
+	if (hw->device_id == IXGBE_DEV_ID_X550EM_X_10G_T) {
+		hlreg0 = IXGBE_READ_REG(hw, IXGBE_HLREG0);
+		hlreg0 &= ~IXGBE_HLREG0_MDCSPD;
+		IXGBE_WRITE_REG(hw, IXGBE_HLREG0, hlreg0);
+	}
+
 	if (hw->device_id == IXGBE_DEV_ID_X550EM_X_SFP)
 		ixgbe_setup_mux_ctl(hw);
 

