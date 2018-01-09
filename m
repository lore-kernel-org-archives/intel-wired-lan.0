From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Tue,  9 Jan 2018 12:37:05 +0100
Subject: [Intel-wired-lan] [PATCH] ixgbe: Don't report unsupported
 timestamping filters for X550
Message-ID: <20180109113705.8464-1-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The current code enables on X550 timestamping of all packets for any
filter, which means ethtool should not report any PTP-specific filters
as supported.

Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 37 ++++++++++++------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 0aaf70b..0a5a351 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3086,26 +3086,9 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_x550em_a:
 		info->rx_filters |= BIT(HWTSTAMP_FILTER_ALL);
-		/* fallthrough */
+		break;
 	case ixgbe_mac_X540:
 	case ixgbe_mac_82599EB:
-		info->so_timestamping =
-			SOF_TIMESTAMPING_TX_SOFTWARE |
-			SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE |
-			SOF_TIMESTAMPING_TX_HARDWARE |
-			SOF_TIMESTAMPING_RX_HARDWARE |
-			SOF_TIMESTAMPING_RAW_HARDWARE;
-
-		if (adapter->ptp_clock)
-			info->phc_index = ptp_clock_index(adapter->ptp_clock);
-		else
-			info->phc_index = -1;
-
-		info->tx_types =
-			BIT(HWTSTAMP_TX_OFF) |
-			BIT(HWTSTAMP_TX_ON);
-
 		info->rx_filters |=
 			BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
 			BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
@@ -3114,6 +3097,24 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 	default:
 		return ethtool_op_get_ts_info(dev, info);
 	}
+
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE |
+		SOF_TIMESTAMPING_TX_HARDWARE |
+		SOF_TIMESTAMPING_RX_HARDWARE |
+		SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	if (adapter->ptp_clock)
+		info->phc_index = ptp_clock_index(adapter->ptp_clock);
+	else
+		info->phc_index = -1;
+
+	info->tx_types =
+		BIT(HWTSTAMP_TX_OFF) |
+		BIT(HWTSTAMP_TX_ON);
+
 	return 0;
 }
 
-- 
2.9.5

