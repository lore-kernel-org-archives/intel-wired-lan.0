From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Sun, 31 May 2015 21:25:20 +0300
Subject: [Intel-wired-lan] [PATCH 3/5] e1000e: fix systim issues
In-Reply-To: <ad0b0062af01fe16002d93a4a77faede268071eb.1433096643.git.yanirx.lubetkin@intel.com>
References: <ad0b0062af01fe16002d93a4a77faede268071eb.1433096643.git.yanirx.lubetkin@intel.com>
Message-ID: <87806ac28e0a22d15f0401f3887d1b8c285cfb27.1433096643.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Two issues involving systim were reported.
1. clock is not running in the correct fequency
2. in some situations, systim values were not incremented linearly
This patch fixes the hardware clock configuration and the spurious non-linear increment.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  4 ++++
 drivers/net/ethernet/intel/e1000e/netdev.c | 36 +++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index e78487a..7d8a45c 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -386,6 +386,10 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
 #define INCVALUE_SHIFT_25MHz	18
 #define INCPERIOD_25MHz		1
 
+#define INCVALUE_24MHz		125
+#define INCVALUE_SHIFT_24MHz	14
+#define INCPERIOD_24MHz		3
+
 /* Another drawback of scaling the incvalue by a large factor is the
  * 64-bit SYSTIM register overflows more quickly.  This is dealt with
  * by simply reading the clock before it overflows.
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index dec2cb8..674135c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3525,21 +3525,30 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
 	case e1000_pch_lpt:
-	case e1000_pch_spt:
-		/* On I217, I218 and I219, the clock frequency is 25MHz
-		 * or 96MHz as indicated by the System Clock Frequency
-		 * Indication
-		 */
-		if (((hw->mac.type != e1000_pch_lpt) &&
-		     (hw->mac.type != e1000_pch_spt)) ||
-		    (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)) {
+		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 96MHz frequency */
 			incperiod = INCPERIOD_96MHz;
 			incvalue = INCVALUE_96MHz;
 			shift = INCVALUE_SHIFT_96MHz;
 			adapter->cc.shift = shift + INCPERIOD_SHIFT_96MHz;
+		} else {
+			/* Stable 25MHz frequency */
+			incperiod = INCPERIOD_25MHz;
+			incvalue = INCVALUE_25MHz;
+			shift = INCVALUE_SHIFT_25MHz;
+			adapter->cc.shift = shift;
+		}
+		break;
+	case e1000_pch_spt:
+		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
+			/* Stable 24MHz frequency */
+			incperiod = INCPERIOD_24MHz;
+			incvalue = INCVALUE_24MHz;
+			shift = INCVALUE_SHIFT_24MHz;
+			adapter->cc.shift = shift;
 			break;
 		}
+		return -EINVAL;
 		/* fall-through */
 	case e1000_82574:
 	case e1000_82583:
@@ -4273,9 +4282,16 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 						     cc);
 	struct e1000_hw *hw = &adapter->hw;
 	cycle_t systim, systim_next;
+	/* SYSTIMH latching upon SYSTIML read does not work well. to fix that
+	 * we don't want to allow overflow of SYSTIML and a change to SYSTIMH
+	 * to occur between reads, so if we read a vale close to overflow, we
+	 * wait for overflow to occur and read both registers when its safe.
+	 */
+	u32 systim_overflow_latch_fix = 0x3FFFFFFF;
 
-	/* latch SYSTIMH on read of SYSTIML */
-	systim = (cycle_t)er32(SYSTIML);
+	do {
+		systim = (cycle_t)er32(SYSTIML);
+	} while (systim > systim_overflow_latch_fix);
 	systim |= (cycle_t)er32(SYSTIMH) << 32;
 
 	if ((hw->mac.type == e1000_82574) || (hw->mac.type == e1000_82583)) {
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

