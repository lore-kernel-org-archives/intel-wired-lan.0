From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:41 -0700
Subject: [Intel-wired-lan] [next PATCH S93 04/11] i40e: convert VEB TC stats
 to use an i40e_stats array
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <20180731104148.11896-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The VEB TC stats are currently implemented with separate parsing,
instead of using the i40e_stats array and associated helper functions.
This is likely because the stats rely on embedding the TC number into
the stat name.

Update i40e_add_stat_strings to take variadic arguments, and use these
to vsnprintf the i40e_stats string as a string containing format
specifiers.

Create a stats array for the VEB TC related stats,
i40e_gstrings_veb_tc_stats, and use this along with the helper functions
to remove the specialized boiler plate code.

Always call i40e_add_ethtool_stats for both this array and the general
VEB stats array. This ensures that we zero out any memory in case it was
not zero-allocated for us.

This ultimately results in less boiler plate code for the
i40e_get_stat_strings and i40e_get_ethtool_stats.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 83 +++++++++++++-------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c051afe..52ccafe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -7,6 +7,11 @@
 #include "i40e_diag.h"
 
 struct i40e_stats {
+	/* The stat_string is expected to be a format string formatted using
+	 * vsnprintf by i40e_add_stat_strings. Every member of a stats array
+	 * should use the same format specifiers as they will be formatted
+	 * using the same variadic arguments.
+	 */
 	char stat_string[ETH_GSTRING_LEN];
 	int sizeof_stat;
 	int stat_offset;
@@ -56,6 +61,13 @@ static const struct i40e_stats i40e_gstrings_veb_stats[] = {
 	I40E_VEB_STAT("veb.rx_unknown_protocol", stats.rx_unknown_protocol),
 };
 
+static const struct i40e_stats i40e_gstrings_veb_tc_stats[] = {
+	I40E_VEB_STAT("veb.tc_%u_tx_packets", tc_stats.tc_tx_packets),
+	I40E_VEB_STAT("veb.tc_%u_tx_bytes", tc_stats.tc_tx_bytes),
+	I40E_VEB_STAT("veb.tc_%u_rx_packets", tc_stats.tc_rx_packets),
+	I40E_VEB_STAT("veb.tc_%u_rx_bytes", tc_stats.tc_rx_bytes),
+};
+
 static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("rx_unicast", eth_stats.rx_unicast),
 	I40E_VSI_STAT("tx_unicast", eth_stats.tx_unicast),
@@ -162,16 +174,14 @@ static const struct i40e_stats i40e_gstrings_stats[] = {
 		 FIELD_SIZEOF(struct i40e_pf, stats.priority_xon_tx) + \
 		 FIELD_SIZEOF(struct i40e_pf, stats.priority_xon_2_xoff)) \
 		 / sizeof(u64))
-#define I40E_VEB_TC_STATS_LEN ( \
-		(FIELD_SIZEOF(struct i40e_veb, tc_stats.tc_rx_packets) + \
-		 FIELD_SIZEOF(struct i40e_veb, tc_stats.tc_rx_bytes) + \
-		 FIELD_SIZEOF(struct i40e_veb, tc_stats.tc_tx_packets) + \
-		 FIELD_SIZEOF(struct i40e_veb, tc_stats.tc_tx_bytes)) \
-		 / sizeof(u64))
-#define I40E_VEB_STATS_LEN	ARRAY_SIZE(i40e_gstrings_veb_stats)
-#define I40E_VEB_STATS_TOTAL	(I40E_VEB_STATS_LEN + I40E_VEB_TC_STATS_LEN)
+
+#define I40E_VEB_STATS_LEN	(ARRAY_SIZE(i40e_gstrings_veb_stats) + \
+				 (ARRAY_SIZE(i40e_gstrings_veb_tc_stats) * \
+				  I40E_MAX_TRAFFIC_CLASS))
+
 #define I40E_PF_STATS_LEN(n)	(I40E_GLOBAL_STATS_LEN + \
 				 I40E_PFC_STATS_LEN + \
+				 I40E_VEB_STATS_LEN + \
 				 I40E_VSI_STATS_LEN((n)))
 
 enum i40e_ethtool_test_id {
@@ -1681,7 +1691,7 @@ static int i40e_get_stats_count(struct net_device *netdev)
 	struct i40e_pf *pf = vsi->back;
 
 	if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1)
-		return I40E_PF_STATS_LEN(netdev) + I40E_VEB_STATS_TOTAL;
+		return I40E_PF_STATS_LEN(netdev);
 	else
 		return I40E_VSI_STATS_LEN(netdev);
 }
@@ -1809,8 +1819,10 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	struct i40e_ring *tx_ring, *rx_ring;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
+	struct i40e_veb *veb = pf->veb[pf->lan_veb];
 	unsigned int i;
 	unsigned int start;
+	bool veb_stats;
 
 	i40e_update_stats(vsi);
 
@@ -1855,21 +1867,19 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
 		return;
 
-	if ((pf->lan_veb != I40E_NO_VEB) &&
-	    (pf->flags & I40E_FLAG_VEB_STATS_ENABLED)) {
-		struct i40e_veb *veb = pf->veb[pf->lan_veb];
+	veb_stats = ((pf->lan_veb != I40E_NO_VEB) &&
+		     (pf->flags & I40E_FLAG_VEB_STATS_ENABLED));
 
-		i40e_add_ethtool_stats(&data, veb, i40e_gstrings_veb_stats);
+	/* If veb stats aren't enabled, pass NULL instead of the veb so that
+	 * we initialize stats to zero and update the data pointer
+	 * intelligently
+	 */
+	i40e_add_ethtool_stats(&data, veb_stats ? veb : NULL,
+			       i40e_gstrings_veb_stats);
 
-		for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
-			*(data++) = veb->tc_stats.tc_tx_packets[i];
-			*(data++) = veb->tc_stats.tc_tx_bytes[i];
-			*(data++) = veb->tc_stats.tc_rx_packets[i];
-			*(data++) = veb->tc_stats.tc_rx_bytes[i];
-		}
-	} else {
-		data += I40E_VEB_STATS_TOTAL;
-	}
+	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++)
+		i40e_add_ethtool_stats(&data, veb_stats ? veb : NULL,
+				       i40e_gstrings_veb_tc_stats);
 
 	i40e_add_ethtool_stats(&data, pf, i40e_gstrings_stats);
 
@@ -1891,16 +1901,21 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
  * @stats: stat definitions array
  * @size: size of the stats array
  *
- * Copy the strings described by stats into the buffer pointed@by p.
+ * Format and copy the strings described by stats into the buffer pointed at
+ * by p.
  **/
 static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
-				    const unsigned int size)
+				    const unsigned int size, ...)
 {
 	unsigned int i;
 
 	for (i = 0; i < size; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s", stats[i].stat_string);
+		va_list args;
+
+		va_start(args, size);
+		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
 		*p += ETH_GSTRING_LEN;
+		va_end(args);
 	}
 }
 
@@ -1914,7 +1929,7 @@ static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
  * for it.
  **/
 #define i40e_add_stat_strings(p, stats, ...) \
-	__i40e_add_stat_strings(p, stats, ARRAY_SIZE(stats))
+	__i40e_add_stat_strings(p, stats, ARRAY_SIZE(stats), ## __VA_ARGS__)
 
 /**
  * i40e_get_stat_strings - copy stat strings into supplied buffer
@@ -1953,20 +1968,8 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 
 	i40e_add_stat_strings(&data, i40e_gstrings_veb_stats);
 
-	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
-		snprintf(data, ETH_GSTRING_LEN,
-			 "veb.tc_%u_tx_packets", i);
-		data += ETH_GSTRING_LEN;
-		snprintf(data, ETH_GSTRING_LEN,
-			 "veb.tc_%u_tx_bytes", i);
-		data += ETH_GSTRING_LEN;
-		snprintf(data, ETH_GSTRING_LEN,
-			 "veb.tc_%u_rx_packets", i);
-		data += ETH_GSTRING_LEN;
-		snprintf(data, ETH_GSTRING_LEN,
-			 "veb.tc_%u_rx_bytes", i);
-		data += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++)
+		i40e_add_stat_strings(&data, i40e_gstrings_veb_tc_stats, i);
 
 	i40e_add_stat_strings(&data, i40e_gstrings_stats);
 
-- 
2.9.5

