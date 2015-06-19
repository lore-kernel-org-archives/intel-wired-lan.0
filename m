From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 19 Jun 2015 19:14:57 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: cleanup to use cached
	mask value
Message-ID: <20150619231457.32172.76998.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Don Skidmore <donald.c.skidmore@intel.com>

We already cache this FW/SW semaphore mask so might as well use it
for consistency.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 526a20b..51ec201 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -608,12 +608,7 @@ s32 ixgbe_write_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 				u32 device_type, u16 phy_data)
 {
 	s32 status;
-	u32 gssr;
-
-	if (IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_LAN_ID_1)
-		gssr = IXGBE_GSSR_PHY1_SM;
-	else
-		gssr = IXGBE_GSSR_PHY0_SM;
+	u32 gssr = hw->phy.phy_semaphore_mask;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, gssr) == 0) {
 		status = ixgbe_write_phy_reg_mdi(hw, reg_addr, device_type,

