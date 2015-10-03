From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri,  2 Oct 2015 19:09:34 -0700
Subject: [Intel-wired-lan] [net PATCH] i40e: fix stats offsets
Message-ID: <1443838174-3692-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The code was setting up stats that were not being initialized.
This caused several counters to be displayed incorrectly, due
to indexing beyond the array of strings when printing stats.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8d12328..afe6d99 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1407,6 +1407,12 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = (i40e_gstrings_veb_stats[j].sizeof_stat ==
 				     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 		}
+		for (j = 0; j < I40E_MAX_TRAFFIC_CLASS; j++) {
+			data[i++] = veb->tc_stats.tc_tx_packets[j];
+			data[i++] = veb->tc_stats.tc_tx_bytes[j];
+			data[i++] = veb->tc_stats.tc_rx_packets[j];
+			data[i++] = veb->tc_stats.tc_rx_bytes[j];
+		}
 	}
 	for (j = 0; j < I40E_GLOBAL_STATS_LEN; j++) {
 		p = (char *)pf + i40e_gstrings_stats[j].stat_offset;
-- 
2.1.0

