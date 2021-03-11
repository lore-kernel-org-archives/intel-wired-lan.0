From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Mar 2021 17:36:10 -0800
Subject: [Intel-wired-lan] [RFC PATCH 09/10] bna: Update driver to use
 ethtool_gsprintf
In-Reply-To: <161542634192.13546.4185974647834631704.stgit@localhost.localdomain>
References: <161542634192.13546.4185974647834631704.stgit@localhost.localdomain>
Message-ID: <161542657091.13546.17503493571307422104.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexanderduyck@fb.com>

Update the bnad_get_strings to make use of ethtool_gsprintf and avoid
unnecessary line wrapping. To do this we invert the logic for the string
set test and instead exit immediately if we are not working with the stats
strings. In addition the function is broken up into subfunctions for each
area so that we can simply call ethtool_gsprintf once for each string in a
given subsection.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c |  266 +++++++++--------------
 1 file changed, 105 insertions(+), 161 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
index 588c4804d10a..9d72f896880d 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
@@ -524,6 +524,68 @@ bnad_set_pauseparam(struct net_device *netdev,
 	return 0;
 }
 
+static void bnad_get_txf_strings(u8 **string, int f_num)
+{
+	ethtool_gsprintf(string, "txf%d_ucast_octets", f_num);
+	ethtool_gsprintf(string, "txf%d_ucast", f_num);
+	ethtool_gsprintf(string, "txf%d_ucast_vlan", f_num);
+	ethtool_gsprintf(string, "txf%d_mcast_octets", f_num);
+	ethtool_gsprintf(string, "txf%d_mcast", f_num);
+	ethtool_gsprintf(string, "txf%d_mcast_vlan", f_num);
+	ethtool_gsprintf(string, "txf%d_bcast_octets", f_num);
+	ethtool_gsprintf(string, "txf%d_bcast", f_num);
+	ethtool_gsprintf(string, "txf%d_bcast_vlan", f_num);
+	ethtool_gsprintf(string, "txf%d_errors", f_num);
+	ethtool_gsprintf(string, "txf%d_filter_vlan", f_num);
+	ethtool_gsprintf(string, "txf%d_filter_mac_sa", f_num);
+}
+
+static void bnad_get_rxf_strings(u8 **string, int f_num)
+{
+	ethtool_gsprintf(string, "rxf%d_ucast_octets", f_num);
+	ethtool_gsprintf(string, "rxf%d_ucast", f_num);
+	ethtool_gsprintf(string, "rxf%d_ucast_vlan", f_num);
+	ethtool_gsprintf(string, "rxf%d_mcast_octets", f_num);
+	ethtool_gsprintf(string, "rxf%d_mcast", f_num);
+	ethtool_gsprintf(string, "rxf%d_mcast_vlan", f_num);
+	ethtool_gsprintf(string, "rxf%d_bcast_octets", f_num);
+	ethtool_gsprintf(string, "rxf%d_bcast", f_num);
+	ethtool_gsprintf(string, "rxf%d_bcast_vlan", f_num);
+	ethtool_gsprintf(string, "rxf%d_frame_drops", f_num);
+}
+
+static void bnad_get_cq_strings(u8 **string, int q_num)
+{
+	ethtool_gsprintf(string, "cq%d_producer_index", q_num);
+	ethtool_gsprintf(string, "cq%d_consumer_index", q_num);
+	ethtool_gsprintf(string, "cq%d_hw_producer_index", q_num);
+	ethtool_gsprintf(string, "cq%d_intr", q_num);
+	ethtool_gsprintf(string, "cq%d_poll", q_num);
+	ethtool_gsprintf(string, "cq%d_schedule", q_num);
+	ethtool_gsprintf(string, "cq%d_keep_poll", q_num);
+	ethtool_gsprintf(string, "cq%d_complete", q_num);
+}
+
+static void bnad_get_rxq_strings(u8 **string, int q_num)
+{
+	ethtool_gsprintf(string, "rxq%d_packets", q_num);
+	ethtool_gsprintf(string, "rxq%d_bytes", q_num);
+	ethtool_gsprintf(string, "rxq%d_packets_with_error", q_num);
+	ethtool_gsprintf(string, "rxq%d_allocbuf_failed", q_num);
+	ethtool_gsprintf(string, "rxq%d_mapbuf_failed", q_num);
+	ethtool_gsprintf(string, "rxq%d_producer_index", q_num);
+	ethtool_gsprintf(string, "rxq%d_consumer_index", q_num);
+}
+
+static void bnad_get_txq_strings(u8 **string, int q_num)
+{
+	ethtool_gsprintf(string, "txq%d_packets", q_num);
+	ethtool_gsprintf(string, "txq%d_bytes", q_num);
+	ethtool_gsprintf(string, "txq%d_producer_index", q_num);
+	ethtool_gsprintf(string, "txq%d_consumer_index", q_num);
+	ethtool_gsprintf(string, "txq%d_hw_consumer_index", q_num);
+}
+
 static void
 bnad_get_strings(struct net_device *netdev, u32 stringset, u8 *string)
 {
@@ -531,175 +593,57 @@ bnad_get_strings(struct net_device *netdev, u32 stringset, u8 *string)
 	int i, j, q_num;
 	u32 bmap;
 
+	if (stringset != ETH_SS_STATS)
+		return;
+
 	mutex_lock(&bnad->conf_mutex);
 
-	switch (stringset) {
-	case ETH_SS_STATS:
-		for (i = 0; i < BNAD_ETHTOOL_STATS_NUM; i++) {
-			BUG_ON(!(strlen(bnad_net_stats_strings[i]) <
-				   ETH_GSTRING_LEN));
-			strncpy(string, bnad_net_stats_strings[i],
-				ETH_GSTRING_LEN);
-			string += ETH_GSTRING_LEN;
-		}
-		bmap = bna_tx_rid_mask(&bnad->bna);
-		for (i = 0; bmap; i++) {
-			if (bmap & 1) {
-				sprintf(string, "txf%d_ucast_octets", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_ucast", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_ucast_vlan", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_mcast_octets", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_mcast", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_mcast_vlan", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_bcast_octets", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_bcast", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_bcast_vlan", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_errors", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_filter_vlan", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txf%d_filter_mac_sa", i);
-				string += ETH_GSTRING_LEN;
-			}
-			bmap >>= 1;
-		}
+	for (i = 0; i < BNAD_ETHTOOL_STATS_NUM; i++) {
+		BUG_ON(!(strlen(bnad_net_stats_strings[i]) < ETH_GSTRING_LEN));
+		ethtool_gsprintf(&string, bnad_net_stats_strings[i]);
+	}
 
-		bmap = bna_rx_rid_mask(&bnad->bna);
-		for (i = 0; bmap; i++) {
-			if (bmap & 1) {
-				sprintf(string, "rxf%d_ucast_octets", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_ucast", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_ucast_vlan", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_mcast_octets", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_mcast", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_mcast_vlan", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_bcast_octets", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_bcast", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_bcast_vlan", i);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxf%d_frame_drops", i);
-				string += ETH_GSTRING_LEN;
-			}
-			bmap >>= 1;
-		}
+	bmap = bna_tx_rid_mask(&bnad->bna);
+	for (i = 0; bmap; i++) {
+		if (bmap & 1)
+			bnad_get_txf_strings(&string, i);
+		bmap >>= 1;
+	}
 
-		q_num = 0;
-		for (i = 0; i < bnad->num_rx; i++) {
-			if (!bnad->rx_info[i].rx)
-				continue;
-			for (j = 0; j < bnad->num_rxp_per_rx; j++) {
-				sprintf(string, "cq%d_producer_index", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "cq%d_consumer_index", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "cq%d_hw_producer_index",
-					q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "cq%d_intr", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "cq%d_poll", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "cq%d_schedule", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "cq%d_keep_poll", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "cq%d_complete", q_num);
-				string += ETH_GSTRING_LEN;
-				q_num++;
-			}
-		}
+	bmap = bna_rx_rid_mask(&bnad->bna);
+	for (i = 0; bmap; i++, bmap >>= 1) {
+		if (bmap & 1)
+			bnad_get_rxf_strings(&string, i);
+		bmap >>= 1;
+	}
 
-		q_num = 0;
-		for (i = 0; i < bnad->num_rx; i++) {
-			if (!bnad->rx_info[i].rx)
-				continue;
-			for (j = 0; j < bnad->num_rxp_per_rx; j++) {
-				sprintf(string, "rxq%d_packets", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxq%d_bytes", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxq%d_packets_with_error",
-								q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxq%d_allocbuf_failed", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxq%d_mapbuf_failed", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxq%d_producer_index", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "rxq%d_consumer_index", q_num);
-				string += ETH_GSTRING_LEN;
-				q_num++;
-				if (bnad->rx_info[i].rx_ctrl[j].ccb &&
-					bnad->rx_info[i].rx_ctrl[j].ccb->
-					rcb[1] &&
-					bnad->rx_info[i].rx_ctrl[j].ccb->
-					rcb[1]->rxq) {
-					sprintf(string, "rxq%d_packets", q_num);
-					string += ETH_GSTRING_LEN;
-					sprintf(string, "rxq%d_bytes", q_num);
-					string += ETH_GSTRING_LEN;
-					sprintf(string,
-					"rxq%d_packets_with_error", q_num);
-					string += ETH_GSTRING_LEN;
-					sprintf(string, "rxq%d_allocbuf_failed",
-								q_num);
-					string += ETH_GSTRING_LEN;
-					sprintf(string, "rxq%d_mapbuf_failed",
-						q_num);
-					string += ETH_GSTRING_LEN;
-					sprintf(string, "rxq%d_producer_index",
-								q_num);
-					string += ETH_GSTRING_LEN;
-					sprintf(string, "rxq%d_consumer_index",
-								q_num);
-					string += ETH_GSTRING_LEN;
-					q_num++;
-				}
-			}
-		}
+	q_num = 0;
+	for (i = 0; i < bnad->num_rx; i++) {
+		if (!bnad->rx_info[i].rx)
+			continue;
+		for (j = 0; j < bnad->num_rxp_per_rx; j++)
+			bnad_get_cq_strings(&string, q_num++);
+	}
 
-		q_num = 0;
-		for (i = 0; i < bnad->num_tx; i++) {
-			if (!bnad->tx_info[i].tx)
-				continue;
-			for (j = 0; j < bnad->num_txq_per_tx; j++) {
-				sprintf(string, "txq%d_packets", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txq%d_bytes", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txq%d_producer_index", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txq%d_consumer_index", q_num);
-				string += ETH_GSTRING_LEN;
-				sprintf(string, "txq%d_hw_consumer_index",
-									q_num);
-				string += ETH_GSTRING_LEN;
-				q_num++;
-			}
+	q_num = 0;
+	for (i = 0; i < bnad->num_rx; i++) {
+		if (!bnad->rx_info[i].rx)
+			continue;
+		for (j = 0; j < bnad->num_rxp_per_rx; j++) {
+			bnad_get_rxq_strings(&string, q_num++);
+			if (bnad->rx_info[i].rx_ctrl[j].ccb &&
+			    bnad->rx_info[i].rx_ctrl[j].ccb->rcb[1] &&
+			    bnad->rx_info[i].rx_ctrl[j].ccb->rcb[1]->rxq)
+				bnad_get_rxq_strings(&string, q_num++);
 		}
+	}
 
-		break;
-
-	default:
-		break;
+	q_num = 0;
+	for (i = 0; i < bnad->num_tx; i++) {
+		if (!bnad->tx_info[i].tx)
+			continue;
+		for (j = 0; j < bnad->num_txq_per_tx; j++)
+			bnad_get_txq_strings(&string, q_num++);
 	}
 
 	mutex_unlock(&bnad->conf_mutex);


