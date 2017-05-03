From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:29:04 -0700
Subject: [Intel-wired-lan] [PATCH v4 15/15] ixgbe: check for Tx timestamp
	timeouts during watchdog
In-Reply-To: <20170503172904.9788-1-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
Message-ID: <20170503172904.9788-16-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ixgbe driver has logic to handle only one Tx timestamp at a time,
using a state bit lock to avoid multiple requests at once.

It may be possible, if incredibly unlikely, that a Tx timestamp event is
requested but never completes. Since we use an interrupt scheme to
determine when the Tx timestamp occurred we would never clear the state
bit in this case.

Add an ixgbe_ptp_tx_hang() function similar to the already existing
ixgbe_ptp_rx_hang() function. This function runs in the watchdog routine
and makes sure we eventually recover from this case instead of
permanently disabling Tx timestamps.

Note: there is no currently known way to cause this without hacking the
driver code to force it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index eb36106218ad..dd5578756ae0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -961,6 +961,7 @@ void ixgbe_ptp_suspend(struct ixgbe_adapter *adapter);
 void ixgbe_ptp_stop(struct ixgbe_adapter *adapter);
 void ixgbe_ptp_overflow_check(struct ixgbe_adapter *adapter);
 void ixgbe_ptp_rx_hang(struct ixgbe_adapter *adapter);
+void ixgbe_ptp_tx_hang(struct ixgbe_adapter *adapter);
 void ixgbe_ptp_rx_pktstamp(struct ixgbe_q_vector *, struct sk_buff *);
 void ixgbe_ptp_rx_rgtstamp(struct ixgbe_q_vector *, struct sk_buff *skb);
 static inline void ixgbe_ptp_rx_hwtstamp(struct ixgbe_ring *rx_ring,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 85a10458ab59..ee20a2bf5514 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7645,6 +7645,7 @@ static void ixgbe_service_task(struct work_struct *work)
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state)) {
 		ixgbe_ptp_overflow_check(adapter);
 		ixgbe_ptp_rx_hang(adapter);
+		ixgbe_ptp_tx_hang(adapter);
 	}
 
 	ixgbe_service_event_complete(adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 9270e6f4fcff..24f4eaf37727 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -662,6 +662,33 @@ static void ixgbe_ptp_clear_tx_timestamp(struct ixgbe_adapter *adapter)
 	clear_bit_unlock(__IXGBE_PTP_TX_IN_PROGRESS, &adapter->state);
 }
 
+/**
+ * ixgbe_ptp_tx_hang - detect error case where Tx timestamp never finishes
+ * @adapter: private network adapter structure
+ */
+void ixgbe_ptp_tx_hang(struct ixgbe_adapter *adapter)
+{
+	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
+					      IXGBE_PTP_TX_TIMEOUT);
+
+	if (!adapter->ptp_tx_skb)
+		return;
+
+	if (!test_bit(__IXGBE_PTP_TX_IN_PROGRESS, &adapter->state))
+		return;
+
+	/* If we haven't received a timestamp within the timeout, it is
+	 * reasonable to assume that it will never occur, so we can unlock the
+	 * timestamp bit when this occurs.
+	 */
+	if (timeout) {
+		cancel_work_sync(&adapter->ptp_tx_work);
+		ixgbe_ptp_clear_tx_timestamp(adapter);
+		adapter->tx_hwtstamp_timeouts++;
+		e_warn(drv, "clearing Tx timestamp hang\n");
+	}
+}
+
 /**
  * ixgbe_ptp_tx_hwtstamp - utility function which checks for TX time stamp
  * @adapter: the private adapter struct
-- 
2.13.0.rc0.317.gcc792a6cad5a

