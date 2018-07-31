From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:38 -0700
Subject: [Intel-wired-lan] [next PATCH S93 01/11] i40e: add helper function
 for copying strings from stat arrays
Message-ID: <20180731104148.11896-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Many of the ethtool statistics use the same basic logic for copying
strings into the supplied buffer. A set of stats are stored in a const
array of i40e_stats structures, and we apply these all together.

Simplify the stats code by introducing a helper function which can take
a stats array and copy the strings into the buffer, updating the buffer
pointer as we go.

We use a macro to implement i40e_add_stat_strings so that ARRAY_SIZE can
be used on the array passed in. This ensures that we always use the
matching size in __i40e_add_stat_strings.

More complex stats currently do not use i40e_stats arrays, usually due
to custom formatted strings, or because the stats are not laid out in
the expected way. These stats will be updated to use the helper function
in separate future patches.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 59 +++++++++++++++++---------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 6947a2a..20e8630 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1816,6 +1816,37 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 }
 
 /**
+ * __i40e_add_stat_strings - copy stat strings into ethtool buffer
+ * @p: ethtool supplied buffer
+ * @stats: stat definitions array
+ * @size: size of the stats array
+ *
+ * Copy the strings described by stats into the buffer pointed at by p.
+ **/
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+				    const unsigned int size)
+{
+	unsigned int i;
+
+	for (i = 0; i < size; i++) {
+		snprintf(*p, ETH_GSTRING_LEN, "%s", stats[i].stat_string);
+		*p += ETH_GSTRING_LEN;
+	}
+}
+
+/**
+ * 40e_add_stat_strings - copy stat strings into ethtool buffer
+ * @p: ethtool supplied buffer
+ * @stats: stat definitions array
+ *
+ * Format and copy the strings described by the const static stats value into
+ * the buffer pointed@by p. Assumes that stats can have ARRAY_SIZE called
+ * for it.
+ **/
+#define i40e_add_stat_strings(p, stats, ...) \
+	__i40e_add_stat_strings(p, stats, ARRAY_SIZE(stats))
+
+/**
  * i40e_get_stat_strings - copy stat strings into supplied buffer
  * @netdev: the netdev to collect strings for
  * @data: supplied buffer to copy strings into
@@ -1833,16 +1864,10 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	unsigned int i;
 	u8 *p = data;
 
-	for (i = 0; i < I40E_NETDEV_STATS_LEN; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "%s",
-			 i40e_gstrings_net_stats[i].stat_string);
-		data += ETH_GSTRING_LEN;
-	}
-	for (i = 0; i < I40E_MISC_STATS_LEN; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "%s",
-			 i40e_gstrings_misc_stats[i].stat_string);
-		data += ETH_GSTRING_LEN;
-	}
+	i40e_add_stat_strings(&data, i40e_gstrings_net_stats);
+
+	i40e_add_stat_strings(&data, i40e_gstrings_misc_stats);
+
 	for (i = 0; i < I40E_MAX_NUM_QUEUES(netdev); i++) {
 		snprintf(data, ETH_GSTRING_LEN, "tx-%u.tx_packets", i);
 		data += ETH_GSTRING_LEN;
@@ -1856,11 +1881,8 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
 		return;
 
-	for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "%s",
-			 i40e_gstrings_veb_stats[i].stat_string);
-		data += ETH_GSTRING_LEN;
-	}
+	i40e_add_stat_strings(&data, i40e_gstrings_veb_stats);
+
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
 		snprintf(data, ETH_GSTRING_LEN,
 			 "veb.tc_%u_tx_packets", i);
@@ -1876,11 +1898,8 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 		data += ETH_GSTRING_LEN;
 	}
 
-	for (i = 0; i < I40E_GLOBAL_STATS_LEN; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "%s",
-			 i40e_gstrings_stats[i].stat_string);
-		data += ETH_GSTRING_LEN;
-	}
+	i40e_add_stat_strings(&data, i40e_gstrings_stats);
+
 	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
 		snprintf(data, ETH_GSTRING_LEN,
 			 "port.tx_priority_%u_xon", i);
-- 
2.9.5

