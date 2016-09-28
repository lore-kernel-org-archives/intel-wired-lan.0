From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 28 Sep 2016 19:35:46 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add X553 FW ALEF support
Message-ID: <1475105746-43737-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch add X553 FW ALEF support for B0.  ALEF is the new unified
FW.  This contains updated register defines for ALEF speed
configuration.  Likewise it also removes the AN_CNTL_8 usage from
the native SFI flow as it is no longer supported by FW.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  16 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 241 +++++++++++++++++++-------
 2 files changed, 192 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 998708c..312bffb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3588,9 +3588,25 @@ struct ixgbe_info {
 #define IXGBE_KRM_DSP_TXFFE_STATE_5(P)	((P) ? 0x8638 : 0x4638)
 #define IXGBE_KRM_RX_TRN_LINKUP_CTRL(P)	((P) ? 0x8B00 : 0x4B00)
 #define IXGBE_KRM_PMD_DFX_BURNIN(P)	((P) ? 0x8E00 : 0x4E00)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20(P)	((P) ? 0x9054 : 0x5054)
 #define IXGBE_KRM_TX_COEFF_CTRL_1(P)	((P) ? 0x9520 : 0x5520)
 #define IXGBE_KRM_RX_ANA_CTL(P)		((P) ? 0x9A00 : 0x5A00)
 
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA		~(0x3 << 20)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_SR		BIT(20)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_LR		(0x2 << 20)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SGMII_EN		BIT(25)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_AN37_EN		BIT(26)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_AN_EN		BIT(27)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_10M		~(0x7 << 28)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_100M		BIT(28)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_1G		(0x2 << 28)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_10G		(0x3 << 28)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_AN		(0x4 << 28)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_2_5G		(0x7 << 28)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_MASK		(0x7 << 28)
+#define IXGBE_KRM_PMD_FLX_MASK_ST20_FW_AN_RESTART	BIT(31)
+
 #define IXGBE_KRM_PORT_CAR_GEN_CTRL_NELB_32B		BIT(9)
 #define IXGBE_KRM_PORT_CAR_GEN_CTRL_NELB_KRPCS		BIT(11)
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 3796482..905ccc7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1204,6 +1204,53 @@ static s32 ixgbe_setup_ixfi_x550em_x(struct ixgbe_hw *hw)
 	return status;
 }
 
+/**
+ *  ixgbe_restart_an_internal_phy_x550em - restart autonegotiation for the
+ *  internal PHY
+ *  @hw: pointer to hardware structure
+ **/
+static s32 ixgbe_restart_an_internal_phy_x550em(struct ixgbe_hw *hw)
+{
+	s32 status;
+	u32 link_ctrl;
+
+	/* Restart auto-negotiation. */
+	status = hw->mac.ops.read_iosf_sb_reg(hw,
+				IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, &link_ctrl);
+
+	if (status) {
+		hw_dbg(hw, "Auto-negotiation did not complete\n");
+		return status;
+	}
+
+	link_ctrl |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
+	status = hw->mac.ops.write_iosf_sb_reg(hw,
+				IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, link_ctrl);
+
+	if (hw->mac.type == ixgbe_mac_x550em_a) {
+		u32 flx_mask_st20;
+
+		/* Indicate to FW that AN restart has been asserted */
+		status = hw->mac.ops.read_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, &flx_mask_st20);
+
+		if (status) {
+			hw_dbg(hw, "Auto-negotiation did not complete\n");
+			return status;
+		}
+
+		flx_mask_st20 |= IXGBE_KRM_PMD_FLX_MASK_ST20_FW_AN_RESTART;
+		status = hw->mac.ops.write_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, flx_mask_st20);
+	}
+
+	return status;
+}
+
 /** ixgbe_setup_ixfi_x550em - Configure the KR PHY for iXFI mode.
  *  @hw: pointer to hardware structure
  *  @speed: the link speed to force
@@ -1253,16 +1300,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 	}
 
 	/* Toggle port SW reset by AN reset. */
-	status = ixgbe_read_iosf_sb_reg_x550(hw,
-				IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-				IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	if (status)
-		return status;
-
-	reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
-	status = ixgbe_write_iosf_sb_reg_x550(hw,
-				IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+	status = ixgbe_restart_an_internal_phy_x550em(hw);
 
 	return status;
 }
@@ -1398,6 +1436,55 @@ i2c_err:
 }
 
 /**
+ * ixgbe_setup_sfi_x550a - Configure the internal PHY for native SFI mode
+ * @hw: pointer to hardware structure
+ * @speed: the link speed to force
+ *
+ * Configures the integrated PHY for native SFI mode. Used to connect the
+ * internal PHY directly to an SFP cage, without autonegotiation.
+ **/
+static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
+{
+	struct ixgbe_mac_info *mac = &hw->mac;
+	s32 status;
+	u32 reg_val;
+
+	/* Disable all AN and force speed to 10G Serial. */
+	status = mac->ops.read_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
+	if (status)
+		return status;
+
+	reg_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_AN_EN;
+	reg_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_AN37_EN;
+	reg_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_SGMII_EN;
+	reg_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_MASK;
+
+	/* Select forced link speed for internal PHY. */
+	switch (*speed) {
+	case IXGBE_LINK_SPEED_10GB_FULL:
+		reg_val |= IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_10G;
+		break;
+	case IXGBE_LINK_SPEED_1GB_FULL:
+		reg_val |= IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_1G;
+		break;
+	default:
+		/* Other link speeds are not supported by internal PHY. */
+		return IXGBE_ERR_LINK_SETUP;
+	}
+
+	status = mac->ops.write_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+
+	/* Toggle port SW reset by AN reset. */
+	status = ixgbe_restart_an_internal_phy_x550em(hw);
+
+	return status;
+}
+
+/**
  * ixgbe_setup_mac_link_sfp_n - Setup internal PHY for native SFP
  * @hw: pointer to hardware structure
  *
@@ -1409,45 +1496,39 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 {
 	bool setup_linear = false;
 	u32 reg_phy_int;
-	s32 rc;
+	s32 ret_val;
 
 	/* Check if SFP module is supported and linear */
-	rc = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
+	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
 
 	/* If no SFP module present, then return success. Return success since
 	 * SFP not present error is not excepted in the setup MAC link flow.
 	 */
-	if (rc == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
 		return 0;
 
-	if (!rc)
-		return rc;
+	if (!ret_val)
+		return ret_val;
 
-	/* Configure internal PHY for native SFI */
-	rc = hw->mac.ops.read_iosf_sb_reg(hw,
-					  IXGBE_KRM_AN_CNTL_8(hw->bus.lan_id),
-					  IXGBE_SB_IOSF_TARGET_KR_PHY,
-					  &reg_phy_int);
-	if (rc)
-		return rc;
+	/* Configure internal PHY for native SFI based on module type */
+	ret_val = hw->mac.ops.read_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_phy_int);
+	if (!ret_val)
+		return ret_val;
 
-	if (setup_linear) {
-		reg_phy_int &= ~IXGBE_KRM_AN_CNTL_8_LIMITING;
-		reg_phy_int |= IXGBE_KRM_AN_CNTL_8_LINEAR;
-	} else {
-		reg_phy_int |= IXGBE_KRM_AN_CNTL_8_LIMITING;
-		reg_phy_int &= ~IXGBE_KRM_AN_CNTL_8_LINEAR;
-	}
+	reg_phy_int &= IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA;
+	if (!setup_linear)
+		reg_phy_int |= IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_SR;
 
-	rc = hw->mac.ops.write_iosf_sb_reg(hw,
-					   IXGBE_KRM_AN_CNTL_8(hw->bus.lan_id),
-					   IXGBE_SB_IOSF_TARGET_KR_PHY,
-					   reg_phy_int);
-	if (rc)
-		return rc;
+	ret_val = hw->mac.ops.write_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_phy_int);
+	if (!ret_val)
+		return ret_val;
 
-	/* Setup XFI/SFI internal link */
-	return ixgbe_setup_ixfi_x550em(hw, &speed);
+	/* Setup SFI internal link. */
+	return ixgbe_setup_sfi_x550a(hw, &speed);
 }
 
 /**
@@ -1463,19 +1544,19 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	u32 reg_slice, slice_offset;
 	bool setup_linear = false;
 	u16 reg_phy_ext;
-	s32 rc;
+	s32 ret_val;
 
 	/* Check if SFP module is supported and linear */
-	rc = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
+	ret_val = ixgbe_supported_sfp_modules_X550em(hw, &setup_linear);
 
 	/* If no SFP module present, then return success. Return success since
 	 * SFP not present error is not excepted in the setup MAC link flow.
 	 */
-	if (rc == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
 		return 0;
 
-	if (!rc)
-		return rc;
+	if (!ret_val)
+		return ret_val;
 
 	/* Configure internal PHY for KR/KX. */
 	ixgbe_setup_kr_speed_x550em(hw, speed);
@@ -1484,10 +1565,10 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 		return IXGBE_ERR_PHY_ADDR_INVALID;
 
 	/* Get external PHY device id */
-	rc = hw->phy.ops.read_reg(hw, IXGBE_CS4227_GLOBAL_ID_MSB,
+	ret_val = hw->phy.ops.read_reg(hw, IXGBE_CS4227_GLOBAL_ID_MSB,
 				  IXGBE_MDIO_ZERO_DEV_TYPE, &reg_phy_ext);
-	if (rc)
-		return rc;
+	if (ret_val)
+		return ret_val;
 
 	/* When configuring quad port CS4223, the MAC instance is part
 	 * of the slice offset.
@@ -1600,7 +1681,7 @@ ixgbe_setup_sgmii(struct ixgbe_hw *hw, __always_unused ixgbe_link_speed speed,
 		  __always_unused bool autoneg_wait_to_complete)
 {
 	struct ixgbe_mac_info *mac = &hw->mac;
-	u32 lval, sval;
+	u32 lval, sval, flx_val;
 	s32 rc;
 
 	rc = mac->ops.read_iosf_sb_reg(hw,
@@ -1634,11 +1715,31 @@ ixgbe_setup_sgmii(struct ixgbe_hw *hw, __always_unused ixgbe_link_speed speed,
 	if (rc)
 		return rc;
 
-	lval |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
+	rc = mac->ops.read_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, &flx_val);
+	if (rc)
+		return rc;
+
+	rc = mac->ops.read_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, &flx_val);
+	if (rc)
+		return rc;
+
+	flx_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_MASK;
+	flx_val |= IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_1G;
+	flx_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_AN_EN;
+	flx_val |= IXGBE_KRM_PMD_FLX_MASK_ST20_SGMII_EN;
+	flx_val |= IXGBE_KRM_PMD_FLX_MASK_ST20_AN37_EN;
+
 	rc = mac->ops.write_iosf_sb_reg(hw,
-					IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-					IXGBE_SB_IOSF_TARGET_KR_PHY, lval);
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, flx_val);
+	if (rc)
+		return rc;
 
+	rc = ixgbe_restart_an_internal_phy_x550em(hw);
 	return rc;
 }
 
@@ -1661,6 +1762,10 @@ static void ixgbe_init_mac_link_ops_X550em_a(struct ixgbe_hw *hw)
 	default:
 		break;
 	}
+
+	/* Additional modification for X550em_a devices */
+	if (hw->mac.type == ixgbe_mac_x550em_a)
+		ixgbe_init_mac_link_ops_X550em_a(hw);
 }
 
 /** ixgbe_init_mac_link_ops_X550em - init mac link function pointers
@@ -1995,13 +2100,31 @@ static s32 ixgbe_setup_kr_speed_x550em(struct ixgbe_hw *hw,
 	if (speed & IXGBE_LINK_SPEED_1GB_FULL)
 		reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_CAP_KX;
 
-	/* Restart auto-negotiation. */
-	reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
 	status = hw->mac.ops.write_iosf_sb_reg(hw,
 					IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
 					IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
 
-	return status;
+	if (hw->mac.type == ixgbe_mac_x550em_a) {
+		/* Set lane mode  to KR auto negotiation */
+		status = hw->mac.ops.read_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
+
+		if (status)
+			return status;
+
+		reg_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_MASK;
+		reg_val |= IXGBE_KRM_PMD_FLX_MASK_ST20_SPEED_AN;
+		reg_val |= IXGBE_KRM_PMD_FLX_MASK_ST20_AN_EN;
+		reg_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_AN37_EN;
+		reg_val &= ~IXGBE_KRM_PMD_FLX_MASK_ST20_SGMII_EN;
+
+		status = hw->mac.ops.write_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+	}
+
+	return ixgbe_restart_an_internal_phy_x550em(hw);
 }
 
 /** ixgbe_setup_kx4_x550em - Configure the KX4 PHY.
@@ -2869,7 +2992,6 @@ static void ixgbe_set_source_address_pruning_X550(struct ixgbe_hw *hw,
 static s32 ixgbe_setup_fc_backplane_x550em_a(struct ixgbe_hw *hw)
 {
 	s32 status = 0;
-	u32 link_ctrl = 0;
 	u32 an_cntl = 0;
 
 	/* Validate the requested mode */
@@ -2940,18 +3062,7 @@ static s32 ixgbe_setup_fc_backplane_x550em_a(struct ixgbe_hw *hw)
 					IXGBE_SB_IOSF_TARGET_KR_PHY, an_cntl);
 
 	/* Restart auto-negotiation. */
-	status = hw->mac.ops.read_iosf_sb_reg(hw,
-				IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-				IXGBE_SB_IOSF_TARGET_KR_PHY, &link_ctrl);
-	if (status) {
-		hw_dbg(hw, "Auto-Negotiation did not complete\n");
-		return status;
-	}
-
-	link_ctrl |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
-	status = hw->mac.ops.write_iosf_sb_reg(hw,
-				IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-				IXGBE_SB_IOSF_TARGET_KR_PHY, link_ctrl);
+	status = ixgbe_restart_an_internal_phy_x550em(hw);
 
 	return status;
 }
-- 
2.4.3

