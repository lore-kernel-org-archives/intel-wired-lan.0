From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 17 Aug 2016 20:34:40 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for new X557 device
Message-ID: <1471480480-26483-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support for the new copper device X557.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 8 ++++++++
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index b4217f3..3095c24 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -99,6 +99,7 @@ bool ixgbe_device_supports_autoneg_fc(struct ixgbe_hw *hw)
 		case IXGBE_DEV_ID_X550T:
 		case IXGBE_DEV_ID_X550T1:
 		case IXGBE_DEV_ID_X550EM_X_10G_T:
+		case IXGBE_DEV_ID_X550EM_A_10G_T:
 			supported = true;
 			break;
 		default:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e06ca55..33ad52b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -137,6 +137,7 @@ static const struct pci_device_id ixgbe_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP_N), board_x550em_a },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII), board_x550em_a },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII_L), board_x550em_a },
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_10G_T), board_x550em_a},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP), board_x550em_a },
 	/* required last entry */
 	{0, }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index a59b65f7..31d82e3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -90,6 +90,7 @@
 #define IXGBE_DEV_ID_X550EM_A_SFP_N	0x15C4
 #define IXGBE_DEV_ID_X550EM_A_SGMII	0x15C6
 #define IXGBE_DEV_ID_X550EM_A_SGMII_L	0x15C7
+#define IXGBE_DEV_ID_X550EM_A_10G_T	0x15C8
 #define IXGBE_DEV_ID_X550EM_A_SFP	0x15CE
 
 /* VF Device IDs */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a8030e0..fb1b819 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -295,6 +295,12 @@ static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 	case IXGBE_DEV_ID_X550EM_A_KR_L:
 		hw->phy.type = ixgbe_phy_x550em_kr;
 		break;
+	case IXGBE_DEV_ID_X550EM_A_10G_T:
+		if (hw->bus.lan_id)
+			hw->phy.phy_semaphore_mask = IXGBE_GSSR_PHY1_SM;
+		else
+			hw->phy.phy_semaphore_mask = IXGBE_GSSR_PHY0_SM;
+		/* Fallthrough */
 	case IXGBE_DEV_ID_X550EM_X_1G_T:
 	case IXGBE_DEV_ID_X550EM_X_10G_T:
 		return ixgbe_identify_phy_generic(hw);
@@ -2500,6 +2506,7 @@ static enum ixgbe_media_type ixgbe_get_media_type_X550em(struct ixgbe_hw *hw)
 		break;
 	case IXGBE_DEV_ID_X550EM_X_1G_T:
 	case IXGBE_DEV_ID_X550EM_X_10G_T:
+	case IXGBE_DEV_ID_X550EM_A_10G_T:
 		media_type = ixgbe_media_type_copper;
 		break;
 	default:
@@ -2560,6 +2567,7 @@ static void ixgbe_set_mdio_speed(struct ixgbe_hw *hw)
 	case IXGBE_DEV_ID_X550EM_X_10G_T:
 	case IXGBE_DEV_ID_X550EM_A_SGMII:
 	case IXGBE_DEV_ID_X550EM_A_SGMII_L:
+	case IXGBE_DEV_ID_X550EM_A_10G_T:
 	case IXGBE_DEV_ID_X550EM_A_SFP:
 		/* Config MDIO clock speed before the first MDIO PHY access */
 		hlreg0 = IXGBE_READ_REG(hw, IXGBE_HLREG0);
-- 
2.4.3

