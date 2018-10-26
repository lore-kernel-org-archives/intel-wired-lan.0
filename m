From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Fri, 26 Oct 2018 18:27:41 +0200
Subject: [Intel-wired-lan] [RFC PATCH 3/4] igb: add support for extended PHC
 gettime
In-Reply-To: <20181026162742.631-1-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
Message-ID: <20181026162742.631-4-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 43 ++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 29ced6b74d36..6294d18b5a60 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -310,6 +310,46 @@ static int igb_ptp_gettime_i210(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+static int igb_ptp_gettimex(struct ptp_clock_info *ptp,
+			    struct ptp_system_timestamp *sts)
+{
+	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
+					       ptp_caps);
+	struct e1000_hw *hw = &igb->hw;
+	unsigned long flags;
+	u32 lo, hi;
+	u64 ns;
+
+	spin_lock_irqsave(&igb->tmreg_lock, flags);
+
+	/* 82576 doesn't have SYSTIMR */
+	if (igb->hw.mac.type == e1000_82576) {
+		ptp_read_system_prets(sts);
+		lo = rd32(E1000_SYSTIML);
+		ptp_read_system_postts(sts);
+		hi = rd32(E1000_SYSTIMH);
+	} else {
+		ptp_read_system_prets(sts);
+		rd32(E1000_SYSTIMR);
+		ptp_read_system_postts(sts);
+		lo = rd32(E1000_SYSTIML);
+		hi = rd32(E1000_SYSTIMH);
+	}
+
+	/* SYSTIM on I210/I211 counts time in seconds and nanoseconds */
+	if (igb->hw.mac.type == e1000_i210 || igb->hw.mac.type == e1000_i211) {
+		sts->phc_ts.tv_sec = hi;
+		sts->phc_ts.tv_nsec = lo;
+	} else {
+		ns = timecounter_cyc2time(&igb->tc, ((u64)hi << 32) | lo);
+		sts->phc_ts = ns_to_timespec64(ns);
+	}
+
+	spin_unlock_irqrestore(&igb->tmreg_lock, flags);
+
+	return 0;
+}
+
 static int igb_ptp_settime_82576(struct ptp_clock_info *ptp,
 				 const struct timespec64 *ts)
 {
@@ -1125,6 +1165,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_caps.adjfreq = igb_ptp_adjfreq_82576;
 		adapter->ptp_caps.adjtime = igb_ptp_adjtime_82576;
 		adapter->ptp_caps.gettime64 = igb_ptp_gettime_82576;
+		adapter->ptp_caps.gettimex64 = igb_ptp_gettimex;
 		adapter->ptp_caps.settime64 = igb_ptp_settime_82576;
 		adapter->ptp_caps.enable = igb_ptp_feature_enable;
 		adapter->cc.read = igb_ptp_read_82576;
@@ -1144,6 +1185,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_caps.adjfine = igb_ptp_adjfine_82580;
 		adapter->ptp_caps.adjtime = igb_ptp_adjtime_82576;
 		adapter->ptp_caps.gettime64 = igb_ptp_gettime_82576;
+		adapter->ptp_caps.gettimex64 = igb_ptp_gettimex;
 		adapter->ptp_caps.settime64 = igb_ptp_settime_82576;
 		adapter->ptp_caps.enable = igb_ptp_feature_enable;
 		adapter->cc.read = igb_ptp_read_82580;
@@ -1172,6 +1214,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_caps.adjfine = igb_ptp_adjfine_82580;
 		adapter->ptp_caps.adjtime = igb_ptp_adjtime_i210;
 		adapter->ptp_caps.gettime64 = igb_ptp_gettime_i210;
+		adapter->ptp_caps.gettimex64 = igb_ptp_gettimex;
 		adapter->ptp_caps.settime64 = igb_ptp_settime_i210;
 		adapter->ptp_caps.enable = igb_ptp_feature_enable_i210;
 		adapter->ptp_caps.verify = igb_ptp_verify_pin;
-- 
2.17.2

