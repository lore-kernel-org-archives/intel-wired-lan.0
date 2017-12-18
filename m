From: Alice Michael <alice.michael@intel.com>
Date: Mon, 18 Dec 2017 05:17:03 -0500
Subject: [Intel-wired-lan] [next PATCH S83-V5 5/9] i40e: Fix for blinking
 activity instead of link LEDs
Message-ID: <20171218101703.75823-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Kuchta <michal.kuchta@intel.com>

This fix solves an issue occurring while calling i40e_led_set function
from the driver with "blink" parameter set as TRUE. This call resulted
in Activity LED blinking instead of Link LED, which may lead to errors
in physically identyfying the port, since Activity LED may be blinking
for different reasons aswell.

Signed-off-by: Michal Kuchta <michal.kuchta@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index cf929cc..ee6052e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1486,6 +1486,7 @@ u32 i40e_led_get(struct i40e_hw *hw)
 		case I40E_COMBINED_ACTIVITY:
 		case I40E_FILTER_ACTIVITY:
 		case I40E_MAC_ACTIVITY:
+		case I40E_LINK_ACTIVITY:
 			continue;
 		default:
 			break;
@@ -1534,6 +1535,7 @@ void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink)
 		case I40E_COMBINED_ACTIVITY:
 		case I40E_FILTER_ACTIVITY:
 		case I40E_MAC_ACTIVITY:
+		case I40E_LINK_ACTIVITY:
 			continue;
 		default:
 			break;
@@ -1544,9 +1546,6 @@ void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink)
 		gpio_val |= ((mode << I40E_GLGEN_GPIO_CTL_LED_MODE_SHIFT) &
 			     I40E_GLGEN_GPIO_CTL_LED_MODE_MASK);
 
-		if (mode == I40E_LINK_ACTIVITY)
-			blink = false;
-
 		if (blink)
 			gpio_val |= BIT(I40E_GLGEN_GPIO_CTL_LED_BLINK_SHIFT);
 		else
-- 
2.9.5

