From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  1 Apr 2016 11:15:09 -0700
Subject: [Intel-wired-lan] [PATCH v7] fm10k: add helper functions to set
	strings and data for ethtool stats
In-Reply-To: <1459534509-4972-1-git-send-email-jacob.e.keller@intel.com>
References: <1459534509-4972-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1459534509-4972-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce duplicate code and the amount of indentation by adding
fm10k_add_stat_strings and fm10k_add_ethtool_stats functions which help
add fm10k_stat structures to the ethtool stats callbacks. This helps
increase ease of use for future stat additions, and increases code
readability.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

This is a resend of 74bf40286439 ("fm10k: add helper functions to set
strings and data for ethtool stats", 2016-03-25). It likely has
dependencies on later patches in the queue, which should have no impact
on this change but will need to be kept in order.

Notes:
    Changes in v7
    - fix copy-paste error of packets, so that the per queue
      stats show bytes and packets correctly

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 219 ++++++++++++-----------
 1 file changed, 115 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 724f5d6566c7..f331966ac9df 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -121,13 +121,22 @@ static const struct fm10k_stats fm10k_gstrings_mbx_stats[] = {
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
+	FM10K_QUEUE_STAT("bytes", stats.bytes),
+};
+
 #define FM10K_GLOBAL_STATS_LEN ARRAY_SIZE(fm10k_gstrings_global_stats)
 #define FM10K_DEBUG_STATS_LEN ARRAY_SIZE(fm10k_gstrings_debug_stats)
 #define FM10K_PF_STATS_LEN ARRAY_SIZE(fm10k_gstrings_pf_stats)
 #define FM10K_MBX_STATS_LEN ARRAY_SIZE(fm10k_gstrings_mbx_stats)
-
-#define FM10K_QUEUE_STATS_LEN(_n) \
-	((_n) * 2 * (sizeof(struct fm10k_queue_stats) / sizeof(u64)))
+#define FM10K_QUEUE_STATS_LEN ARRAY_SIZE(fm10k_gstrings_queue_stats)
 
 #define FM10K_STATIC_STATS_LEN (FM10K_GLOBAL_STATS_LEN + \
 				FM10K_NETDEV_STATS_LEN + \
@@ -153,69 +162,66 @@ static const char fm10k_prv_flags[FM10K_PRV_FLAG_LEN][ETH_GSTRING_LEN] = {
 	"debug-statistics",
 };
 
+static void fm10k_add_stat_strings(char **p, const char *prefix,
+				   const struct fm10k_stats stats[],
+				   const unsigned int size)
+{
+	unsigned int i;
+
+	for (i = 0; i < size; i++) {
+		snprintf(*p, ETH_GSTRING_LEN, "%s%s",
+			 prefix, stats[i].stat_string);
+		*p += ETH_GSTRING_LEN;
+	}
+}
+
 static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	struct fm10k_iov_data *iov_data = interface->iov_data;
 	char *p = (char *)data;
 	unsigned int i;
-	unsigned int j;
 
-	for (i = 0; i < FM10K_NETDEV_STATS_LEN; i++) {
-		memcpy(p, fm10k_gstrings_net_stats[i].stat_string,
-		       ETH_GSTRING_LEN);
-		p += ETH_GSTRING_LEN;
-	}
+	fm10k_add_stat_strings(&p, "", fm10k_gstrings_net_stats,
+			       FM10K_NETDEV_STATS_LEN);
 
-	for (i = 0; i < FM10K_GLOBAL_STATS_LEN; i++) {
-		memcpy(p, fm10k_gstrings_global_stats[i].stat_string,
-		       ETH_GSTRING_LEN);
-		p += ETH_GSTRING_LEN;
-	}
+	fm10k_add_stat_strings(&p, "", fm10k_gstrings_global_stats,
+			       FM10K_GLOBAL_STATS_LEN);
 
-	if (interface->flags & FM10K_FLAG_DEBUG_STATS) {
-		for (i = 0; i < FM10K_DEBUG_STATS_LEN; i++) {
-			memcpy(p, fm10k_gstrings_debug_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
-	}
+	if (interface->flags & FM10K_FLAG_DEBUG_STATS)
+		fm10k_add_stat_strings(&p, "", fm10k_gstrings_debug_stats,
+				       FM10K_DEBUG_STATS_LEN);
 
-	for (i = 0; i < FM10K_MBX_STATS_LEN; i++) {
-		memcpy(p, fm10k_gstrings_mbx_stats[i].stat_string,
-		       ETH_GSTRING_LEN);
-		p += ETH_GSTRING_LEN;
-	}
+	fm10k_add_stat_strings(&p, "", fm10k_gstrings_mbx_stats,
+			       FM10K_MBX_STATS_LEN);
 
-	if (interface->hw.mac.type != fm10k_mac_vf) {
-		for (i = 0; i < FM10K_PF_STATS_LEN; i++) {
-			memcpy(p, fm10k_gstrings_pf_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
-	}
+	if (interface->hw.mac.type != fm10k_mac_vf)
+		fm10k_add_stat_strings(&p, "", fm10k_gstrings_pf_stats,
+				       FM10K_PF_STATS_LEN);
 
 	if ((interface->flags & FM10K_FLAG_DEBUG_STATS) && iov_data) {
 		for (i = 0; i < iov_data->num_vfs; i++) {
-			for (j = 0; j < FM10K_MBX_STATS_LEN; j++) {
-				snprintf(p,
-					 ETH_GSTRING_LEN,
-					 "vf_%u_%s", i,
-					 fm10k_gstrings_mbx_stats[j].stat_string);
-				p += ETH_GSTRING_LEN;
-			}
+			char prefix[ETH_GSTRING_LEN];
+
+			snprintf(prefix, ETH_GSTRING_LEN, "vf_%u_", i);
+			fm10k_add_stat_strings(&p, prefix,
+					       fm10k_gstrings_mbx_stats,
+					       FM10K_MBX_STATS_LEN);
 		}
 	}
 
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
 
@@ -250,7 +256,7 @@ static int fm10k_get_sset_count(struct net_device *dev, int sset)
 	case ETH_SS_TEST:
 		return FM10K_TEST_LEN;
 	case ETH_SS_STATS:
-		stats_len += FM10K_QUEUE_STATS_LEN(hw->mac.max_queues);
+		stats_len += hw->mac.max_queues * 2 * FM10K_QUEUE_STATS_LEN;
 
 		if (hw->mac.type != fm10k_mac_vf)
 			stats_len += FM10K_PF_STATS_LEN;
@@ -271,55 +277,72 @@ static int fm10k_get_sset_count(struct net_device *dev, int sset)
 	}
 }
 
+static void fm10k_add_ethtool_stats(u64 **data, void *pointer,
+				    const struct fm10k_stats stats[],
+				    const unsigned int size)
+{
+	unsigned int i;
+	char *p;
+
+	if (!pointer) {
+		/* memory is not zero allocated so we have to clear it */
+		for (i = 0; i < size; i++)
+			*((*data)++) = 0;
+		return;
+	}
+
+	for (i = 0; i < size; i++) {
+		p = (char *)pointer + stats[i].stat_offset;
+
+		switch (stats[i].sizeof_stat) {
+		case sizeof(u64):
+			*((*data)++) = *(u64 *)p;
+			break;
+		case sizeof(u32):
+			*((*data)++) = *(u32 *)p;
+			break;
+		case sizeof(u16):
+			*((*data)++) = *(u16 *)p;
+			break;
+		case sizeof(u8):
+			*((*data)++) = *(u8 *)p;
+			break;
+		default:
+			*((*data)++) = 0;
+		}
+	}
+}
+
 static void fm10k_get_ethtool_stats(struct net_device *netdev,
 				    struct ethtool_stats __always_unused *stats,
 				    u64 *data)
 {
-	const int stat_count = sizeof(struct fm10k_queue_stats) / sizeof(u64);
 	struct fm10k_intfc *interface = netdev_priv(netdev);
 	struct fm10k_iov_data *iov_data = interface->iov_data;
 	struct net_device_stats *net_stats = &netdev->stats;
-	char *p;
-	int i, j;
+	int i;
 
 	fm10k_update_stats(interface);
 
-	for (i = 0; i < FM10K_NETDEV_STATS_LEN; i++) {
-		p = (char *)net_stats + fm10k_gstrings_net_stats[i].stat_offset;
-		*(data++) = (fm10k_gstrings_net_stats[i].sizeof_stat ==
-			sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
-	}
+	fm10k_add_ethtool_stats(&data, net_stats, fm10k_gstrings_net_stats,
+				FM10K_NETDEV_STATS_LEN);
 
-	for (i = 0; i < FM10K_GLOBAL_STATS_LEN; i++) {
-		p = (char *)interface +
-		    fm10k_gstrings_global_stats[i].stat_offset;
-		*(data++) = (fm10k_gstrings_global_stats[i].sizeof_stat ==
-			sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
-	}
+	fm10k_add_ethtool_stats(&data, interface, fm10k_gstrings_global_stats,
+				FM10K_GLOBAL_STATS_LEN);
 
-	if (interface->flags & FM10K_FLAG_DEBUG_STATS) {
-		for (i = 0; i < FM10K_DEBUG_STATS_LEN; i++) {
-			p = (char *)interface +
-				fm10k_gstrings_debug_stats[i].stat_offset;
-			*(data++) = (fm10k_gstrings_debug_stats[i].sizeof_stat ==
-				     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
-		}
-	}
+	if (interface->flags & FM10K_FLAG_DEBUG_STATS)
+		fm10k_add_ethtool_stats(&data, interface,
+					fm10k_gstrings_debug_stats,
+					FM10K_DEBUG_STATS_LEN);
 
-	for (i = 0; i < FM10K_MBX_STATS_LEN; i++) {
-		p = (char *)&interface->hw.mbx +
-			fm10k_gstrings_mbx_stats[i].stat_offset;
-		*(data++) = (fm10k_gstrings_mbx_stats[i].sizeof_stat ==
-			sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
-	}
+	fm10k_add_ethtool_stats(&data, &interface->hw.mbx,
+				fm10k_gstrings_mbx_stats,
+				FM10K_MBX_STATS_LEN);
 
 	if (interface->hw.mac.type != fm10k_mac_vf) {
-		for (i = 0; i < FM10K_PF_STATS_LEN; i++) {
-			p = (char *)interface +
-			    fm10k_gstrings_pf_stats[i].stat_offset;
-			*(data++) = (fm10k_gstrings_pf_stats[i].sizeof_stat ==
-				     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
-		}
+		fm10k_add_ethtool_stats(&data, interface,
+					fm10k_gstrings_pf_stats,
+					FM10K_PF_STATS_LEN);
 	}
 
 	if ((interface->flags & FM10K_FLAG_DEBUG_STATS) && iov_data) {
@@ -328,36 +351,24 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 
 			vf_info = &iov_data->vf_info[i];
 
-			/* skip stats if we don't have a vf info */
-			if (!vf_info) {
-				data += FM10K_MBX_STATS_LEN;
-				continue;
-			}
-
-			for (j = 0; j < FM10K_MBX_STATS_LEN; j++) {
-				p = (char *)&vf_info->mbx +
-					fm10k_gstrings_mbx_stats[j].stat_offset;
-				*(data++) = (fm10k_gstrings_mbx_stats[j].sizeof_stat ==
-					     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
-			}
+			fm10k_add_ethtool_stats(&data, &vf_info->mbx,
+						fm10k_gstrings_mbx_stats,
+						FM10K_MBX_STATS_LEN);
 		}
 	}
 
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
 
-- 
2.8.0.rc1.177.g5628860

