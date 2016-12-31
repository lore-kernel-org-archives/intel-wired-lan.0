From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 30 Dec 2016 21:07:14 -0500
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: Complete support for X553 sgmii
Message-ID: <1483150034-35128-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The initial patches supporting X553 sgmii forgot some details.  This patch
should cover those missing spots.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 29 +++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index f784298..801427a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -334,6 +334,16 @@ static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 	case IXGBE_DEV_ID_X550EM_X_1G_T:
 	case IXGBE_DEV_ID_X550EM_X_10G_T:
 		return ixgbe_identify_phy_generic(hw);
+	case IXGBE_DEV_ID_X550EM_A_1G_T:
+	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
+		hw->phy.type = ixgbe_phy_fw;
+		hw->phy.ops.read_reg = NULL;
+		hw->phy.ops.write_reg = NULL;
+		if (hw->bus.lan_id)
+			hw->phy.phy_semaphore_mask |= IXGBE_GSSR_PHY1_SM;
+		else
+			hw->phy.phy_semaphore_mask |= IXGBE_GSSR_PHY0_SM;
+		break;
 	default:
 		break;
 	}
@@ -2215,8 +2225,20 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
 		else
 			*speed = IXGBE_LINK_SPEED_10GB_FULL;
 	} else {
-		*speed = IXGBE_LINK_SPEED_10GB_FULL |
-			 IXGBE_LINK_SPEED_1GB_FULL;
+		switch (hw->phy.type) {
+		case ixgbe_phy_x550em_kx4:
+			*speed = IXGBE_LINK_SPEED_1GB_FULL |
+				 IXGBE_LINK_SPEED_2_5GB_FULL |
+				 IXGBE_LINK_SPEED_10GB_FULL;
+			break;
+		case ixgbe_phy_sgmii:
+			*speed = IXGBE_LINK_SPEED_1GB_FULL;
+			break;
+		default:
+			*speed = IXGBE_LINK_SPEED_10GB_FULL |
+				 IXGBE_LINK_SPEED_1GB_FULL;
+			break;
+		}
 		*autoneg = true;
 	}
 	return 0;
@@ -3126,6 +3148,9 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 		phy->ops.handle_lasi = ixgbe_handle_lasi_ext_t_x550em;
 		phy->ops.reset = ixgbe_reset_phy_t_X550em;
 		break;
+	case ixgbe_phy_sgmii:
+		phy->ops.setup_link = NULL;
+		break;
 	case ixgbe_phy_fw:
 		phy->ops.setup_link = ixgbe_setup_fw_link;
 		phy->ops.reset = ixgbe_reset_phy_fw;
-- 
2.4.3

