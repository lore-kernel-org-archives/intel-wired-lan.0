From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Jun 2015 12:23:29 +0800
Subject: [Intel-wired-lan] [PATCH jkirsher-next-queue] ixgbe:
 ixgbe_get_lcd_t_x550em() can be static
In-Reply-To: <201506121203.9UfHmWd1%fengguang.wu@intel.com>
References: <201506121203.9UfHmWd1%fengguang.wu@intel.com>
Message-ID: <20150612042329.GA146134@lkp-ib04>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ixgbe_x550.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index ae164da..710c195 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1464,7 +1464,7 @@ static s32 ixgbe_reset_phy_t_X550em(struct ixgbe_hw *hw)
  *
  *  Determine lowest common link speed with link partner.
  **/
-s32 ixgbe_get_lcd_t_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *lcd_speed)
+static s32 ixgbe_get_lcd_t_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *lcd_speed)
 {
 	u16 an_lp_status;
 	s32 status;
@@ -1501,7 +1501,7 @@ s32 ixgbe_get_lcd_t_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *lcd_speed)
  *  (from D0 to non-D0). Link is required to enter LPLU so avoid resetting
  *  the X557 PHY immediately prior to entering LPLU.
  **/
-s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
+static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
 {
 	u16 an_10g_cntl_reg, autoneg_reg, speed;
 	s32 status;
