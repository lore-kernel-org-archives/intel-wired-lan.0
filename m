From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 03 Oct 2016 17:10:03 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: use link instead of I2C
	combined abstraction
In-Reply-To: <20161004000958.22554.2468.stgit@localhost6.localdomain6>
References: <20161004000958.22554.2468.stgit@localhost6.localdomain6>
Message-ID: <20161004001003.22554.95064.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Introduce ixgbe_link_operations struct with the following changes:

	read_i2c_combined		=> read_link
	read_i2c_combined_unlocked	=> read_link_unlocked
	write_i2c_combined		=> write_link
	write_i2c_combined_unlocked	=> write_link_unlocked

This will allow X550EM_a to override these methods for MDIO access
while X550EM_x provides methods to use I2C combined access. This
also adds a new structure, ixgbe_link_info, to hold information
about the link. Initially this is just method pointers and a bus
address.

The functions involved in combined I2C accesses were moved from
ixgbe_phy.c to ixgbe_x550.c. The underlying functions that carry
out the combined I2C accesses were left in ixgbe_phy.c because
they share some functions with other I2C methods.


Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |   68 +---------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   12 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   26 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  106 ++++++++++++++++++++++---
 4 files changed, 122 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index b883b31..78edf5b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -109,8 +109,8 @@ static u8 ixgbe_ones_comp_byte_add(u8 add1, u8 add2)
  *
  *  Returns an error code on error.
  */
-static s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
-					       u16 reg, u16 *val, bool lock)
+s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
+					u16 reg, u16 *val, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 	int max_retry = 10;
@@ -178,36 +178,6 @@ fail:
 }
 
 /**
- *  ixgbe_read_i2c_combined_generic - Perform I2C read combined operation
- *  @hw: pointer to the hardware structure
- *  @addr: I2C bus address to read from
- *  @reg: I2C device register to read from
- *  @val: pointer to location to receive read value
- *
- *  Returns an error code on error.
- */
-s32 ixgbe_read_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
-				    u16 reg, u16 *val)
-{
-	return ixgbe_read_i2c_combined_generic_int(hw, addr, reg, val, true);
-}
-
-/**
- *  ixgbe_read_i2c_combined_generic_unlocked - Unlocked I2C read combined
- *  @hw: pointer to the hardware structure
- *  @addr: I2C bus address to read from
- *  @reg: I2C device register to read from
- *  @val: pointer to location to receive read value
- *
- *  Returns an error code on error.
- */
-s32 ixgbe_read_i2c_combined_generic_unlocked(struct ixgbe_hw *hw, u8 addr,
-					     u16 reg, u16 *val)
-{
-	return ixgbe_read_i2c_combined_generic_int(hw, addr, reg, val, false);
-}
-
-/**
  *  ixgbe_write_i2c_combined_generic_int - Perform I2C write combined operation
  *  @hw: pointer to the hardware structure
  *  @addr: I2C bus address to write to
@@ -217,8 +187,8 @@ s32 ixgbe_read_i2c_combined_generic_unlocked(struct ixgbe_hw *hw, u8 addr,
  *
  *  Returns an error code on error.
  */
-static s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
-						u16 reg, u16 val, bool lock)
+s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
+					 u16 reg, u16 val, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 	int max_retry = 1;
@@ -273,36 +243,6 @@ fail:
 }
 
 /**
- *  ixgbe_write_i2c_combined_generic - Perform I2C write combined operation
- *  @hw: pointer to the hardware structure
- *  @addr: I2C bus address to write to
- *  @reg: I2C device register to write to
- *  @val: value to write
- *
- *  Returns an error code on error.
- */
-s32 ixgbe_write_i2c_combined_generic(struct ixgbe_hw *hw,
-				     u8 addr, u16 reg, u16 val)
-{
-	return ixgbe_write_i2c_combined_generic_int(hw, addr, reg, val, true);
-}
-
-/**
- *  ixgbe_write_i2c_combined_generic_unlocked - Unlocked I2C write combined
- *  @hw: pointer to the hardware structure
- *  @addr: I2C bus address to write to
- *  @reg: I2C device register to write to
- *  @val: value to write
- *
- *  Returns an error code on error.
- */
-s32 ixgbe_write_i2c_combined_generic_unlocked(struct ixgbe_hw *hw,
-					      u8 addr, u16 reg, u16 val)
-{
-	return ixgbe_write_i2c_combined_generic_int(hw, addr, reg, val, false);
-}
-
-/**
  *  ixgbe_identify_phy_generic - Get physical layer module
  *  @hw: pointer to hardware structure
  *
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index cc735ec..ecf05f8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -195,12 +195,8 @@ s32 ixgbe_read_i2c_sff8472_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				   u8 *sff8472_data);
 s32 ixgbe_write_i2c_eeprom_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				   u8 eeprom_data);
-s32 ixgbe_read_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
-				    u16 reg, u16 *val);
-s32 ixgbe_read_i2c_combined_generic_unlocked(struct ixgbe_hw *hw, u8 addr,
-					     u16 reg, u16 *val);
-s32 ixgbe_write_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
-				     u16 reg, u16 val);
-s32 ixgbe_write_i2c_combined_generic_unlocked(struct ixgbe_hw *hw, u8 addr,
-					      u16 reg, u16 val);
+s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *, u8 addr, u16 reg,
+					u16 *val, bool lock);
+s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *, u8 addr, u16 reg,
+					 u16 val, bool lock);
 #endif /* _IXGBE_PHY_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 312bffb..95f6a12 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3395,16 +3395,28 @@ struct ixgbe_phy_operations {
 	s32 (*read_i2c_sff8472)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*read_i2c_eeprom)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*write_i2c_eeprom)(struct ixgbe_hw *, u8, u8);
-	s32 (*read_i2c_combined)(struct ixgbe_hw *, u8 addr, u16 reg, u16 *val);
-	s32 (*write_i2c_combined)(struct ixgbe_hw *, u8 addr, u16 reg, u16 val);
 	s32 (*check_overtemp)(struct ixgbe_hw *);
 	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
 	s32 (*enter_lplu)(struct ixgbe_hw *);
 	s32 (*handle_lasi)(struct ixgbe_hw *hw);
-	s32 (*read_i2c_combined_unlocked)(struct ixgbe_hw *, u8 addr, u16 reg,
-					  u16 *value);
-	s32 (*write_i2c_combined_unlocked)(struct ixgbe_hw *, u8 addr, u16 reg,
-					   u16 value);
+	s32 (*read_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
+				      u8 *value);
+	s32 (*write_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
+				       u8 value);
+};
+
+struct ixgbe_link_operations {
+	s32 (*read_link)(struct ixgbe_hw *, u8 addr, u16 reg, u16 *val);
+	s32 (*read_link_unlocked)(struct ixgbe_hw *, u8 addr, u16 reg,
+				  u16 *val);
+	s32 (*write_link)(struct ixgbe_hw *, u8 addr, u16 reg, u16 val);
+	s32 (*write_link_unlocked)(struct ixgbe_hw *, u8 addr, u16 reg,
+				   u16 val);
+};
+
+struct ixgbe_link_info {
+	struct ixgbe_link_operations ops;
+	u8 addr;
 };
 
 struct ixgbe_eeprom_info {
@@ -3508,6 +3520,7 @@ struct ixgbe_hw {
 	struct ixgbe_addr_filter_info	addr_ctrl;
 	struct ixgbe_fc_info		fc;
 	struct ixgbe_phy_info		phy;
+	struct ixgbe_link_info		link;
 	struct ixgbe_eeprom_info	eeprom;
 	struct ixgbe_bus_info		bus;
 	struct ixgbe_mbx_info		mbx;
@@ -3531,6 +3544,7 @@ struct ixgbe_info {
 	const struct ixgbe_eeprom_operations	*eeprom_ops;
 	const struct ixgbe_phy_operations	*phy_ops;
 	const struct ixgbe_mbx_operations	*mbx_ops;
+	const struct ixgbe_link_operations	*link_ops;
 	const u32			*mvals;
 };
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index d4b8f8c..1929947 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -36,6 +36,23 @@ static s32 ixgbe_get_invariants_X550_x(struct ixgbe_hw *hw)
 {
 	struct ixgbe_mac_info *mac = &hw->mac;
 	struct ixgbe_phy_info *phy = &hw->phy;
+	struct ixgbe_link_info *link = &hw->link;
+
+	/* Start with X540 invariants, since so simular */
+	ixgbe_get_invariants_X540(hw);
+
+	if (mac->ops.get_media_type(hw) != ixgbe_media_type_copper)
+		phy->ops.set_phy_power = NULL;
+
+	link->addr = IXGBE_CS4227;
+
+	return 0;
+}
+
+static s32 ixgbe_get_invariants_X550_a(struct ixgbe_hw *hw)
+{
+	struct ixgbe_mac_info *mac = &hw->mac;
+	struct ixgbe_phy_info *phy = &hw->phy;
 
 	/* Start with X540 invariants, since so simular */
 	ixgbe_get_invariants_X540(hw);
@@ -72,8 +89,7 @@ static void ixgbe_setup_mux_ctl(struct ixgbe_hw *hw)
  */
 static s32 ixgbe_read_cs4227(struct ixgbe_hw *hw, u16 reg, u16 *value)
 {
-	return hw->phy.ops.read_i2c_combined_unlocked(hw, IXGBE_CS4227, reg,
-						      value);
+	return hw->link.ops.read_link_unlocked(hw, hw->link.addr, reg, value);
 }
 
 /**
@@ -86,8 +102,7 @@ static s32 ixgbe_read_cs4227(struct ixgbe_hw *hw, u16 reg, u16 *value)
  */
 static s32 ixgbe_write_cs4227(struct ixgbe_hw *hw, u16 reg, u16 value)
 {
-	return hw->phy.ops.write_i2c_combined_unlocked(hw, IXGBE_CS4227, reg,
-						       value);
+	return hw->link.ops.write_link_unlocked(hw, hw->link.addr, reg, value);
 }
 
 /**
@@ -325,6 +340,68 @@ static s32 ixgbe_write_phy_reg_x550em(struct ixgbe_hw *hw, u32 reg_addr,
 	return IXGBE_NOT_IMPLEMENTED;
 }
 
+/**
+ * ixgbe_read_i2c_combined_generic - Perform I2C read combined operation
+ * @hw: pointer to the hardware structure
+ * @addr: I2C bus address to read from
+ * @reg: I2C device register to read from
+ * @val: pointer to location to receive read value
+ *
+ * Returns an error code on error.
+ **/
+static s32 ixgbe_read_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
+					   u16 reg, u16 *val)
+{
+	return ixgbe_read_i2c_combined_generic_int(hw, addr, reg, val, true);
+}
+
+/**
+ * ixgbe_read_i2c_combined_generic_unlocked - Do I2C read combined operation
+ * @hw: pointer to the hardware structure
+ * @addr: I2C bus address to read from
+ * @reg: I2C device register to read from
+ * @val: pointer to location to receive read value
+ *
+ * Returns an error code on error.
+ **/
+static s32
+ixgbe_read_i2c_combined_generic_unlocked(struct ixgbe_hw *hw, u8 addr,
+					 u16 reg, u16 *val)
+{
+	return ixgbe_read_i2c_combined_generic_int(hw, addr, reg, val, false);
+}
+
+/**
+ * ixgbe_write_i2c_combined_generic - Perform I2C write combined operation
+ * @hw: pointer to the hardware structure
+ * @addr: I2C bus address to write to
+ * @reg: I2C device register to write to
+ * @val: value to write
+ *
+ * Returns an error code on error.
+ **/
+static s32 ixgbe_write_i2c_combined_generic(struct ixgbe_hw *hw,
+					    u8 addr, u16 reg, u16 val)
+{
+	return ixgbe_write_i2c_combined_generic_int(hw, addr, reg, val, true);
+}
+
+/**
+ * ixgbe_write_i2c_combined_generic_unlocked - Do I2C write combined operation
+ * @hw: pointer to the hardware structure
+ * @addr: I2C bus address to write to
+ * @reg: I2C device register to write to
+ * @val: value to write
+ *
+ * Returns an error code on error.
+ **/
+static s32
+ixgbe_write_i2c_combined_generic_unlocked(struct ixgbe_hw *hw,
+					  u8 addr, u16 reg, u16 val)
+{
+	return ixgbe_write_i2c_combined_generic_int(hw, addr, reg, val, false);
+}
+
 /** ixgbe_init_eeprom_params_X550 - Initialize EEPROM params
  *  @hw: pointer to hardware structure
  *
@@ -1376,8 +1453,10 @@ ixgbe_setup_mac_link_sfp_x550em(struct ixgbe_hw *hw,
 		reg_val = (IXGBE_CS4227_EDC_MODE_CX1 << 1) | 0x1;
 	else
 		reg_val = (IXGBE_CS4227_EDC_MODE_SR << 1) | 0x1;
-	status = ixgbe_write_i2c_combined_generic(hw, IXGBE_CS4227,
-						  reg_slice, reg_val);
+
+	status = hw->link.ops.write_link(hw, hw->link.addr, reg_slice,
+					 reg_val);
+
 	return status;
 }
 
@@ -3318,11 +3397,6 @@ static const struct ixgbe_phy_operations phy_ops_X550EM_x = {
 	.identify		= &ixgbe_identify_phy_x550em,
 	.read_reg		= &ixgbe_read_phy_reg_generic,
 	.write_reg		= &ixgbe_write_phy_reg_generic,
-	.read_i2c_combined	= &ixgbe_read_i2c_combined_generic,
-	.write_i2c_combined	= &ixgbe_write_i2c_combined_generic,
-	.read_i2c_combined_unlocked = &ixgbe_read_i2c_combined_generic_unlocked,
-	.write_i2c_combined_unlocked =
-				     &ixgbe_write_i2c_combined_generic_unlocked,
 };
 
 static const struct ixgbe_phy_operations phy_ops_x550em_a = {
@@ -3335,6 +3409,13 @@ static const struct ixgbe_phy_operations phy_ops_x550em_a = {
 	.write_reg_mdi		= &ixgbe_write_phy_reg_mdi,
 };
 
+static const struct ixgbe_link_operations link_ops_x550em_x = {
+	.read_link		= &ixgbe_read_i2c_combined_generic,
+	.read_link_unlocked	= &ixgbe_read_i2c_combined_generic_unlocked,
+	.write_link		= &ixgbe_write_i2c_combined_generic,
+	.write_link_unlocked	= &ixgbe_write_i2c_combined_generic_unlocked,
+};
+
 static const u32 ixgbe_mvals_X550[IXGBE_MVALS_IDX_LIMIT] = {
 	IXGBE_MVALS_INIT(X550)
 };
@@ -3365,11 +3446,12 @@ const struct ixgbe_info ixgbe_X550EM_x_info = {
 	.phy_ops		= &phy_ops_X550EM_x,
 	.mbx_ops		= &mbx_ops_generic,
 	.mvals			= ixgbe_mvals_X550EM_x,
+	.link_ops		= &link_ops_x550em_x,
 };
 
 const struct ixgbe_info ixgbe_x550em_a_info = {
 	.mac			= ixgbe_mac_x550em_a,
-	.get_invariants		= &ixgbe_get_invariants_X550_x,
+	.get_invariants		= &ixgbe_get_invariants_X550_a,
 	.mac_ops		= &mac_ops_x550em_a,
 	.eeprom_ops		= &eeprom_ops_X550EM_x,
 	.phy_ops		= &phy_ops_x550em_a,

