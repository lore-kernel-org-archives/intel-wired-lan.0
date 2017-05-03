From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:29:03 -0700
Subject: [Intel-wired-lan] [PATCH v4 14/15] igb: check for Tx timestamp
	timeouts during watchdog
In-Reply-To: <20170503172904.9788-1-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
Message-ID: <20170503172904.9788-15-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The igb driver has logic to handle only one Tx timestamp at a time,
using a state bit lock to avoid multiple requests at once.

It may be possible, if incredibly unlikely, that a Tx timestamp event is
requested but never completes. Since we use an interrupt scheme to
determine when the Tx timestamp occurred we would never clear the state
bit in this case.

Add an igb_ptp_tx_hang() function similar to the already existing
igb_ptp_rx_hang() function. This function runs in the watchdog routine
and makes sure we eventually recover from this case instead of
permanently disabling Tx timestamps.

Note: there is no currently known way to cause this without hacking the
driver code to force it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c |  1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index be35edcf6b08..ff4d9073781a 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -677,6 +677,7 @@ void igb_ptp_stop(struct igb_adapter *adapter);
 void igb_ptp_reset(struct igb_adapter *adapter);
 void igb_ptp_suspend(struct igb_adapter *adapter);
 void igb_ptp_rx_hang(struct igb_adapter *adapter);
+void igb_ptp_tx_hang(struct igb_adapter *adapter);
 void igb_ptp_rx_rgtstamp(struct igb_q_vector *q_vector, struct sk_buff *skb);
 void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			 struct sk_buff *skb);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 21b455bfb4ca..eec54d9df06b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4726,6 +4726,7 @@ static void igb_watchdog_task(struct work_struct *work)
 
 	igb_spoof_check(adapter);
 	igb_ptp_rx_hang(adapter);
+	igb_ptp_tx_hang(adapter);
 
 	/* Check LVMMC register on i350/i354 only */
 	if ((adapter->hw.mac.type == e1000_i350) ||
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index a2da5738bfb5..b2f67c169bd2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -711,6 +711,35 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
 	}
 }
 
+/**
+ * igb_ptp_tx_hang - detect error case where Tx timestamp never finishes
+ * @adapter: private network adapter structure
+ */
+void igb_ptp_tx_hang(struct igb_adapter *adapter)
+{
+	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
+					      IGB_PTP_TX_TIMEOUT);
+
+	if (!adapter->ptp_tx_skb)
+		return;
+
+	if (!test_bit(__IGB_PTP_TX_IN_PROGRESS, &adapter->state))
+		return;
+
+	/* If we haven't received a timestamp within the timeout, it is
+	 * reasonable to assume that it will never occur, so we can unlock the
+	 * timestamp bit when this occurs.
+	 */
+	if (timeout) {
+		cancel_work_sync(&adapter->ptp_tx_work);
+		dev_kfree_skb_any(adapter->ptp_tx_skb);
+		adapter->ptp_tx_skb = NULL;
+		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
+		adapter->tx_hwtstamp_timeouts++;
+		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
+	}
+}
+
 /**
  * igb_ptp_tx_hwtstamp - utility function which checks for TX time stamp
  * @adapter: Board private structure.
-- 
2.13.0.rc0.317.gcc792a6cad5a

