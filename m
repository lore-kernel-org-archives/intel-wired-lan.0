From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 May 2016 16:18:21 -0700
Subject: [Intel-wired-lan] [net v2 2/5] igb: introduce
	IGB_PTP_OVERFLOW_CHECK flag
In-Reply-To: <20160511231824.22542-1-jacob.e.keller@intel.com>
References: <20160511231824.22542-1-jacob.e.keller@intel.com>
Message-ID: <20160511231824.22542-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Don't continue to use complex MAC type checks for handling various cases
where we have overflow check code. Make this code more obvious by
introducing a flag which is enabled for hardware that needs these
checks.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h     |  1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 1e18a9eb16e0..38daaaba0cdb 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -477,6 +477,7 @@ struct igb_adapter {
 
 /* flags controlling PTP/1588 function */
 #define IGB_PTP_ENABLED		BIT(0)
+#define IGB_PTP_OVERFLOW_CHECK	BIT(1)
 
 #define IGB_FLAG_HAS_MSI		BIT(0)
 #define IGB_FLAG_DCA_ENABLED		BIT(1)
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 88e3b40415a1..e2c494ad1be0 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1066,6 +1066,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->cc.shift = IGB_82576_TSYNC_SHIFT;
 		/* Dial the nominal frequency. */
 		wr32(E1000_TIMINCA, INCPERIOD_82576 | INCVALUE_82576);
+		adapter->ptp_flags |= IGB_PTP_OVERFLOW_CHECK;
 		break;
 	case e1000_82580:
 	case e1000_i354:
@@ -1086,6 +1087,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->cc.shift = 0;
 		/* Enable the timer functions by clearing bit 31. */
 		wr32(E1000_TSAUXC, 0x0);
+		adapter->ptp_flags |= IGB_PTP_OVERFLOW_CHECK;
 		break;
 	case e1000_i210:
 	case e1000_i211:
@@ -1131,7 +1133,9 @@ void igb_ptp_init(struct igb_adapter *adapter)
 	} else {
 		timecounter_init(&adapter->tc, &adapter->cc,
 				 ktime_to_ns(ktime_get_real()));
+	}
 
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK) {
 		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
 				  igb_ptp_overflow_check);
 
@@ -1168,20 +1172,11 @@ void igb_ptp_init(struct igb_adapter *adapter)
  **/
 void igb_ptp_stop(struct igb_adapter *adapter)
 {
-	switch (adapter->hw.mac.type) {
-	case e1000_82576:
-	case e1000_82580:
-	case e1000_i354:
-	case e1000_i350:
-		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
-		break;
-	case e1000_i210:
-	case e1000_i211:
-		/* No delayed work to cancel. */
-		break;
-	default:
+	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
 		return;
-	}
+
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
 
 	cancel_work_sync(&adapter->ptp_tx_work);
 	if (adapter->ptp_tx_skb) {
-- 
2.8.1.493.g7b22612

