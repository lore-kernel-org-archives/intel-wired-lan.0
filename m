From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Date: Fri, 15 Dec 2017 13:08:24 +0530
Subject: [Intel-wired-lan] [PATCH 09/27] igb: Use timecounter_initialize
 interface
In-Reply-To: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <1513323522-15021-10-git-send-email-sagar.a.kamble@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With new interface timecounter_initialize we can initialize timecounter
fields and underlying cyclecounter together. Update igb ptp timecounter
init with this new function.

Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/intel/igb/igb.h     |  4 ++++
 drivers/net/ethernet/intel/igb/igb_ptp.c | 23 ++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 4eac4f2..4ef5632 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -566,6 +566,10 @@ struct igb_adapter {
 	unsigned int ptp_flags;
 	spinlock_t tmreg_lock;
 	struct timecounter tc;
+	u64 (*cc_read)(const struct cyclecounter *cc);
+	u64 cc_mask;
+	u32 cc_mult;
+	u32 cc_shift;
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 0745eff..f6c1a8d 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1126,10 +1126,10 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_caps.gettime64 = igb_ptp_gettime_82576;
 		adapter->ptp_caps.settime64 = igb_ptp_settime_82576;
 		adapter->ptp_caps.enable = igb_ptp_feature_enable;
-		adapter->tc.cc.read = igb_ptp_read_82576;
-		adapter->tc.cc.mask = CYCLECOUNTER_MASK(64);
-		adapter->tc.cc.mult = 1;
-		adapter->tc.cc.shift = IGB_82576_TSYNC_SHIFT;
+		adapter->cc_read = igb_ptp_read_82576;
+		adapter->cc_mask = CYCLECOUNTER_MASK(64);
+		adapter->cc_mult = 1;
+		adapter->cc_shift = IGB_82576_TSYNC_SHIFT;
 		adapter->ptp_flags |= IGB_PTP_OVERFLOW_CHECK;
 		break;
 	case e1000_82580:
@@ -1145,10 +1145,10 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_caps.gettime64 = igb_ptp_gettime_82576;
 		adapter->ptp_caps.settime64 = igb_ptp_settime_82576;
 		adapter->ptp_caps.enable = igb_ptp_feature_enable;
-		adapter->tc.cc.read = igb_ptp_read_82580;
-		adapter->tc.cc.mask = CYCLECOUNTER_MASK(IGB_NBITS_82580);
-		adapter->tc.cc.mult = 1;
-		adapter->tc.cc.shift = 0;
+		adapter->cc_read = igb_ptp_read_82580;
+		adapter->cc_mask = CYCLECOUNTER_MASK(IGB_NBITS_82580);
+		adapter->cc_mult = 1;
+		adapter->cc_shift = 0;
 		adapter->ptp_flags |= IGB_PTP_OVERFLOW_CHECK;
 		break;
 	case e1000_i210:
@@ -1289,7 +1289,12 @@ void igb_ptp_reset(struct igb_adapter *adapter)
 
 		igb_ptp_write_i210(adapter, &ts);
 	} else {
-		timecounter_init(&adapter->tc, ktime_to_ns(ktime_get_real()));
+		timecounter_initialize(&adapter->tc,
+				       adapter->cc_read,
+				       adapter->cc_mask,
+				       adapter->cc_mult,
+				       adapter->cc_shift,
+				       ktime_to_ns(ktime_get_real()));
 	}
 out:
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
-- 
1.9.1

