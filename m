From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  2 Mar 2016 12:23:03 -0800
Subject: [Intel-wired-lan] [PATCH v3] fm10k: cleanup fm10k stats and remove
	debug-statistics
Message-ID: <1456950183-29413-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change fixes up subtle issues with the current fm10k ethtool stats.
Primarily, support of debug-statistics and per-queue length statistics
is not something the current API can handle. Due to the way that ethtool
works, the number of statistics needs to be static for the life time of
a given device. Our use of debug-statistics does not really allow for
this, so this patch drops its use.

Finish this cleanup by reworking the per-queue stats to use the new
helper functions which reduce the duplicate and error prone code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Testing Hints: Check that you see all 128 queues for Tx/Rx, as this is
the expected behavior since the ethtool stats API cannot have non-static
counts of statistics. Check that debug-statistics have been removed.

This is based on comments regarding the API upstream after attempts to
fix it. The only real way to fix this is to implement a new/better
stats API.

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 116 +++++++----------------
 1 file changed, 33 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index c67121cc7b23..a488ab03117e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -121,18 +121,27 @@ static const struct fm10k_stats fm10k_gstrings_mbx_stats[] = {
 	FM10K_MBX_STAT("mbx_rx_mbmem_pushed", rx_mbmem_pushed),
 };
 
+#define FM10K_QUEUE_STAT(_name, _stat) { \
+	.stat_string = _name, \
+	.sizeof_stat = FIELD_SIZEOF(struct fm10k_ring, _stat), \
+	.stat_offset = offsetof(struct fm10k_ring, _stat) \
+}
+
+static const struct fm10k_stats fm10k_gstrings_queue_stats[] = {
+	FM10K_QUEUE_STAT("packets", stats.packets),
+	FM10K_QUEUE_STAT("bytes", stats.packets),
+};
+
 #define FM10K_GLOBAL_STATS_LEN ARRAY_SIZE(fm10k_gstrings_global_stats)
-#define FM10K_DEBUG_STATS_LEN ARRAY_SIZE(fm10k_gstrings_debug_stats)
 #define FM10K_PF_STATS_LEN ARRAY_SIZE(fm10k_gstrings_pf_stats)
 #define FM10K_MBX_STATS_LEN ARRAY_SIZE(fm10k_gstrings_mbx_stats)
-
-#define FM10K_QUEUE_STATS_LEN(_n) \
-	((_n) * 2 * (sizeof(struct fm10k_queue_stats) / sizeof(u64)))
+#define FM10K_QUEUE_STATS_LEN ARRAY_SIZE(fm10k_gstrings_queue_stats)
 
 #define FM10K_STATIC_STATS_LEN (FM10K_GLOBAL_STATS_LEN + \
 				FM10K_NETDEV_STATS_LEN + \
 				FM10K_MBX_STATS_LEN)
 
+
 static const char fm10k_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Mailbox test (on/offline)"
 };
@@ -145,12 +154,10 @@ enum fm10k_self_test_types {
 };
 
 enum {
-	FM10K_PRV_FLAG_DEBUG_STATS,
 	FM10K_PRV_FLAG_LEN,
 };
 
 static const char fm10k_prv_flags[FM10K_PRV_FLAG_LEN][ETH_GSTRING_LEN] = {
-	"debug-statistics",
 };
 
 static void fm10k_add_stat_strings(char **p, const char *prefix,
@@ -169,7 +176,6 @@ static void fm10k_add_stat_strings(char **p, const char *prefix,
 static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_iov_data *iov_data = interface->iov_data;
 	char *p = (char *)data;
 	unsigned int i;
 
@@ -179,10 +185,6 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 	fm10k_add_stat_strings(&p, "", fm10k_gstrings_global_stats,
 			       FM10K_GLOBAL_STATS_LEN);
 
-	if (interface->flags & FM10K_FLAG_DEBUG_STATS)
-		fm10k_add_stat_strings(&p, "", fm10k_gstrings_debug_stats,
-				       FM10K_DEBUG_STATS_LEN);
-
 	fm10k_add_stat_strings(&p, "", fm10k_gstrings_mbx_stats,
 			       FM10K_MBX_STATS_LEN);
 
@@ -190,26 +192,18 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
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
-		snprintf(p, ETH_GSTRING_LEN, "tx_queue_%u_packets", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "tx_queue_%u_bytes", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_packets", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_bytes", i);
-		p += ETH_GSTRING_LEN;
+		char prefix[ETH_GSTRING_LEN];
+
+		snprintf(prefix, ETH_GSTRING_LEN, "tx_queue_%u_", i);
+		fm10k_add_stat_strings(&p, prefix,
+				       fm10k_gstrings_queue_stats,
+				       FM10K_QUEUE_STATS_LEN);
+
+		snprintf(prefix, ETH_GSTRING_LEN, "rx_queue_%u_", i);
+		fm10k_add_stat_strings(&p, prefix,
+				       fm10k_gstrings_queue_stats,
+				       FM10K_QUEUE_STATS_LEN);
 	}
 }
 
@@ -236,7 +230,6 @@ static void fm10k_get_strings(struct net_device *dev,
 static int fm10k_get_sset_count(struct net_device *dev, int sset)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_iov_data *iov_data = interface->iov_data;
 	struct fm10k_hw *hw = &interface->hw;
 	int stats_len = FM10K_STATIC_STATS_LEN;
 
@@ -244,19 +237,11 @@ static int fm10k_get_sset_count(struct net_device *dev, int sset)
 	case ETH_SS_TEST:
 		return FM10K_TEST_LEN;
 	case ETH_SS_STATS:
-		stats_len += FM10K_QUEUE_STATS_LEN(hw->mac.max_queues);
+		stats_len += hw->mac.max_queues * 2 * FM10K_QUEUE_STATS_LEN;
 
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
@@ -304,11 +289,9 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 				    struct ethtool_stats __always_unused *stats,
 				    u64 *data)
 {
-	const int stat_count = sizeof(struct fm10k_queue_stats) / sizeof(u64);
 	struct fm10k_intfc *interface = netdev_priv(netdev);
-	struct fm10k_iov_data *iov_data = interface->iov_data;
 	struct net_device_stats *net_stats = &netdev->stats;
-	int i, j;
+	int i;
 
 	fm10k_update_stats(interface);
 
@@ -318,11 +301,6 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
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
@@ -333,33 +311,18 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
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
-		u64 *queue_stat;
 
 		ring = interface->tx_ring[i];
-		if (ring)
-			queue_stat = (u64 *)&ring->stats;
-		for (j = 0; j < stat_count; j++)
-			*(data++) = ring ? queue_stat[j] : 0;
+		fm10k_add_ethtool_stats(&data, ring,
+					fm10k_gstrings_queue_stats,
+					FM10K_QUEUE_STATS_LEN);
 
 		ring = interface->rx_ring[i];
-		if (ring)
-			queue_stat = (u64 *)&ring->stats;
-		for (j = 0; j < stat_count; j++)
-			*(data++) = ring ? queue_stat[j] : 0;
+		fm10k_add_ethtool_stats(&data, ring,
+					fm10k_gstrings_queue_stats,
+					FM10K_QUEUE_STATS_LEN);
 	}
 }
 
@@ -1003,27 +966,14 @@ static void fm10k_self_test(struct net_device *dev,
 
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

