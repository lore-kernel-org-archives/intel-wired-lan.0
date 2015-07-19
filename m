From: Raanan Avargil <raanan.avargil@intel.com>
Date: Sun, 19 Jul 2015 16:33:20 +0300
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Fix tight loop implementation
	of systime read algorithm
Message-ID: <eb0fc1b6ebdfe79027886fbf2f64f985a413614d.1437312332.git.raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change the algorithm. Read systimel twice and check for overflow.
If there was no overflow, use the first value.
If there was an overflow, read systimeh again and use the second systimel value.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f71cd24..f6db0c2 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4280,18 +4280,27 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 	struct e1000_adapter *adapter = container_of(cc, struct e1000_adapter,
 						     cc);
 	struct e1000_hw *hw = &adapter->hw;
+	u32 systimel_1, systimel_2, systimeh;
 	cycle_t systim, systim_next;
-	/* SYSTIMH latching upon SYSTIML read does not work well. To fix that
-	 * we don't want to allow overflow of SYSTIML and a change to SYSTIMH
-	 * to occur between reads, so if we read a vale close to overflow, we
-	 * wait for overflow to occur and read both registers when its safe.
+	/* SYSTIMH latching upon SYSTIML read does not work well.
+	 * This means that if SYSTIML overflows after we read it but before
+	 * we read SYSTIMH, the value of SYSTIMH has been incremented and we
+	 * will experience a huge non linear increment in the systime value
+	 * to fix that we test for overflow and if true, we re-read systime.
 	 */
-	u32 systim_overflow_latch_fix = 0x3FFFFFFF;
-
-	do {
-		systim = (cycle_t)er32(SYSTIML);
-	} while (systim > systim_overflow_latch_fix);
-	systim |= (cycle_t)er32(SYSTIMH) << 32;
+	systimel_1 = er32(SYSTIML);
+	systimeh = er32(SYSTIMH);
+	systimel_2 = er32(SYSTIML);
+	/* Check for overflow. If there was no overflow, use the values */
+	if (systimel_1 < systimel_2) {
+		systim = (cycle_t)systimel_1;
+		systim |= (cycle_t)systimeh << 32;
+	} else {
+		/* There was an overflow, read again SYSTIMH, and use systimel_2 */
+		systimeh = er32(SYSTIMH);
+		systim = (cycle_t)systimel_2;
+		systim |= (cycle_t)systimeh << 32;
+	}
 
 	if ((hw->mac.type == e1000_82574) || (hw->mac.type == e1000_82583)) {
 		u64 incvalue, time_delta, rem, temp;
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

