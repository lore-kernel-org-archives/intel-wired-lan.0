From: Marczak, Piotr <piotr.marczak@intel.com>
Date: Wed, 6 Feb 2019 19:48:11 +0000
Subject: [Intel-wired-lan] [next PATCH S2 05/13] i40e: Fix for 10G ports
 LED not blinking
In-Reply-To: <20190206193622.69370-5-alice.michael@intel.com>
References: <20190206193622.69370-1-alice.michael@intel.com>
 <20190206193622.69370-5-alice.michael@intel.com>
Message-ID: <BD558F072FDA374BB8561E84707C7CEA47DD18@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Wednesday, February 6, 2019 8:36 PM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Marczak, Piotr <piotr.marczak@intel.com>
Subject: [next PATCH S2 05/13] i40e: Fix for 10G ports LED not blinking

From: Piotr Marczak <piotr.marczak@intel.com>

On some hardware LEDs would not blink after command 'ethtool -p {eth-port}'
in certain circumstances. Now, function does not care about the activity of the LED (though still preserves its state) but forcibly executes identification blinking and then restores the LED state.

Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 33 -------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 486a406789b8..dd6b3b3ac5c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1466,7 +1466,6 @@ static u32 i40e_led_is_mine(struct i40e_hw *hw, int idx)
  **/
 u32 i40e_led_get(struct i40e_hw *hw)
 {
-	u32 current_mode = 0;
 	u32 mode = 0;
 	int i;
 
@@ -1479,21 +1478,6 @@ u32 i40e_led_get(struct i40e_hw *hw)
 		if (!gpio_val)
 			continue;
 
-		/* ignore gpio LED src mode entries related to the activity
-		 * LEDs
-		 */
-		current_mode = ((gpio_val & I40E_GLGEN_GPIO_CTL_LED_MODE_MASK)
-				>> I40E_GLGEN_GPIO_CTL_LED_MODE_SHIFT);
-		switch (current_mode) {
-		case I40E_COMBINED_ACTIVITY:
-		case I40E_FILTER_ACTIVITY:
-		case I40E_MAC_ACTIVITY:
-		case I40E_LINK_ACTIVITY:
-			continue;
-		default:
-			break;
-		}
-
 		mode = (gpio_val & I40E_GLGEN_GPIO_CTL_LED_MODE_MASK) >>
 			I40E_GLGEN_GPIO_CTL_LED_MODE_SHIFT;
 		break;
@@ -1513,7 +1497,6 @@ u32 i40e_led_get(struct i40e_hw *hw)
  **/
 void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink)  {
-	u32 current_mode = 0;
 	int i;
 
 	if (mode & 0xfffffff0)
@@ -1527,22 +1510,6 @@ void i40e_led_set(struct i40e_hw *hw, u32 mode, bool blink)
 
 		if (!gpio_val)
 			continue;
-
-		/* ignore gpio LED src mode entries related to the activity
-		 * LEDs
-		 */
-		current_mode = ((gpio_val & I40E_GLGEN_GPIO_CTL_LED_MODE_MASK)
-				>> I40E_GLGEN_GPIO_CTL_LED_MODE_SHIFT);
-		switch (current_mode) {
-		case I40E_COMBINED_ACTIVITY:
-		case I40E_FILTER_ACTIVITY:
-		case I40E_MAC_ACTIVITY:
-		case I40E_LINK_ACTIVITY:
-			continue;
-		default:
-			break;
-		}
-
 		gpio_val &= ~I40E_GLGEN_GPIO_CTL_LED_MODE_MASK;
 		/* this & is a bit of paranoia, but serves as a range check */
 		gpio_val |= ((mode << I40E_GLGEN_GPIO_CTL_LED_MODE_SHIFT) &
--
2.19.2

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.
