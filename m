From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Apr 2018 11:15:56 -0700
Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: use variadic arguments to
 fm10k_add_stat_strings
In-Reply-To: <20180412181559.4343-1-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
Message-ID: <20180412181559.4343-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of using a fixed prefix string we setup before each call to
fm10k_add_stat_strings, modify the helper to take variadic arguments and
pass them to vsnprintf. This requires changing the fm10k_stat strings to
take % format specifiers where necessary, but the resulting code is much
simpler.

Change-Id: I8055adeae0d63c227024c007c2ff51d0ee495238
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Title: use variadic arguments to fm10k_add_stat_strings
Change-type: ImplementationChange
Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/198022
Tested-by: nosbuild <nosbuild@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 53 ++++++++++++------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 339915400a03..26bf2322f457 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -24,6 +24,11 @@
 #include "fm10k.h"
 
 struct fm10k_stats {
+	/* The stat_string is expected to be a format string formatted using
+	 * vsnprintf by fm10k_add_stat_strings. Every member of a stats array
+	 * should use the same format specifiers as they will be formatted
+	 * using the same variadic arguments.
+	 */
 	char stat_string[ETH_GSTRING_LEN];
 	int sizeof_stat;
 	int stat_offset;
@@ -111,15 +116,13 @@ static const struct fm10k_stats fm10k_gstrings_mbx_stats[] = {
 	FM10K_MBX_STAT("mbx_rx_mbmem_pushed", rx_mbmem_pushed),
 };
 
-#define FM10K_QUEUE_STAT(_name, _stat) { \
-	.stat_string = _name, \
-	.sizeof_stat = FIELD_SIZEOF(struct fm10k_ring, _stat), \
-	.stat_offset = offsetof(struct fm10k_ring, _stat) \
-}
+/* per-queue ring statistics */
+#define FM10K_QUEUE_STAT(_name, _stat) \
+	FM10K_STAT_FIELDS(struct fm10k_ring, _name, _stat)
 
 static const struct fm10k_stats fm10k_gstrings_queue_stats[] = {
-	FM10K_QUEUE_STAT("packets", stats.packets),
-	FM10K_QUEUE_STAT("bytes", stats.bytes),
+	FM10K_QUEUE_STAT("%s_queue_%u_packets", stats.packets),
+	FM10K_QUEUE_STAT("%s_queue_%u_bytes", stats.bytes),
 };
 
 #define FM10K_GLOBAL_STATS_LEN ARRAY_SIZE(fm10k_gstrings_global_stats)
@@ -149,16 +152,18 @@ enum {
 static const char fm10k_prv_flags[FM10K_PRV_FLAG_LEN][ETH_GSTRING_LEN] = {
 };
 
-static void fm10k_add_stat_strings(u8 **p, const char *prefix,
-				   const struct fm10k_stats stats[],
-				   const unsigned int size)
+static void fm10k_add_stat_strings(u8 **p, const struct fm10k_stats stats[],
+				   const unsigned int size, ...)
 {
 	unsigned int i;
 
 	for (i = 0; i < size; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s%s",
-			 prefix, stats[i].stat_string);
+		va_list args;
+
+		va_start(args, size);
+		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
 		*p += ETH_GSTRING_LEN;
+		va_end(args);
 	}
 }
 
@@ -167,31 +172,27 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	unsigned int i;
 
-	fm10k_add_stat_strings(&data, "", fm10k_gstrings_net_stats,
+	fm10k_add_stat_strings(&data, fm10k_gstrings_net_stats,
 			       FM10K_NETDEV_STATS_LEN);
 
-	fm10k_add_stat_strings(&data, "", fm10k_gstrings_global_stats,
+	fm10k_add_stat_strings(&data, fm10k_gstrings_global_stats,
 			       FM10K_GLOBAL_STATS_LEN);
 
-	fm10k_add_stat_strings(&data, "", fm10k_gstrings_mbx_stats,
+	fm10k_add_stat_strings(&data, fm10k_gstrings_mbx_stats,
 			       FM10K_MBX_STATS_LEN);
 
 	if (interface->hw.mac.type != fm10k_mac_vf)
-		fm10k_add_stat_strings(&data, "", fm10k_gstrings_pf_stats,
+		fm10k_add_stat_strings(&data, fm10k_gstrings_pf_stats,
 				       FM10K_PF_STATS_LEN);
 
 	for (i = 0; i < interface->hw.mac.max_queues; i++) {
-		char prefix[ETH_GSTRING_LEN];
+		fm10k_add_stat_strings(&data, fm10k_gstrings_queue_stats,
+				       FM10K_QUEUE_STATS_LEN,
+				       "tx", i);
 
-		snprintf(prefix, ETH_GSTRING_LEN, "tx_queue_%u_", i);
-		fm10k_add_stat_strings(&data, prefix,
-				       fm10k_gstrings_queue_stats,
-				       FM10K_QUEUE_STATS_LEN);
-
-		snprintf(prefix, ETH_GSTRING_LEN, "rx_queue_%u_", i);
-		fm10k_add_stat_strings(&data, prefix,
-				       fm10k_gstrings_queue_stats,
-				       FM10K_QUEUE_STATS_LEN);
+		fm10k_add_stat_strings(&data, fm10k_gstrings_queue_stats,
+				       FM10K_QUEUE_STATS_LEN,
+				       "rx", i);
 	}
 }
 
-- 
2.15.1.478.ga1e07cd25f8b

