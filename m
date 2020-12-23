From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 23 Dec 2020 12:37:02 -0800
Subject: [Intel-wired-lan] [PATCH v2 6/9] igc: Introduce
 igc_unmap_tx_buffer() helper
In-Reply-To: <20201223203705.78705-1-andre.guedes@intel.com>
References: <20201223203705.78705-1-andre.guedes@intel.com>
Message-ID: <20201223203705.78705-7-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation for AF_XDP zero-copy support, encapsulate the code that
unmaps tx buffers into its own local helper so we can reuse it, avoiding
code duplication.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 49 +++++++----------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 630ef97ebabb..815ceaba6f89 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -171,6 +171,14 @@ static void igc_get_hw_control(struct igc_adapter *adapter)
 	     ctrl_ext | IGC_CTRL_EXT_DRV_LOAD);
 }
 
+static void igc_unmap_tx_buffer(struct device *dev, struct igc_tx_buffer *buf)
+{
+	dma_unmap_single(dev, dma_unmap_addr(buf, dma),
+			 dma_unmap_len(buf, len), DMA_TO_DEVICE);
+
+	dma_unmap_len_set(buf, len, 0);
+}
+
 /**
  * igc_clean_tx_ring - Free Tx Buffers
  * @tx_ring: ring to be cleaned
@@ -188,11 +196,7 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 		else
 			dev_kfree_skb_any(tx_buffer->skb);
 
-		/* unmap skb header data */
-		dma_unmap_single(tx_ring->dev,
-				 dma_unmap_addr(tx_buffer, dma),
-				 dma_unmap_len(tx_buffer, len),
-				 DMA_TO_DEVICE);
+		igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
 
 		/* check for eop_desc to determine the end of the packet */
 		eop_desc = tx_buffer->next_to_watch;
@@ -211,10 +215,7 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 
 			/* unmap any remaining paged data */
 			if (dma_unmap_len(tx_buffer, len))
-				dma_unmap_page(tx_ring->dev,
-					       dma_unmap_addr(tx_buffer, dma),
-					       dma_unmap_len(tx_buffer, len),
-					       DMA_TO_DEVICE);
+				igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
 		}
 
 		/* move us one more past the eop_desc for start of next pkt */
@@ -1230,11 +1231,7 @@ static int igc_tx_map(struct igc_ring *tx_ring,
 	/* clear dma mappings for failed tx_buffer_info map */
 	while (tx_buffer != first) {
 		if (dma_unmap_len(tx_buffer, len))
-			dma_unmap_page(tx_ring->dev,
-				       dma_unmap_addr(tx_buffer, dma),
-				       dma_unmap_len(tx_buffer, len),
-				       DMA_TO_DEVICE);
-		dma_unmap_len_set(tx_buffer, len, 0);
+			igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
 
 		if (i-- == 0)
 			i += tx_ring->count;
@@ -1242,11 +1239,7 @@ static int igc_tx_map(struct igc_ring *tx_ring,
 	}
 
 	if (dma_unmap_len(tx_buffer, len))
-		dma_unmap_single(tx_ring->dev,
-				 dma_unmap_addr(tx_buffer, dma),
-				 dma_unmap_len(tx_buffer, len),
-				 DMA_TO_DEVICE);
-	dma_unmap_len_set(tx_buffer, len, 0);
+		igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
 
 	dev_kfree_skb_any(tx_buffer->skb);
 	tx_buffer->skb = NULL;
@@ -2328,14 +2321,7 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 		else
 			napi_consume_skb(tx_buffer->skb, napi_budget);
 
-		/* unmap skb header data */
-		dma_unmap_single(tx_ring->dev,
-				 dma_unmap_addr(tx_buffer, dma),
-				 dma_unmap_len(tx_buffer, len),
-				 DMA_TO_DEVICE);
-
-		/* clear tx_buffer data */
-		dma_unmap_len_set(tx_buffer, len, 0);
+		igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
 
 		/* clear last DMA location and unmap remaining buffers */
 		while (tx_desc != eop_desc) {
@@ -2349,13 +2335,8 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 			}
 
 			/* unmap any remaining paged data */
-			if (dma_unmap_len(tx_buffer, len)) {
-				dma_unmap_page(tx_ring->dev,
-					       dma_unmap_addr(tx_buffer, dma),
-					       dma_unmap_len(tx_buffer, len),
-					       DMA_TO_DEVICE);
-				dma_unmap_len_set(tx_buffer, len, 0);
-			}
+			if (dma_unmap_len(tx_buffer, len))
+				igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
 		}
 
 		/* move us one more past the eop_desc for start of next pkt */
-- 
2.29.2

