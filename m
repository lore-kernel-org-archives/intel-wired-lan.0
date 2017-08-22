From: Alice Michael <alice.michael@intel.com>
Date: Tue, 22 Aug 2017 06:57:45 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V8 03/12] i40e: use admin queue
	for setting LEDs behavior
In-Reply-To: <20170822105754.29486-1-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
Message-ID: <20170822105754.29486-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

Instead of accessing register directly, use newly added AQC in
order to blink LEDs. Introduce and utilize a new flag to prevent
excessive API version checking.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |   6 ++
 drivers/net/ethernet/intel/i40e/i40e_common.c | 115 ++++++++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h |   2 +
 4 files changed, 100 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index ba04988..08f6322 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -607,6 +607,12 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
 			   &oem_lo);
 	hw->nvm.oem_ver = ((u32)oem_hi << 16) | oem_lo;
 
+	if (hw->mac.type == I40E_MAC_XL710 &&
+	    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
+	    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
+		hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
+	}
+
 	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
 		ret_code = I40E_ERR_FIRMWARE_API_VERSION;
 		goto init_adminq_free_arq;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index e74c5c6..0e41b35 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4842,6 +4842,74 @@ i40e_status i40e_blink_phy_link_led(struct i40e_hw *hw,
 }
 
 /**
+ * i40e_led_get_reg - read LED register
+ * @hw: pointer to the HW structure
+ * @led_addr: LED register address
+ * @reg_val: read register value
+ **/
+static enum i40e_status_code i40e_led_get_reg(struct i40e_hw *hw, u16 led_addr,
+					      u32 *reg_val)
+{
+	enum i40e_status_code status;
+	u8 phy_addr = 0;
+	u8 port_num;
+	u32 i;
+
+	*reg_val = 0;
+	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
+		status =
+		       i40e_aq_get_phy_register(hw,
+						I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
+						I40E_PHY_COM_REG_PAGE,
+						I40E_PHY_LED_PROV_REG_1,
+						reg_val, NULL);
+	} else {
+		i = rd32(hw, I40E_PFGEN_PORTNUM);
+		port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
+		phy_addr = i40e_get_phy_address(hw, port_num);
+		status = i40e_read_phy_register_clause45(hw,
+							 I40E_PHY_COM_REG_PAGE,
+							 led_addr, phy_addr,
+							 (u16 *)reg_val);
+	}
+	return status;
+}
+
+/**
+ * i40e_led_set_reg - write LED register
+ * @hw: pointer to the HW structure
+ * @led_addr: LED register address
+ * @reg_val: register value to write
+ **/
+static enum i40e_status_code i40e_led_set_reg(struct i40e_hw *hw, u16 led_addr,
+					      u32 reg_val)
+{
+	enum i40e_status_code status;
+	u8 phy_addr = 0;
+	u8 port_num;
+	u32 i;
+
+	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
+		status =
+		       i40e_aq_set_phy_register(hw,
+						I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
+						I40E_PHY_COM_REG_PAGE,
+						I40E_PHY_LED_PROV_REG_1,
+						reg_val, NULL);
+	} else {
+		i = rd32(hw, I40E_PFGEN_PORTNUM);
+		port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
+		phy_addr = i40e_get_phy_address(hw, port_num);
+		status = i40e_write_phy_register_clause45(hw,
+							  I40E_PHY_COM_REG_PAGE,
+							  led_addr, phy_addr,
+							  (u16)reg_val);
+	}
+
+	return status;
+}
+
+/**
  * i40e_led_get_phy - return current on/off mode
  * @hw: pointer to the hw struct
  * @led_addr: address of led register to use
@@ -4858,7 +4926,19 @@ i40e_status i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
 	u16 temp_addr;
 	u8 port_num;
 	u32 i;
-
+	u32 reg_val_aq;
+
+	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
+		status =
+		      i40e_aq_get_phy_register(hw,
+					       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
+					       I40E_PHY_COM_REG_PAGE,
+					       I40E_PHY_LED_PROV_REG_1,
+					       &reg_val_aq, NULL);
+		if (status == I40E_SUCCESS)
+			*val = (u16)reg_val_aq;
+		return status;
+	}
 	temp_addr = I40E_PHY_LED_PROV_REG_1;
 	i = rd32(hw, I40E_PFGEN_PORTNUM);
 	port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
@@ -4893,51 +4973,38 @@ i40e_status i40e_led_set_phy(struct i40e_hw *hw, bool on,
 			     u16 led_addr, u32 mode)
 {
 	i40e_status status = 0;
-	u16 led_ctl = 0;
-	u16 led_reg = 0;
-	u8 phy_addr = 0;
-	u8 port_num;
-	u32 i;
+	u32 led_ctl = 0;
+	u32 led_reg = 0;
 
-	i = rd32(hw, I40E_PFGEN_PORTNUM);
-	port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
-	phy_addr = i40e_get_phy_address(hw, port_num);
-	status = i40e_read_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
-						 led_addr, phy_addr, &led_reg);
+	status = i40e_led_get_reg(hw, led_addr, &led_reg);
 	if (status)
 		return status;
 	led_ctl = led_reg;
 	if (led_reg & I40E_PHY_LED_LINK_MODE_MASK) {
 		led_reg = 0;
-		status = i40e_write_phy_register_clause45(hw,
-							  I40E_PHY_COM_REG_PAGE,
-							  led_addr, phy_addr,
-							  led_reg);
+		status = i40e_led_set_reg(hw, led_addr, led_reg);
 		if (status)
 			return status;
 	}
-	status = i40e_read_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
-						 led_addr, phy_addr, &led_reg);
+	status = i40e_led_get_reg(hw, led_addr, &led_reg);
 	if (status)
 		goto restore_config;
 	if (on)
 		led_reg = I40E_PHY_LED_MANUAL_ON;
 	else
 		led_reg = 0;
-	status = i40e_write_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
-						  led_addr, phy_addr, led_reg);
+
+	status = i40e_led_set_reg(hw, led_addr, led_reg);
 	if (status)
 		goto restore_config;
 	if (mode & I40E_PHY_LED_MODE_ORIG) {
 		led_ctl = (mode & I40E_PHY_LED_MODE_MASK);
-		status = i40e_write_phy_register_clause45(hw,
-						 I40E_PHY_COM_REG_PAGE,
-						 led_addr, phy_addr, led_ctl);
+		status = i40e_led_set_reg(hw, led_addr, led_ctl);
 	}
 	return status;
+
 restore_config:
-	status = i40e_write_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
-						  led_addr, phy_addr, led_ctl);
+	status = i40e_led_set_reg(hw, led_addr, led_ctl);
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 4bb5914..8b0b9f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -610,6 +610,7 @@ struct i40e_hw {
 	struct i40e_dcbx_config desired_dcbx_config; /* CEE Desired Cfg */
 
 #define I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE BIT_ULL(0)
+#define I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE  BIT_ULL(2)
 	u64 flags;
 
 	/* debug mask */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index b53584e..48eacf5 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -568,6 +568,8 @@ struct i40e_hw {
 	/* LLDP/DCBX Status */
 	u16 dcbx_status;
 
+#define I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE  BIT_ULL(2)
+
 	/* DCBX info */
 	struct i40e_dcbx_config local_dcbx_config; /* Oper/Local Cfg */
 	struct i40e_dcbx_config remote_dcbx_config; /* Peer Cfg */
-- 
2.9.4

