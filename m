From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 22 Aug 2016 16:28:34 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: make ixgbe_led_on/off_t_x550em
	static
Message-ID: <20160822232834.9806.70247.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These functions are only used in ixgbe_x550.c.

Fixes a warning when compiling with -Wmissing-prototypes

Reported-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index fb1b819..417913e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2125,7 +2125,7 @@ static s32 ixgbe_reset_phy_t_X550em(struct ixgbe_hw *hw)
  *  @hw: pointer to hardware structure
  *  @led_idx: led number to turn on
  **/
-s32 ixgbe_led_on_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
+static s32 ixgbe_led_on_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 {
 	u16 phy_data;
 
@@ -2147,7 +2147,7 @@ s32 ixgbe_led_on_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
  *  @hw: pointer to hardware structure
  *  @led_idx: led number to turn off
  **/
-s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
+static s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 {
 	u16 phy_data;
 

