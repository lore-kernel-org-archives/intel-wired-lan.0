From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 18 May 2017 16:45:06 -0700
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: fix incorrect status check
Message-ID: <20170518234506.32551.44123.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Check for ret_val instead of !ret_val to allow the rest of
the code to execute and configure the speed properly.

v2 - fixed few more cases in ixgbe_setup_mac_link_sfp_n()

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index cb5d363..c729ef0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1750,14 +1750,14 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
 		return 0;
 
-	if (!ret_val)
+	if (ret_val)
 		return ret_val;
 
 	/* Configure internal PHY for native SFI based on module type */
 	ret_val = hw->mac.ops.read_iosf_sb_reg(hw,
 				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
 				IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_phy_int);
-	if (!ret_val)
+	if (ret_val)
 		return ret_val;
 
 	reg_phy_int &= IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA;
@@ -1767,7 +1767,7 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 	ret_val = hw->mac.ops.write_iosf_sb_reg(hw,
 				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
 				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_phy_int);
-	if (!ret_val)
+	if (ret_val)
 		return ret_val;
 
 	/* Setup SFI internal link. */
@@ -1798,7 +1798,7 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
 		return 0;
 
-	if (!ret_val)
+	if (ret_val)
 		return ret_val;
 
 	/* Configure internal PHY for KR/KX. */

