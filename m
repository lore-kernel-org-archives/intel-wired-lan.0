From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 25 Oct 2021 17:08:23 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 1/4] ice: update to newer
 kernel API
In-Reply-To: <20211026000826.156803-1-jesse.brandeburg@intel.com>
References: <20211026000826.156803-1-jesse.brandeburg@intel.com>
Message-ID: <20211026000826.156803-2-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the netif_tx_* API from netdevice.h which has simpler parameters.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Testing Hints: test transmit performance and queue
start/stop tests which increment tx_restart counter.
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index bc3ba19dc88f..12a2edd13877 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -304,8 +304,10 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 
 	ice_update_tx_ring_stats(tx_ring, total_pkts, total_bytes);
 
-	netdev_tx_completed_queue(txring_txq(tx_ring), total_pkts,
-				  total_bytes);
+	if (ice_ring_is_xdp(tx_ring))
+		return !!budget;
+
+	netdev_tx_completed_queue(txring_txq(tx_ring), total_pkts, total_bytes);
 
 #define TX_WAKE_THRESHOLD ((s16)(DESC_NEEDED * 2))
 	if (unlikely(total_pkts && netif_carrier_ok(tx_ring->netdev) &&
@@ -314,11 +316,9 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 		 * sees the new next_to_clean.
 		 */
 		smp_mb();
-		if (__netif_subqueue_stopped(tx_ring->netdev,
-					     tx_ring->q_index) &&
+		if (netif_tx_queue_stopped(txring_txq(tx_ring)) &&
 		    !test_bit(ICE_VSI_DOWN, vsi->state)) {
-			netif_wake_subqueue(tx_ring->netdev,
-					    tx_ring->q_index);
+			netif_tx_wake_queue(txring_txq(tx_ring));
 			++tx_ring->tx_stats.restart_q;
 		}
 	}
@@ -1517,7 +1517,7 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
  */
 static int __ice_maybe_stop_tx(struct ice_tx_ring *tx_ring, unsigned int size)
 {
-	netif_stop_subqueue(tx_ring->netdev, tx_ring->q_index);
+	netif_tx_stop_queue(txring_txq(tx_ring));
 	/* Memory barrier before checking head and tail */
 	smp_mb();
 
@@ -1525,8 +1525,8 @@ static int __ice_maybe_stop_tx(struct ice_tx_ring *tx_ring, unsigned int size)
 	if (likely(ICE_DESC_UNUSED(tx_ring) < size))
 		return -EBUSY;
 
-	/* A reprieve! - use start_subqueue because it doesn't call schedule */
-	netif_start_subqueue(tx_ring->netdev, tx_ring->q_index);
+	/* A reprieve! - use start_queue because it doesn't call schedule */
+	netif_tx_start_queue(txring_txq(tx_ring));
 	++tx_ring->tx_stats.restart_q;
 	return 0;
 }
-- 
2.31.1

