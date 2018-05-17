From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:33 -0700
Subject: [Intel-wired-lan] [next PATCH S92 2/9] i40e: always return VEB stat
 strings
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <20180517080840.30192-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The ethtool API for obtaining device statistics is not intended to allow
runtime changes in the number of statistics reported. It may *appear*
this way, as there is an ability to request the number of stats using
ethtool_get_set_count(). However, it is expected that this must always
return the same value for invocations of the same device.

If we don't satisfy this contract, and allow the number of stats to
change during run time, we could cause invalid memory accesses or report
the stat strings incorrectly. This is because the API for obtaining
stats is to (1) get the size, (2) get the strings and finally (3) get
the stats. Since these are each separate ethtool op commands, it is not
possible to maintain consistency by holding the RTNL lock over the whole
operation. This results in the potential for a race condition to occur
where the size changed between any of the 3 calls.

Avoid this issue by requiring that we always return the same value for
a given device. We can check any values which remain constant for the
life of the device, but must not report different sizes depending on
runtime attributes.

This patch specifically fixes the VEB statistics strings to always be
reported. Other issues will be fixed in future patches.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 52 ++++++++++++--------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 4b78225..5a0e4d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1541,15 +1541,10 @@ static int i40e_get_stats_count(struct net_device *netdev)
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 
-	if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1) {
-		if (pf->lan_veb != I40E_NO_VEB &&
-		    pf->flags & I40E_FLAG_VEB_STATS_ENABLED)
-			return I40E_PF_STATS_LEN(netdev) + I40E_VEB_STATS_TOTAL;
-		else
-			return I40E_PF_STATS_LEN(netdev);
-	} else {
+	if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1)
+		return I40E_PF_STATS_LEN(netdev) + I40E_VEB_STATS_TOTAL;
+	else
 		return I40E_VSI_STATS_LEN(netdev);
-	}
 }
 
 static int i40e_get_sset_count(struct net_device *netdev, int sset)
@@ -1640,6 +1635,8 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = veb->tc_stats.tc_rx_packets[j];
 			data[i++] = veb->tc_stats.tc_rx_bytes[j];
 		}
+	} else {
+		i += I40E_VEB_STATS_TOTAL;
 	}
 	for (j = 0; j < I40E_GLOBAL_STATS_LEN; j++) {
 		p = (char *)pf + i40e_gstrings_stats[j].stat_offset;
@@ -1696,27 +1693,24 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 		if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
 			return;
 
-		if ((pf->lan_veb != I40E_NO_VEB) &&
-		    (pf->flags & I40E_FLAG_VEB_STATS_ENABLED)) {
-			for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
-				snprintf(p, ETH_GSTRING_LEN, "veb.%s",
-					i40e_gstrings_veb_stats[i].stat_string);
-				p += ETH_GSTRING_LEN;
-			}
-			for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
-				snprintf(p, ETH_GSTRING_LEN,
-					 "veb.tc_%d_tx_packets", i);
-				p += ETH_GSTRING_LEN;
-				snprintf(p, ETH_GSTRING_LEN,
-					 "veb.tc_%d_tx_bytes", i);
-				p += ETH_GSTRING_LEN;
-				snprintf(p, ETH_GSTRING_LEN,
-					 "veb.tc_%d_rx_packets", i);
-				p += ETH_GSTRING_LEN;
-				snprintf(p, ETH_GSTRING_LEN,
-					 "veb.tc_%d_rx_bytes", i);
-				p += ETH_GSTRING_LEN;
-			}
+		for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
+			snprintf(p, ETH_GSTRING_LEN, "veb.%s",
+				 i40e_gstrings_veb_stats[i].stat_string);
+			p += ETH_GSTRING_LEN;
+		}
+		for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
+			snprintf(p, ETH_GSTRING_LEN,
+				 "veb.tc_%u_tx_packets", i);
+			p += ETH_GSTRING_LEN;
+			snprintf(p, ETH_GSTRING_LEN,
+				 "veb.tc_%u_tx_bytes", i);
+			p += ETH_GSTRING_LEN;
+			snprintf(p, ETH_GSTRING_LEN,
+				 "veb.tc_%u_rx_packets", i);
+			p += ETH_GSTRING_LEN;
+			snprintf(p, ETH_GSTRING_LEN,
+				 "veb.tc_%u_rx_bytes", i);
+			p += ETH_GSTRING_LEN;
 		}
 		for (i = 0; i < I40E_GLOBAL_STATS_LEN; i++) {
 			snprintf(p, ETH_GSTRING_LEN, "port.%s",
-- 
2.9.5

