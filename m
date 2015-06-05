From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 6 Jun 2015 01:23:12 +0800
Subject: [Intel-wired-lan] [PATCH jkirsher-next-queue] ixgbe:
 ixgbe_setup_mac_link_t_X550em() can be static
In-Reply-To: <201506060155.snCKv8gq%fengguang.wu@intel.com>
References: <201506060155.snCKv8gq%fengguang.wu@intel.com>
Message-ID: <20150605172312.GA146396@lkp-ib03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ixgbe_x550.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index e77e272..ea217cb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -888,7 +888,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
  *
  * Returns error status for any failure
  **/
-s32 ixgbe_setup_mac_link_t_X550em(struct ixgbe_hw *hw,
+static s32 ixgbe_setup_mac_link_t_X550em(struct ixgbe_hw *hw,
 				  ixgbe_link_speed speed,
 				  bool autoneg_wait)
 {
@@ -1187,7 +1187,7 @@ static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
  * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
  * failure alarm, else return PHY access status.
  **/
-s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
+static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	bool lsc;
@@ -1335,7 +1335,7 @@ static s32 ixgbe_ext_phy_t_x550em_get_link(struct ixgbe_hw *hw, bool *link_up)
  * A return of a non-zero value indicates an error, and the base driver should
  * not report link up.
  **/
-s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
+static s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 {
 	ixgbe_link_speed force_speed;
 	bool link_up;
