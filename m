From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 16 Nov 2017 11:54:43 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 5/9] ixgbe: add
 ipsec offload stats
In-Reply-To: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1510862087-1924-6-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ipsec offload and offload_failed queue data to the ethtool stats
output.  I'm not thrilled with adding these to every single queue, but
for the moment they're useful for debugging.  This may not be a part of
the final patchset.

While we're here, fix up a little array-index management to make it a
little less likely to forget to update.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 31 +++++++++++++-----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 0aad1c2..e798f02 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -134,9 +134,10 @@ static const struct ixgbe_stats ixgbe_gstrings_stats[] = {
  */
 #define IXGBE_NUM_RX_QUEUES netdev->num_tx_queues
 
-#define IXGBE_QUEUE_STATS_LEN ( \
+#define IXGBE_QUEUE_STATS_LEN (( \
 	(netdev->num_tx_queues + IXGBE_NUM_RX_QUEUES) * \
-	(sizeof(struct ixgbe_queue_stats) / sizeof(u64)))
+	(sizeof(struct ixgbe_queue_stats) / sizeof(u64))) + \
+	(2 * IXGBE_NUM_RX_QUEUES))
 #define IXGBE_GLOBAL_STATS_LEN ARRAY_SIZE(ixgbe_gstrings_stats)
 #define IXGBE_PB_STATS_LEN ( \
 			(sizeof(((struct ixgbe_adapter *)0)->stats.pxonrxc) + \
@@ -1234,34 +1235,32 @@ static void ixgbe_get_ethtool_stats(struct net_device *netdev,
 	for (j = 0; j < netdev->num_tx_queues; j++) {
 		ring = adapter->tx_ring[j];
 		if (!ring) {
-			data[i] = 0;
-			data[i+1] = 0;
-			i += 2;
+			data[i++] = 0;
+			data[i++] = 0;
 			continue;
 		}
 
 		do {
 			start = u64_stats_fetch_begin_irq(&ring->syncp);
-			data[i]   = ring->stats.packets;
-			data[i+1] = ring->stats.bytes;
+			data[i++]   = ring->stats.packets;
+			data[i++] = ring->stats.bytes;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
-		i += 2;
 	}
 	for (j = 0; j < IXGBE_NUM_RX_QUEUES; j++) {
 		ring = adapter->rx_ring[j];
 		if (!ring) {
-			data[i] = 0;
-			data[i+1] = 0;
-			i += 2;
+			data[i++] = 0;
+			data[i++] = 0;
 			continue;
 		}
 
 		do {
 			start = u64_stats_fetch_begin_irq(&ring->syncp);
-			data[i]   = ring->stats.packets;
-			data[i+1] = ring->stats.bytes;
+			data[i++] = ring->stats.packets;
+			data[i++] = ring->stats.bytes;
+			data[i++] = ring->rx_stats.ipsec_offloads;
+			data[i++] = ring->rx_stats.ipsec_offload_faileds;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
-		i += 2;
 	}
 
 	for (j = 0; j < IXGBE_MAX_PACKET_BUFFERS; j++) {
@@ -1304,6 +1303,10 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 			p += ETH_GSTRING_LEN;
 			sprintf(p, "rx_queue_%u_bytes", i);
 			p += ETH_GSTRING_LEN;
+			sprintf(p, "rx_queue_%u_ipsec_offloads", i);
+			p += ETH_GSTRING_LEN;
+			sprintf(p, "rx_queue_%u_ipsec_offload_faileds", i);
+			p += ETH_GSTRING_LEN;
 		}
 		for (i = 0; i < IXGBE_MAX_PACKET_BUFFERS; i++) {
 			sprintf(p, "tx_pb_%u_pxon", i);
-- 
2.7.4

