From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 May 2016 16:18:22 -0700
Subject: [Intel-wired-lan] [net v2 3/5] igb: introduce igb_ptp_resume
	function
In-Reply-To: <20160511231824.22542-1-jacob.e.keller@intel.com>
References: <20160511231824.22542-1-jacob.e.keller@intel.com>
Message-ID: <20160511231824.22542-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Modify igb_ptp_init to take advantage of igb_ptp_resume, and remove
duplicated work that was occurring in both igb_ptp_reset and
igb_ptp_init.

In total, resetting the TSAUXC register, and resetting the system time
both happen in igb_ptp_reset already, which the new igb_ptp_resume
calls. igb_ptp_resume also takes care of starting the delayed work item
for overflow checks, as well.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h     |  1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c | 57 ++++++++++++++++----------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 38daaaba0cdb..fcba5ebba5ab 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -550,6 +550,7 @@ void igb_set_fw_version(struct igb_adapter *);
 void igb_ptp_init(struct igb_adapter *adapter);
 void igb_ptp_stop(struct igb_adapter *adapter);
 void igb_ptp_reset(struct igb_adapter *adapter);
+void igb_ptp_resume(struct igb_adapter *adapter);
 void igb_ptp_rx_hang(struct igb_adapter *adapter);
 void igb_ptp_rx_rgtstamp(struct igb_q_vector *q_vector, struct sk_buff *skb);
 void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, unsigned char *va,
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index e2c494ad1be0..6c7d05d35894 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1042,6 +1042,29 @@ int igb_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr)
 		-EFAULT : 0;
 }
 
+/**
+ * igb_ptp_resume - Restart PTP and associated work items
+ * @adapter: Board private structure
+ *
+ * This function restarts the overflow check if required, and calls
+ * igb_ptp_reset to restore proper functionality after the machine resumes.
+ */
+void igb_ptp_resume(struct igb_adapter *adapter)
+{
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+		schedule_delayed_work(&adapter->ptp_overflow_work,
+				      IGB_SYSTIM_OVERFLOW_PERIOD);
+
+	igb_ptp_reset(adapter);
+}
+
+/**
+ * igb_ptp_init - Initialize PTP functionality
+ * @adapter: Board private structure
+ *
+ * This function is called at device probe to initialize the PTP
+ * functionality.
+ */
 void igb_ptp_init(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
@@ -1064,8 +1087,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->cc.mask = CYCLECOUNTER_MASK(64);
 		adapter->cc.mult = 1;
 		adapter->cc.shift = IGB_82576_TSYNC_SHIFT;
-		/* Dial the nominal frequency. */
-		wr32(E1000_TIMINCA, INCPERIOD_82576 | INCVALUE_82576);
 		adapter->ptp_flags |= IGB_PTP_OVERFLOW_CHECK;
 		break;
 	case e1000_82580:
@@ -1085,8 +1106,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->cc.mask = CYCLECOUNTER_MASK(IGB_NBITS_82580);
 		adapter->cc.mult = 1;
 		adapter->cc.shift = 0;
-		/* Enable the timer functions by clearing bit 31. */
-		wr32(E1000_TSAUXC, 0x0);
 		adapter->ptp_flags |= IGB_PTP_OVERFLOW_CHECK;
 		break;
 	case e1000_i210:
@@ -1112,46 +1131,24 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_caps.settime64 = igb_ptp_settime_i210;
 		adapter->ptp_caps.enable = igb_ptp_feature_enable_i210;
 		adapter->ptp_caps.verify = igb_ptp_verify_pin;
-		/* Enable the timer functions by clearing bit 31. */
-		wr32(E1000_TSAUXC, 0x0);
 		break;
 	default:
 		adapter->ptp_clock = NULL;
 		return;
 	}
 
-	wrfl();
-
 	spin_lock_init(&adapter->tmreg_lock);
 	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
 
-	/* Initialize the clock and overflow work for devices that need it. */
-	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211)) {
-		struct timespec64 ts = ktime_to_timespec64(ktime_get_real());
-
-		igb_ptp_settime_i210(&adapter->ptp_caps, &ts);
-	} else {
-		timecounter_init(&adapter->tc, &adapter->cc,
-				 ktime_to_ns(ktime_get_real()));
-	}
-
-	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK) {
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
 		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
 				  igb_ptp_overflow_check);
 
-		schedule_delayed_work(&adapter->ptp_overflow_work,
-				      IGB_SYSTIM_OVERFLOW_PERIOD);
-	}
-
-	/* Initialize the time sync interrupts for devices that support it. */
-	if (hw->mac.type >= e1000_82580) {
-		wr32(E1000_TSIM, TSYNC_INTERRUPTS);
-		wr32(E1000_IMS, E1000_IMS_TS);
-	}
-
 	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 
+	igb_ptp_resume(adapter);
+
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1243,4 +1240,6 @@ void igb_ptp_reset(struct igb_adapter *adapter)
 	}
 out:
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
+
+	wrfl();
 }
-- 
2.8.1.493.g7b22612

