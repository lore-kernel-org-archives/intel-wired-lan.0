From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 Nov 2019 13:44:11 +0200
Subject: [Intel-wired-lan] [PATCH v1 05/15] igc: Remove no need declaration
 of the igc_alloc_mapped_page
Message-ID: <20191119114411.41911-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We want to avoid forward-declarations of function if possible.
Rearrange the igc_alloc_mapped_page function implementation.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 94 +++++++++++++++----------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8a2baf8ad956..d26875592937 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -63,8 +63,6 @@ static void igc_free_q_vectors(struct igc_adapter *adapter);
 static void igc_irq_disable(struct igc_adapter *adapter);
 static void igc_irq_enable(struct igc_adapter *adapter);
 static void igc_configure_msix(struct igc_adapter *adapter);
-static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
-				  struct igc_rx_buffer *bi);
 
 enum latency_range {
 	lowest_latency = 0,
@@ -1606,6 +1604,52 @@ static void igc_put_rx_buffer(struct igc_ring *rx_ring,
 	rx_buffer->page = NULL;
 }
 
+static inline unsigned int igc_rx_offset(struct igc_ring *rx_ring)
+{
+	return ring_uses_build_skb(rx_ring) ? IGC_SKB_PAD : 0;
+}
+
+static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
+				  struct igc_rx_buffer *bi)
+{
+	struct page *page = bi->page;
+	dma_addr_t dma;
+
+	/* since we are recycling buffers we should seldom need to alloc */
+	if (likely(page))
+		return true;
+
+	/* alloc new page for storage */
+	page = dev_alloc_pages(igc_rx_pg_order(rx_ring));
+	if (unlikely(!page)) {
+		rx_ring->rx_stats.alloc_failed++;
+		return false;
+	}
+
+	/* map page for use */
+	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
+				 igc_rx_pg_size(rx_ring),
+				 DMA_FROM_DEVICE,
+				 IGC_RX_DMA_ATTR);
+
+	/* if mapping failed free memory back to system since
+	 * there isn't much point in holding memory we can't use
+	 */
+	if (dma_mapping_error(rx_ring->dev, dma)) {
+		__free_page(page);
+
+		rx_ring->rx_stats.alloc_failed++;
+		return false;
+	}
+
+	bi->dma = dma;
+	bi->page = page;
+	bi->page_offset = igc_rx_offset(rx_ring);
+	bi->pagecnt_bias = 1;
+
+	return true;
+}
+
 /**
  * igc_alloc_rx_buffers - Replace used receive buffers; packet split
  * @rx_ring: rx descriptor ring
@@ -1767,52 +1811,6 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 	return total_packets;
 }
 
-static inline unsigned int igc_rx_offset(struct igc_ring *rx_ring)
-{
-	return ring_uses_build_skb(rx_ring) ? IGC_SKB_PAD : 0;
-}
-
-static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
-				  struct igc_rx_buffer *bi)
-{
-	struct page *page = bi->page;
-	dma_addr_t dma;
-
-	/* since we are recycling buffers we should seldom need to alloc */
-	if (likely(page))
-		return true;
-
-	/* alloc new page for storage */
-	page = dev_alloc_pages(igc_rx_pg_order(rx_ring));
-	if (unlikely(!page)) {
-		rx_ring->rx_stats.alloc_failed++;
-		return false;
-	}
-
-	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 igc_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
-				 IGC_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
-		__free_page(page);
-
-		rx_ring->rx_stats.alloc_failed++;
-		return false;
-	}
-
-	bi->dma = dma;
-	bi->page = page;
-	bi->page_offset = igc_rx_offset(rx_ring);
-	bi->pagecnt_bias = 1;
-
-	return true;
-}
-
 /**
  * igc_clean_tx_irq - Reclaim resources after transmit completes
  * @q_vector: pointer to q_vector containing needed info
-- 
2.11.0

