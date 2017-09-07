From: John Fastabend <john.fastabend@gmail.com>
Date: Thu, 07 Sep 2017 10:32:48 -0700
Subject: [Intel-wired-lan] [net PATCH] ixgbe: incorrect xdp ring accounting
 in ethtool tx_frame param
Message-ID: <20170907173248.7589.44547.stgit@john-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Changing the TX ring parameters with an XDP program attached may
cause the XDP queues to be cleared and the TX rings to be incorrectly
configured.

Fix by doing correct ring accounting in setup call.

Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 72c5657..c3e7a81 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1048,7 +1048,7 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_ring *temp_ring;
-	int i, err = 0;
+	int i, j, err = 0;
 	u32 new_rx_count, new_tx_count;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
@@ -1085,8 +1085,8 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
 	}
 
 	/* allocate temporary buffer to store rings in */
-	i = max_t(int, adapter->num_tx_queues, adapter->num_rx_queues);
-	i = max_t(int, i, adapter->num_xdp_queues);
+	i = max_t(int, adapter->num_tx_queues + adapter->num_xdp_queues,
+		  adapter->num_rx_queues);
 	temp_ring = vmalloc(i * sizeof(struct ixgbe_ring));
 
 	if (!temp_ring) {
@@ -1118,8 +1118,8 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
 			}
 		}
 
-		for (i = 0; i < adapter->num_xdp_queues; i++) {
-			memcpy(&temp_ring[i], adapter->xdp_ring[i],
+		for (j = 0; j < adapter->num_xdp_queues; j++, i++) {
+			memcpy(&temp_ring[i], adapter->xdp_ring[j],
 			       sizeof(struct ixgbe_ring));
 
 			temp_ring[i].count = new_tx_count;
@@ -1139,10 +1139,10 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
 			memcpy(adapter->tx_ring[i], &temp_ring[i],
 			       sizeof(struct ixgbe_ring));
 		}
-		for (i = 0; i < adapter->num_xdp_queues; i++) {
-			ixgbe_free_tx_resources(adapter->xdp_ring[i]);
+		for (j = 0; j < adapter->num_xdp_queues; j++, i++) {
+			ixgbe_free_tx_resources(adapter->xdp_ring[j]);
 
-			memcpy(adapter->xdp_ring[i], &temp_ring[i],
+			memcpy(adapter->xdp_ring[j], &temp_ring[i],
 			       sizeof(struct ixgbe_ring));
 		}
 

