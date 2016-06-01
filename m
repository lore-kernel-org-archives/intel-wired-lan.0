From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  1 Jun 2016 09:50:43 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct reporting of timestamping
	for x550
Message-ID: <1464799843-2589-1-git-send-email-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update ixgbe_ethtool_get_ts_info() to show that x550 supports hardware
timestamping of all packets.

Reported-by: Guy Harris <guy@alum.mit.edu>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index f1d2fc1..716e643 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2993,10 +2993,15 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 
+	/* we always support timestamping disabled */
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE);
+
 	switch (adapter->hw.mac.type) {
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
 	case ixgbe_mac_x550em_a:
+		info->rx_filters |= BIT(HWTSTAMP_FILTER_ALL);
+		/* fallthrough */
 	case ixgbe_mac_X540:
 	case ixgbe_mac_82599EB:
 		info->so_timestamping =
@@ -3016,8 +3021,7 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 			BIT(HWTSTAMP_TX_OFF) |
 			BIT(HWTSTAMP_TX_ON);
 
-		info->rx_filters =
-			BIT(HWTSTAMP_FILTER_NONE) |
+		info->rx_filters |=
 			BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
 			BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
 			BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
-- 
2.4.0

