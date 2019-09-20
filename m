From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Sep 2019 02:17:23 -0700
Subject: [Intel-wired-lan] [next PATCH S10 09/10] i40e: Fix LED blinking
 flow for X710T*L devices.
In-Reply-To: <20190920091724.51767-1-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
Message-ID: <20190920091724.51767-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Damian Milosek <damian.milosek@intel.com>

Add X710T*L device specific operations (in port LED detection and
handling
of GLGEN_GPIO_CTL.PIN_FUNC field) to enable LED blinking.

Signed-off-by: Damian Milosek <damian.milosek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 29 +++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_devids.h |  2 ++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ed8608b874f4..8b25a6d9c81d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1437,9 +1437,9 @@ static u32 i40e_led_is_mine(struct i40e_hw *hw, int idx)
 	u32 gpio_val = 0;
 	u32 port;
 
-	if (!hw->func_caps.led[idx])
+	if (!I40E_IS_X710TL_DEVICE(hw->device_id) &&
+	    !hw->func_caps.led[idx])
 		return 0;
-
 	gpio_val = rd32(hw, I40E_GLGEN_GPIO_CTL(idx));
 	port = (gpio_val & I40E_GLGEN_GPIO_CTL_PRT_NUM_MASK) >>
 		I40E_GLGEN_GPIO_CTL_PRT_NUM_SHIFT;
@@ -1458,8 +1458,15 @@ static u32 i40e_led_is_mine(struct i40e_hw *hw, int idx)
 #define I40E_FILTER_ACTIVITY 0xE
 #define I40E_LINK_ACTIVITY 0xC
 #define I40E_MAC_ACTIVITY 0xD
+#define I40E_FW_LED BIT(4)
+#define I40E_LED_MODE_VALID (I40E_GLGEN_GPIO_CTL_LED_MODE_MASK >> \
+			     I40E_GLGEN_GPIO_CTL_LED_MODE_SHIFT)
+
 #define I40E_LED0 22
 
+#define I40E_PIN_FUNC_SDP 0x0
+#define I40E_PIN_FUNC_LED 0x1
+
 /**
  * i40e_led_get - return current on/off mode
  * @hw: pointer to the hw struct
@@ -1504,8 +1511,10 @@ void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink)
 {
 	int i;
 
-	if (mode & 0xfffffff0)
+	if (mode & ~I40E_LED_MODE_VALID) {
 		hw_dbg(hw, "invalid mode passed in %X\n", mode);
+		return;
+	}
 
 	/* as per the documentation GPIO 22-29 are the LED
 	 * GPIO pins named LED0..LED7
@@ -1515,6 +1524,20 @@ void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink)
 
 		if (!gpio_val)
 			continue;
+
+		if (I40E_IS_X710TL_DEVICE(hw->device_id)) {
+			u32 pin_func = 0;
+
+			if (mode & I40E_FW_LED)
+				pin_func = I40E_PIN_FUNC_SDP;
+			else
+				pin_func = I40E_PIN_FUNC_LED;
+
+			gpio_val &= ~I40E_GLGEN_GPIO_CTL_PIN_FUNC_MASK;
+			gpio_val |= ((pin_func <<
+				     I40E_GLGEN_GPIO_CTL_PIN_FUNC_SHIFT) &
+				     I40E_GLGEN_GPIO_CTL_PIN_FUNC_MASK);
+		}
 		gpio_val &= ~I40E_GLGEN_GPIO_CTL_LED_MODE_MASK;
 		/* this & is a bit of paranoia, but serves as a range check */
 		gpio_val |= ((mode << I40E_GLGEN_GPIO_CTL_LED_MODE_SHIFT) &
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index bac4da031f9b..bf15a868292f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -23,6 +23,8 @@
 #define I40E_DEV_ID_10G_BASE_T_BC	0x15FF
 #define I40E_DEV_ID_10G_B		0x104F
 #define I40E_DEV_ID_10G_SFP		0x104E
+#define I40E_IS_X710TL_DEVICE(d) \
+	((d) == I40E_DEV_ID_10G_BASE_T_BC)
 #define I40E_DEV_ID_KX_X722		0x37CE
 #define I40E_DEV_ID_QSFP_X722		0x37CF
 #define I40E_DEV_ID_SFP_X722		0x37D0
-- 
2.21.0

