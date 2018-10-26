From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Fri, 26 Oct 2018 18:27:42 +0200
Subject: [Intel-wired-lan] [RFC PATCH 4/4] ixgbe: add support for extended
 PHC gettime
In-Reply-To: <20181026162742.631-1-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
Message-ID: <20181026162742.631-5-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index b3e0d8bb5cbd..d31e8d3effc7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -466,6 +466,60 @@ static int ixgbe_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	return 0;
 }
 
+/**
+ * ixgbe_ptp_gettimex
+ * @ptp: the ptp clock structure
+ * @sts: structure to hold the system time before reading the PHC,
+ * the PHC timestamp, and system time after reading the PHC
+ *
+ * read the timecounter and return the correct value on ns,
+ * after converting it into a struct timespec.
+ */
+static int ixgbe_ptp_gettimex(struct ptp_clock_info *ptp,
+			      struct ptp_system_timestamp *sts)
+{
+	struct ixgbe_adapter *adapter =
+		container_of(ptp, struct ixgbe_adapter, ptp_caps);
+	struct ixgbe_hw *hw = &adapter->hw;
+	unsigned long flags;
+	struct timespec64 ts;
+	u64 ns, stamp;
+
+	spin_lock_irqsave(&adapter->tmreg_lock, flags);
+
+	switch (adapter->hw.mac.type) {
+	case ixgbe_mac_X550:
+	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
+		/* Upper 32 bits represent billions of cycles, lower 32 bits
+		 * represent cycles. However, we use timespec64_to_ns for the
+		 * correct math even though the units haven't been corrected
+		 * yet.
+		 */
+		ptp_read_system_prets(sts);
+		IXGBE_READ_REG(hw, IXGBE_SYSTIMR);
+		ptp_read_system_postts(sts);
+		ts.tv_nsec = IXGBE_READ_REG(hw, IXGBE_SYSTIML);
+		ts.tv_sec = IXGBE_READ_REG(hw, IXGBE_SYSTIMH);
+		stamp = timespec64_to_ns(&ts);
+		break;
+	default:
+		ptp_read_system_prets(sts);
+		stamp = IXGBE_READ_REG(hw, IXGBE_SYSTIML);
+		ptp_read_system_postts(sts);
+		stamp |= (u64)IXGBE_READ_REG(hw, IXGBE_SYSTIMH) << 32;
+		break;
+	}
+
+	ns = timecounter_cyc2time(&adapter->hw_tc, stamp);
+
+	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
+
+	sts->phc_ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
 /**
  * ixgbe_ptp_settime
  * @ptp: the ptp clock structure
@@ -1217,6 +1271,7 @@ static long ixgbe_ptp_create_clock(struct ixgbe_adapter *adapter)
 		adapter->ptp_caps.adjfreq = ixgbe_ptp_adjfreq_82599;
 		adapter->ptp_caps.adjtime = ixgbe_ptp_adjtime;
 		adapter->ptp_caps.gettime64 = ixgbe_ptp_gettime;
+		adapter->ptp_caps.gettimex64 = ixgbe_ptp_gettimex;
 		adapter->ptp_caps.settime64 = ixgbe_ptp_settime;
 		adapter->ptp_caps.enable = ixgbe_ptp_feature_enable;
 		adapter->ptp_setup_sdp = ixgbe_ptp_setup_sdp_x540;
@@ -1234,6 +1289,7 @@ static long ixgbe_ptp_create_clock(struct ixgbe_adapter *adapter)
 		adapter->ptp_caps.adjfreq = ixgbe_ptp_adjfreq_82599;
 		adapter->ptp_caps.adjtime = ixgbe_ptp_adjtime;
 		adapter->ptp_caps.gettime64 = ixgbe_ptp_gettime;
+		adapter->ptp_caps.gettimex64 = ixgbe_ptp_gettimex;
 		adapter->ptp_caps.settime64 = ixgbe_ptp_settime;
 		adapter->ptp_caps.enable = ixgbe_ptp_feature_enable;
 		break;
@@ -1250,6 +1306,7 @@ static long ixgbe_ptp_create_clock(struct ixgbe_adapter *adapter)
 		adapter->ptp_caps.adjfreq = ixgbe_ptp_adjfreq_X550;
 		adapter->ptp_caps.adjtime = ixgbe_ptp_adjtime;
 		adapter->ptp_caps.gettime64 = ixgbe_ptp_gettime;
+		adapter->ptp_caps.gettimex64 = ixgbe_ptp_gettimex;
 		adapter->ptp_caps.settime64 = ixgbe_ptp_settime;
 		adapter->ptp_caps.enable = ixgbe_ptp_feature_enable;
 		adapter->ptp_setup_sdp = NULL;
-- 
2.17.2

