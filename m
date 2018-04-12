From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Apr 2018 11:15:57 -0700
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: use macro to avoid passing the
 array and size separately
In-Reply-To: <20180412181559.4343-1-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
Message-ID: <20180412181559.4343-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Avoid potential bugs with fm10k_add_stat_strings and
fm10k_add_ethtool_stats by using a macro to calculate the ARRAY_SIZE
when passing. This helps ensure that the size is always correct.

Note that it assumes we only pass static const fm10k_stat arrays, and
that evaluation of the argument won't have side effects.

Change-Id: Id9396eef12cbab51a2559db80782e33fb20df274
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Title: use macro to avoid passing the array and size separately
Change-type: ImplementationChange
Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/198023
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 48 +++++++++++-------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 26bf2322f457..e7e0e3c82fb2 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -152,8 +152,8 @@ enum {
 static const char fm10k_prv_flags[FM10K_PRV_FLAG_LEN][ETH_GSTRING_LEN] = {
 };
 
-static void fm10k_add_stat_strings(u8 **p, const struct fm10k_stats stats[],
-				   const unsigned int size, ...)
+static void __fm10k_add_stat_strings(u8 **p, const struct fm10k_stats stats[],
+				     const unsigned int size, ...)
 {
 	unsigned int i;
 
@@ -167,31 +167,28 @@ static void fm10k_add_stat_strings(u8 **p, const struct fm10k_stats stats[],
 	}
 }
 
+#define fm10k_add_stat_strings(p, stats, ...) \
+	__fm10k_add_stat_strings(p, stats, ARRAY_SIZE(stats), ## __VA_ARGS__)
+
 static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	unsigned int i;
 
-	fm10k_add_stat_strings(&data, fm10k_gstrings_net_stats,
-			       FM10K_NETDEV_STATS_LEN);
+	fm10k_add_stat_strings(&data, fm10k_gstrings_net_stats);
 
-	fm10k_add_stat_strings(&data, fm10k_gstrings_global_stats,
-			       FM10K_GLOBAL_STATS_LEN);
+	fm10k_add_stat_strings(&data, fm10k_gstrings_global_stats);
 
-	fm10k_add_stat_strings(&data, fm10k_gstrings_mbx_stats,
-			       FM10K_MBX_STATS_LEN);
+	fm10k_add_stat_strings(&data, fm10k_gstrings_mbx_stats);
 
 	if (interface->hw.mac.type != fm10k_mac_vf)
-		fm10k_add_stat_strings(&data, fm10k_gstrings_pf_stats,
-				       FM10K_PF_STATS_LEN);
+		fm10k_add_stat_strings(&data, fm10k_gstrings_pf_stats);
 
 	for (i = 0; i < interface->hw.mac.max_queues; i++) {
 		fm10k_add_stat_strings(&data, fm10k_gstrings_queue_stats,
-				       FM10K_QUEUE_STATS_LEN,
 				       "tx", i);
 
 		fm10k_add_stat_strings(&data, fm10k_gstrings_queue_stats,
-				       FM10K_QUEUE_STATS_LEN,
 				       "rx", i);
 	}
 }
@@ -237,9 +234,9 @@ static int fm10k_get_sset_count(struct net_device *dev, int sset)
 	}
 }
 
-static void fm10k_add_ethtool_stats(u64 **data, void *pointer,
-				    const struct fm10k_stats stats[],
-				    const unsigned int size)
+static void __fm10k_add_ethtool_stats(u64 **data, void *pointer,
+				      const struct fm10k_stats stats[],
+				      const unsigned int size)
 {
 	unsigned int i;
 	char *p;
@@ -273,6 +270,9 @@ static void fm10k_add_ethtool_stats(u64 **data, void *pointer,
 	}
 }
 
+#define fm10k_add_ethtool_stats(data, pointer, stats) \
+	__fm10k_add_ethtool_stats(data, pointer, stats, ARRAY_SIZE(stats))
+
 static void fm10k_get_ethtool_stats(struct net_device *netdev,
 				    struct ethtool_stats __always_unused *stats,
 				    u64 *data)
@@ -283,20 +283,16 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 
 	fm10k_update_stats(interface);
 
-	fm10k_add_ethtool_stats(&data, net_stats, fm10k_gstrings_net_stats,
-				FM10K_NETDEV_STATS_LEN);
+	fm10k_add_ethtool_stats(&data, net_stats, fm10k_gstrings_net_stats);
 
-	fm10k_add_ethtool_stats(&data, interface, fm10k_gstrings_global_stats,
-				FM10K_GLOBAL_STATS_LEN);
+	fm10k_add_ethtool_stats(&data, interface, fm10k_gstrings_global_stats);
 
 	fm10k_add_ethtool_stats(&data, &interface->hw.mbx,
-				fm10k_gstrings_mbx_stats,
-				FM10K_MBX_STATS_LEN);
+				fm10k_gstrings_mbx_stats);
 
 	if (interface->hw.mac.type != fm10k_mac_vf) {
 		fm10k_add_ethtool_stats(&data, interface,
-					fm10k_gstrings_pf_stats,
-					FM10K_PF_STATS_LEN);
+					fm10k_gstrings_pf_stats);
 	}
 
 	for (i = 0; i < interface->hw.mac.max_queues; i++) {
@@ -304,13 +300,11 @@ static void fm10k_get_ethtool_stats(struct net_device *netdev,
 
 		ring = interface->tx_ring[i];
 		fm10k_add_ethtool_stats(&data, ring,
-					fm10k_gstrings_queue_stats,
-					FM10K_QUEUE_STATS_LEN);
+					fm10k_gstrings_queue_stats);
 
 		ring = interface->rx_ring[i];
 		fm10k_add_ethtool_stats(&data, ring,
-					fm10k_gstrings_queue_stats,
-					FM10K_QUEUE_STATS_LEN);
+					fm10k_gstrings_queue_stats);
 	}
 }
 
-- 
2.15.1.478.ga1e07cd25f8b

