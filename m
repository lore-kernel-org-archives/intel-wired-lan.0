From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Date: Fri, 15 Dec 2017 13:08:23 +0530
Subject: [Intel-wired-lan] [PATCH 08/27] e1000e: Use timecounter_initialize
 interface
In-Reply-To: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <1513323522-15021-9-git-send-email-sagar.a.kamble@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With new interface timecounter_initialize we can initialize timecounter
fields and underlying cyclecounter together. Update e1000e timecounter
init with this new function.

Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  4 ++++
 drivers/net/ethernet/intel/e1000e/netdev.c | 31 +++++++++++++++++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index b59f82a..d6b0e59 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -341,6 +341,10 @@ struct e1000_adapter {
 	struct work_struct tx_hwtstamp_work;
 	spinlock_t systim_lock;	/* protects SYSTIML/H regsters */
 	struct timecounter tc;
+	u64 (*cc_read)(const struct cyclecounter *cc);
+	u64 cc_mask;
+	u32 cc_mult;
+	u32 cc_shift;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
 	struct pm_qos_request pm_qos_req;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index c9f7ba3..6be1327 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3536,7 +3536,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 		incperiod = INCPERIOD_96MHZ;
 		incvalue = INCVALUE_96MHZ;
 		shift = INCVALUE_SHIFT_96MHZ;
-		adapter->tc.cc.shift = shift + INCPERIOD_SHIFT_96MHZ;
+		adapter->cc_shift = shift + INCPERIOD_SHIFT_96MHZ;
 		break;
 	case e1000_pch_lpt:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
@@ -3544,13 +3544,13 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 			incperiod = INCPERIOD_96MHZ;
 			incvalue = INCVALUE_96MHZ;
 			shift = INCVALUE_SHIFT_96MHZ;
-			adapter->tc.cc.shift = shift + INCPERIOD_SHIFT_96MHZ;
+			adapter->cc_shift = shift + INCPERIOD_SHIFT_96MHZ;
 		} else {
 			/* Stable 25MHz frequency */
 			incperiod = INCPERIOD_25MHZ;
 			incvalue = INCVALUE_25MHZ;
 			shift = INCVALUE_SHIFT_25MHZ;
-			adapter->tc.cc.shift = shift;
+			adapter->cc_shift = shift;
 		}
 		break;
 	case e1000_pch_spt:
@@ -3559,7 +3559,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 			incperiod = INCPERIOD_24MHZ;
 			incvalue = INCVALUE_24MHZ;
 			shift = INCVALUE_SHIFT_24MHZ;
-			adapter->tc.cc.shift = shift;
+			adapter->cc_shift = shift;
 			break;
 		}
 		return -EINVAL;
@@ -3569,13 +3569,13 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 			incperiod = INCPERIOD_24MHZ;
 			incvalue = INCVALUE_24MHZ;
 			shift = INCVALUE_SHIFT_24MHZ;
-			adapter->tc.cc.shift = shift;
+			adapter->cc_shift = shift;
 		} else {
 			/* Stable 38400KHz frequency */
 			incperiod = INCPERIOD_38400KHZ;
 			incvalue = INCVALUE_38400KHZ;
 			shift = INCVALUE_SHIFT_38400KHZ;
-			adapter->tc.cc.shift = shift;
+			adapter->cc_shift = shift;
 		}
 		break;
 	case e1000_82574:
@@ -3584,7 +3584,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 		incperiod = INCPERIOD_25MHZ;
 		incvalue = INCVALUE_25MHZ;
 		shift = INCVALUE_SHIFT_25MHZ;
-		adapter->tc.cc.shift = shift;
+		adapter->cc_shift = shift;
 		break;
 	default:
 		return -EINVAL;
@@ -3953,9 +3953,14 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 		return;
 	}
 
-	/* reset the systim ns time counter */
+	/* reinitialize the systim ns time counter */
 	spin_lock_irqsave(&adapter->systim_lock, flags);
-	timecounter_init(&adapter->tc, ktime_to_ns(ktime_get_real()));
+	timecounter_initialize(&adapter->tc,
+			       adapter->cc_read,
+			       adapter->cc_mask,
+			       adapter->cc_mult,
+			       adapter->cc_shift,
+			       ktime_to_ns(ktime_get_real()));
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	/* restore the previous hwtstamp configuration settings */
@@ -4448,10 +4453,10 @@ static int e1000_sw_init(struct e1000_adapter *adapter)
 
 	/* Setup hardware time stamping cyclecounter */
 	if (adapter->flags & FLAG_HAS_HW_TIMESTAMP) {
-		adapter->tc.cc.read = e1000e_cyclecounter_read;
-		adapter->tc.cc.mask = CYCLECOUNTER_MASK(64);
-		adapter->tc.cc.mult = 1;
-		/* tc.cc.shift set in e1000e_get_base_tininca() */
+		adapter->cc_read = e1000e_cyclecounter_read;
+		adapter->cc_mask = CYCLECOUNTER_MASK(64);
+		adapter->cc_mult = 1;
+		/* cc_shift set in e1000e_get_base_tininca() */
 
 		spin_lock_init(&adapter->systim_lock);
 		INIT_WORK(&adapter->tx_hwtstamp_work, e1000e_tx_hwtstamp_work);
-- 
1.9.1

