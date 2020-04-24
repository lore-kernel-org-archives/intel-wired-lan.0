From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:06 -0700
Subject: [Intel-wired-lan] [PATCH 02/19] igc: Get rid of igc_max_channels()
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-3-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The local function igc_max_channels() is a pointless wrapper around
igc_get_max_rss_queues(). This patch removes it and updates the callers
accordingly. It also does some cleanup on igc_get_max_rss_queues().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 9 ++-------
 drivers/net/ethernet/intel/igc/igc_main.c    | 7 +------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 9023dc2a2446..ee2563ef24ac 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1508,18 +1508,13 @@ static int igc_set_rxfh(struct net_device *netdev, const u32 *indir,
 	return 0;
 }
 
-static unsigned int igc_max_channels(struct igc_adapter *adapter)
-{
-	return igc_get_max_rss_queues(adapter);
-}
-
 static void igc_get_channels(struct net_device *netdev,
 			     struct ethtool_channels *ch)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
 	/* Report maximum channels */
-	ch->max_combined = igc_max_channels(adapter);
+	ch->max_combined = igc_get_max_rss_queues(adapter);
 
 	/* Report info for other vector */
 	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
@@ -1546,7 +1541,7 @@ static int igc_set_channels(struct net_device *netdev,
 		return -EINVAL;
 
 	/* Verify the number of channels doesn't exceed hw limits */
-	max_combined = igc_max_channels(adapter);
+	max_combined = igc_get_max_rss_queues(adapter);
 	if (count > max_combined)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 73140938ec2c..04f7f4112205 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2732,12 +2732,7 @@ void igc_set_flag_queue_pairs(struct igc_adapter *adapter,
 
 unsigned int igc_get_max_rss_queues(struct igc_adapter *adapter)
 {
-	unsigned int max_rss_queues;
-
-	/* Determine the maximum number of RSS queues supported. */
-	max_rss_queues = IGC_MAX_RX_QUEUES;
-
-	return max_rss_queues;
+	return IGC_MAX_RX_QUEUES;
 }
 
 static void igc_init_queue_configuration(struct igc_adapter *adapter)
-- 
2.26.0

