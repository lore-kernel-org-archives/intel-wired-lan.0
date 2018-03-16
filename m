From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 16 Mar 2018 15:34:06 -0700
Subject: [Intel-wired-lan] [PATCH 5/5] ixgbevf: Add XDP queue stats reporting
In-Reply-To: <20180316223406.7295-1-anthony.l.nguyen@intel.com>
References: <20180316223406.7295-1-anthony.l.nguyen@intel.com>
Message-ID: <20180316223406.7295-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

XDP stats are included in TX stats, however, they are not
reported in TX queue stats since they are setup on different
queues.  Add reporting for XDP queue stats to provide
consistency between the total stats and per queue stats.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index da8c0e299a37..8e7d6c6f5c92 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -82,6 +82,7 @@ static struct ixgbe_stats ixgbevf_gstrings_stats[] = {
 
 #define IXGBEVF_QUEUE_STATS_LEN ( \
 	(((struct ixgbevf_adapter *)netdev_priv(netdev))->num_tx_queues + \
+	 ((struct ixgbevf_adapter *)netdev_priv(netdev))->num_xdp_queues + \
 	 ((struct ixgbevf_adapter *)netdev_priv(netdev))->num_rx_queues) * \
 	 (sizeof(struct ixgbevf_stats) / sizeof(u64)))
 #define IXGBEVF_GLOBAL_STATS_LEN ARRAY_SIZE(ixgbevf_gstrings_stats)
@@ -491,6 +492,23 @@ static void ixgbevf_get_ethtool_stats(struct net_device *netdev,
 		i += 2;
 	}
 
+	/* populate XDP queue data */
+	for (j = 0; j < adapter->num_xdp_queues; j++) {
+		ring = adapter->xdp_ring[j];
+		if (!ring) {
+			data[i++] = 0;
+			data[i++] = 0;
+			continue;
+		}
+
+		do {
+			start = u64_stats_fetch_begin_irq(&ring->syncp);
+			data[i] = ring->stats.packets;
+			data[i + 1] = ring->stats.bytes;
+		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
+		i += 2;
+	}
+
 	/* populate Rx queue data */
 	for (j = 0; j < adapter->num_rx_queues; j++) {
 		ring = adapter->rx_ring[j];
@@ -534,6 +552,12 @@ static void ixgbevf_get_strings(struct net_device *netdev, u32 stringset,
 			sprintf(p, "tx_queue_%u_bytes", i);
 			p += ETH_GSTRING_LEN;
 		}
+		for (i = 0; i < adapter->num_xdp_queues; i++) {
+			sprintf(p, "xdp_queue_%u_packets", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "xdp_queue_%u_bytes", i);
+			p += ETH_GSTRING_LEN;
+		}
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			sprintf(p, "rx_queue_%u_packets", i);
 			p += ETH_GSTRING_LEN;
-- 
2.13.6

