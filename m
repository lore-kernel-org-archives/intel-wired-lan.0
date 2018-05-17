From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:38 -0700
Subject: [Intel-wired-lan] [next PATCH S92 7/9] i40e: update data pointer
 directly when copying to the buffer
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <20180517080840.30192-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

A future patch is going to add a helper function i40e_add_ethtool_stats
that will help lower the amount of boiler plate code in the
i40e_get_ethtool_stats function.

This conversion will take place over many patches, and the helper
function will work by directly updating a reference to the data pointer.

Since this would not work combined with the current method of accessing
data like an array, update all the code that copies stats into the data
buffer to use direct updates to the pointer instead of array accesses.

This will prevent incorrect stat updates for patches in between the
conversion.

Similarly, when copying strings, we used a separate char *p pointer.
Instead, use the data pointer directly as it's already a (u8 *) type
which is the same size.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 117 ++++++++++++-------------
 1 file changed, 58 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2498d19..94e1995 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1579,7 +1579,6 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	unsigned int j;
-	int i = 0;
 	char *p;
 	struct rtnl_link_stats64 *net_stats = i40e_get_vsi_stats_struct(vsi);
 	unsigned int start;
@@ -1588,12 +1587,12 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 
 	for (j = 0; j < I40E_NETDEV_STATS_LEN; j++) {
 		p = (char *)net_stats + i40e_gstrings_net_stats[j].stat_offset;
-		data[i++] = (i40e_gstrings_net_stats[j].sizeof_stat ==
+		*(data++) = (i40e_gstrings_net_stats[j].sizeof_stat ==
 			sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 	for (j = 0; j < I40E_MISC_STATS_LEN; j++) {
 		p = (char *)vsi + i40e_gstrings_misc_stats[j].stat_offset;
-		data[i++] = (i40e_gstrings_misc_stats[j].sizeof_stat ==
+		*(data++) = (i40e_gstrings_misc_stats[j].sizeof_stat ==
 			    sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 	rcu_read_lock();
@@ -1604,29 +1603,29 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 			/* Bump the stat counter to skip these stats, and make
 			 * sure the memory is zero'd
 			 */
-			data[i++] = 0;
-			data[i++] = 0;
-			data[i++] = 0;
-			data[i++] = 0;
+			*(data++) = 0;
+			*(data++) = 0;
+			*(data++) = 0;
+			*(data++) = 0;
 			continue;
 		}
 
 		/* process Tx ring statistics */
 		do {
 			start = u64_stats_fetch_begin_irq(&tx_ring->syncp);
-			data[i] = tx_ring->stats.packets;
-			data[i + 1] = tx_ring->stats.bytes;
+			data[0] = tx_ring->stats.packets;
+			data[1] = tx_ring->stats.bytes;
 		} while (u64_stats_fetch_retry_irq(&tx_ring->syncp, start));
-		i += 2;
+		data += 2;
 
 		/* Rx ring is the 2nd half of the queue pair */
 		rx_ring = &tx_ring[1];
 		do {
 			start = u64_stats_fetch_begin_irq(&rx_ring->syncp);
-			data[i] = rx_ring->stats.packets;
-			data[i + 1] = rx_ring->stats.bytes;
+			data[0] = rx_ring->stats.packets;
+			data[1] = rx_ring->stats.bytes;
 		} while (u64_stats_fetch_retry_irq(&rx_ring->syncp, start));
-		i += 2;
+		data += 2;
 	}
 	rcu_read_unlock();
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
@@ -1639,33 +1638,33 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 		for (j = 0; j < I40E_VEB_STATS_LEN; j++) {
 			p = (char *)veb;
 			p += i40e_gstrings_veb_stats[j].stat_offset;
-			data[i++] = (i40e_gstrings_veb_stats[j].sizeof_stat ==
+			*(data++) = (i40e_gstrings_veb_stats[j].sizeof_stat ==
 				     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 		}
 		for (j = 0; j < I40E_MAX_TRAFFIC_CLASS; j++) {
-			data[i++] = veb->tc_stats.tc_tx_packets[j];
-			data[i++] = veb->tc_stats.tc_tx_bytes[j];
-			data[i++] = veb->tc_stats.tc_rx_packets[j];
-			data[i++] = veb->tc_stats.tc_rx_bytes[j];
+			*(data++) = veb->tc_stats.tc_tx_packets[j];
+			*(data++) = veb->tc_stats.tc_tx_bytes[j];
+			*(data++) = veb->tc_stats.tc_rx_packets[j];
+			*(data++) = veb->tc_stats.tc_rx_bytes[j];
 		}
 	} else {
-		i += I40E_VEB_STATS_TOTAL;
+		data += I40E_VEB_STATS_TOTAL;
 	}
 	for (j = 0; j < I40E_GLOBAL_STATS_LEN; j++) {
 		p = (char *)pf + i40e_gstrings_stats[j].stat_offset;
-		data[i++] = (i40e_gstrings_stats[j].sizeof_stat ==
+		*(data++) = (i40e_gstrings_stats[j].sizeof_stat ==
 			     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 	for (j = 0; j < I40E_MAX_USER_PRIORITY; j++) {
-		data[i++] = pf->stats.priority_xon_tx[j];
-		data[i++] = pf->stats.priority_xoff_tx[j];
+		*(data++) = pf->stats.priority_xon_tx[j];
+		*(data++) = pf->stats.priority_xoff_tx[j];
 	}
 	for (j = 0; j < I40E_MAX_USER_PRIORITY; j++) {
-		data[i++] = pf->stats.priority_xon_rx[j];
-		data[i++] = pf->stats.priority_xoff_rx[j];
+		*(data++) = pf->stats.priority_xon_rx[j];
+		*(data++) = pf->stats.priority_xoff_rx[j];
 	}
 	for (j = 0; j < I40E_MAX_USER_PRIORITY; j++)
-		data[i++] = pf->stats.priority_xon_2_xoff[j];
+		*(data++) = pf->stats.priority_xon_2_xoff[j];
 }
 
 static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
@@ -1677,73 +1676,73 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	u8 *p = data;
 
 	for (i = 0; i < I40E_NETDEV_STATS_LEN; i++) {
-		snprintf(p, ETH_GSTRING_LEN, "%s",
+		snprintf(data, ETH_GSTRING_LEN, "%s",
 			 i40e_gstrings_net_stats[i].stat_string);
-		p += ETH_GSTRING_LEN;
+		data += ETH_GSTRING_LEN;
 	}
 	for (i = 0; i < I40E_MISC_STATS_LEN; i++) {
-		snprintf(p, ETH_GSTRING_LEN, "%s",
+		snprintf(data, ETH_GSTRING_LEN, "%s",
 			 i40e_gstrings_misc_stats[i].stat_string);
-		p += ETH_GSTRING_LEN;
+		data += ETH_GSTRING_LEN;
 	}
 	for (i = 0; i < I40E_MAX_NUM_QUEUES(netdev); i++) {
-		snprintf(p, ETH_GSTRING_LEN, "tx-%u.tx_packets", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "tx-%u.tx_bytes", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "rx-%u.rx_packets", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN, "rx-%u.rx_bytes", i);
-		p += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN, "tx-%u.tx_packets", i);
+		data += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN, "tx-%u.tx_bytes", i);
+		data += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN, "rx-%u.rx_packets", i);
+		data += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN, "rx-%u.rx_bytes", i);
+		data += ETH_GSTRING_LEN;
 	}
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
 		return;
 
 	for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
-		snprintf(p, ETH_GSTRING_LEN, "%s",
+		snprintf(data, ETH_GSTRING_LEN, "%s",
 			 i40e_gstrings_veb_stats[i].stat_string);
-		p += ETH_GSTRING_LEN;
+		data += ETH_GSTRING_LEN;
 	}
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
-		snprintf(p, ETH_GSTRING_LEN,
+		snprintf(data, ETH_GSTRING_LEN,
 			 "veb.tc_%u_tx_packets", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN,
+		data += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN,
 			 "veb.tc_%u_tx_bytes", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN,
+		data += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN,
 			 "veb.tc_%u_rx_packets", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN,
+		data += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN,
 			 "veb.tc_%u_rx_bytes", i);
-		p += ETH_GSTRING_LEN;
+		data += ETH_GSTRING_LEN;
 	}
 
 	for (i = 0; i < I40E_GLOBAL_STATS_LEN; i++) {
-		snprintf(p, ETH_GSTRING_LEN, "%s",
+		snprintf(data, ETH_GSTRING_LEN, "%s",
 			 i40e_gstrings_stats[i].stat_string);
-		p += ETH_GSTRING_LEN;
+		data += ETH_GSTRING_LEN;
 	}
 	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
-		snprintf(p, ETH_GSTRING_LEN,
+		snprintf(data, ETH_GSTRING_LEN,
 			 "port.tx_priority_%u_xon", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN,
+		data += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN,
 			 "port.tx_priority_%u_xoff", i);
-		p += ETH_GSTRING_LEN;
+		data += ETH_GSTRING_LEN;
 	}
 	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
-		snprintf(p, ETH_GSTRING_LEN,
+		snprintf(data, ETH_GSTRING_LEN,
 			 "port.rx_priority_%u_xon", i);
-		p += ETH_GSTRING_LEN;
-		snprintf(p, ETH_GSTRING_LEN,
+		data += ETH_GSTRING_LEN;
+		snprintf(data, ETH_GSTRING_LEN,
 			 "port.rx_priority_%u_xoff", i);
-		p += ETH_GSTRING_LEN;
+		data += ETH_GSTRING_LEN;
 	}
 	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
-		snprintf(p, ETH_GSTRING_LEN,
+		snprintf(data, ETH_GSTRING_LEN,
 			 "port.rx_priority_%u_xon_2_xoff", i);
-		p += ETH_GSTRING_LEN;
+		data += ETH_GSTRING_LEN;
 	}
 
 	WARN_ONCE(p - data != i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
-- 
2.9.5

