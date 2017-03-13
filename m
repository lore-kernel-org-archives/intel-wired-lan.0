From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Mon, 13 Mar 2017 05:47:56 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Acquire PHY semaphore before
	device reset
Message-ID: <1489398476-15893-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A recent firmware change fixed an issue to acquire the PHY semaphore before
accessing PHY registers. This led to a case where  SW can issue a device
reset clearing the MDIO registers. This patch makes SW acquire the PHY
semaphore before issuing a device reset.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 8 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index 84a467a..6ea0d6a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -95,6 +95,7 @@ s32 ixgbe_reset_hw_X540(struct ixgbe_hw *hw)
 {
 	s32 status;
 	u32 ctrl, i;
+	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 
 	/* Call adapter stop to disable tx/rx and clear interrupts */
 	status = hw->mac.ops.stop_adapter(hw);
@@ -105,10 +106,17 @@ s32 ixgbe_reset_hw_X540(struct ixgbe_hw *hw)
 	ixgbe_clear_tx_pending(hw);
 
 mac_reset_top:
+	status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
+	if (status) {
+		hw_dbg(hw, "semaphore failed with %d", status);
+		return IXGBE_ERR_SWFW_SYNC;
+	}
+
 	ctrl = IXGBE_CTRL_RST;
 	ctrl |= IXGBE_READ_REG(hw, IXGBE_CTRL);
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, ctrl);
 	IXGBE_WRITE_FLUSH(hw);
+	hw->mac.ops.release_swfw_sync(hw, swfw_mask);
 	usleep_range(1000, 1200);
 
 	/* Poll for reset bit to self-clear indicating reset is complete */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 200f847..c862c6d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3300,6 +3300,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	u32 ctrl = 0;
 	u32 i;
 	bool link_up = false;
+	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 
 	/* Call adapter stop to disable Tx/Rx and clear interrupts */
 	status = hw->mac.ops.stop_adapter(hw);
@@ -3345,9 +3346,16 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 			ctrl = IXGBE_CTRL_RST;
 	}
 
+	status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
+	if (status) {
+		hw_dbg(hw, "semaphore failed with %d", status);
+		return IXGBE_ERR_SWFW_SYNC;
+	}
+
 	ctrl |= IXGBE_READ_REG(hw, IXGBE_CTRL);
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, ctrl);
 	IXGBE_WRITE_FLUSH(hw);
+	hw->mac.ops.release_swfw_sync(hw, swfw_mask);
 	usleep_range(1000, 1200);
 
 	/* Poll for reset bit to self-clear meaning reset is complete */
-- 
2.7.4

