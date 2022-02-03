From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu,  3 Feb 2022 13:16:51 +0100
Subject: [Intel-wired-lan] [PATCH v2 intel-net] ice: avoid XDP checks in
 ice_clean_tx_irq()
Message-ID: <20220203121651.18937-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 9610bd988df9 ("ice: optimize XDP_TX workloads") introduced Tx IRQ
cleaning routine dedicated for XDP rings. Currently it is impossible to
call ice_clean_tx_irq() against XDP ring, so it is safe to drop
ice_ring_is_xdp() calls in there.

Fixes: 1c96c16858ba ("ice: update to newer kernel API")
Fixes: cc14db11c8a4 ("ice: use prefetch methods")
Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---

v2: fix commit msg and collect ack (Alex)

 drivers/net/ethernet/intel/ice/ice_txrx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 7d8824b4c8ff..25a5a3f2d107 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -223,8 +223,7 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 	struct ice_tx_buf *tx_buf;
 
 	/* get the bql data ready */
-	if (!ice_ring_is_xdp(tx_ring))
-		netdev_txq_bql_complete_prefetchw(txring_txq(tx_ring));
+	netdev_txq_bql_complete_prefetchw(txring_txq(tx_ring));
 
 	tx_buf = &tx_ring->tx_buf[i];
 	tx_desc = ICE_TX_DESC(tx_ring, i);
@@ -313,10 +312,6 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 	tx_ring->next_to_clean = i;
 
 	ice_update_tx_ring_stats(tx_ring, total_pkts, total_bytes);
-
-	if (ice_ring_is_xdp(tx_ring))
-		return !!budget;
-
 	netdev_tx_completed_queue(txring_txq(tx_ring), total_pkts, total_bytes);
 
 #define TX_WAKE_THRESHOLD ((s16)(DESC_NEEDED * 2))
-- 
2.33.1

