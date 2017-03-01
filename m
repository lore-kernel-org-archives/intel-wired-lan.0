From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  1 Mar 2017 11:52:09 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: add check for VETO bit when
	configuring link for KR
Message-ID: <20170301195209.5993-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We did not have a check in place for MMNGC.MNG_VETO when setting up link
on X550EM_X KR devices which resulted in link loss for the BMC when
loading the driver.

This patch adds a check for ixgbe_check_reset_blocked() in setup_link()
since in that case there is no PHY reset function.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 04d6c74..2658394 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2526,6 +2526,9 @@ static s32 ixgbe_setup_kr_x550em(struct ixgbe_hw *hw)
 	if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_2_5GB_FULL)
 		return 0;
 
+	if (ixgbe_check_reset_blocked(hw))
+		return 0;
+
 	return ixgbe_setup_kr_speed_x550em(hw, hw->phy.autoneg_advertised);
 }
 
-- 
2.9.3

