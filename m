From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Mon, 12 Mar 2018 09:22:55 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: add status reg reads to
 ixgbe_check_remove
Message-ID: <1520860975-110746-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add status register reads and delay between reads to ixgbe_check_remove.
Registers can read 0xFFFFFFFF during pci reset, which causes the driver
to remove the adapter. The additional status register reads can reduce the
chance of this race condition.

If the status register is not 0xFFFFFFFF, then ixgbe_check_remove returns
the value of the register being read.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 31 ++++++++++++++++---------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index 7359d0b..c0827ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -154,6 +154,7 @@ s32 ixgbe_setup_mac_link_multispeed_fiber(struct ixgbe_hw *hw,
 void ixgbe_set_soft_rate_select_speed(struct ixgbe_hw *hw,
 				      ixgbe_link_speed speed);
 
+#define IXGBE_FAILED_READ_RETRIES 5
 #define IXGBE_FAILED_READ_REG 0xffffffffU
 #define IXGBE_FAILED_READ_CFG_DWORD 0xffffffffU
 #define IXGBE_FAILED_READ_CFG_WORD 0xffffU
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8536942..faf368b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -353,23 +353,32 @@ static void ixgbe_remove_adapter(struct ixgbe_hw *hw)
 		ixgbe_service_event_schedule(adapter);
 }
 
-static void ixgbe_check_remove(struct ixgbe_hw *hw, u32 reg)
+static u32 ixgbe_check_remove(struct ixgbe_hw *hw, u32 reg)
 {
+	u8 __iomem *reg_addr;
 	u32 value;
+	int i;
 
-	/* The following check not only optimizes a bit by not
-	 * performing a read on the status register when the
-	 * register just read was a status register read that
-	 * returned IXGBE_FAILED_READ_REG. It also blocks any
-	 * potential recursion.
+	reg_addr = READ_ONCE(hw->hw_addr);
+	if (ixgbe_removed(reg_addr))
+		return IXGBE_FAILED_READ_REG;
+
+	/* Register read of 0xFFFFFFF can indicate the adapter has been removed,
+	 * so perform several status register reads to determine if the adapter
+	 * has been removed.
 	 */
-	if (reg == IXGBE_STATUS) {
-		ixgbe_remove_adapter(hw);
-		return;
+	for (i = 0; i < IXGBE_FAILED_READ_RETRIES; i++) {
+		value = readl(reg_addr + IXGBE_STATUS);
+		if (value != IXGBE_FAILED_READ_REG)
+			break;
+		mdelay(3);
 	}
-	value = ixgbe_read_reg(hw, IXGBE_STATUS);
+
 	if (value == IXGBE_FAILED_READ_REG)
 		ixgbe_remove_adapter(hw);
+	else
+		value = readl(reg_addr + reg);
+	return value;
 }
 
 /**
@@ -415,7 +424,7 @@ u32 ixgbe_read_reg(struct ixgbe_hw *hw, u32 reg)
 writes_completed:
 	value = readl(reg_addr + reg);
 	if (unlikely(value == IXGBE_FAILED_READ_REG))
-		ixgbe_check_remove(hw, reg);
+		value = ixgbe_check_remove(hw, reg);
 	return value;
 }
 
-- 
2.7.5

