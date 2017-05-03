From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:28:57 -0700
Subject: [Intel-wired-lan] [PATCH v4 08/15] e1000e: add statistic indicating
	number of skipped Tx timestamps
In-Reply-To: <20170503172904.9788-1-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
Message-ID: <20170503172904.9788-9-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The e1000e driver can only handle one Tx timestamp request at a time.
This means it is possible for an application timestamp request to be
ignored.

There is no easy way for an administrator to determine if this occurred.
Add a new statistic which tracks this, tx_hwtstamp_skipped.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   |  1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c  | 17 ++++++++++-------
 3 files changed, 12 insertions(+), 7 deletions(-)

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
-- 
2.13.0.rc0.317.gcc792a6cad5a

