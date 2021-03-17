From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 16 Mar 2021 17:31:55 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 10/10] ionic: Update driver to
 use ethtool_sprintf
In-Reply-To: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
References: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
Message-ID: <161594111532.5644.3540447704803147733.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexanderduyck@fb.com>

Update the ionic driver to make use of ethtool_sprintf. In addition add
separate functions for Tx/Rx stats strings in order to reduce the total
amount of indenting needed in the driver code.

Acked-by: Shannon Nelson <snelson@pensando.io>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_stats.c |  145 +++++++++------------
 1 file changed, 60 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 6ae75b771a15..308b4ac6c57b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -246,98 +246,73 @@ static u64 ionic_sw_stats_get_count(struct ionic_lif *lif)
 	return total;
 }
 
+static void ionic_sw_stats_get_tx_strings(struct ionic_lif *lif, u8 **buf,
+					  int q_num)
+{
+	int i;
+
+	for (i = 0; i < IONIC_NUM_TX_STATS; i++)
+		ethtool_sprintf(buf, "tx_%d_%s", q_num,
+				ionic_tx_stats_desc[i].name);
+
+	if (!test_bit(IONIC_LIF_F_UP, lif->state) ||
+	    !test_bit(IONIC_LIF_F_SW_DEBUG_STATS, lif->state))
+		return;
+
+	for (i = 0; i < IONIC_NUM_TX_Q_STATS; i++)
+		ethtool_sprintf(buf, "txq_%d_%s", q_num,
+				ionic_txq_stats_desc[i].name);
+	for (i = 0; i < IONIC_NUM_DBG_CQ_STATS; i++)
+		ethtool_sprintf(buf, "txq_%d_cq_%s", q_num,
+				ionic_dbg_cq_stats_desc[i].name);
+	for (i = 0; i < IONIC_NUM_DBG_INTR_STATS; i++)
+		ethtool_sprintf(buf, "txq_%d_intr_%s", q_num,
+				ionic_dbg_intr_stats_desc[i].name);
+	for (i = 0; i < IONIC_MAX_NUM_SG_CNTR; i++)
+		ethtool_sprintf(buf, "txq_%d_sg_cntr_%d", q_num, i);
+}
+
+static void ionic_sw_stats_get_rx_strings(struct ionic_lif *lif, u8 **buf,
+					  int q_num)
+{
+	int i;
+
+	for (i = 0; i < IONIC_NUM_RX_STATS; i++)
+		ethtool_sprintf(buf, "rx_%d_%s", q_num,
+				ionic_rx_stats_desc[i].name);
+
+	if (!test_bit(IONIC_LIF_F_UP, lif->state) ||
+	    !test_bit(IONIC_LIF_F_SW_DEBUG_STATS, lif->state))
+		return;
+
+	for (i = 0; i < IONIC_NUM_DBG_CQ_STATS; i++)
+		ethtool_sprintf(buf, "rxq_%d_cq_%s", q_num,
+				ionic_dbg_cq_stats_desc[i].name);
+	for (i = 0; i < IONIC_NUM_DBG_INTR_STATS; i++)
+		ethtool_sprintf(buf, "rxq_%d_intr_%s", q_num,
+				ionic_dbg_intr_stats_desc[i].name);
+	for (i = 0; i < IONIC_NUM_DBG_NAPI_STATS; i++)
+		ethtool_sprintf(buf, "rxq_%d_napi_%s", q_num,
+				ionic_dbg_napi_stats_desc[i].name);
+	for (i = 0; i < IONIC_MAX_NUM_NAPI_CNTR; i++)
+		ethtool_sprintf(buf, "rxq_%d_napi_work_done_%d", q_num, i);
+}
+
 static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
 {
 	int i, q_num;
 
-	for (i = 0; i < IONIC_NUM_LIF_STATS; i++) {
-		snprintf(*buf, ETH_GSTRING_LEN, ionic_lif_stats_desc[i].name);
-		*buf += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < IONIC_NUM_LIF_STATS; i++)
+		ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
 
-	for (i = 0; i < IONIC_NUM_PORT_STATS; i++) {
-		snprintf(*buf, ETH_GSTRING_LEN,
-			 ionic_port_stats_desc[i].name);
-		*buf += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
+		ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
 
-	for (q_num = 0; q_num < MAX_Q(lif); q_num++) {
-		for (i = 0; i < IONIC_NUM_TX_STATS; i++) {
-			snprintf(*buf, ETH_GSTRING_LEN, "tx_%d_%s",
-				 q_num, ionic_tx_stats_desc[i].name);
-			*buf += ETH_GSTRING_LEN;
-		}
+	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
+		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
 
-		if (test_bit(IONIC_LIF_F_UP, lif->state) &&
-		    test_bit(IONIC_LIF_F_SW_DEBUG_STATS, lif->state)) {
-			for (i = 0; i < IONIC_NUM_TX_Q_STATS; i++) {
-				snprintf(*buf, ETH_GSTRING_LEN,
-					 "txq_%d_%s",
-					 q_num,
-					 ionic_txq_stats_desc[i].name);
-				*buf += ETH_GSTRING_LEN;
-			}
-			for (i = 0; i < IONIC_NUM_DBG_CQ_STATS; i++) {
-				snprintf(*buf, ETH_GSTRING_LEN,
-					 "txq_%d_cq_%s",
-					 q_num,
-					 ionic_dbg_cq_stats_desc[i].name);
-				*buf += ETH_GSTRING_LEN;
-			}
-			for (i = 0; i < IONIC_NUM_DBG_INTR_STATS; i++) {
-				snprintf(*buf, ETH_GSTRING_LEN,
-					 "txq_%d_intr_%s",
-					 q_num,
-					 ionic_dbg_intr_stats_desc[i].name);
-				*buf += ETH_GSTRING_LEN;
-			}
-			for (i = 0; i < IONIC_MAX_NUM_SG_CNTR; i++) {
-				snprintf(*buf, ETH_GSTRING_LEN,
-					 "txq_%d_sg_cntr_%d",
-					 q_num, i);
-				*buf += ETH_GSTRING_LEN;
-			}
-		}
-	}
-	for (q_num = 0; q_num < MAX_Q(lif); q_num++) {
-		for (i = 0; i < IONIC_NUM_RX_STATS; i++) {
-			snprintf(*buf, ETH_GSTRING_LEN,
-				 "rx_%d_%s",
-				 q_num, ionic_rx_stats_desc[i].name);
-			*buf += ETH_GSTRING_LEN;
-		}
-
-		if (test_bit(IONIC_LIF_F_UP, lif->state) &&
-		    test_bit(IONIC_LIF_F_SW_DEBUG_STATS, lif->state)) {
-			for (i = 0; i < IONIC_NUM_DBG_CQ_STATS; i++) {
-				snprintf(*buf, ETH_GSTRING_LEN,
-					 "rxq_%d_cq_%s",
-					 q_num,
-					 ionic_dbg_cq_stats_desc[i].name);
-				*buf += ETH_GSTRING_LEN;
-			}
-			for (i = 0; i < IONIC_NUM_DBG_INTR_STATS; i++) {
-				snprintf(*buf, ETH_GSTRING_LEN,
-					 "rxq_%d_intr_%s",
-					 q_num,
-					 ionic_dbg_intr_stats_desc[i].name);
-				*buf += ETH_GSTRING_LEN;
-			}
-			for (i = 0; i < IONIC_NUM_DBG_NAPI_STATS; i++) {
-				snprintf(*buf, ETH_GSTRING_LEN,
-					 "rxq_%d_napi_%s",
-					 q_num,
-					 ionic_dbg_napi_stats_desc[i].name);
-				*buf += ETH_GSTRING_LEN;
-			}
-			for (i = 0; i < IONIC_MAX_NUM_NAPI_CNTR; i++) {
-				snprintf(*buf, ETH_GSTRING_LEN,
-					 "rxq_%d_napi_work_done_%d",
-					 q_num, i);
-				*buf += ETH_GSTRING_LEN;
-			}
-		}
-	}
+	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
+		ionic_sw_stats_get_rx_strings(lif, buf, q_num);
 }
 
 static void ionic_sw_stats_get_values(struct ionic_lif *lif, u64 **buf)


