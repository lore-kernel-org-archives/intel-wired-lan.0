From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Sat, 06 Jun 2015 15:31:44 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Remember to write ixfi
 changes after modifying
Message-ID: <20150606193144.7701.41164.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch corrects a bug in ixgbe_setup_ixfi_x550em where we were
reading and modifying IXGBE_KRM_LINK_CTRL_1 but forgot to write the
results back.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index dc9cdb6..57c40fd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -795,7 +795,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 	}
 
 	status = ixgbe_write_iosf_sb_reg_x550(hw,
-				IXGBE_KRM_RX_TRN_LINKUP_CTRL(hw->bus.lan_id),
+				IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
 				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
 	if (status)
 		return status;

