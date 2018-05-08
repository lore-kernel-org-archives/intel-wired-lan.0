From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  8 May 2018 11:09:57 -0700
Subject: [Intel-wired-lan] [PATCH v2] fm10k: reduce duplicate fm10k_stat
 macro code
Message-ID: <20180508180957.6923-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Share some of the code for setting up fm10k_stat macros by implementing
an FM10K_STAT_FIELDS macro which we can use when setting up the type
specific macros.

Change-Id: Ifeedfafa4707cbeb4fac818ed6672eb1db268e1a
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Title: reduce duplicate fm10k_stat macro code
Change-type: ImplementationChange
Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/198021
---

Changes in v2
* use __stringify() macro in definition of FM10K_NETDEV_STAT

 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index eeac2b75a195..73fe7bec8c3d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -11,12 +11,18 @@ struct fm10k_stats {
 	int stat_offset;
 };
 
-#define FM10K_NETDEV_STAT(_net_stat) { \
-	.stat_string = #_net_stat, \
-	.sizeof_stat = FIELD_SIZEOF(struct net_device_stats, _net_stat), \
-	.stat_offset = offsetof(struct net_device_stats, _net_stat) \
+#define FM10K_STAT_FIELDS(_type, _name, _stat) { \
+	.stat_string = _name, \
+	.sizeof_stat = FIELD_SIZEOF(_type, _stat), \
+	.stat_offset = offsetof(_type, _stat) \
 }
 
+/* netdevice statistics */
+#define FM10K_NETDEV_STAT(_net_stat) \
+	FM10K_STAT_FIELDS(struct net_device_stats, \
+			  __stringify(_net_stat), \
+			  _net_stat)
+
 static const struct fm10k_stats fm10k_gstrings_net_stats[] = {
 	FM10K_NETDEV_STAT(tx_packets),
 	FM10K_NETDEV_STAT(tx_bytes),
@@ -34,11 +40,9 @@ static const struct fm10k_stats fm10k_gstrings_net_stats[] = {
 
 #define FM10K_NETDEV_STATS_LEN	ARRAY_SIZE(fm10k_gstrings_net_stats)
 
-#define FM10K_STAT(_name, _stat) { \
-	.stat_string = _name, \
-	.sizeof_stat = FIELD_SIZEOF(struct fm10k_intfc, _stat), \
-	.stat_offset = offsetof(struct fm10k_intfc, _stat) \
-}
+/* General interface statistics */
+#define FM10K_STAT(_name, _stat) \
+	FM10K_STAT_FIELDS(struct fm10k_intfc, _name, _stat)
 
 static const struct fm10k_stats fm10k_gstrings_global_stats[] = {
 	FM10K_STAT("tx_restart_queue", restart_queue),
@@ -75,11 +79,9 @@ static const struct fm10k_stats fm10k_gstrings_pf_stats[] = {
 	FM10K_STAT("nodesc_drop", stats.nodesc_drop.count),
 };
 
-#define FM10K_MBX_STAT(_name, _stat) { \
-	.stat_string = _name, \
-	.sizeof_stat = FIELD_SIZEOF(struct fm10k_mbx_info, _stat), \
-	.stat_offset = offsetof(struct fm10k_mbx_info, _stat) \
-}
+/* mailbox statistics */
+#define FM10K_MBX_STAT(_name, _stat) \
+	FM10K_STAT_FIELDS(struct fm10k_mbx_info, _name, _stat)
 
 static const struct fm10k_stats fm10k_gstrings_mbx_stats[] = {
 	FM10K_MBX_STAT("mbx_tx_busy", tx_busy),
-- 
2.17.0.536.g43f547f64b90

