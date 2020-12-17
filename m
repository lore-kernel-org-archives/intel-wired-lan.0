From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 17 Dec 2020 12:24:11 -0800
Subject: [Intel-wired-lan] [PATCH 06/10] igc: Introduce igc_update_tx_stats()
In-Reply-To: <20201217202415.77891-1-andre.guedes@intel.com>
References: <20201217202415.77891-1-andre.guedes@intel.com>
Message-ID: <20201217202415.77891-7-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Likewise we do with the RX stats, this patch encapsulates the code that
updates the driver TX stats in its own local helper.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e5cdebbe5637..26c2fc9977cc 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2263,6 +2263,20 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 	return total_packets;
 }
 
+static void igc_update_tx_stats(struct igc_q_vector *q_vector,
+				unsigned int packets, unsigned int bytes)
+{
+	struct igc_ring *ring = q_vector->tx.ring;
+
+	u64_stats_update_begin(&ring->tx_syncp);
+	ring->tx_stats.bytes += bytes;
+	ring->tx_stats.packets += packets;
+	u64_stats_update_end(&ring->tx_syncp);
+
+	q_vector->tx.total_bytes += bytes;
+	q_vector->tx.total_packets += packets;
+}
+
 /**
  * igc_clean_tx_irq - Reclaim resources after transmit completes
  * @q_vector: pointer to q_vector containing needed info
@@ -2365,12 +2379,8 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 
 	i += tx_ring->count;
 	tx_ring->next_to_clean = i;
-	u64_stats_update_begin(&tx_ring->tx_syncp);
-	tx_ring->tx_stats.bytes += total_bytes;
-	tx_ring->tx_stats.packets += total_packets;
-	u64_stats_update_end(&tx_ring->tx_syncp);
-	q_vector->tx.total_bytes += total_bytes;
-	q_vector->tx.total_packets += total_packets;
+
+	igc_update_tx_stats(q_vector, total_packets, total_bytes);
 
 	if (test_bit(IGC_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags)) {
 		struct igc_hw *hw = &adapter->hw;
-- 
2.29.2

