From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 May 2017 10:28:59 -0700
Subject: [Intel-wired-lan] [PATCH v4 10/15] igb: add statistic indicating
	number of skipped Tx timestamps
In-Reply-To: <20170503172904.9788-1-jacob.e.keller@intel.com>
References: <20170503172904.9788-1-jacob.e.keller@intel.com>
Message-ID: <20170503172904.9788-11-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The igb driver can only handle one Tx timestamp request at a time.
This means it is possible for an application timestamp request to be
ignored.

There is no easy way for an administrator to determine if this occurred.
Add a new statistic which tracks this, tx_hwtstamp_skipped.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h         | 1 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 1 +
 drivers/net/ethernet/intel/igb/igb_main.c    | 2 ++
 3 files changed, 4 insertions(+)

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
 
-- 
2.13.0.rc0.317.gcc792a6cad5a

