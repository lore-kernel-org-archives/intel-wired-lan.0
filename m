From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:37 -0700
Subject: [Intel-wired-lan] [next PATCH S92 6/9] i40e: fold prefix strings
 directly into stat names
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <20180517080840.30192-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We always prefix these stats with a fixed string, so just fold this
prefix into the stat string definition. This preparatory work will make
it easier to implement a helper function to copy stats and strings into
the supplied buffers in a future patch.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 137 +++++++++++++------------
 1 file changed, 69 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9bddae4..2498d19 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -42,18 +42,18 @@ static const struct i40e_stats i40e_gstrings_net_stats[] = {
 };
 
 static const struct i40e_stats i40e_gstrings_veb_stats[] = {
-	I40E_VEB_STAT("rx_bytes", stats.rx_bytes),
-	I40E_VEB_STAT("tx_bytes", stats.tx_bytes),
-	I40E_VEB_STAT("rx_unicast", stats.rx_unicast),
-	I40E_VEB_STAT("tx_unicast", stats.tx_unicast),
-	I40E_VEB_STAT("rx_multicast", stats.rx_multicast),
-	I40E_VEB_STAT("tx_multicast", stats.tx_multicast),
-	I40E_VEB_STAT("rx_broadcast", stats.rx_broadcast),
-	I40E_VEB_STAT("tx_broadcast", stats.tx_broadcast),
-	I40E_VEB_STAT("rx_discards", stats.rx_discards),
-	I40E_VEB_STAT("tx_discards", stats.tx_discards),
-	I40E_VEB_STAT("tx_errors", stats.tx_errors),
-	I40E_VEB_STAT("rx_unknown_protocol", stats.rx_unknown_protocol),
+	I40E_VEB_STAT("veb.rx_bytes", stats.rx_bytes),
+	I40E_VEB_STAT("veb.tx_bytes", stats.tx_bytes),
+	I40E_VEB_STAT("veb.rx_unicast", stats.rx_unicast),
+	I40E_VEB_STAT("veb.tx_unicast", stats.tx_unicast),
+	I40E_VEB_STAT("veb.rx_multicast", stats.rx_multicast),
+	I40E_VEB_STAT("veb.tx_multicast", stats.tx_multicast),
+	I40E_VEB_STAT("veb.rx_broadcast", stats.rx_broadcast),
+	I40E_VEB_STAT("veb.tx_broadcast", stats.tx_broadcast),
+	I40E_VEB_STAT("veb.rx_discards", stats.rx_discards),
+	I40E_VEB_STAT("veb.tx_discards", stats.tx_discards),
+	I40E_VEB_STAT("veb.tx_errors", stats.tx_errors),
+	I40E_VEB_STAT("veb.rx_unknown_protocol", stats.rx_unknown_protocol),
 };
 
 static const struct i40e_stats i40e_gstrings_misc_stats[] = {
@@ -82,62 +82,63 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
  * is queried on the base PF netdev, not on the VMDq or FCoE netdev.
  */
 static const struct i40e_stats i40e_gstrings_stats[] = {
-	I40E_PF_STAT("rx_bytes", stats.eth.rx_bytes),
-	I40E_PF_STAT("tx_bytes", stats.eth.tx_bytes),
-	I40E_PF_STAT("rx_unicast", stats.eth.rx_unicast),
-	I40E_PF_STAT("tx_unicast", stats.eth.tx_unicast),
-	I40E_PF_STAT("rx_multicast", stats.eth.rx_multicast),
-	I40E_PF_STAT("tx_multicast", stats.eth.tx_multicast),
-	I40E_PF_STAT("rx_broadcast", stats.eth.rx_broadcast),
-	I40E_PF_STAT("tx_broadcast", stats.eth.tx_broadcast),
-	I40E_PF_STAT("tx_errors", stats.eth.tx_errors),
-	I40E_PF_STAT("rx_dropped", stats.eth.rx_discards),
-	I40E_PF_STAT("tx_dropped_link_down", stats.tx_dropped_link_down),
-	I40E_PF_STAT("rx_crc_errors", stats.crc_errors),
-	I40E_PF_STAT("illegal_bytes", stats.illegal_bytes),
-	I40E_PF_STAT("mac_local_faults", stats.mac_local_faults),
-	I40E_PF_STAT("mac_remote_faults", stats.mac_remote_faults),
-	I40E_PF_STAT("tx_timeout", tx_timeout_count),
-	I40E_PF_STAT("rx_csum_bad", hw_csum_rx_error),
-	I40E_PF_STAT("rx_length_errors", stats.rx_length_errors),
-	I40E_PF_STAT("link_xon_rx", stats.link_xon_rx),
-	I40E_PF_STAT("link_xoff_rx", stats.link_xoff_rx),
-	I40E_PF_STAT("link_xon_tx", stats.link_xon_tx),
-	I40E_PF_STAT("link_xoff_tx", stats.link_xoff_tx),
-	I40E_PF_STAT("rx_size_64", stats.rx_size_64),
-	I40E_PF_STAT("rx_size_127", stats.rx_size_127),
-	I40E_PF_STAT("rx_size_255", stats.rx_size_255),
-	I40E_PF_STAT("rx_size_511", stats.rx_size_511),
-	I40E_PF_STAT("rx_size_1023", stats.rx_size_1023),
-	I40E_PF_STAT("rx_size_1522", stats.rx_size_1522),
-	I40E_PF_STAT("rx_size_big", stats.rx_size_big),
-	I40E_PF_STAT("tx_size_64", stats.tx_size_64),
-	I40E_PF_STAT("tx_size_127", stats.tx_size_127),
-	I40E_PF_STAT("tx_size_255", stats.tx_size_255),
-	I40E_PF_STAT("tx_size_511", stats.tx_size_511),
-	I40E_PF_STAT("tx_size_1023", stats.tx_size_1023),
-	I40E_PF_STAT("tx_size_1522", stats.tx_size_1522),
-	I40E_PF_STAT("tx_size_big", stats.tx_size_big),
-	I40E_PF_STAT("rx_undersize", stats.rx_undersize),
-	I40E_PF_STAT("rx_fragments", stats.rx_fragments),
-	I40E_PF_STAT("rx_oversize", stats.rx_oversize),
-	I40E_PF_STAT("rx_jabber", stats.rx_jabber),
-	I40E_PF_STAT("VF_admin_queue_requests", vf_aq_requests),
-	I40E_PF_STAT("arq_overflows", arq_overflows),
-	I40E_PF_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
-	I40E_PF_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
-	I40E_PF_STAT("fdir_flush_cnt", fd_flush_cnt),
-	I40E_PF_STAT("fdir_atr_match", stats.fd_atr_match),
-	I40E_PF_STAT("fdir_atr_tunnel_match", stats.fd_atr_tunnel_match),
-	I40E_PF_STAT("fdir_atr_status", stats.fd_atr_status),
-	I40E_PF_STAT("fdir_sb_match", stats.fd_sb_match),
-	I40E_PF_STAT("fdir_sb_status", stats.fd_sb_status),
+	I40E_PF_STAT("port.rx_bytes", stats.eth.rx_bytes),
+	I40E_PF_STAT("port.tx_bytes", stats.eth.tx_bytes),
+	I40E_PF_STAT("port.rx_unicast", stats.eth.rx_unicast),
+	I40E_PF_STAT("port.tx_unicast", stats.eth.tx_unicast),
+	I40E_PF_STAT("port.rx_multicast", stats.eth.rx_multicast),
+	I40E_PF_STAT("port.tx_multicast", stats.eth.tx_multicast),
+	I40E_PF_STAT("port.rx_broadcast", stats.eth.rx_broadcast),
+	I40E_PF_STAT("port.tx_broadcast", stats.eth.tx_broadcast),
+	I40E_PF_STAT("port.tx_errors", stats.eth.tx_errors),
+	I40E_PF_STAT("port.rx_dropped", stats.eth.rx_discards),
+	I40E_PF_STAT("port.tx_dropped_link_down", stats.tx_dropped_link_down),
+	I40E_PF_STAT("port.rx_crc_errors", stats.crc_errors),
+	I40E_PF_STAT("port.illegal_bytes", stats.illegal_bytes),
+	I40E_PF_STAT("port.mac_local_faults", stats.mac_local_faults),
+	I40E_PF_STAT("port.mac_remote_faults", stats.mac_remote_faults),
+	I40E_PF_STAT("port.tx_timeout", tx_timeout_count),
+	I40E_PF_STAT("port.rx_csum_bad", hw_csum_rx_error),
+	I40E_PF_STAT("port.rx_length_errors", stats.rx_length_errors),
+	I40E_PF_STAT("port.link_xon_rx", stats.link_xon_rx),
+	I40E_PF_STAT("port.link_xoff_rx", stats.link_xoff_rx),
+	I40E_PF_STAT("port.link_xon_tx", stats.link_xon_tx),
+	I40E_PF_STAT("port.link_xoff_tx", stats.link_xoff_tx),
+	I40E_PF_STAT("port.rx_size_64", stats.rx_size_64),
+	I40E_PF_STAT("port.rx_size_127", stats.rx_size_127),
+	I40E_PF_STAT("port.rx_size_255", stats.rx_size_255),
+	I40E_PF_STAT("port.rx_size_511", stats.rx_size_511),
+	I40E_PF_STAT("port.rx_size_1023", stats.rx_size_1023),
+	I40E_PF_STAT("port.rx_size_1522", stats.rx_size_1522),
+	I40E_PF_STAT("port.rx_size_big", stats.rx_size_big),
+	I40E_PF_STAT("port.tx_size_64", stats.tx_size_64),
+	I40E_PF_STAT("port.tx_size_127", stats.tx_size_127),
+	I40E_PF_STAT("port.tx_size_255", stats.tx_size_255),
+	I40E_PF_STAT("port.tx_size_511", stats.tx_size_511),
+	I40E_PF_STAT("port.tx_size_1023", stats.tx_size_1023),
+	I40E_PF_STAT("port.tx_size_1522", stats.tx_size_1522),
+	I40E_PF_STAT("port.tx_size_big", stats.tx_size_big),
+	I40E_PF_STAT("port.rx_undersize", stats.rx_undersize),
+	I40E_PF_STAT("port.rx_fragments", stats.rx_fragments),
+	I40E_PF_STAT("port.rx_oversize", stats.rx_oversize),
+	I40E_PF_STAT("port.rx_jabber", stats.rx_jabber),
+	I40E_PF_STAT("port.VF_admin_queue_requests", vf_aq_requests),
+	I40E_PF_STAT("port.arq_overflows", arq_overflows),
+	I40E_PF_STAT("port.tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
+	I40E_PF_STAT("port.rx_hwtstamp_cleared", rx_hwtstamp_cleared),
+	I40E_PF_STAT("port.tx_hwtstamp_skipped", tx_hwtstamp_skipped),
+	I40E_PF_STAT("port.fdir_flush_cnt", fd_flush_cnt),
+	I40E_PF_STAT("port.fdir_atr_match", stats.fd_atr_match),
+	I40E_PF_STAT("port.fdir_atr_tunnel_match", stats.fd_atr_tunnel_match),
+	I40E_PF_STAT("port.fdir_atr_status", stats.fd_atr_status),
+	I40E_PF_STAT("port.fdir_sb_match", stats.fd_sb_match),
+	I40E_PF_STAT("port.fdir_sb_status", stats.fd_sb_status),
 
 	/* LPI stats */
-	I40E_PF_STAT("tx_lpi_status", stats.tx_lpi_status),
-	I40E_PF_STAT("rx_lpi_status", stats.rx_lpi_status),
-	I40E_PF_STAT("tx_lpi_count", stats.tx_lpi_count),
-	I40E_PF_STAT("rx_lpi_count", stats.rx_lpi_count),
+	I40E_PF_STAT("port.tx_lpi_status", stats.tx_lpi_status),
+	I40E_PF_STAT("port.rx_lpi_status", stats.rx_lpi_status),
+	I40E_PF_STAT("port.tx_lpi_count", stats.tx_lpi_count),
+	I40E_PF_STAT("port.rx_lpi_count", stats.rx_lpi_count),
 };
 
 /* We use num_tx_queues here as a proxy for the maximum number of queues
@@ -1699,7 +1700,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 		return;
 
 	for (i = 0; i < I40E_VEB_STATS_LEN; i++) {
-		snprintf(p, ETH_GSTRING_LEN, "veb.%s",
+		snprintf(p, ETH_GSTRING_LEN, "%s",
 			 i40e_gstrings_veb_stats[i].stat_string);
 		p += ETH_GSTRING_LEN;
 	}
@@ -1719,7 +1720,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 	}
 
 	for (i = 0; i < I40E_GLOBAL_STATS_LEN; i++) {
-		snprintf(p, ETH_GSTRING_LEN, "port.%s",
+		snprintf(p, ETH_GSTRING_LEN, "%s",
 			 i40e_gstrings_stats[i].stat_string);
 		p += ETH_GSTRING_LEN;
 	}
-- 
2.9.5

