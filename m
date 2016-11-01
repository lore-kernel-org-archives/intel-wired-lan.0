From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  1 Nov 2016 13:58:27 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove driver config for KX4 PHY
Message-ID: <1478033907-10221-1-git-send-email-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The KX4 PHY is configured by the NVM.  Currently, the driver is overwriting
the config; remove the code associated with KX4 configuration.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 12 --------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 40 +--------------------------
 3 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index b1711ff..df657ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -784,7 +784,8 @@ s32 ixgbe_setup_phy_link_speed_generic(struct ixgbe_hw *hw,
 		hw->phy.autoneg_advertised |= IXGBE_LINK_SPEED_100_FULL;
 
 	/* Setup link based on the new speed settings */
-	hw->phy.ops.setup_link(hw);
+	if (hw->phy.ops.setup_link)
+		hw->phy.ops.setup_link(hw);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index bde7e33..9ad110d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3679,15 +3679,6 @@ struct ixgbe_info {
 #define IXGBE_KRM_TX_COEFF_CTRL_1_CZERO_EN		BIT(3)
 #define IXGBE_KRM_TX_COEFF_CTRL_1_OVRRD_EN		BIT(31)
 
-#define IXGBE_KX4_LINK_CNTL_1				0x4C
-#define IXGBE_KX4_LINK_CNTL_1_TETH_AN_CAP_KX		BIT(16)
-#define IXGBE_KX4_LINK_CNTL_1_TETH_AN_CAP_KX4		BIT(17)
-#define IXGBE_KX4_LINK_CNTL_1_TETH_EEE_CAP_KX		BIT(24)
-#define IXGBE_KX4_LINK_CNTL_1_TETH_EEE_CAP_KX4		BIT(25)
-#define IXGBE_KX4_LINK_CNTL_1_TETH_AN_ENABLE		BIT(29)
-#define IXGBE_KX4_LINK_CNTL_1_TETH_FORCE_LINK_UP	BIT(30)
-#define IXGBE_KX4_LINK_CNTL_1_TETH_AN_RESTART		BIT(31)
-
 #define IXGBE_SB_IOSF_INDIRECT_CTRL		0x00011144
 #define IXGBE_SB_IOSF_INDIRECT_DATA		0x00011148
 
@@ -3704,9 +3695,6 @@ struct ixgbe_info {
 #define IXGBE_SB_IOSF_CTRL_BUSY_SHIFT		31
 #define IXGBE_SB_IOSF_CTRL_BUSY		BIT(IXGBE_SB_IOSF_CTRL_BUSY_SHIFT)
 #define IXGBE_SB_IOSF_TARGET_KR_PHY	0
-#define IXGBE_SB_IOSF_TARGET_KX4_UNIPHY	1
-#define IXGBE_SB_IOSF_TARGET_KX4_PCS0	2
-#define IXGBE_SB_IOSF_TARGET_KX4_PCS1	3
 
 #define IXGBE_NW_MNG_IF_SEL		0x00011178
 #define IXGBE_NW_MNG_IF_SEL_MDIO_ACT		BIT(1)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 92f2b5e..80be82d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2146,44 +2146,6 @@ static s32 ixgbe_setup_kr_speed_x550em(struct ixgbe_hw *hw,
 	return ixgbe_restart_an_internal_phy_x550em(hw);
 }
 
-/** ixgbe_setup_kx4_x550em - Configure the KX4 PHY.
- *  @hw: pointer to hardware structure
- *
- *   Configures the integrated KX4 PHY.
- **/
-static s32 ixgbe_setup_kx4_x550em(struct ixgbe_hw *hw)
-{
-	s32 status;
-	u32 reg_val;
-
-	status = hw->mac.ops.read_iosf_sb_reg(hw, IXGBE_KX4_LINK_CNTL_1,
-					      IXGBE_SB_IOSF_TARGET_KX4_PCS0 +
-					      hw->bus.lan_id, &reg_val);
-	if (status)
-		return status;
-
-	reg_val &= ~(IXGBE_KX4_LINK_CNTL_1_TETH_AN_CAP_KX4 |
-		     IXGBE_KX4_LINK_CNTL_1_TETH_AN_CAP_KX);
-
-	reg_val |= IXGBE_KX4_LINK_CNTL_1_TETH_AN_ENABLE;
-
-	/* Advertise 10G support. */
-	if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL)
-		reg_val |= IXGBE_KX4_LINK_CNTL_1_TETH_AN_CAP_KX4;
-
-	/* Advertise 1G support. */
-	if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL)
-		reg_val |= IXGBE_KX4_LINK_CNTL_1_TETH_AN_CAP_KX;
-
-	/* Restart auto-negotiation. */
-	reg_val |= IXGBE_KX4_LINK_CNTL_1_TETH_AN_RESTART;
-	status = hw->mac.ops.write_iosf_sb_reg(hw, IXGBE_KX4_LINK_CNTL_1,
-					       IXGBE_SB_IOSF_TARGET_KX4_PCS0 +
-					       hw->bus.lan_id, reg_val);
-
-	return status;
-}
-
 /**
  * ixgbe_setup_kr_x550em - Configure the KR PHY
  * @hw: pointer to hardware structure
@@ -2764,7 +2726,7 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 	/* Set functions pointers based on phy type */
 	switch (hw->phy.type) {
 	case ixgbe_phy_x550em_kx4:
-		phy->ops.setup_link = ixgbe_setup_kx4_x550em;
+		phy->ops.setup_link = NULL;
 		phy->ops.read_reg = ixgbe_read_phy_reg_x550em;
 		phy->ops.write_reg = ixgbe_write_phy_reg_x550em;
 		break;
-- 
2.4.0

