From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 28 Apr 2017 11:44:19 -0700
Subject: [Intel-wired-lan] [PATCH v3 3/5] net-intel: add statistic
	indicating number of skipped Tx timestamps
In-Reply-To: <20170428184421.20216-1-jacob.e.keller@intel.com>
References: <20170428184421.20216-1-jacob.e.keller@intel.com>
Message-ID: <20170428184421.20216-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The e1000e, igb, i40e, and ixgbe drivers share similar code for handling
Tx timestamps, with a similar limitation of only one Tx timestamp
register set. Because the hardware only supports one Tx timestamp at
a time, the drivers may silently ignore timestamp requests for packets
while waiting for a previous packet timestamp to complete. Add a new
statistic, tx_hwtstamp_skipped, which indicates how many times this has
happened. This is useful when trying to determine why a specific
application is not receiving timestamps. Without this statistic, the
developer may not have any indication that the timestamp was
intentionally skipped.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h        |  1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c      |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c       | 17 ++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e.h           |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c      |  1 +
 drivers/net/ethernet/intel/igb/igb.h             |  1 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c     |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c        |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 21 ++++++++++++---------
 12 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index c7c994eb410e..98e68888abb1 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -268,6 +268,7 @@ struct e1000_adapter {
 	u32 tx_fifo_size;
 	u32 tx_dma_failed;
 	u32 tx_hwtstamp_timeouts;
+	u32 tx_hwtstamp_skipped;
 
 	/* Rx */
 	bool (*clean_rx)(struct e1000_ring *ring, int *work_done,
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index e23dbd9190d6..c658f6ebf7cb 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -105,6 +105,7 @@ static const struct e1000_stats e1000_gstrings_stats[] = {
 	E1000_STAT("uncorr_ecc_errors", uncorr_errors),
 	E1000_STAT("corr_ecc_errors", corr_errors),
 	E1000_STAT("tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
+	E1000_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
 };
 
 #define E1000_GLOBAL_STATS_LEN	ARRAY_SIZE(e1000_gstrings_stats)
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ec9a50a72550..42424274853c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5866,13 +5866,16 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 			     nr_frags);
 	if (count) {
 		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-		    (adapter->flags & FLAG_HAS_HW_TIMESTAMP) &&
-		    !adapter->tx_hwtstamp_skb) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-			tx_flags |= E1000_TX_FLAGS_HWTSTAMP;
-			adapter->tx_hwtstamp_skb = skb_get(skb);
-			adapter->tx_hwtstamp_start = jiffies;
-			schedule_work(&adapter->tx_hwtstamp_work);
+		    (adapter->flags & FLAG_HAS_HW_TIMESTAMP)) {
+			if (!adapter->tx_hwtstamp_skb) {
+				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+				tx_flags |= E1000_TX_FLAGS_HWTSTAMP;
+				adapter->tx_hwtstamp_skb = skb_get(skb);
+				adapter->tx_hwtstamp_start = jiffies;
+				schedule_work(&adapter->tx_hwtstamp_work);
+			} else {
+				adapter->tx_hwtstamp_skipped++;
+			}
 		} else {
 			skb_tx_timestamp(skb);
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index cdde3cc28fb5..aa46ae016539 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -506,6 +506,7 @@ struct i40e_pf {
 	struct mutex tmreg_lock; /* Used to protect the SYSTIME registers. */
 	u64 ptp_base_adj;
 	u32 tx_hwtstamp_timeouts;
+	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
 	u32 latch_event_flags;
 	spinlock_t ptp_rx_lock; /* Used to protect Rx timestamp registers. */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 7a8eb486b9ea..35a246f05520 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -147,6 +147,7 @@ static const struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("VF_admin_queue_requests", vf_aq_requests),
 	I40E_PF_STAT("arq_overflows", arq_overflows),
 	I40E_PF_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
+	I40E_PF_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
 	I40E_PF_STAT("fdir_flush_cnt", fd_flush_cnt),
 	I40E_PF_STAT("fdir_atr_match", stats.fd_atr_match),
 	I40E_PF_STAT("fdir_atr_tunnel_match", stats.fd_atr_tunnel_match),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 19984be0f70c..c69ee4b0cfe2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2630,6 +2630,7 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		pf->ptp_tx_skb = skb_get(skb);
 	} else {
+		pf->tx_hwtstamp_skipped++;
 		return 0;
 	}
 
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index bf9bf9056d0c..be35edcf6b08 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -563,6 +563,7 @@ struct igb_adapter {
 	struct cyclecounter cc;
 	struct timecounter tc;
 	u32 tx_hwtstamp_timeouts;
+	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
 	bool pps_sys_wrap_on;
 
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 0efb62db6efd..8730f7cbce68 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -90,6 +90,7 @@ static const struct igb_stats igb_gstrings_stats[] = {
 	IGB_STAT("os2bmc_tx_by_host", stats.o2bspc),
 	IGB_STAT("os2bmc_rx_by_host", stats.b2ogprc),
 	IGB_STAT("tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
+	IGB_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
 	IGB_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
 };
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 978908f426a7..21b455bfb4ca 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5392,6 +5392,8 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 			adapter->ptp_tx_start = jiffies;
 			if (adapter->hw.mac.type == e1000_82576)
 				schedule_work(&adapter->ptp_tx_work);
+		} else {
+			adapter->tx_hwtstamp_skipped++;
 		}
 	}
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 76263762bea1..eb36106218ad 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -733,6 +733,7 @@ struct ixgbe_adapter {
 	struct timecounter hw_tc;
 	u32 base_incval;
 	u32 tx_hwtstamp_timeouts;
+	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
 	void (*ptp_setup_sdp)(struct ixgbe_adapter *);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index cced74dd5a63..0b75d304b009 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -111,6 +111,9 @@ static const struct ixgbe_stats ixgbe_gstrings_stats[] = {
 	{"os2bmc_tx_by_bmc", IXGBE_STAT(stats.b2ospc)},
 	{"os2bmc_tx_by_host", IXGBE_STAT(stats.o2bspc)},
 	{"os2bmc_rx_by_host", IXGBE_STAT(stats.b2ogprc)},
+	{"tx_hwtstamp_timeouts", IXGBE_STAT(tx_hwtstamp_timeouts)},
+	{"tx_hwtstamp_skipped", IXGBE_STAT(tx_hwtstamp_skipped)},
+	{"rx_hwtstamp_cleared", IXGBE_STAT(rx_hwtstamp_cleared)},
 #ifdef IXGBE_FCOE
 	{"fcoe_bad_fccrc", IXGBE_STAT(stats.fccrc)},
 	{"rx_fcoe_dropped", IXGBE_STAT(stats.fcoerpdc)},
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 54bf0f9f5573..c61459fcc21e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8346,16 +8346,19 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 	protocol = vlan_get_protocol(skb);
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    adapter->ptp_clock &&
-	    !test_and_set_bit_lock(__IXGBE_PTP_TX_IN_PROGRESS,
-				   &adapter->state)) {
-		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-		tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
+	    adapter->ptp_clock) {
+		if (!test_and_set_bit_lock(__IXGBE_PTP_TX_IN_PROGRESS,
+					   &adapter->state)) {
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+			tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
 
-		/* schedule check for Tx timestamp */
-		adapter->ptp_tx_skb = skb_get(skb);
-		adapter->ptp_tx_start = jiffies;
-		schedule_work(&adapter->ptp_tx_work);
+			/* schedule check for Tx timestamp */
+			adapter->ptp_tx_skb = skb_get(skb);
+			adapter->ptp_tx_start = jiffies;
+			schedule_work(&adapter->ptp_tx_work);
+		} else {
+			adapter->tx_hwtstamp_skipped++;
+		}
 	}
 
 	skb_tx_timestamp(skb);
-- 
2.13.0.rc0.317.gcc792a6cad5a

