From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  7 Apr 2020 14:07:08 -0700
Subject: [Intel-wired-lan] [PATCH 2/5] igc: Remove ethertype filter in ptp
 code
In-Reply-To: <20200407210711.24371-1-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
Message-ID: <20200407210711.24371-3-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver only supports hardware timestamping for all incoming
traffic (HWTSTAMP_FILTER_ALL) which is enabled via Rx Time Sync
Control (TSYNCRXCTL) register already. Therefore, the ethertype
filter set in in igc_ptp_set_timestamp_mode() is useless so this
patch removes it.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_defines.h |  3 ---
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 12 ------------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index dd2d2f0c312f..3666914724b0 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -26,7 +26,7 @@ void igc_set_ethtool_ops(struct net_device *);
 #define MAX_Q_VECTORS			8
 #define MAX_STD_JUMBO_FRAME_SIZE	9216
 
-#define MAX_ETYPE_FILTER		(4 - 1)
+#define MAX_ETYPE_FILTER		4
 #define IGC_RETA_SIZE			128
 
 struct igc_tx_queue_stats {
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 03c3ce86a9b6..1127ef81e374 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -384,9 +384,6 @@
 
 #define IGC_TSICR_INTERRUPTS	IGC_TSICR_TXTS
 
-/* PTP Queue Filter */
-#define IGC_ETQF_1588		BIT(30)
-
 #define IGC_FTQF_VF_BP		0x00008000
 #define IGC_FTQF_1588_TIME_STAMP	0x08000000
 #define IGC_FTQF_MASK			0xF0000000
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index c292aaf7c79d..825e21a73355 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -305,7 +305,6 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	struct igc_hw *hw = &adapter->hw;
 	u32 tsync_rx_cfg = 0;
 	bool is_l4 = false;
-	bool is_l2 = false;
 	u32 regval;
 
 	/* reserved for future extensions */
@@ -346,7 +345,6 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 		tsync_rx_ctl |= IGC_TSYNCRXCTL_TYPE_EVENT_V2;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		is_l2 = true;
 		is_l4 = true;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
@@ -370,7 +368,6 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 		tsync_rx_ctl |= IGC_TSYNCRXCTL_TYPE_ALL;
 		tsync_rx_ctl |= IGC_TSYNCRXCTL_RXSYNSIG;
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
-		is_l2 = true;
 		is_l4 = true;
 
 		if (hw->mac.type == igc_i225) {
@@ -405,15 +402,6 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	/* define which PTP packets are time stamped */
 	wr32(IGC_TSYNCRXCFG, tsync_rx_cfg);
 
-	/* define ethertype filter for timestamped packets */
-	if (is_l2)
-		wr32(IGC_ETQF(3),
-		     (IGC_ETQF_FILTER_ENABLE | /* enable filter */
-		     IGC_ETQF_1588 | /* enable timestamping */
-		     ETH_P_1588)); /* 1588 eth protocol type */
-	else
-		wr32(IGC_ETQF(3), 0);
-
 	/* L4 Queue Filter[3]: filter by destination port and protocol */
 	if (is_l4) {
 		u32 ftqf = (IPPROTO_UDP /* UDP */
-- 
2.26.0

