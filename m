From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Sep 2015 13:26:33 +0200
Subject: [Intel-wired-lan] [PATCH 03/12] net: igb: avoid using timespec
In-Reply-To: <1443612402-3000775-1-git-send-email-arnd@arndb.de>
References: <1443612402-3000775-1-git-send-email-arnd@arndb.de>
Message-ID: <1443612402-3000775-4-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We want to deprecate the use of 'struct timespec' on 32-bit
architectures, as it is will overflow in 2038. The igb
driver uses it to read the current time, and can simply
be changed to use ktime_get_real_ts64() instead.

Because of hardware limitations, there is still an overflow
in year 2106, which we cannot really avoid, but this documents
the overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
---
 drivers/net/ethernet/intel/igb/igb.h      |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c | 15 ++++++++-------
 drivers/net/ethernet/intel/igb/igb_ptp.c  |  8 ++++----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 212d668dabb3..1a2f1cc44b28 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -444,8 +444,8 @@ struct igb_adapter {
 
 	struct ptp_pin_desc sdp_config[IGB_N_SDP];
 	struct {
-		struct timespec start;
-		struct timespec period;
+		struct timespec64 start;
+		struct timespec64 period;
 	} perout[IGB_N_PEROUT];
 
 	char fw_version[32];
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index e174fbbdba40..911bbadbb994 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5389,7 +5389,7 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	struct ptp_clock_event event;
-	struct timespec ts;
+	struct timespec64 ts;
 	u32 ack = 0, tsauxc, sec, nsec, tsicr = rd32(E1000_TSICR);
 
 	if (tsicr & TSINTR_SYS_WRAP) {
@@ -5409,10 +5409,11 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 
 	if (tsicr & TSINTR_TT0) {
 		spin_lock(&adapter->tmreg_lock);
-		ts = timespec_add(adapter->perout[0].start,
-				  adapter->perout[0].period);
+		ts = timespec64_add(adapter->perout[0].start,
+				    adapter->perout[0].period);
+		/* u32 conversion of tv_sec is safe until y2106 */
 		wr32(E1000_TRGTTIML0, ts.tv_nsec);
-		wr32(E1000_TRGTTIMH0, ts.tv_sec);
+		wr32(E1000_TRGTTIMH0, (u32)ts.tv_sec);
 		tsauxc = rd32(E1000_TSAUXC);
 		tsauxc |= TSAUXC_EN_TT0;
 		wr32(E1000_TSAUXC, tsauxc);
@@ -5423,10 +5424,10 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 
 	if (tsicr & TSINTR_TT1) {
 		spin_lock(&adapter->tmreg_lock);
-		ts = timespec_add(adapter->perout[1].start,
-				  adapter->perout[1].period);
+		ts = timespec64_add(adapter->perout[1].start,
+				    adapter->perout[1].period);
 		wr32(E1000_TRGTTIML1, ts.tv_nsec);
-		wr32(E1000_TRGTTIMH1, ts.tv_sec);
+		wr32(E1000_TRGTTIMH1, (u32)ts.tv_sec);
 		tsauxc = rd32(E1000_TSAUXC);
 		tsauxc |= TSAUXC_EN_TT1;
 		wr32(E1000_TSAUXC, tsauxc);
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 5982f28d521a..c44df87c38de 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -143,7 +143,7 @@ static void igb_ptp_write_i210(struct igb_adapter *adapter,
 	 * sub-nanosecond resolution.
 	 */
 	wr32(E1000_SYSTIML, ts->tv_nsec);
-	wr32(E1000_SYSTIMH, ts->tv_sec);
+	wr32(E1000_SYSTIMH, (u32)ts->tv_sec);
 }
 
 /**
@@ -479,7 +479,7 @@ static int igb_ptp_feature_enable_i210(struct ptp_clock_info *ptp,
 	struct e1000_hw *hw = &igb->hw;
 	u32 tsauxc, tsim, tsauxc_mask, tsim_mask, trgttiml, trgttimh, freqout;
 	unsigned long flags;
-	struct timespec ts;
+	struct timespec64 ts;
 	int use_freq = 0, pin = -1;
 	s64 ns;
 
@@ -523,14 +523,14 @@ static int igb_ptp_feature_enable_i210(struct ptp_clock_info *ptp,
 		}
 		ts.tv_sec = rq->perout.period.sec;
 		ts.tv_nsec = rq->perout.period.nsec;
-		ns = timespec_to_ns(&ts);
+		ns = timespec64_to_ns(&ts);
 		ns = ns >> 1;
 		if (on && ns <= 70000000LL) {
 			if (ns < 8LL)
 				return -EINVAL;
 			use_freq = 1;
 		}
-		ts = ns_to_timespec(ns);
+		ts = ns_to_timespec64(ns);
 		if (rq->perout.index == 1) {
 			if (use_freq) {
 				tsauxc_mask = TSAUXC_EN_CLK1 | TSAUXC_ST1;
-- 
2.1.0.rc2

