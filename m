From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Nov 2016 10:48:48 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add bounds check for x540 LED
	functions
Message-ID: <1478717328-2168-1-git-send-email-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is an extension of commit 003287e0f087 ("ixgbevf: Correct parameter
sent to LED function"); add bounds checking to x540 functions to ensure the
index is valid.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index e2ff823..afc4d16 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -780,8 +780,10 @@ s32 ixgbe_blink_led_start_X540(struct ixgbe_hw *hw, u32 index)
 	ixgbe_link_speed speed;
 	bool link_up;
 
-	/*
-	 * Link should be up in order for the blink bit in the LED control
+	if (index > 3)
+		return IXGBE_ERR_PARAM;
+
+	/* Link should be up in order for the blink bit in the LED control
 	 * register to work. Force link and speed in the MAC if link is down.
 	 * This will be reversed when we stop the blinking.
 	 */
@@ -814,6 +816,9 @@ s32 ixgbe_blink_led_stop_X540(struct ixgbe_hw *hw, u32 index)
 	u32 macc_reg;
 	u32 ledctl_reg;
 
+	if (index > 3)
+		return IXGBE_ERR_PARAM;
+
 	/* Restore the LED to its default value. */
 	ledctl_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
 	ledctl_reg &= ~IXGBE_LED_MODE_MASK(index);
-- 
2.4.0

