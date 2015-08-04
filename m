From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 04 Aug 2015 13:41:30 -0700
Subject: [Intel-wired-lan] [PATCH V4 04/13] ixgbe: Provide unlocked I2C
	methods
In-Reply-To: <20150804204010.51606.29686.stgit@mdrustad-wks.jf.intel.com>
References: <20150804204010.51606.29686.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150804204130.51606.97686.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Most I2C accesses take and release semaphores for each access. Now
there is a reason to perform multiple I2C operations under the same
holding of the semaphore, so provide unlocked I2C methods for that
purpose.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  195 +++++++++++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |    8 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    3 
 4 files changed, 178 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 597d0b1c2370..7ff7d7012f68 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -99,17 +99,17 @@ static u8 ixgbe_ones_comp_byte_add(u8 add1, u8 add2)
 	return sum & 0xFF;
 }
 
-/**
- *  ixgbe_read_i2c_combined_generic - Perform I2C read combined operation
+/** ixgbe_read_i2c_combined_generic_int - Perform I2C read combined operation
  *  @hw: pointer to the hardware structure
  *  @addr: I2C bus address to read from
  *  @reg: I2C device register to read from
  *  @val: pointer to location to receive read value
+ *  @lock: true if to take and release semaphore
  *
  *  Returns an error code on error.
- **/
-s32 ixgbe_read_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
-				    u16 reg, u16 *val)
+ */
+static s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
+					       u16 reg, u16 *val, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 	int max_retry = 10;
@@ -124,7 +124,7 @@ s32 ixgbe_read_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
 	csum = ixgbe_ones_comp_byte_add(reg_high, reg & 0xFF);
 	csum = ~csum;
 	do {
-		if (hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
+		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
 			return IXGBE_ERR_SWFW_SYNC;
 		ixgbe_i2c_start(hw);
 		/* Device Address and write indication */
@@ -157,13 +157,15 @@ s32 ixgbe_read_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
 		if (ixgbe_clock_out_i2c_bit(hw, false))
 			goto fail;
 		ixgbe_i2c_stop(hw);
-		hw->mac.ops.release_swfw_sync(hw, swfw_mask);
+		if (lock)
+			hw->mac.ops.release_swfw_sync(hw, swfw_mask);
 		*val = (high_bits << 8) | low_bits;
 		return 0;
 
 fail:
 		ixgbe_i2c_bus_clear(hw);
-		hw->mac.ops.release_swfw_sync(hw, swfw_mask);
+		if (lock)
+			hw->mac.ops.release_swfw_sync(hw, swfw_mask);
 		retry++;
 		if (retry < max_retry)
 			hw_dbg(hw, "I2C byte read combined error - Retry.\n");
@@ -174,18 +176,47 @@ fail:
 	return IXGBE_ERR_I2C;
 }
 
-/**
- *  ixgbe_write_i2c_combined_generic - Perform I2C write combined operation
+/** ixgbe_read_i2c_combined_generic - Perform I2C read combined operation
+ *  @hw: pointer to the hardware structure
+ *  @addr: I2C bus address to read from
+ *  @reg: I2C device register to read from
+ *  @val: pointer to location to receive read value
+ *
+ *  Returns an error code on error.
+ */
+s32 ixgbe_read_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
+				    u16 reg, u16 *val)
+{
+	return ixgbe_read_i2c_combined_generic_int(hw, addr, reg, val, true);
+}
+
+/** ixgbe_read_i2c_combined_generic_unlocked - Unlocked I2C read combined
+ *  @hw: pointer to the hardware structure
+ *  @addr: I2C bus address to read from
+ *  @reg: I2C device register to read from
+ *  @val: pointer to location to receive read value
+ *
+ *  Returns an error code on error.
+ */
+s32 ixgbe_read_i2c_combined_generic_unlocked(struct ixgbe_hw *hw, u8 addr,
+					     u16 reg, u16 *val)
+{
+	return ixgbe_read_i2c_combined_generic_int(hw, addr, reg, val, false);
+}
+
+/** ixgbe_write_i2c_combined_generic_int - Perform I2C write combined operation
  *  @hw: pointer to the hardware structure
  *  @addr: I2C bus address to write to
  *  @reg: I2C device register to write to
  *  @val: value to write
+ *  @lock: true if to take and release semaphore
  *
  *  Returns an error code on error.
- **/
-s32 ixgbe_write_i2c_combined_generic(struct ixgbe_hw *hw,
-				     u8 addr, u16 reg, u16 val)
+ */
+static s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
+						u16 reg, u16 val, bool lock)
 {
+	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 	int max_retry = 1;
 	int retry = 0;
 	u8 reg_high;
@@ -197,6 +228,8 @@ s32 ixgbe_write_i2c_combined_generic(struct ixgbe_hw *hw,
 	csum = ixgbe_ones_comp_byte_add(csum, val & 0xFF);
 	csum = ~csum;
 	do {
+		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
+			return IXGBE_ERR_SWFW_SYNC;
 		ixgbe_i2c_start(hw);
 		/* Device Address and write indication */
 		if (ixgbe_out_i2c_byte_ack(hw, addr))
@@ -217,10 +250,14 @@ s32 ixgbe_write_i2c_combined_generic(struct ixgbe_hw *hw,
 		if (ixgbe_out_i2c_byte_ack(hw, csum))
 			goto fail;
 		ixgbe_i2c_stop(hw);
+		if (lock)
+			hw->mac.ops.release_swfw_sync(hw, swfw_mask);
 		return 0;
 
 fail:
 		ixgbe_i2c_bus_clear(hw);
+		if (lock)
+			hw->mac.ops.release_swfw_sync(hw, swfw_mask);
 		retry++;
 		if (retry < max_retry)
 			hw_dbg(hw, "I2C byte write combined error - Retry.\n");
@@ -231,6 +268,34 @@ fail:
 	return IXGBE_ERR_I2C;
 }
 
+/** ixgbe_write_i2c_combined_generic - Perform I2C write combined operation
+ *  @hw: pointer to the hardware structure
+ *  @addr: I2C bus address to write to
+ *  @reg: I2C device register to write to
+ *  @val: value to write
+ *
+ *  Returns an error code on error.
+ */
+s32 ixgbe_write_i2c_combined_generic(struct ixgbe_hw *hw,
+				     u8 addr, u16 reg, u16 val)
+{
+	return ixgbe_write_i2c_combined_generic_int(hw, addr, reg, val, true);
+}
+
+/** ixgbe_write_i2c_combined_generic_unlocked - Unlocked I2C write combined
+ *  @hw: pointer to the hardware structure
+ *  @addr: I2C bus address to write to
+ *  @reg: I2C device register to write to
+ *  @val: value to write
+ *
+ *  Returns an error code on error.
+ */
+s32 ixgbe_write_i2c_combined_generic_unlocked(struct ixgbe_hw *hw,
+					      u8 addr, u16 reg, u16 val)
+{
+	return ixgbe_write_i2c_combined_generic_int(hw, addr, reg, val, false);
+}
+
 /**
  *  ixgbe_identify_phy_generic - Get physical layer module
  *  @hw: pointer to hardware structure
@@ -1659,27 +1724,28 @@ s32 ixgbe_write_i2c_eeprom_generic(struct ixgbe_hw *hw, u8 byte_offset,
 					  eeprom_data);
 }
 
-/**
- *  ixgbe_read_i2c_byte_generic - Reads 8 bit word over I2C
+/** ixgbe_read_i2c_byte_generic_int - Reads 8 bit word over I2C
  *  @hw: pointer to hardware structure
  *  @byte_offset: byte offset to read
  *  @data: value read
+ *  @lock: true if to take and release semaphore
  *
  *  Performs byte read operation to SFP module's EEPROM over I2C interface at
  *  a specified device address.
- **/
-s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
-				u8 dev_addr, u8 *data)
+ */
+static s32 ixgbe_read_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
+					   u8 dev_addr, u8 *data, bool lock)
 {
 	s32 status;
 	u32 max_retry = 10;
 	u32 retry = 0;
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 	bool nack = true;
+
 	*data = 0;
 
 	do {
-		if (hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
+		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
 			return IXGBE_ERR_SWFW_SYNC;
 
 		ixgbe_i2c_start(hw);
@@ -1721,12 +1787,16 @@ s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 			goto fail;
 
 		ixgbe_i2c_stop(hw);
-		break;
+		if (lock)
+			hw->mac.ops.release_swfw_sync(hw, swfw_mask);
+		return 0;
 
 fail:
 		ixgbe_i2c_bus_clear(hw);
-		hw->mac.ops.release_swfw_sync(hw, swfw_mask);
-		msleep(100);
+		if (lock) {
+			hw->mac.ops.release_swfw_sync(hw, swfw_mask);
+			msleep(100);
+		}
 		retry++;
 		if (retry < max_retry)
 			hw_dbg(hw, "I2C byte read error - Retrying.\n");
@@ -1735,29 +1805,57 @@ fail:
 
 	} while (retry < max_retry);
 
-	hw->mac.ops.release_swfw_sync(hw, swfw_mask);
-
 	return status;
 }
 
-/**
- *  ixgbe_write_i2c_byte_generic - Writes 8 bit word over I2C
+/** ixgbe_read_i2c_byte_generic - Reads 8 bit word over I2C
+ *  @hw: pointer to hardware structure
+ *  @byte_offset: byte offset to read
+ *  @data: value read
+ *
+ *  Performs byte read operation to SFP module's EEPROM over I2C interface at
+ *  a specified device address.
+ */
+s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
+				u8 dev_addr, u8 *data)
+{
+	return ixgbe_read_i2c_byte_generic_int(hw, byte_offset, dev_addr,
+					       data, true);
+}
+
+/** ixgbe_read_i2c_byte_generic_unlocked - Reads 8 bit word over I2C
+ *  @hw: pointer to hardware structure
+ *  @byte_offset: byte offset to read
+ *  @data: value read
+ *
+ *  Performs byte read operation to SFP module's EEPROM over I2C interface at
+ *  a specified device address.
+ */
+s32 ixgbe_read_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
+					 u8 dev_addr, u8 *data)
+{
+	return ixgbe_read_i2c_byte_generic_int(hw, byte_offset, dev_addr,
+					       data, false);
+}
+
+/** ixgbe_write_i2c_byte_generic_int - Writes 8 bit word over I2C
  *  @hw: pointer to hardware structure
  *  @byte_offset: byte offset to write
  *  @data: value to write
+ *  @lock: true if to take and release semaphore
  *
  *  Performs byte write operation to SFP module's EEPROM over I2C interface at
  *  a specified device address.
- **/
-s32 ixgbe_write_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
-				 u8 dev_addr, u8 data)
+ */
+static s32 ixgbe_write_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
+					    u8 dev_addr, u8 data, bool lock)
 {
 	s32 status;
 	u32 max_retry = 1;
 	u32 retry = 0;
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 
-	if (hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
+	if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
 		return IXGBE_ERR_SWFW_SYNC;
 
 	do {
@@ -1788,7 +1886,9 @@ s32 ixgbe_write_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 			goto fail;
 
 		ixgbe_i2c_stop(hw);
-		break;
+		if (lock)
+			hw->mac.ops.release_swfw_sync(hw, swfw_mask);
+		return 0;
 
 fail:
 		ixgbe_i2c_bus_clear(hw);
@@ -1799,11 +1899,42 @@ fail:
 			hw_dbg(hw, "I2C byte write error.\n");
 	} while (retry < max_retry);
 
-	hw->mac.ops.release_swfw_sync(hw, swfw_mask);
+	if (lock)
+		hw->mac.ops.release_swfw_sync(hw, swfw_mask);
 
 	return status;
 }
 
+/** ixgbe_write_i2c_byte_generic - Writes 8 bit word over I2C
+ *  @hw: pointer to hardware structure
+ *  @byte_offset: byte offset to write
+ *  @data: value to write
+ *
+ *  Performs byte write operation to SFP module's EEPROM over I2C interface at
+ *  a specified device address.
+ */
+s32 ixgbe_write_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
+				 u8 dev_addr, u8 data)
+{
+	return ixgbe_write_i2c_byte_generic_int(hw, byte_offset, dev_addr,
+						data, true);
+}
+
+/** ixgbe_write_i2c_byte_generic_unlocked - Writes 8 bit word over I2C
+ *  @hw: pointer to hardware structure
+ *  @byte_offset: byte offset to write
+ *  @data: value to write
+ *
+ *  Performs byte write operation to SFP module's EEPROM over I2C interface at
+ *  a specified device address.
+ */
+s32 ixgbe_write_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
+					  u8 dev_addr, u8 data)
+{
+	return ixgbe_write_i2c_byte_generic_int(hw, byte_offset, dev_addr,
+						data, false);
+}
+
 /**
  *  ixgbe_i2c_start - Sets I2C start condition
  *  @hw: pointer to hardware structure
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index e45988c4dad5..4c06484fdebc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -154,8 +154,12 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
 s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				u8 dev_addr, u8 *data);
+s32 ixgbe_read_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
+					 u8 dev_addr, u8 *data);
 s32 ixgbe_write_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				 u8 dev_addr, u8 data);
+s32 ixgbe_write_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
+					  u8 dev_addr, u8 data);
 s32 ixgbe_read_i2c_eeprom_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				  u8 *eeprom_data);
 s32 ixgbe_read_i2c_sff8472_generic(struct ixgbe_hw *hw, u8 byte_offset,
@@ -164,6 +168,10 @@ s32 ixgbe_write_i2c_eeprom_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				   u8 eeprom_data);
 s32 ixgbe_read_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
 				    u16 reg, u16 *val);
+s32 ixgbe_read_i2c_combined_generic_unlocked(struct ixgbe_hw *hw, u8 addr,
+					     u16 reg, u16 *val);
 s32 ixgbe_write_i2c_combined_generic(struct ixgbe_hw *hw, u8 addr,
 				     u16 reg, u16 val);
+s32 ixgbe_write_i2c_combined_generic_unlocked(struct ixgbe_hw *hw, u8 addr,
+					      u16 reg, u16 val);
 #endif /* _IXGBE_PHY_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 4e16d146739c..3be743b4f6ba 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3329,6 +3329,10 @@ struct ixgbe_phy_operations {
 	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
 	s32 (*enter_lplu)(struct ixgbe_hw *);
 	s32 (*handle_lasi)(struct ixgbe_hw *hw);
+	s32 (*read_i2c_combined_unlocked)(struct ixgbe_hw *, u8 addr, u16 reg,
+					  u16 *value);
+	s32 (*write_i2c_combined_unlocked)(struct ixgbe_hw *, u8 addr, u16 reg,
+					   u16 value);
 };
 
 struct ixgbe_eeprom_info {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index acf78c5d8cc4..128cf6ce3a46 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2047,6 +2047,9 @@ static struct ixgbe_phy_operations phy_ops_X550EM_x = {
 	.identify		= &ixgbe_identify_phy_x550em,
 	.read_i2c_combined	= &ixgbe_read_i2c_combined_generic,
 	.write_i2c_combined	= &ixgbe_write_i2c_combined_generic,
+	.read_i2c_combined_unlocked = &ixgbe_read_i2c_combined_generic_unlocked,
+	.write_i2c_combined_unlocked =
+				     &ixgbe_write_i2c_combined_generic_unlocked,
 };
 
 static const u32 ixgbe_mvals_X550[IXGBE_MVALS_IDX_LIMIT] = {

