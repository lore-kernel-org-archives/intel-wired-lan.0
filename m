From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:18:00 -0700
Subject: [Intel-wired-lan] [next PATCH S51 6/9] i40e: Add Clause22
	implementation
In-Reply-To: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
References: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477433883-3248-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Kosiarz <michal.kosiarz@intel.com>

Some external PHYs require Clause22 method for accessing registers.
This patch also adds some defines to support blink led on devices using
10CBaseT PHY.

Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
Change-ID: I868a4326911900f6c89e7e522fda4968b0825f14
---
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 180 +++++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_prototype.h |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h      |  19 ++-
 3 files changed, 159 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 64ac814..5ba34be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4430,7 +4430,99 @@ i40e_status i40e_aq_configure_partition_bw(struct i40e_hw *hw,
 }
 
 /**
- * i40e_read_phy_register
+ * i40e_read_phy_register_clause22
+ * @hw: pointer to the HW structure
+ * @reg: register address in the page
+ * @phy_adr: PHY address on MDIO interface
+ * @value: PHY register value
+ *
+ * Reads specified PHY register value
+ **/
+i40e_status i40e_read_phy_register_clause22(struct i40e_hw *hw,
+					u16 reg, u8 phy_addr, u16 *value)
+{
+	i40e_status status = I40E_ERR_TIMEOUT;
+	u8 port_num = hw->func_caps.mdio_port_num;
+	u32 command = 0;
+	u16 retry = 1000;
+
+	command = (reg << I40E_GLGEN_MSCA_DEVADD_SHIFT) |
+		  (phy_addr << I40E_GLGEN_MSCA_PHYADD_SHIFT) |
+		  (I40E_MDIO_CLAUSE22_OPCODE_READ_MASK) |
+		  (I40E_MDIO_CLAUSE22_STCODE_MASK) |
+		  (I40E_GLGEN_MSCA_MDICMD_MASK);
+	wr32(hw, I40E_GLGEN_MSCA(port_num), command);
+	do {
+		command = rd32(hw, I40E_GLGEN_MSCA(port_num));
+		if (!(command & I40E_GLGEN_MSCA_MDICMD_MASK)) {
+			status = 0;
+			break;
+		}
+		udelay(10);
+		retry--;
+	} while (retry);
+
+	if (status) {
+		i40e_debug(hw, I40E_DEBUG_PHY,
+			   "PHY: Can't write command to external PHY.\n");
+		goto phy_read_end;
+	}
+
+	if (!status) {
+		command = rd32(hw, I40E_GLGEN_MSRWD(port_num));
+		*value = (command & I40E_GLGEN_MSRWD_MDIRDDATA_MASK) >>
+			 I40E_GLGEN_MSRWD_MDIRDDATA_SHIFT;
+	} else {
+		i40e_debug(hw, I40E_DEBUG_PHY,
+			   "PHY: Can't read register value from external PHY.\n");
+	}
+
+phy_read_end:
+	return status;
+}
+
+/**
+ * i40e_write_phy_register_clause22
+ * @hw: pointer to the HW structure
+ * @reg: register address in the page
+ * @phy_adr: PHY address on MDIO interface
+ * @value: PHY register value
+ *
+ * Writes specified PHY register value
+ **/
+i40e_status i40e_write_phy_register_clause22(struct i40e_hw *hw,
+					u16 reg, u8 phy_addr, u16 value)
+{
+	i40e_status status = I40E_ERR_TIMEOUT;
+	u32 command  = 0;
+	u16 retry = 1000;
+	u8 port_num = hw->func_caps.mdio_port_num;
+
+	command = value << I40E_GLGEN_MSRWD_MDIWRDATA_SHIFT;
+	wr32(hw, I40E_GLGEN_MSRWD(port_num), command);
+
+	command = (reg << I40E_GLGEN_MSCA_DEVADD_SHIFT) |
+		  (phy_addr << I40E_GLGEN_MSCA_PHYADD_SHIFT) |
+		  (I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK) |
+		  (I40E_MDIO_CLAUSE22_STCODE_MASK) |
+		  (I40E_GLGEN_MSCA_MDICMD_MASK);
+
+	wr32(hw, I40E_GLGEN_MSCA(port_num), command);
+	do {
+		command = rd32(hw, I40E_GLGEN_MSCA(port_num));
+		if (!(command & I40E_GLGEN_MSCA_MDICMD_MASK)) {
+			status = 0;
+			break;
+		}
+		udelay(10);
+		retry--;
+	} while (retry);
+
+	return status;
+}
+
+/**
+ * i40e_read_phy_register_clause45
  * @hw: pointer to the HW structure
  * @page: registers page number
  * @reg: register address in the page
@@ -4439,9 +4531,8 @@ i40e_status i40e_aq_configure_partition_bw(struct i40e_hw *hw,
  *
  * Reads specified PHY register value
  **/
-i40e_status i40e_read_phy_register(struct i40e_hw *hw,
-				   u8 page, u16 reg, u8 phy_addr,
-				   u16 *value)
+i40e_status i40e_read_phy_register_clause45(struct i40e_hw *hw,
+				u8 page, u16 reg, u8 phy_addr, u16 *value)
 {
 	i40e_status status = I40E_ERR_TIMEOUT;
 	u32 command = 0;
@@ -4451,8 +4542,8 @@ i40e_status i40e_read_phy_register(struct i40e_hw *hw,
 	command = (reg << I40E_GLGEN_MSCA_MDIADD_SHIFT) |
 		  (page << I40E_GLGEN_MSCA_DEVADD_SHIFT) |
 		  (phy_addr << I40E_GLGEN_MSCA_PHYADD_SHIFT) |
-		  (I40E_MDIO_OPCODE_ADDRESS) |
-		  (I40E_MDIO_STCODE) |
+		  (I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK) |
+		  (I40E_MDIO_CLAUSE45_STCODE_MASK) |
 		  (I40E_GLGEN_MSCA_MDICMD_MASK) |
 		  (I40E_GLGEN_MSCA_MDIINPROGEN_MASK);
 	wr32(hw, I40E_GLGEN_MSCA(port_num), command);
@@ -4474,8 +4565,8 @@ i40e_status i40e_read_phy_register(struct i40e_hw *hw,
 
 	command = (page << I40E_GLGEN_MSCA_DEVADD_SHIFT) |
 		  (phy_addr << I40E_GLGEN_MSCA_PHYADD_SHIFT) |
-		  (I40E_MDIO_OPCODE_READ) |
-		  (I40E_MDIO_STCODE) |
+		  (I40E_MDIO_CLAUSE45_OPCODE_READ_MASK) |
+		  (I40E_MDIO_CLAUSE45_STCODE_MASK) |
 		  (I40E_GLGEN_MSCA_MDICMD_MASK) |
 		  (I40E_GLGEN_MSCA_MDIINPROGEN_MASK);
 	status = I40E_ERR_TIMEOUT;
@@ -4505,7 +4596,7 @@ i40e_status i40e_read_phy_register(struct i40e_hw *hw,
 }
 
 /**
- * i40e_write_phy_register
+ * i40e_write_phy_register_clause45
  * @hw: pointer to the HW structure
  * @page: registers page number
  * @reg: register address in the page
@@ -4514,9 +4605,8 @@ i40e_status i40e_read_phy_register(struct i40e_hw *hw,
  *
  * Writes value to specified PHY register
  **/
-i40e_status i40e_write_phy_register(struct i40e_hw *hw,
-				    u8 page, u16 reg, u8 phy_addr,
-				    u16 value)
+i40e_status i40e_write_phy_register_clause45(struct i40e_hw *hw,
+				u8 page, u16 reg, u8 phy_addr, u16 value)
 {
 	i40e_status status = I40E_ERR_TIMEOUT;
 	u32 command = 0;
@@ -4526,8 +4616,8 @@ i40e_status i40e_write_phy_register(struct i40e_hw *hw,
 	command = (reg << I40E_GLGEN_MSCA_MDIADD_SHIFT) |
 		  (page << I40E_GLGEN_MSCA_DEVADD_SHIFT) |
 		  (phy_addr << I40E_GLGEN_MSCA_PHYADD_SHIFT) |
-		  (I40E_MDIO_OPCODE_ADDRESS) |
-		  (I40E_MDIO_STCODE) |
+		  (I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK) |
+		  (I40E_MDIO_CLAUSE45_STCODE_MASK) |
 		  (I40E_GLGEN_MSCA_MDICMD_MASK) |
 		  (I40E_GLGEN_MSCA_MDIINPROGEN_MASK);
 	wr32(hw, I40E_GLGEN_MSCA(port_num), command);
@@ -4551,8 +4641,8 @@ i40e_status i40e_write_phy_register(struct i40e_hw *hw,
 
 	command = (page << I40E_GLGEN_MSCA_DEVADD_SHIFT) |
 		  (phy_addr << I40E_GLGEN_MSCA_PHYADD_SHIFT) |
-		  (I40E_MDIO_OPCODE_WRITE) |
-		  (I40E_MDIO_STCODE) |
+		  (I40E_MDIO_CLAUSE45_OPCODE_WRITE_MASK) |
+		  (I40E_MDIO_CLAUSE45_STCODE_MASK) |
 		  (I40E_GLGEN_MSCA_MDICMD_MASK) |
 		  (I40E_GLGEN_MSCA_MDIINPROGEN_MASK);
 	status = I40E_ERR_TIMEOUT;
@@ -4614,14 +4704,16 @@ i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
 
 	for (gpio_led_port = 0; gpio_led_port < 3; gpio_led_port++,
 	     led_addr++) {
-		status = i40e_read_phy_register(hw, I40E_PHY_COM_REG_PAGE,
-						led_addr, phy_addr, &led_reg);
+		status = i40e_read_phy_register_clause45(hw,
+							 I40E_PHY_COM_REG_PAGE,
+							 led_addr, phy_addr,
+							 &led_reg);
 		if (status)
 			goto phy_blinking_end;
 		led_ctl = led_reg;
 		if (led_reg & I40E_PHY_LED_LINK_MODE_MASK) {
 			led_reg = 0;
-			status = i40e_write_phy_register(hw,
+			status = i40e_write_phy_register_clause45(hw,
 							 I40E_PHY_COM_REG_PAGE,
 							 led_addr, phy_addr,
 							 led_reg);
@@ -4633,20 +4725,18 @@ i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
 
 	if (time > 0 && interval > 0) {
 		for (i = 0; i < time * 1000; i += interval) {
-			status = i40e_read_phy_register(hw,
-							I40E_PHY_COM_REG_PAGE,
-							led_addr, phy_addr,
-							&led_reg);
+			status = i40e_read_phy_register_clause45(hw,
+						I40E_PHY_COM_REG_PAGE,
+						led_addr, phy_addr, &led_reg);
 			if (status)
 				goto restore_config;
 			if (led_reg & I40E_PHY_LED_MANUAL_ON)
 				led_reg = 0;
 			else
 				led_reg = I40E_PHY_LED_MANUAL_ON;
-			status = i40e_write_phy_register(hw,
-							 I40E_PHY_COM_REG_PAGE,
-							 led_addr, phy_addr,
-							 led_reg);
+			status = i40e_write_phy_register_clause45(hw,
+						I40E_PHY_COM_REG_PAGE,
+						led_addr, phy_addr, led_reg);
 			if (status)
 				goto restore_config;
 			msleep(interval);
@@ -4654,8 +4744,9 @@ i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
 	}
 
 restore_config:
-	status = i40e_write_phy_register(hw, I40E_PHY_COM_REG_PAGE, led_addr,
-					 phy_addr, led_ctl);
+	status = i40e_write_phy_register_clause45(hw,
+						  I40E_PHY_COM_REG_PAGE,
+						  led_addr, phy_addr, led_ctl);
 
 phy_blinking_end:
 	return status;
@@ -4686,8 +4777,10 @@ i40e_status i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
 
 	for (gpio_led_port = 0; gpio_led_port < 3; gpio_led_port++,
 	     temp_addr++) {
-		status = i40e_read_phy_register(hw, I40E_PHY_COM_REG_PAGE,
-						temp_addr, phy_addr, &reg_val);
+		status = i40e_read_phy_register_clause45(hw,
+							 I40E_PHY_COM_REG_PAGE,
+							 temp_addr, phy_addr,
+							 &reg_val);
 		if (status)
 			return status;
 		*val = reg_val;
@@ -4720,41 +4813,42 @@ i40e_status i40e_led_set_phy(struct i40e_hw *hw, bool on,
 	i = rd32(hw, I40E_PFGEN_PORTNUM);
 	port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
 	phy_addr = i40e_get_phy_address(hw, port_num);
-
-	status = i40e_read_phy_register(hw, I40E_PHY_COM_REG_PAGE, led_addr,
-					phy_addr, &led_reg);
+	status = i40e_read_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
+						 led_addr, phy_addr, &led_reg);
 	if (status)
 		return status;
 	led_ctl = led_reg;
 	if (led_reg & I40E_PHY_LED_LINK_MODE_MASK) {
 		led_reg = 0;
-		status = i40e_write_phy_register(hw, I40E_PHY_COM_REG_PAGE,
-						 led_addr, phy_addr, led_reg);
+		status = i40e_write_phy_register_clause45(hw,
+							  I40E_PHY_COM_REG_PAGE,
+							  led_addr, phy_addr,
+							  led_reg);
 		if (status)
 			return status;
 	}
-	status = i40e_read_phy_register(hw, I40E_PHY_COM_REG_PAGE,
-					led_addr, phy_addr, &led_reg);
+	status = i40e_read_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
+						 led_addr, phy_addr, &led_reg);
 	if (status)
 		goto restore_config;
 	if (on)
 		led_reg = I40E_PHY_LED_MANUAL_ON;
 	else
 		led_reg = 0;
-	status = i40e_write_phy_register(hw, I40E_PHY_COM_REG_PAGE,
-					 led_addr, phy_addr, led_reg);
+	status = i40e_write_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
+						  led_addr, phy_addr, led_reg);
 	if (status)
 		goto restore_config;
 	if (mode & I40E_PHY_LED_MODE_ORIG) {
 		led_ctl = (mode & I40E_PHY_LED_MODE_MASK);
-		status = i40e_write_phy_register(hw,
+		status = i40e_write_phy_register_clause45(hw,
 						 I40E_PHY_COM_REG_PAGE,
 						 led_addr, phy_addr, led_ctl);
 	}
 	return status;
 restore_config:
-	status = i40e_write_phy_register(hw, I40E_PHY_COM_REG_PAGE, led_addr,
-					 phy_addr, led_ctl);
+	status = i40e_write_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
+						  led_addr, phy_addr, led_ctl);
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 1278410..4e641a6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -365,10 +365,14 @@ i40e_status i40e_aq_rx_ctl_write_register(struct i40e_hw *hw,
 				u32 reg_addr, u32 reg_val,
 				struct i40e_asq_cmd_details *cmd_details);
 void i40e_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val);
-i40e_status i40e_read_phy_register(struct i40e_hw *hw, u8 page,
-				   u16 reg, u8 phy_addr, u16 *value);
-i40e_status i40e_write_phy_register(struct i40e_hw *hw, u8 page,
-				    u16 reg, u8 phy_addr, u16 value);
+i40e_status i40e_read_phy_register_clause22(struct i40e_hw *hw,
+					u16 reg, u8 phy_addr, u16 *value);
+i40e_status i40e_write_phy_register_clause22(struct i40e_hw *hw,
+					u16 reg, u8 phy_addr, u16 value);
+i40e_status i40e_read_phy_register_clause45(struct i40e_hw *hw,
+				u8 page, u16 reg, u8 phy_addr, u16 *value);
+i40e_status i40e_write_phy_register_clause45(struct i40e_hw *hw,
+				u8 page, u16 reg, u8 phy_addr, u16 value);
 u8 i40e_get_phy_address(struct i40e_hw *hw, u8 dev_num);
 i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
 				    u32 time, u32 interval);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 39b30be..bffe1e3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -90,14 +90,23 @@ enum i40e_debug_mask {
 	I40E_DEBUG_ALL			= 0xFFFFFFFF
 };
 
-#define I40E_MDIO_STCODE                0
-#define I40E_MDIO_OPCODE_ADDRESS        0
-#define I40E_MDIO_OPCODE_WRITE          I40E_MASK(1, \
+#define I40E_MDIO_CLAUSE22_STCODE_MASK	I40E_MASK(1, \
+						  I40E_GLGEN_MSCA_STCODE_SHIFT)
+#define I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK	I40E_MASK(1, \
 						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-#define I40E_MDIO_OPCODE_READ_INC_ADDR  I40E_MASK(2, \
+#define I40E_MDIO_CLAUSE22_OPCODE_READ_MASK	I40E_MASK(2, \
 						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-#define I40E_MDIO_OPCODE_READ           I40E_MASK(3, \
+
+#define I40E_MDIO_CLAUSE45_STCODE_MASK	I40E_MASK(0, \
+						  I40E_GLGEN_MSCA_STCODE_SHIFT)
+#define I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK	I40E_MASK(0, \
+						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
+#define I40E_MDIO_CLAUSE45_OPCODE_WRITE_MASK	I40E_MASK(1, \
 						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
+#define I40E_MDIO_CLAUSE45_OPCODE_READ_INC_ADDR_MASK	I40E_MASK(2, \
+						I40E_GLGEN_MSCA_OPCODE_SHIFT)
+#define I40E_MDIO_CLAUSE45_OPCODE_READ_MASK    I40E_MASK(3, \
+						I40E_GLGEN_MSCA_OPCODE_SHIFT)
 
 #define I40E_PHY_COM_REG_PAGE                   0x1E
 #define I40E_PHY_LED_LINK_MODE_MASK             0xF0
-- 
2.4.11

