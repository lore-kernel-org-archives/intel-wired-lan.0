From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Mon, 08 Jun 2015 18:44:03 -0400
Subject: [Intel-wired-lan] [net-next PATCH 3] ixgbe: fix bug in not clearing
 counters for X550 devices
Message-ID: <20150608224402.10742.59971.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Skidmore Don <donald.c.skidmore@intel.com>

This check was missed in when this new MAC type was added.  Since
these counts can be incremented for X550 we need to clear them.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 21e5ae3..4c1c267 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -470,7 +470,7 @@ s32 ixgbe_clear_hw_cntrs_generic(struct ixgbe_hw *hw)
 		}
 	}
 
-	if (hw->mac.type == ixgbe_mac_X540) {
+	if (hw->mac.type == ixgbe_mac_X550 || hw->mac.type == ixgbe_mac_X540) {
 		if (hw->phy.id == 0)
 			hw->phy.ops.identify(hw);
 		hw->phy.ops.read_reg(hw, IXGBE_PCRC8ECL, MDIO_MMD_PCS, &i);

