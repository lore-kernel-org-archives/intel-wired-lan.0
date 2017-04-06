From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  6 Apr 2017 10:27:03 +0300
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: Add Support for 38.4MHZ
	frequency
Message-ID: <20170406072703.10810-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Description: add support for 38.4MHz frequency is required for PTP
on CannonLake. SYSTIM frequency adjustment attributes for TIMINCA are
get/set dependent on the hardware clock frequency for a different
types of adapters. 38.4MHz frequency supported by CannonLake
and active once time synchronisation mechanism was enabled
Changed abbreviation from Hz to HZ to be compliant checkpatch code style

Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  | 28 ++++++++++--------
 drivers/net/ethernet/intel/e1000e/netdev.c | 47 +++++++++++++++++++++---------
 2 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index f16d9826c66d..c7c994eb410e 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -379,18 +379,22 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
  * INCVALUE_n into the TIMINCA register allowing 32+8+(24-INCVALUE_SHIFT_n)
  * bits to count nanoseconds leaving the rest for fractional nonseconds.
  */
-#define INCVALUE_96MHz		125
-#define INCVALUE_SHIFT_96MHz	17
-#define INCPERIOD_SHIFT_96MHz	2
-#define INCPERIOD_96MHz		(12 >> INCPERIOD_SHIFT_96MHz)
-
-#define INCVALUE_25MHz		40
-#define INCVALUE_SHIFT_25MHz	18
-#define INCPERIOD_25MHz		1
-
-#define INCVALUE_24MHz		125
-#define INCVALUE_SHIFT_24MHz	14
-#define INCPERIOD_24MHz		3
+#define INCVALUE_96MHZ		125
+#define INCVALUE_SHIFT_96MHZ	17
+#define INCPERIOD_SHIFT_96MHZ	2
+#define INCPERIOD_96MHZ		(12 >> INCPERIOD_SHIFT_96MHZ)
+
+#define INCVALUE_25MHZ		40
+#define INCVALUE_SHIFT_25MHZ	18
+#define INCPERIOD_25MHZ		1
+
+#define INCVALUE_24MHZ		125
+#define INCVALUE_SHIFT_24MHZ	14
+#define INCPERIOD_24MHZ		3
+
+#define INCVALUE_38400KHZ	26
+#define INCVALUE_SHIFT_38400KHZ	19
+#define INCPERIOD_38400KHZ	1
 
 /* Another drawback of scaling the incvalue by a large factor is the
  * 64-bit SYSTIM register overflows more quickly.  This is dealt with
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index dc83ac92cb67..22e99b0ca24d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3508,37 +3508,58 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
+		/* Stable 96MHz frequency */
+		incperiod = INCPERIOD_96MHZ;
+		incvalue = INCVALUE_96MHZ;
+		shift = INCVALUE_SHIFT_96MHZ;
+		adapter->cc.shift = shift + INCPERIOD_SHIFT_96MHZ;
+		break;
 	case e1000_pch_lpt:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 96MHz frequency */
-			incperiod = INCPERIOD_96MHz;
-			incvalue = INCVALUE_96MHz;
-			shift = INCVALUE_SHIFT_96MHz;
-			adapter->cc.shift = shift + INCPERIOD_SHIFT_96MHz;
+			incperiod = INCPERIOD_96MHZ;
+			incvalue = INCVALUE_96MHZ;
+			shift = INCVALUE_SHIFT_96MHZ;
+			adapter->cc.shift = shift + INCPERIOD_SHIFT_96MHZ;
 		} else {
 			/* Stable 25MHz frequency */
-			incperiod = INCPERIOD_25MHz;
-			incvalue = INCVALUE_25MHz;
-			shift = INCVALUE_SHIFT_25MHz;
+			incperiod = INCPERIOD_25MHZ;
+			incvalue = INCVALUE_25MHZ;
+			shift = INCVALUE_SHIFT_25MHZ;
 			adapter->cc.shift = shift;
 		}
 		break;
 	case e1000_pch_spt:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 24MHz frequency */
-			incperiod = INCPERIOD_24MHz;
-			incvalue = INCVALUE_24MHz;
-			shift = INCVALUE_SHIFT_24MHz;
+			incperiod = INCPERIOD_24MHZ;
+			incvalue = INCVALUE_24MHZ;
+			shift = INCVALUE_SHIFT_24MHZ;
 			adapter->cc.shift = shift;
 			break;
 		}
 		return -EINVAL;
+	case e1000_pch_cnp:
+		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
+			/* Stable 24MHz frequency */
+			incperiod = INCPERIOD_24MHZ;
+			incvalue = INCVALUE_24MHZ;
+			shift = INCVALUE_SHIFT_24MHZ;
+			adapter->cc.shift = shift;
+		} else {
+			/* Stable 38400KHz frequency */
+			incperiod = INCPERIOD_38400KHZ;
+			incvalue = INCVALUE_38400KHZ;
+			shift = INCVALUE_SHIFT_38400KHZ;
+			adapter->cc.shift = shift;
+		}
+		break;
 	case e1000_82574:
 	case e1000_82583:
 		/* Stable 25MHz frequency */
-		incperiod = INCPERIOD_25MHz;
-		incvalue = INCVALUE_25MHz;
-		shift = INCVALUE_SHIFT_25MHz;
+		incperiod = INCPERIOD_25MHZ;
+		incvalue = INCVALUE_25MHZ;
+		shift = INCVALUE_SHIFT_25MHZ;
 		adapter->cc.shift = shift;
 		break;
 	default:
-- 
2.11.0

