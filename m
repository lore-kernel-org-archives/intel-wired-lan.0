From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  4 Dec 2017 21:35:15 -0800
Subject: [Intel-wired-lan] [next-queue 09/10] ixgbe: ipsec offload stats
In-Reply-To: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1512452116-14795-10-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a simple statistic to count the ipsec offloads.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 28 ++++++++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c   |  3 +++
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 68097fe..bb66c85 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -265,6 +265,7 @@ struct ixgbe_rx_buffer {
 struct ixgbe_queue_stats {
 	u64 packets;
 	u64 bytes;
+	u64 ipsec_offloads;
 };
 
 struct ixgbe_tx_queue_stats {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index c3e7a81..dddbc74 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1233,34 +1233,34 @@ static void ixgbe_get_ethtool_stats(struct net_device *netdev,
 	for (j = 0; j < netdev->num_tx_queues; j++) {
 		ring = adapter->tx_ring[j];
 		if (!ring) {
-			data[i] = 0;
-			data[i+1] = 0;
-			i += 2;
+			data[i++] = 0;
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
+			data[i++] = ring->stats.ipsec_offloads;
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
+			data[i++] = 0;
 			continue;
 		}
 
 		do {
 			start = u64_stats_fetch_begin_irq(&ring->syncp);
-			data[i]   = ring->stats.packets;
-			data[i+1] = ring->stats.bytes;
+			data[i++] = ring->stats.packets;
+			data[i++] = ring->stats.bytes;
+			data[i++] = ring->stats.ipsec_offloads;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
-		i += 2;
 	}
 
 	for (j = 0; j < IXGBE_MAX_PACKET_BUFFERS; j++) {
@@ -1297,12 +1297,16 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 			p += ETH_GSTRING_LEN;
 			sprintf(p, "tx_queue_%u_bytes", i);
 			p += ETH_GSTRING_LEN;
+			sprintf(p, "tx_queue_%u_ipsec_offloads", i);
+			p += ETH_GSTRING_LEN;
 		}
 		for (i = 0; i < IXGBE_NUM_RX_QUEUES; i++) {
 			sprintf(p, "rx_queue_%u_packets", i);
 			p += ETH_GSTRING_LEN;
 			sprintf(p, "rx_queue_%u_bytes", i);
 			p += ETH_GSTRING_LEN;
+			sprintf(p, "rx_queue_%u_ipsec_offloads", i);
+			p += ETH_GSTRING_LEN;
 		}
 		for (i = 0; i < IXGBE_MAX_PACKET_BUFFERS; i++) {
 			sprintf(p, "tx_pb_%u_pxon", i);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 2a0dd7a..d1220bf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -782,6 +782,7 @@ int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring, struct sk_buff *skb,
 	if (tsa->encrypt)
 		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN;
 
+	tx_ring->stats.ipsec_offloads++;
 	return 1;
 }
 
@@ -843,6 +844,8 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 	xo = xfrm_offload(skb);
 	xo->flags = CRYPTO_DONE;
 	xo->status = CRYPTO_SUCCESS;
+
+	rx_ring->stats.ipsec_offloads++;
 }
 
 /**
-- 
2.7.4

