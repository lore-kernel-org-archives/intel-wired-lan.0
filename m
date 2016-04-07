From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 07 Apr 2016 15:58:44 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: add support for per-queue
	ethtool stats
In-Reply-To: <20160407225839.28139.26733.stgit@localhost6.localdomain6>
References: <20160407225839.28139.26733.stgit@localhost6.localdomain6>
Message-ID: <20160407225844.28139.2180.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Implement per-queue statistics for packets, bytes and busy poll
specific counters.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c |  127 +++++++++++++++++++-------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |   10 --
 2 files changed, 91 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index cd4d311..64d5c6e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -75,14 +75,6 @@ static struct ixgbe_stats ixgbevf_gstrings_stats[] = {
 	IXGBEVF_STAT("tx_timeout_count", tx_timeout_count),
 	IXGBEVF_NETDEV_STAT(multicast),
 	IXGBEVF_STAT("rx_csum_offload_errors", hw_csum_rx_error),
-#ifdef BP_EXTENDED_STATS
-	IXGBEVF_STAT("rx_bp_poll_yield", bp_rx_yields),
-	IXGBEVF_STAT("rx_bp_cleaned", bp_rx_cleaned),
-	IXGBEVF_STAT("rx_bp_misses", bp_rx_missed),
-	IXGBEVF_STAT("tx_bp_napi_yield", bp_tx_yields),
-	IXGBEVF_STAT("tx_bp_cleaned", bp_tx_cleaned),
-	IXGBEVF_STAT("tx_bp_misses", bp_tx_missed),
-#endif
 };
 
 #define IXGBEVF_QUEUE_STATS_LEN ( \
@@ -389,13 +381,13 @@ clear_reset:
 	return err;
 }
 
-static int ixgbevf_get_sset_count(struct net_device *dev, int stringset)
+static int ixgbevf_get_sset_count(struct net_device *netdev, int stringset)
 {
 	switch (stringset) {
 	case ETH_SS_TEST:
 		return IXGBEVF_TEST_LEN;
 	case ETH_SS_STATS:
-		return IXGBEVF_GLOBAL_STATS_LEN;
+		return IXGBEVF_STATS_LEN;
 	default:
 		return -EINVAL;
 	}
@@ -407,34 +399,11 @@ static void ixgbevf_get_ethtool_stats(struct net_device *netdev,
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 	struct rtnl_link_stats64 temp;
 	const struct rtnl_link_stats64 *net_stats;
-	int i;
+	unsigned int start;
+	struct ixgbevf_ring *ring;
+	int i, j;
 	char *p;
 
-#ifdef BP_EXTENDED_STATS
-	u64 rx_yields = 0, rx_cleaned = 0, rx_missed = 0,
-	    tx_yields = 0, tx_cleaned = 0, tx_missed = 0;
-
-	for (i = 0; i < adapter->num_rx_queues; i++) {
-		rx_yields += adapter->rx_ring[i]->stats.yields;
-		rx_cleaned += adapter->rx_ring[i]->stats.cleaned;
-		rx_yields += adapter->rx_ring[i]->stats.yields;
-	}
-
-	for (i = 0; i < adapter->num_tx_queues; i++) {
-		tx_yields += adapter->tx_ring[i]->stats.yields;
-		tx_cleaned += adapter->tx_ring[i]->stats.cleaned;
-		tx_yields += adapter->tx_ring[i]->stats.yields;
-	}
-
-	adapter->bp_rx_yields = rx_yields;
-	adapter->bp_rx_cleaned = rx_cleaned;
-	adapter->bp_rx_missed = rx_missed;
-
-	adapter->bp_tx_yields = tx_yields;
-	adapter->bp_tx_cleaned = tx_cleaned;
-	adapter->bp_tx_missed = tx_missed;
-#endif
-
 	ixgbevf_update_stats(adapter);
 	net_stats = dev_get_stats(netdev, &temp);
 	for (i = 0; i < IXGBEVF_GLOBAL_STATS_LEN; i++) {
@@ -455,11 +424,68 @@ static void ixgbevf_get_ethtool_stats(struct net_device *netdev,
 		data[i] = (ixgbevf_gstrings_stats[i].sizeof_stat ==
 			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
+
+	/* populate Tx queue data */
+	for (j = 0; j < adapter->num_tx_queues; j++) {
+		ring = adapter->tx_ring[j];
+		if (!ring) {
+			data[i++] = 0;
+			data[i++] = 0;
+#ifdef BP_EXTENDED_STATS
+			data[i++] = 0;
+			data[i++] = 0;
+			data[i++] = 0;
+#endif
+			continue;
+		}
+
+		do {
+			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			data[i]   = ring->stats.packets;
+			data[i + 1] = ring->stats.bytes;
+		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		i += 2;
+#ifdef BP_EXTENDED_STATS
+		data[i] = ring->stats.yields;
+		data[i + 1] = ring->stats.misses;
+		data[i + 2] = ring->stats.cleaned;
+		i += 3;
+#endif
+	}
+
+	/* populate Rx queue data */
+	for (j = 0; j < adapter->num_rx_queues; j++) {
+		ring = adapter->rx_ring[j];
+		if (!ring) {
+			data[i++] = 0;
+			data[i++] = 0;
+#ifdef BP_EXTENDED_STATS
+			data[i++] = 0;
+			data[i++] = 0;
+			data[i++] = 0;
+#endif
+			continue;
+		}
+
+		do {
+			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			data[i]   = ring->stats.packets;
+			data[i + 1] = ring->stats.bytes;
+		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		i += 2;
+#ifdef BP_EXTENDED_STATS
+		data[i] = ring->stats.yields;
+		data[i + 1] = ring->stats.misses;
+		data[i + 2] = ring->stats.cleaned;
+		i += 3;
+#endif
+	}
 }
 
 static void ixgbevf_get_strings(struct net_device *netdev, u32 stringset,
 				u8 *data)
 {
+	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 	char *p = (char *)data;
 	int i;
 
@@ -474,6 +500,35 @@ static void ixgbevf_get_strings(struct net_device *netdev, u32 stringset,
 			       ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
+
+		for (i = 0; i < adapter->num_tx_queues; i++) {
+			sprintf(p, "tx_queue_%u_packets", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "tx_queue_%u_bytes", i);
+			p += ETH_GSTRING_LEN;
+#ifdef BP_EXTENDED_STATS
+			sprintf(p, "tx_queue_%u_bp_napi_yield", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "tx_queue_%u_bp_misses", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "tx_queue_%u_bp_cleaned", i);
+			p += ETH_GSTRING_LEN;
+#endif /* BP_EXTENDED_STATS */
+		}
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			sprintf(p, "rx_queue_%u_packets", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "rx_queue_%u_bytes", i);
+			p += ETH_GSTRING_LEN;
+#ifdef BP_EXTENDED_STATS
+			sprintf(p, "rx_queue_%u_bp_poll_yield", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "rx_queue_%u_bp_misses", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "rx_queue_%u_bp_cleaned", i);
+			p += ETH_GSTRING_LEN;
+#endif /* BP_EXTENDED_STATS */
+		}
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 5ac60ee..5ca3794 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -422,16 +422,6 @@ struct ixgbevf_adapter {
 	unsigned int tx_ring_count;
 	unsigned int rx_ring_count;
 
-#ifdef BP_EXTENDED_STATS
-	u64 bp_rx_yields;
-	u64 bp_rx_cleaned;
-	u64 bp_rx_missed;
-
-	u64 bp_tx_yields;
-	u64 bp_tx_cleaned;
-	u64 bp_tx_missed;
-#endif
-
 	u8 __iomem *io_addr; /* Mainly for iounmap use */
 	u32 link_speed;
 	bool link_up;

