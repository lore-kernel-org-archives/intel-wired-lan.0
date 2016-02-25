From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 25 Feb 2016 15:56:44 -0800
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use fm10k_stats structures for
	per-queue statistics
Message-ID: <1456444604-5597-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This will allow us numerous advantages, including

(a) rework the per-queue stats to only display active queues, reducing
    clutter on the output. This is important since we often don't have
    all possible queues enabled.

(b) use the new streamlined helper functions, reducing duplicate code
    and increasing readability of the stats logic

(c) add the additional per-tx and per-rx statistics when
    debug-statistics is enabled, which may be helpful for future debug
    work.

The primary motivation for this change is (a), though (b) and (c) are
useful additions which were noticed while developing the change.

Note that this code currently assumes we have the same number of Tx and
Rx queues which should be true of our driver pretty much always. Even if
there are a non equal number of Tx and Rx queues, the only result will
be a few extra statistics displaying 0s. This is better than the current
setup which shows every disabled queue with all 0s.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
This is a direct replacement for what is on the queue now, and removes
the extraneous space added on accident.

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 117 ++++++++++++++++++-----
 1 file changed, 92 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index c67121cc7b23..4eb90317f83a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -121,18 +121,52 @@ static const struct fm10k_stats fm10k_gstrings_mbx_stats[] = {
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
+static const struct fm10k_stats fm10k_gstrings_tx_queue_stats[] = {
+	FM10K_QUEUE_STAT("restart_queue", tx_stats.restart_queue),
+	FM10K_QUEUE_STAT("csum_err", tx_stats.restart_queue),
+	FM10K_QUEUE_STAT("tx_busy", tx_stats.restart_queue),
+	FM10K_QUEUE_STAT("tx_done_old", tx_stats.restart_queue),
+	FM10K_QUEUE_STAT("csum_good", tx_stats.restart_queue),
+};
+
+static const struct fm10k_stats fm10k_gstrings_rx_queue_stats[] = {
+	FM10K_QUEUE_STAT("alloc_failed", rx_stats.alloc_failed),
+	FM10K_QUEUE_STAT("csum_err", rx_stats.csum_err),
+	FM10K_QUEUE_STAT("errors", rx_stats.errors),
+	FM10K_QUEUE_STAT("csum_good", rx_stats.csum_good),
+	FM10K_QUEUE_STAT("switch_errors", rx_stats.switch_errors),
+	FM10K_QUEUE_STAT("drops", rx_stats.drops),
+	FM10K_QUEUE_STAT("pp_errors", rx_stats.pp_errors),
+	FM10K_QUEUE_STAT("link_errors", rx_stats.link_errors),
+	FM10K_QUEUE_STAT("length_errors", rx_stats.length_errors),
+
+};
+
 #define FM10K_GLOBAL_STATS_LEN ARRAY_SIZE(fm10k_gstrings_global_stats)
 #define FM10K_DEBUG_STATS_LEN ARRAY_SIZE(fm10k_gstrings_debug_stats)
 #define FM10K_PF_STATS_LEN ARRAY_SIZE(fm10k_gstrings_pf_stats)
 #define FM10K_MBX_STATS_LEN ARRAY_SIZE(fm10k_gstrings_mbx_stats)
 
-#define FM10K_QUEUE_STATS_LEN(_n) \
-	((_n) * 2 * (sizeof(struct fm10k_queue_stats) / sizeof(u64)))
-
 #define FM10K_STATIC_STATS_LEN (FM10K_GLOBAL_STATS_LEN + \
 				FM10K_NETDEV_STATS_LEN + \
 				FM10K_MBX_STATS_LEN)
 
+/* non-static stats based on number of Tx/Rx queues */
+#define FM10K_QUEUE_STATS_LEN ARRAY_SIZE(fm10k_gstrings_queue_stats)
+#define FM10K_TX_QUEUE_STATS_LEN ARRAY_SIZE(fm10k_gstrings_tx_queue_stats)
+#define FM10K_RX_QUEUE_STATS_LEN ARRAY_SIZE(fm10k_gstrings_rx_queue_stats)
+
 static const char fm10k_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Mailbox test (on/offline)"
 };
@@ -153,6 +187,11 @@ static const char fm10k_prv_flags[FM10K_PRV_FLAG_LEN][ETH_GSTRING_LEN] = {
 	"debug-statistics",
 };
 
+static unsigned int fm10k_queues_in_use(struct fm10k_intfc *interface)
+{
+	return max(interface->num_tx_queues, interface->num_rx_queues);
+}
+
 static void fm10k_add_stat_strings(char **p, const char *prefix,
 				   const struct fm10k_stats stats[],
 				   const unsigned int size)
@@ -201,15 +240,30 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 		}
 	}
 
-	for (i = 0; i < interface->hw.mac.max_queues; i++) {
-		snprintf(p, ETH_GSTRING_LEN, "tx_queue_%u_packets", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "tx_queue_%u_bytes", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_packets", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_bytes", i);
-		p += ETH_GSTRING_LEN;
+	for (i = 0; i < fm10k_queues_in_use(interface); i++) {
+		char prefix[ETH_GSTRING_LEN];
+
+		snprintf(prefix, ETH_GSTRING_LEN, "tx_queue_%u_", i);
+		fm10k_add_stat_strings(&p, prefix,
+				       fm10k_gstrings_queue_stats,
+				       FM10K_QUEUE_STATS_LEN);
+
+		if (interface->flags & FM10K_FLAG_DEBUG_STATS) {
+			fm10k_add_stat_strings(&p, prefix,
+					       fm10k_gstrings_tx_queue_stats,
+					       FM10K_TX_QUEUE_STATS_LEN);
+		}
+
+		snprintf(prefix, ETH_GSTRING_LEN, "rx_queue_%u_", i);
+		fm10k_add_stat_strings(&p, prefix,
+				       fm10k_gstrings_queue_stats,
+				       FM10K_QUEUE_STATS_LEN);
+
+		if (interface->flags & FM10K_FLAG_DEBUG_STATS) {
+			fm10k_add_stat_strings(&p, prefix,
+					       fm10k_gstrings_rx_queue_stats,
+					       FM10K_RX_QUEUE_STATS_LEN);
+		}
 	}
 }
 
@@ -239,12 +293,14 @@ static int fm10k_get_sset_count(struct net_device *dev, int sset)
 	struct fm10k_iov_data *iov_data = interface->iov_data;
 	struct fm10k_hw *hw = &interface->hw;
 	int stats_len = FM10K_STATIC_STATS_LEN;
+	int tx_queues = interface->num_tx_queues;
+	int rx_queues = interface->num_rx_queues;
 
 	switch (sset) {
 	case ETH_SS_TEST:
 		return FM10K_TEST_LEN;
 	case ETH_SS_STATS:
-		stats_len += FM10K_QUEUE_STATS_LEN(hw->mac.max_queues);
+		stats_len += (tx_queues + rx_queues) * FM10K_QUEUE_STATS_LEN;
 
 		if (hw->mac.type != fm10k_mac_vf)
 			stats_len += FM10K_PF_STATS_LEN;
@@ -252,6 +308,9 @@ static int fm10k_get_sset_count(struct net_device *dev, int sset)
 		if (interface->flags & FM10K_FLAG_DEBUG_STATS) {
 			stats_len += FM10K_DEBUG_STATS_LEN;
 
+			stats_len += tx_queues * FM10K_TX_QUEUE_STATS_LEN;
+			stats_len += rx_queues * FM10K_RX_QUEUE_STATS_LEN;
+
 			if (iov_data)
 				stats_len += FM10K_MBX_STATS_LEN *
 					iov_data->num_vfs;
@@ -304,11 +363,10 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 				    struct ethtool_stats __always_unused *stats,
 				    u64 *data)
 {
-	const int stat_count = sizeof(struct fm10k_queue_stats) / sizeof(u64);
 	struct fm10k_intfc *interface = netdev_priv(netdev);
 	struct fm10k_iov_data *iov_data = interface->iov_data;
 	struct net_device_stats *net_stats = &netdev->stats;
-	int i, j;
+	int i;
 
 	fm10k_update_stats(interface);
 
@@ -345,21 +403,30 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 		}
 	}
 
-	for (i = 0; i < interface->hw.mac.max_queues; i++) {
+	for (i = 0; i < fm10k_queues_in_use(interface); i++) {
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
+
+		if (interface->flags & FM10K_FLAG_DEBUG_STATS) {
+			fm10k_add_ethtool_stats(&data, ring,
+						fm10k_gstrings_tx_queue_stats,
+						FM10K_TX_QUEUE_STATS_LEN);
+		}
 
 		ring = interface->rx_ring[i];
-		if (ring)
-			queue_stat = (u64 *)&ring->stats;
-		for (j = 0; j < stat_count; j++)
-			*(data++) = ring ? queue_stat[j] : 0;
+		fm10k_add_ethtool_stats(&data, ring,
+					fm10k_gstrings_queue_stats,
+					FM10K_QUEUE_STATS_LEN);
+
+		if (interface->flags & FM10K_FLAG_DEBUG_STATS) {
+			fm10k_add_ethtool_stats(&data, ring,
+						fm10k_gstrings_rx_queue_stats,
+						FM10K_RX_QUEUE_STATS_LEN);
+		}
 	}
 }
 
-- 
2.7.1.429.g45cd78e

