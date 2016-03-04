From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  4 Mar 2016 15:37:48 -0800
Subject: [Intel-wired-lan] [PATCH v6 2/2] fm10k: remove remove
	debug-statistics support
In-Reply-To: <1457134668-19142-1-git-send-email-jacob.e.keller@intel.com>
References: <1457134668-19142-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1457134668-19142-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change fixes an (ab)use of the ethtool stats API, which could
result in corrupt memory or misleading stat output. The ethtool stats
API is not robust enough to handle varying number of statistics due to
how it requests the size and allocates memory. Remove the poorly conceived
support originally added for extra debug statistics. In the future,
a new stats api may open up the ability to display these statistics.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Notes:
    - v6
    * move the queue stats changes to the first patch in this series
    * rework commit message to explain why we need to remove this feature
    
    This is a direct replacement for 2d6c14d75442 ("fm10k: cleanup fm10k stats and
    remove debug-statistics", 2016-03-04) which was on the queue. The previous
    version has a different title, but should be removed from the queue before
    applying this version.

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 72 +-----------------------
 1 file changed, 1 insertion(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 93f26c8b520c..a41a35082ddb 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -81,17 +81,6 @@ static const struct fm10k_stats fm10k_gstrings_global_stats[] = {
 	FM10K_STAT("tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
 };
 
-static const struct fm10k_stats fm10k_gstrings_debug_stats[] = {
-	FM10K_STAT("hw_sm_mbx_full", hw_sm_mbx_full),
-	FM10K_STAT("hw_csum_tx_good", hw_csum_tx_good),
-	FM10K_STAT("hw_csum_rx_good", hw_csum_rx_good),
-	FM10K_STAT("rx_switch_errors", rx_switch_errors),
-	FM10K_STAT("rx_drops", rx_drops),
-	FM10K_STAT("rx_pp_errors", rx_pp_errors),
-	FM10K_STAT("rx_link_errors", rx_link_errors),
-	FM10K_STAT("rx_length_errors", rx_length_errors),
-};
-
 static const struct fm10k_stats fm10k_gstrings_pf_stats[] = {
 	FM10K_STAT("timeout", stats.timeout.count),
 	FM10K_STAT("ur", stats.ur.count),
@@ -133,7 +122,6 @@ static const struct fm10k_stats fm10k_gstrings_queue_stats[] = {
 };
 
 #define FM10K_GLOBAL_STATS_LEN ARRAY_SIZE(fm10k_gstrings_global_stats)
-#define FM10K_DEBUG_STATS_LEN ARRAY_SIZE(fm10k_gstrings_debug_stats)
 #define FM10K_PF_STATS_LEN ARRAY_SIZE(fm10k_gstrings_pf_stats)
 #define FM10K_MBX_STATS_LEN ARRAY_SIZE(fm10k_gstrings_mbx_stats)
 #define FM10K_QUEUE_STATS_LEN ARRAY_SIZE(fm10k_gstrings_queue_stats)
@@ -154,12 +142,10 @@ enum fm10k_self_test_types {
 };
 
 enum {
-	FM10K_PRV_FLAG_DEBUG_STATS,
 	FM10K_PRV_FLAG_LEN,
 };
 
 static const char fm10k_prv_flags[FM10K_PRV_FLAG_LEN][ETH_GSTRING_LEN] = {
-	"debug-statistics",
 };
 
 static void fm10k_add_stat_strings(char **p, const char *prefix,
@@ -178,7 +164,6 @@ static void fm10k_add_stat_strings(char **p, const char *prefix,
 static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_iov_data *iov_data = interface->iov_data;
 	char *p = (char *)data;
 	unsigned int i;
 
@@ -188,10 +173,6 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 	fm10k_add_stat_strings(&p, "", fm10k_gstrings_global_stats,
 			       FM10K_GLOBAL_STATS_LEN);
 
-	if (interface->flags & FM10K_FLAG_DEBUG_STATS)
-		fm10k_add_stat_strings(&p, "", fm10k_gstrings_debug_stats,
-				       FM10K_DEBUG_STATS_LEN);
-
 	fm10k_add_stat_strings(&p, "", fm10k_gstrings_mbx_stats,
 			       FM10K_MBX_STATS_LEN);
 
@@ -199,17 +180,6 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 		fm10k_add_stat_strings(&p, "", fm10k_gstrings_pf_stats,
 				       FM10K_PF_STATS_LEN);
 
-	if ((interface->flags & FM10K_FLAG_DEBUG_STATS) && iov_data) {
-		for (i = 0; i < iov_data->num_vfs; i++) {
-			char prefix[ETH_GSTRING_LEN];
-
-			snprintf(prefix, ETH_GSTRING_LEN, "vf_%u_", i);
-			fm10k_add_stat_strings(&p, prefix,
-					       fm10k_gstrings_mbx_stats,
-					       FM10K_MBX_STATS_LEN);
-		}
-	}
-
 	for (i = 0; i < interface->hw.mac.max_queues; i++) {
 		char prefix[ETH_GSTRING_LEN];
 
@@ -248,7 +218,6 @@ static void fm10k_get_strings(struct net_device *dev,
 static int fm10k_get_sset_count(struct net_device *dev, int sset)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_iov_data *iov_data = interface->iov_data;
 	struct fm10k_hw *hw = &interface->hw;
 	int stats_len = FM10K_STATIC_STATS_LEN;
 
@@ -261,14 +230,6 @@ static int fm10k_get_sset_count(struct net_device *dev, int sset)
 		if (hw->mac.type != fm10k_mac_vf)
 			stats_len += FM10K_PF_STATS_LEN;
 
-		if (interface->flags & FM10K_FLAG_DEBUG_STATS) {
-			stats_len += FM10K_DEBUG_STATS_LEN;
-
-			if (iov_data)
-				stats_len += FM10K_MBX_STATS_LEN *
-					iov_data->num_vfs;
-		}
-
 		return stats_len;
 	case ETH_SS_PRIV_FLAGS:
 		return FM10K_PRV_FLAG_LEN;
@@ -318,7 +279,6 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 				    u64 *data)
 {
 	struct fm10k_intfc *interface = netdev_priv(netdev);
-	struct fm10k_iov_data *iov_data = interface->iov_data;
 	struct net_device_stats *net_stats = &netdev->stats;
 	int i;
 
@@ -330,11 +290,6 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 	fm10k_add_ethtool_stats(&data, interface, fm10k_gstrings_global_stats,
 				FM10K_GLOBAL_STATS_LEN);
 
-	if (interface->flags & FM10K_FLAG_DEBUG_STATS)
-		fm10k_add_ethtool_stats(&data, interface,
-					fm10k_gstrings_debug_stats,
-					FM10K_DEBUG_STATS_LEN);
-
 	fm10k_add_ethtool_stats(&data, &interface->hw.mbx,
 				fm10k_gstrings_mbx_stats,
 				FM10K_MBX_STATS_LEN);
@@ -345,18 +300,6 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 					FM10K_PF_STATS_LEN);
 	}
 
-	if ((interface->flags & FM10K_FLAG_DEBUG_STATS) && iov_data) {
-		for (i = 0; i < iov_data->num_vfs; i++) {
-			struct fm10k_vf_info *vf_info;
-
-			vf_info = &iov_data->vf_info[i];
-
-			fm10k_add_ethtool_stats(&data, &vf_info->mbx,
-						fm10k_gstrings_mbx_stats,
-						FM10K_MBX_STATS_LEN);
-		}
-	}
-
 	for (i = 0; i < interface->hw.mac.max_queues; i++) {
 		struct fm10k_ring *ring;
 
@@ -1015,27 +958,14 @@ static void fm10k_self_test(struct net_device *dev,
 
 static u32 fm10k_get_priv_flags(struct net_device *netdev)
 {
-	struct fm10k_intfc *interface = netdev_priv(netdev);
-	u32 priv_flags = 0;
-
-	if (interface->flags & FM10K_FLAG_DEBUG_STATS)
-		priv_flags |= BIT(FM10K_PRV_FLAG_DEBUG_STATS);
-
-	return priv_flags;
+	return 0;
 }
 
 static int fm10k_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 {
-	struct fm10k_intfc *interface = netdev_priv(netdev);
-
 	if (priv_flags >= BIT(FM10K_PRV_FLAG_LEN))
 		return -EINVAL;
 
-	if (priv_flags & BIT(FM10K_PRV_FLAG_DEBUG_STATS))
-		interface->flags |= FM10K_FLAG_DEBUG_STATS;
-	else
-		interface->flags &= ~FM10K_FLAG_DEBUG_STATS;
-
 	return 0;
 }
 
-- 
2.7.1.429.g45cd78e

