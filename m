From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:43 -0800
Subject: [Intel-wired-lan] [PATCH S11 16/16] ice: fix overlong string,
 update stats output
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-17-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

A test started warning on a string truncation. This led to an unfortunate
realization that we are likely not accounting for the stats length
correctly before this patch, so fix the issue by putting "port." in front
of all the PF stats, instead of magically prepending it at runtime.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 80 ++++++++++++++--------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 295571b1c4e8..eb8d149e317c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -63,45 +63,45 @@ static const struct ice_stats ice_gstrings_vsi_stats[] = {
  * is queried on the base PF netdev.
  */
 static const struct ice_stats ice_gstrings_pf_stats[] = {
-	ICE_PF_STAT("tx_bytes", stats.eth.tx_bytes),
-	ICE_PF_STAT("rx_bytes", stats.eth.rx_bytes),
-	ICE_PF_STAT("tx_unicast", stats.eth.tx_unicast),
-	ICE_PF_STAT("rx_unicast", stats.eth.rx_unicast),
-	ICE_PF_STAT("tx_multicast", stats.eth.tx_multicast),
-	ICE_PF_STAT("rx_multicast", stats.eth.rx_multicast),
-	ICE_PF_STAT("tx_broadcast", stats.eth.tx_broadcast),
-	ICE_PF_STAT("rx_broadcast", stats.eth.rx_broadcast),
-	ICE_PF_STAT("tx_errors", stats.eth.tx_errors),
-	ICE_PF_STAT("tx_size_64", stats.tx_size_64),
-	ICE_PF_STAT("rx_size_64", stats.rx_size_64),
-	ICE_PF_STAT("tx_size_127", stats.tx_size_127),
-	ICE_PF_STAT("rx_size_127", stats.rx_size_127),
-	ICE_PF_STAT("tx_size_255", stats.tx_size_255),
-	ICE_PF_STAT("rx_size_255", stats.rx_size_255),
-	ICE_PF_STAT("tx_size_511", stats.tx_size_511),
-	ICE_PF_STAT("rx_size_511", stats.rx_size_511),
-	ICE_PF_STAT("tx_size_1023", stats.tx_size_1023),
-	ICE_PF_STAT("rx_size_1023", stats.rx_size_1023),
-	ICE_PF_STAT("tx_size_1522", stats.tx_size_1522),
-	ICE_PF_STAT("rx_size_1522", stats.rx_size_1522),
-	ICE_PF_STAT("tx_size_big", stats.tx_size_big),
-	ICE_PF_STAT("rx_size_big", stats.rx_size_big),
-	ICE_PF_STAT("link_xon_tx", stats.link_xon_tx),
-	ICE_PF_STAT("link_xon_rx", stats.link_xon_rx),
-	ICE_PF_STAT("link_xoff_tx", stats.link_xoff_tx),
-	ICE_PF_STAT("link_xoff_rx", stats.link_xoff_rx),
-	ICE_PF_STAT("tx_dropped_link_down", stats.tx_dropped_link_down),
-	ICE_PF_STAT("rx_undersize", stats.rx_undersize),
-	ICE_PF_STAT("rx_fragments", stats.rx_fragments),
-	ICE_PF_STAT("rx_oversize", stats.rx_oversize),
-	ICE_PF_STAT("rx_jabber", stats.rx_jabber),
-	ICE_PF_STAT("rx_csum_bad", hw_csum_rx_error),
-	ICE_PF_STAT("rx_length_errors", stats.rx_len_errors),
-	ICE_PF_STAT("rx_dropped", stats.eth.rx_discards),
-	ICE_PF_STAT("rx_crc_errors", stats.crc_errors),
-	ICE_PF_STAT("illegal_bytes", stats.illegal_bytes),
-	ICE_PF_STAT("mac_local_faults", stats.mac_local_faults),
-	ICE_PF_STAT("mac_remote_faults", stats.mac_remote_faults),
+	ICE_PF_STAT("port.tx_bytes", stats.eth.tx_bytes),
+	ICE_PF_STAT("port.rx_bytes", stats.eth.rx_bytes),
+	ICE_PF_STAT("port.tx_unicast", stats.eth.tx_unicast),
+	ICE_PF_STAT("port.rx_unicast", stats.eth.rx_unicast),
+	ICE_PF_STAT("port.tx_multicast", stats.eth.tx_multicast),
+	ICE_PF_STAT("port.rx_multicast", stats.eth.rx_multicast),
+	ICE_PF_STAT("port.tx_broadcast", stats.eth.tx_broadcast),
+	ICE_PF_STAT("port.rx_broadcast", stats.eth.rx_broadcast),
+	ICE_PF_STAT("port.tx_errors", stats.eth.tx_errors),
+	ICE_PF_STAT("port.tx_size_64", stats.tx_size_64),
+	ICE_PF_STAT("port.rx_size_64", stats.rx_size_64),
+	ICE_PF_STAT("port.tx_size_127", stats.tx_size_127),
+	ICE_PF_STAT("port.rx_size_127", stats.rx_size_127),
+	ICE_PF_STAT("port.tx_size_255", stats.tx_size_255),
+	ICE_PF_STAT("port.rx_size_255", stats.rx_size_255),
+	ICE_PF_STAT("port.tx_size_511", stats.tx_size_511),
+	ICE_PF_STAT("port.rx_size_511", stats.rx_size_511),
+	ICE_PF_STAT("port.tx_size_1023", stats.tx_size_1023),
+	ICE_PF_STAT("port.rx_size_1023", stats.rx_size_1023),
+	ICE_PF_STAT("port.tx_size_1522", stats.tx_size_1522),
+	ICE_PF_STAT("port.rx_size_1522", stats.rx_size_1522),
+	ICE_PF_STAT("port.tx_size_big", stats.tx_size_big),
+	ICE_PF_STAT("port.rx_size_big", stats.rx_size_big),
+	ICE_PF_STAT("port.link_xon_tx", stats.link_xon_tx),
+	ICE_PF_STAT("port.link_xon_rx", stats.link_xon_rx),
+	ICE_PF_STAT("port.link_xoff_tx", stats.link_xoff_tx),
+	ICE_PF_STAT("port.link_xoff_rx", stats.link_xoff_rx),
+	ICE_PF_STAT("port.tx_dropped_link_down", stats.tx_dropped_link_down),
+	ICE_PF_STAT("port.rx_undersize", stats.rx_undersize),
+	ICE_PF_STAT("port.rx_fragments", stats.rx_fragments),
+	ICE_PF_STAT("port.rx_oversize", stats.rx_oversize),
+	ICE_PF_STAT("port.rx_jabber", stats.rx_jabber),
+	ICE_PF_STAT("port.rx_csum_bad", hw_csum_rx_error),
+	ICE_PF_STAT("port.rx_length_errors", stats.rx_len_errors),
+	ICE_PF_STAT("port.rx_dropped", stats.eth.rx_discards),
+	ICE_PF_STAT("port.rx_crc_errors", stats.crc_errors),
+	ICE_PF_STAT("port.illegal_bytes", stats.illegal_bytes),
+	ICE_PF_STAT("port.mac_local_faults", stats.mac_local_faults),
+	ICE_PF_STAT("port.mac_remote_faults", stats.mac_remote_faults),
 };
 
 static const u32 ice_regs_dump_list[] = {
@@ -304,7 +304,7 @@ static void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 			return;
 
 		for (i = 0; i < ICE_PF_STATS_LEN; i++) {
-			snprintf(p, ETH_GSTRING_LEN, "port.%s",
+			snprintf(p, ETH_GSTRING_LEN, "%s",
 				 ice_gstrings_pf_stats[i].stat_string);
 			p += ETH_GSTRING_LEN;
 		}
-- 
2.14.5

