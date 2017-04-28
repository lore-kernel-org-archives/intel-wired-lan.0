From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 28 Apr 2017 10:16:55 -0700
Subject: [Intel-wired-lan] [PATCH v2 5/5] net-intel: check for Tx timestamp
	timeouts during watchdog
In-Reply-To: <20170428171655.13650-1-jacob.e.keller@intel.com>
References: <20170428171655.13650-1-jacob.e.keller@intel.com>
Message-ID: <20170428171655.13650-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Several drivers share similar logic for handling the Tx timestamps.
These drivers have some parts which rely on the interrupt instead of
only a polling work task. Although unlikely it may be possible in some
circumstances for the PTP tx timestamp to never occur. If this happens,
the result is that all future Tx timestamp requests will be ignored
permanently.

Fix this by adding a *ptp_tx_hang() function similar to the already
existing *ptp_rx_hang() routine which checks to make sure that the
timestamp hasn't taken too long. This ensures that we will eventually
recover from this case.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    | 30 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  1 +
 drivers/net/ethernet/intel/igb/igb.h          |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c     |  1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c      | 29 ++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 28 +++++++++++++++++++++++++
 10 files changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index f4465afe1fe1..25bf336c5f38 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -502,6 +502,7 @@ struct i40e_pf {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_caps;
 	struct sk_buff *ptp_tx_skb;
+	unsigned long ptp_tx_start;
 	struct hwtstamp_config tstamp_config;
 	struct mutex tmreg_lock; /* Used to protect the SYSTIME registers. */
 	u64 ptp_base_adj;
@@ -957,6 +958,7 @@ bool i40e_dcb_need_reconfig(struct i40e_pf *pf,
 			    struct i40e_dcbx_config *new_cfg);
 #endif /* CONFIG_I40E_DCB */
 void i40e_ptp_rx_hang(struct i40e_pf *pf);
+void i40e_ptp_tx_hang(struct i40e_pf *pf);
 void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf);
 void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index);
 void i40e_ptp_set_increment(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c019dec988e3..e4eb97832413 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6373,6 +6373,7 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 	}
 
 	i40e_ptp_rx_hang(pf);
+	i40e_ptp_tx_hang(pf);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 876ea169816a..cd35c4b9a8b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -327,6 +327,36 @@ void i40e_ptp_rx_hang(struct i40e_pf *pf)
 	pf->rx_hwtstamp_cleared += cleared;
 }
 
+/**
+ * i40e_ptp_tx_hang - Detect error case when Tx timestamp register is hung
+ * @pf: The PF private data structure
+ *
+ * This watchdog task is run periodically to make sure that we clear the Tx
+ * timestamp logic if we don't obtain a timestamp in a reasonable amount of
+ * time. It is unexpected in the normal case but if it occurs it results in
+ * permanently prevent timestamps of future packets
+ **/
+void i40e_ptp_tx_hang(struct i40e_pf *pf)
+{
+	if (!(pf->flags & I40E_FLAG_PTP) || !pf->ptp_tx)
+		return;
+
+	/* Nothing to do if we're not already waiting for a timestamp */
+	if (!test_bit(__I40E_PTP_TX_IN_PROGRESS, pf->state))
+		return;
+
+	/* We already have a handler routine which is run when we are notified
+	 * of a Tx timestamp in the hardware. If we don't get an interrupt
+	 * within a second it is reasonable to assume that we never will.
+	 */
+	if (time_is_before_jiffies(pf->ptp_tx_start + HZ)) {
+		dev_kfree_skb_any(pf->ptp_tx_skb);
+		pf->ptp_tx_skb = NULL;
+		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+		pf->tx_hwtstamp_timeouts++;
+	}
+}
+
 /**
  * i40e_ptp_tx_hwtstamp - Utility function which returns the Tx timestamp
  * @pf: Board private structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c69ee4b0cfe2..c2e9013d05eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2628,6 +2628,7 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (pf->ptp_tx &&
 	    !test_and_set_bit_lock(__I40E_PTP_TX_IN_PROGRESS, pf->state)) {
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		pf->ptp_tx_start = jiffies;
 		pf->ptp_tx_skb = skb_get(skb);
 	} else {
 		pf->tx_hwtstamp_skipped++;
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
index 3745b98749ed..f9900f10215b 100644
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
index c61459fcc21e..f3199c73faed 100644
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
index 9270e6f4fcff..ef78835373fe 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -662,6 +662,34 @@ static void ixgbe_ptp_clear_tx_timestamp(struct ixgbe_adapter *adapter)
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
+
 /**
  * ixgbe_ptp_tx_hwtstamp - utility function which checks for TX time stamp
  * @adapter: the private adapter struct
-- 
2.13.0.rc0.317.gcc792a6cad5a

