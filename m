From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 30 Jan 2017 12:29:35 -0800
Subject: [Intel-wired-lan] [next PATCH S59 4/6] i40e/i40evf: Add support for
	mapping pages with DMA attributes
In-Reply-To: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1485808177-6333-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch adds support for DMA_ATTR_SKIP_CPU_SYNC and
DMA_ATTR_WEAK_ORDERING. By enabling both of these for the Rx path we 
are able to see performance improvements on architectures that implement 
either one due to the fact that page mapping and unmapping only has to 
sync what is actually being used instead of the entire buffer. In addition 
by enabling the weak ordering attribute enables a performance improvement 
for architectures that can associate a memory ordering with a DMA buffer 
such as Sparc.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: If176824e8231c5b24b8a5d55b339a6026738fc75
---
Testing Hints: Changes would only be visible with SPARC platforms or
               systems with swiotlb=force enabled. Even then the actual
               effect should be minimal. Mainly we just need to verify
               that on kernels 4.10 and newer we are still able to
               receive traffic without any issues.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 31 ++++++++++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 31 ++++++++++++++++++++++-----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  3 +++
 4 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d1583ee..012c157 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1105,7 +1105,6 @@ int i40e_setup_tx_descriptors(struct i40e_ring *tx_ring)
  **/
 void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 {
-	struct device *dev = rx_ring->dev;
 	unsigned long bi_size;
 	u16 i;
 	struct bpf_prog *old_prog;
@@ -1126,7 +1125,20 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 		if (!rx_bi->page)
 			continue;
 
-		dma_unmap_page(dev, rx_bi->dma, PAGE_SIZE, DMA_FROM_DEVICE);
+		/* Invalidate cache lines that may have been written to by
+		 * device so that we avoid corrupting memory.
+		 */
+		dma_sync_single_range_for_cpu(rx_ring->dev,
+					      rx_bi->dma,
+					      rx_bi->page_offset,
+					      I40E_RXBUFFER_2048,
+					      DMA_FROM_DEVICE);
+
+		/* free resources associated with mapping */
+		dma_unmap_page_attrs(rx_ring->dev, rx_bi->dma,
+				     PAGE_SIZE,
+				     DMA_FROM_DEVICE,
+				     I40E_RX_DMA_ATTR);
 		__free_pages(rx_bi->page, 0);
 
 		rx_bi->page = NULL;
@@ -1260,7 +1272,10 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page(rx_ring->dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
+	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
+				 PAGE_SIZE,
+				 DMA_FROM_DEVICE,
+				 I40E_RX_DMA_ATTR);
 
 	/* if mapping failed free memory back to system since
 	 * there isn't much point in holding memory we can't use
@@ -1369,6 +1384,12 @@ bool i40e_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 		if (!i40e_alloc_mapped_page(rx_ring, bi))
 			goto no_buffers;
 
+		/* sync the buffer for use by the device */
+		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
+						 bi->page_offset,
+						 I40E_RXBUFFER_2048,
+						 DMA_FROM_DEVICE);
+
 		/* Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
 		 */
@@ -2011,8 +2032,8 @@ struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
 		rx_ring->rx_stats.page_reuse_count++;
 	} else {
 		/* we are not reusing the buffer so unmap it */
-		dma_unmap_page(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
-			       DMA_FROM_DEVICE);
+		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
+				     DMA_FROM_DEVICE, I40E_RX_DMA_ATTR);
 	}
 
 	/* clear contents of buffer_info */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 5e24aef..34fd1e7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -133,6 +133,9 @@ enum i40e_dyn_idx_t {
 #define I40E_RX_HDR_SIZE I40E_RXBUFFER_256
 #define i40e_rx_desc i40e_32byte_rx_desc
 
+#define I40E_RX_DMA_ATTR \
+	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
+
 /**
  * i40e_test_staterr - tests bits in Rx descriptor status and error fields
  * @rx_desc: pointer to receive descriptor (in le64 format)
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index cd0e28f..7edb4a8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -493,7 +493,6 @@ int i40evf_setup_tx_descriptors(struct i40e_ring *tx_ring)
  **/
 void i40evf_clean_rx_ring(struct i40e_ring *rx_ring)
 {
-	struct device *dev = rx_ring->dev;
 	unsigned long bi_size;
 	u16 i;
 
@@ -513,7 +512,20 @@ void i40evf_clean_rx_ring(struct i40e_ring *rx_ring)
 		if (!rx_bi->page)
 			continue;
 
-		dma_unmap_page(dev, rx_bi->dma, PAGE_SIZE, DMA_FROM_DEVICE);
+		/* Invalidate cache lines that may have been written to by
+		 * device so that we avoid corrupting memory.
+		 */
+		dma_sync_single_range_for_cpu(rx_ring->dev,
+					      rx_bi->dma,
+					      rx_bi->page_offset,
+					      I40E_RXBUFFER_2048,
+					      DMA_FROM_DEVICE);
+
+		/* free resources associated with mapping */
+		dma_unmap_page_attrs(rx_ring->dev, rx_bi->dma,
+				     PAGE_SIZE,
+				     DMA_FROM_DEVICE,
+				     I40E_RX_DMA_ATTR);
 		__free_pages(rx_bi->page, 0);
 
 		rx_bi->page = NULL;
@@ -642,7 +654,10 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page(rx_ring->dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
+	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
+				 PAGE_SIZE,
+				 DMA_FROM_DEVICE,
+				 I40E_RX_DMA_ATTR);
 
 	/* if mapping failed free memory back to system since
 	 * there isn't much point in holding memory we can't use
@@ -702,6 +717,12 @@ bool i40evf_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 		if (!i40e_alloc_mapped_page(rx_ring, bi))
 			goto no_buffers;
 
+		/* sync the buffer for use by the device */
+		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
+						 bi->page_offset,
+						 I40E_RXBUFFER_2048,
+						 DMA_FROM_DEVICE);
+
 		/* Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
 		 */
@@ -1158,8 +1179,8 @@ struct sk_buff *i40evf_fetch_rx_buffer(struct i40e_ring *rx_ring,
 		rx_ring->rx_stats.page_reuse_count++;
 	} else {
 		/* we are not reusing the buffer so unmap it */
-		dma_unmap_page(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
-			       DMA_FROM_DEVICE);
+		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
+				     DMA_FROM_DEVICE, I40E_RX_DMA_ATTR);
 	}
 
 	/* clear contents of buffer_info */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 8274ba6..0135121 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -120,6 +120,9 @@ enum i40e_dyn_idx_t {
 #define I40E_RX_HDR_SIZE I40E_RXBUFFER_256
 #define i40e_rx_desc i40e_32byte_rx_desc
 
+#define I40E_RX_DMA_ATTR \
+	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
+
 /**
  * i40e_test_staterr - tests bits in Rx descriptor status and error fields
  * @rx_desc: pointer to receive descriptor (in le64 format)
-- 
2.4.11

