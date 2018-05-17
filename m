From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:40 -0700
Subject: [Intel-wired-lan] [next PATCH S92 9/9] i40e: use the more
 traditional 'i' loop variable
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <20180517080840.30192-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Since we no longer use i as an array index for the data variable,
replace the use of 'j' with 'i' so that we match the general loop
variable name.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 56 +++++++++++++-------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 487a9a4..194cc23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1606,26 +1606,26 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	struct i40e_ring *tx_ring, *rx_ring;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	unsigned int j;
+	unsigned int i;
 	char *p;
 	struct rtnl_link_stats64 *net_stats = i40e_get_vsi_stats_struct(vsi);
 	unsigned int start;
 
 	i40e_update_stats(vsi);
 
-	for (j = 0; j < I40E_NETDEV_STATS_LEN; j++) {
-		p = (char *)net_stats + i40e_gstrings_net_stats[j].stat_offset;
-		*(data++) = (i40e_gstrings_net_stats[j].sizeof_stat ==
+	for (i = 0; i < I40E_NETDEV_STATS_LEN; i++) {
+		p = (char *)net_stats + i40e_gstrings_net_stats[i].stat_offset;
+		*(data++) = (i40e_gstrings_net_stats[i].sizeof_stat ==
 			sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
-	for (j = 0; j < I40E_MISC_STATS_LEN; j++) {
-		p = (char *)vsi + i40e_gstrings_misc_stats[j].stat_offset;
-		*(data++) = (i40e_gstrings_misc_stats[j].sizeof_stat ==
+	for (i = 0; i < I40E_MISC_STATS_LEN; i++) {
+		p = (char *)vsi + i40e_gstrings_misc_stats[i].stat_offset;
+		*(data++) = (i40e_gstrings_misc_stats[i].sizeof_stat ==
 			    sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 	rcu_read_lock();
-	for (j = 0; j < I40E_MAX_NUM_QUEUES(netdev) ; j++) {
-		tx_ring = READ_ONCE(vsi->tx_rings[j]);
+	for (i = 0; i < I40E_MAX_NUM_QUEUES(netdev) ; i++) {
+		tx_ring = READ_ONCE(vsi->tx_rings[i]);
 
 		if (!tx_ring) {
 			/* Bump the stat counter to skip these stats, and make
@@ -1663,36 +1663,36 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	    (pf->flags & I40E_FLAG_VEB_STATS_ENABLED)) {
 		struct i40e_veb *veb = pf->veb[pf->lan_veb];
 
-		for (j = 0; j < I40E_VEB_STATS_LEN; j++) {
+		for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
 			p = (char *)veb;
-			p += i40e_gstrings_veb_stats[j].stat_offset;
-			*(data++) = (i40e_gstrings_veb_stats[j].sizeof_stat ==
+			p += i40e_gstrings_veb_stats[i].stat_offset;
+			*(data++) = (i40e_gstrings_veb_stats[i].sizeof_stat ==
 				     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 		}
-		for (j = 0; j < I40E_MAX_TRAFFIC_CLASS; j++) {
-			*(data++) = veb->tc_stats.tc_tx_packets[j];
-			*(data++) = veb->tc_stats.tc_tx_bytes[j];
-			*(data++) = veb->tc_stats.tc_rx_packets[j];
-			*(data++) = veb->tc_stats.tc_rx_bytes[j];
+		for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
+			*(data++) = veb->tc_stats.tc_tx_packets[i];
+			*(data++) = veb->tc_stats.tc_tx_bytes[i];
+			*(data++) = veb->tc_stats.tc_rx_packets[i];
+			*(data++) = veb->tc_stats.tc_rx_bytes[i];
 		}
 	} else {
 		data += I40E_VEB_STATS_TOTAL;
 	}
-	for (j = 0; j < I40E_GLOBAL_STATS_LEN; j++) {
-		p = (char *)pf + i40e_gstrings_stats[j].stat_offset;
-		*(data++) = (i40e_gstrings_stats[j].sizeof_stat ==
+	for (i = 0; i < I40E_GLOBAL_STATS_LEN; i++) {
+		p = (char *)pf + i40e_gstrings_stats[i].stat_offset;
+		*(data++) = (i40e_gstrings_stats[i].sizeof_stat ==
 			     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
-	for (j = 0; j < I40E_MAX_USER_PRIORITY; j++) {
-		*(data++) = pf->stats.priority_xon_tx[j];
-		*(data++) = pf->stats.priority_xoff_tx[j];
+	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
+		*(data++) = pf->stats.priority_xon_tx[i];
+		*(data++) = pf->stats.priority_xoff_tx[i];
 	}
-	for (j = 0; j < I40E_MAX_USER_PRIORITY; j++) {
-		*(data++) = pf->stats.priority_xon_rx[j];
-		*(data++) = pf->stats.priority_xoff_rx[j];
+	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
+		*(data++) = pf->stats.priority_xon_rx[i];
+		*(data++) = pf->stats.priority_xoff_rx[i];
 	}
-	for (j = 0; j < I40E_MAX_USER_PRIORITY; j++)
-		*(data++) = pf->stats.priority_xon_2_xoff[j];
+	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++)
+		*(data++) = pf->stats.priority_xon_2_xoff[i];
 }
 
 /**
-- 
2.9.5

