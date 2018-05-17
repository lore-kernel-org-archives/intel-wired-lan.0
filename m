From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:35 -0700
Subject: [Intel-wired-lan] [next PATCH S92 4/9] i40e: split
 i40e_get_strings() into smaller functions
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <20180517080840.30192-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Split the statistic strings and private flags strings into their own
separate functions to aid code readability.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 183 ++++++++++++++-----------
 1 file changed, 100 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 698f096..cc09dd7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1667,8 +1667,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 		data[i++] = pf->stats.priority_xon_2_xoff[j];
 }
 
-static void i40e_get_strings(struct net_device *netdev, u32 stringset,
-			     u8 *data)
+static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
@@ -1676,95 +1675,113 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 	char *p = (char *)data;
 	unsigned int i;
 
+	for (i = 0; i < I40E_NETDEV_STATS_LEN; i++) {
+		snprintf(p, ETH_GSTRING_LEN, "%s",
+			 i40e_gstrings_net_stats[i].stat_string);
+		p += ETH_GSTRING_LEN;
+	}
+	for (i = 0; i < I40E_MISC_STATS_LEN; i++) {
+		snprintf(p, ETH_GSTRING_LEN, "%s",
+			 i40e_gstrings_misc_stats[i].stat_string);
+		p += ETH_GSTRING_LEN;
+	}
+	for (i = 0; i < I40E_MAX_NUM_QUEUES(netdev); i++) {
+		snprintf(p, ETH_GSTRING_LEN, "tx-%u.tx_packets", i);
+		p += ETH_GSTRING_LEN;
+		snprintf(p, ETH_GSTRING_LEN, "tx-%u.tx_bytes", i);
+		p += ETH_GSTRING_LEN;
+		snprintf(p, ETH_GSTRING_LEN, "rx-%u.rx_packets", i);
+		p += ETH_GSTRING_LEN;
+		snprintf(p, ETH_GSTRING_LEN, "rx-%u.rx_bytes", i);
+		p += ETH_GSTRING_LEN;
+	}
+	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
+		return;
+
+	for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
+		snprintf(p, ETH_GSTRING_LEN, "veb.%s",
+			 i40e_gstrings_veb_stats[i].stat_string);
+		p += ETH_GSTRING_LEN;
+	}
+	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
+		snprintf(p, ETH_GSTRING_LEN,
+			 "veb.tc_%u_tx_packets", i);
+		p += ETH_GSTRING_LEN;
+		snprintf(p, ETH_GSTRING_LEN,
+			 "veb.tc_%u_tx_bytes", i);
+		p += ETH_GSTRING_LEN;
+		snprintf(p, ETH_GSTRING_LEN,
+			 "veb.tc_%u_rx_packets", i);
+		p += ETH_GSTRING_LEN;
+		snprintf(p, ETH_GSTRING_LEN,
+			 "veb.tc_%u_rx_bytes", i);
+		p += ETH_GSTRING_LEN;
+	}
+
+	for (i = 0; i < I40E_GLOBAL_STATS_LEN; i++) {
+		snprintf(p, ETH_GSTRING_LEN, "port.%s",
+			 i40e_gstrings_stats[i].stat_string);
+		p += ETH_GSTRING_LEN;
+	}
+	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
+		snprintf(p, ETH_GSTRING_LEN,
+			 "port.tx_priority_%u_xon", i);
+		p += ETH_GSTRING_LEN;
+		snprintf(p, ETH_GSTRING_LEN,
+			 "port.tx_priority_%u_xoff", i);
+		p += ETH_GSTRING_LEN;
+	}
+	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
+		snprintf(p, ETH_GSTRING_LEN,
+			 "port.rx_priority_%u_xon", i);
+		p += ETH_GSTRING_LEN;
+		snprintf(p, ETH_GSTRING_LEN,
+			 "port.rx_priority_%u_xoff", i);
+		p += ETH_GSTRING_LEN;
+	}
+	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
+		snprintf(p, ETH_GSTRING_LEN,
+			 "port.rx_priority_%u_xon_2_xoff", i);
+		p += ETH_GSTRING_LEN;
+	}
+	/* BUG_ON(p - data != I40E_STATS_LEN * ETH_GSTRING_LEN); */
+}
+
+static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+	char *p = (char *)data;
+	unsigned int i;
+
+	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
+		snprintf(p, ETH_GSTRING_LEN, "%s",
+			 i40e_gstrings_priv_flags[i].flag_string);
+		p += ETH_GSTRING_LEN;
+	}
+	if (pf->hw.pf_id != 0)
+		return;
+	for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++) {
+		snprintf(p, ETH_GSTRING_LEN, "%s",
+			 i40e_gl_gstrings_priv_flags[i].flag_string);
+		p += ETH_GSTRING_LEN;
+	}
+}
+
+static void i40e_get_strings(struct net_device *netdev, u32 stringset,
+			     u8 *data)
+{
 	switch (stringset) {
 	case ETH_SS_TEST:
 		memcpy(data, i40e_gstrings_test,
 		       I40E_TEST_LEN * ETH_GSTRING_LEN);
 		break;
 	case ETH_SS_STATS:
-		for (i = 0; i < I40E_NETDEV_STATS_LEN; i++) {
-			snprintf(p, ETH_GSTRING_LEN, "%s",
-				 i40e_gstrings_net_stats[i].stat_string);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < I40E_MISC_STATS_LEN; i++) {
-			snprintf(p, ETH_GSTRING_LEN, "%s",
-				 i40e_gstrings_misc_stats[i].stat_string);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < I40E_MAX_NUM_QUEUES(netdev); i++) {
-			snprintf(p, ETH_GSTRING_LEN, "tx-%d.tx_packets", i);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "tx-%d.tx_bytes", i);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "rx-%d.rx_packets", i);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "rx-%d.rx_bytes", i);
-			p += ETH_GSTRING_LEN;
-		}
-		if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
-			return;
-
-		for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
-			snprintf(p, ETH_GSTRING_LEN, "veb.%s",
-				 i40e_gstrings_veb_stats[i].stat_string);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
-			snprintf(p, ETH_GSTRING_LEN,
-				 "veb.tc_%u_tx_packets", i);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN,
-				 "veb.tc_%u_tx_bytes", i);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN,
-				 "veb.tc_%u_rx_packets", i);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN,
-				 "veb.tc_%u_rx_bytes", i);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < I40E_GLOBAL_STATS_LEN; i++) {
-			snprintf(p, ETH_GSTRING_LEN, "port.%s",
-				 i40e_gstrings_stats[i].stat_string);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
-			snprintf(p, ETH_GSTRING_LEN,
-				 "port.tx_priority_%d_xon", i);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN,
-				 "port.tx_priority_%d_xoff", i);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
-			snprintf(p, ETH_GSTRING_LEN,
-				 "port.rx_priority_%d_xon", i);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN,
-				 "port.rx_priority_%d_xoff", i);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
-			snprintf(p, ETH_GSTRING_LEN,
-				 "port.rx_priority_%d_xon_2_xoff", i);
-			p += ETH_GSTRING_LEN;
-		}
-		/* BUG_ON(p - data != I40E_STATS_LEN * ETH_GSTRING_LEN); */
+		i40e_get_stat_strings(netdev, data);
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++) {
-			snprintf(p, ETH_GSTRING_LEN, "%s",
-				 i40e_gstrings_priv_flags[i].flag_string);
-			p += ETH_GSTRING_LEN;
-		}
-		if (pf->hw.pf_id != 0)
-			break;
-		for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++) {
-			snprintf(p, ETH_GSTRING_LEN, "%s",
-				 i40e_gl_gstrings_priv_flags[i].flag_string);
-			p += ETH_GSTRING_LEN;
-		}
+		i40e_get_priv_flag_strings(netdev, data);
 		break;
 	default:
 		break;
-- 
2.9.5

