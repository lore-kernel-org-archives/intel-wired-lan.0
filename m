From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 07 Dec 2016 13:59:28 -0800
Subject: [Intel-wired-lan] [PATCH V2 2/4] ixgbe: Remove unused firmware
 version functions and method
In-Reply-To: <148114788660.130011.4413036825097860499.stgit@mdrustad-wks.jf.intel.com>
References: <148114788660.130011.4413036825097860499.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <148114796871.130011.4860615754246724482.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The firmware version method and functions are not used anywhere, so
remove them all.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |    2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |    2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c   |   34 ------------------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h   |    4 ---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |    3 +-
 7 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 805ab319e578..523f9d05a810 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -139,8 +139,6 @@ static s32 ixgbe_init_phy_ops_82598(struct ixgbe_hw *hw)
 	case ixgbe_phy_tn:
 		phy->ops.setup_link = &ixgbe_setup_phy_link_tnx;
 		phy->ops.check_link = &ixgbe_check_phy_link_tnx;
-		phy->ops.get_firmware_version =
-			     &ixgbe_get_phy_firmware_version_tnx;
 		break;
 	case ixgbe_phy_nl:
 		phy->ops.reset = &ixgbe_reset_phy_nl;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index e00aaeb91827..30535e6b68f0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -331,8 +331,6 @@ static s32 ixgbe_init_phy_ops_82599(struct ixgbe_hw *hw)
 	case ixgbe_phy_tn:
 		phy->ops.check_link = &ixgbe_check_phy_link_tnx;
 		phy->ops.setup_link = &ixgbe_setup_phy_link_tnx;
-		phy->ops.get_firmware_version =
-			     &ixgbe_get_phy_firmware_version_tnx;
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 4aa679359aa8..989a3b19d209 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -978,40 +978,6 @@ s32 ixgbe_setup_phy_link_tnx(struct ixgbe_hw *hw)
 }
 
 /**
- *  ixgbe_get_phy_firmware_version_tnx - Gets the PHY Firmware Version
- *  @hw: pointer to hardware structure
- *  @firmware_version: pointer to the PHY Firmware Version
- **/
-s32 ixgbe_get_phy_firmware_version_tnx(struct ixgbe_hw *hw,
-				       u16 *firmware_version)
-{
-	s32 status;
-
-	status = hw->phy.ops.read_reg(hw, TNX_FW_REV,
-				      MDIO_MMD_VEND1,
-				      firmware_version);
-
-	return status;
-}
-
-/**
- *  ixgbe_get_phy_firmware_version_generic - Gets the PHY Firmware Version
- *  @hw: pointer to hardware structure
- *  @firmware_version: pointer to the PHY Firmware Version
- **/
-s32 ixgbe_get_phy_firmware_version_generic(struct ixgbe_hw *hw,
-					   u16 *firmware_version)
-{
-	s32 status;
-
-	status = hw->phy.ops.read_reg(hw, AQ_FW_REV,
-				      MDIO_MMD_VEND1,
-				      firmware_version);
-
-	return status;
-}
-
-/**
  *  ixgbe_reset_phy_nl - Performs a PHY reset
  *  @hw: pointer to hardware structure
  **/
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index ecf05f838fc5..5aa2c3cf7aec 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -168,10 +168,6 @@ s32 ixgbe_check_phy_link_tnx(struct ixgbe_hw *hw,
 			     ixgbe_link_speed *speed,
 			     bool *link_up);
 s32 ixgbe_setup_phy_link_tnx(struct ixgbe_hw *hw);
-s32 ixgbe_get_phy_firmware_version_tnx(struct ixgbe_hw *hw,
-				       u16 *firmware_version);
-s32 ixgbe_get_phy_firmware_version_generic(struct ixgbe_hw *hw,
-					   u16 *firmware_version);
 
 s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw);
 s32 ixgbe_set_copper_phy_power(struct ixgbe_hw *hw, bool on);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index bfa5d190efe7..2b590fcb82b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3404,7 +3404,6 @@ struct ixgbe_phy_operations {
 	s32 (*setup_internal_link)(struct ixgbe_hw *);
 	s32 (*setup_link_speed)(struct ixgbe_hw *, ixgbe_link_speed, bool);
 	s32 (*check_link)(struct ixgbe_hw *, ixgbe_link_speed *, bool *);
-	s32 (*get_firmware_version)(struct ixgbe_hw *, u16 *);
 	s32 (*read_i2c_byte)(struct ixgbe_hw *, u8, u8, u8 *);
 	s32 (*write_i2c_byte)(struct ixgbe_hw *, u8, u8, u8);
 	s32 (*read_i2c_sff8472)(struct ixgbe_hw *, u8 , u8 *);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index e2ff823ee202..72049fa23616 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -913,7 +913,6 @@ static const struct ixgbe_phy_operations phy_ops_X540 = {
 	.write_i2c_eeprom       = &ixgbe_write_i2c_eeprom_generic,
 	.check_overtemp         = &ixgbe_tn_check_overtemp,
 	.set_phy_power          = &ixgbe_set_copper_phy_power,
-	.get_firmware_version   = &ixgbe_get_phy_firmware_version_generic,
 };
 
 static const u32 ixgbe_mvals_X540[IXGBE_MVALS_IDX_LIMIT] = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 16e1aaf74a63..e58bd77d9197 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3382,8 +3382,7 @@ static const struct ixgbe_eeprom_operations eeprom_ops_X550EM_x = {
 	.write_i2c_eeprom	= &ixgbe_write_i2c_eeprom_generic, \
 	.setup_link		= &ixgbe_setup_phy_link_generic, \
 	.set_phy_power		= NULL, \
-	.check_overtemp		= &ixgbe_tn_check_overtemp, \
-	.get_firmware_version	= &ixgbe_get_phy_firmware_version_generic,
+	.check_overtemp		= &ixgbe_tn_check_overtemp,
 
 static const struct ixgbe_phy_operations phy_ops_X550 = {
 	X550_COMMON_PHY

