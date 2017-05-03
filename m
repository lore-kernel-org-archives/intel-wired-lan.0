From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:29:00 -0700
Subject: [Intel-wired-lan] [PATCH v4 11/15] ixgbe: add statistic indicating
	number of skipped Tx timestamps
In-Reply-To: <20170503172904.9788-1-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
Message-ID: <20170503172904.9788-12-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ixgbe driver can only handle one Tx timestamp request at a time.
This means it is possible for an application timestamp request to be
ignored.

There is no easy way for an administrator to determine if this occurred.
Add a new statistic which tracks this, tx_hwtstamp_skipped.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 21 ++++++++++++---------
 3 files changed, 16 insertions(+), 9 deletions(-)

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
index f93330bc7b97..85a10458ab59 100644
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

