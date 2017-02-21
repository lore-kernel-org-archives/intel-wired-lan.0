From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:39 -0800
Subject: [Intel-wired-lan] [next PATCH S61 01/10] i40e/i40evf: Update code
	to better handle incrementing page count
In-Reply-To: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1487721348-25617-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Update the driver code so that we do bulk updates of the page reference
count instead of just incrementing it by one reference at a time.  The
advantage to doing this is that we cut down on atomic operations and
this in turn should give us a slight improvement in cycles per packet.
In addition if we eventually move this over to using build_skb the gains
will be more noticeable.

I also found and fixed a store forwarding stall from where we were
assigning "*new_buff = *old_buff".  By breaking it up into individual
copies we can avoid this and as a result the performance is slightly
improved.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I1d3880dece4133eca3c32423b04a5467321ccc52
---
Testing Hints: Make certain this doesn't cause any memory leaks or lead
        to any data corruptions under heavy Rx traffic with a mix of frame
        sizes.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 25 ++++++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  7 ++++++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 24 ++++++++++++++++++------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  7 ++++++-
 4 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b442d64d..f80c76c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1139,7 +1139,7 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 				     PAGE_SIZE,
 				     DMA_FROM_DEVICE,
 				     I40E_RX_DMA_ATTR);
-		__free_pages(rx_bi->page, 0);
+		__page_frag_cache_drain(rx_bi->page, rx_bi->pagecnt_bias);
 
 		rx_bi->page = NULL;
 		rx_bi->page_offset = 0;
@@ -1289,6 +1289,7 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 	bi->dma = dma;
 	bi->page = page;
 	bi->page_offset = 0;
+	bi->pagecnt_bias = 1;
 
 	return true;
 }
@@ -1676,6 +1677,7 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 #if (PAGE_SIZE >= 8192)
 	unsigned int last_offset = PAGE_SIZE - I40E_RXBUFFER_2048;
 #endif
+	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias--;
 
 	/* Is any reuse possible? */
 	if (unlikely(!i40e_page_is_reusable(page)))
@@ -1683,7 +1685,7 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 
 #if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
-	if (unlikely(page_count(page) != 1))
+	if (unlikely(page_count(page) != pagecnt_bias))
 		return false;
 
 	/* flip page offset to other buffer */
@@ -1696,9 +1698,14 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 		return false;
 #endif
 
-	/* Inc ref count on page before passing it up to the stack */
-	get_page(page);
-
+	/* If we have drained the page fragment pool we need to update
+	 * the pagecnt_bias and page count so that we fully restock the
+	 * number of references the driver holds.
+	 */
+	if (unlikely(pagecnt_bias == 1)) {
+		page_ref_add(page, USHRT_MAX);
+		rx_buffer->pagecnt_bias = USHRT_MAX;
+	}
 	return true;
 }
 
@@ -1745,7 +1752,6 @@ static bool i40e_add_rx_frag(struct i40e_ring *rx_ring,
 			return true;
 
 		/* this page cannot be reused so discard it */
-		__free_pages(page, 0);
 		return false;
 	}
 
@@ -1865,7 +1871,10 @@ static void i40e_reuse_rx_page(struct i40e_ring *rx_ring,
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
 	/* transfer page from old buffer to new buffer */
-	*new_buff = *old_buff;
+	new_buff->dma		= old_buff->dma;
+	new_buff->page		= old_buff->page;
+	new_buff->page_offset	= old_buff->page_offset;
+	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
 }
 
 /**
@@ -2034,6 +2043,8 @@ struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
 		/* we are not reusing the buffer so unmap it */
 		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
 				     DMA_FROM_DEVICE, I40E_RX_DMA_ATTR);
+		__page_frag_cache_drain(rx_buffer->page,
+					rx_buffer->pagecnt_bias);
 	}
 
 	/* clear contents of buffer_info */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 34fd1e7..606f5ad 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -260,7 +260,12 @@ struct i40e_tx_buffer {
 struct i40e_rx_buffer {
 	dma_addr_t dma;
 	struct page *page;
-	unsigned int page_offset;
+#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
+	__u32 page_offset;
+#else
+	__u16 page_offset;
+#endif
+	__u16 pagecnt_bias;
 };
 
 struct i40e_queue_stats {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 8dc3316..39e2e73 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -526,7 +526,7 @@ void i40evf_clean_rx_ring(struct i40e_ring *rx_ring)
 				     PAGE_SIZE,
 				     DMA_FROM_DEVICE,
 				     I40E_RX_DMA_ATTR);
-		__free_pages(rx_bi->page, 0);
+		__page_frag_cache_drain(rx_bi->page, rx_bi->pagecnt_bias);
 
 		rx_bi->page = NULL;
 		rx_bi->page_offset = 0;
@@ -671,6 +671,7 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 	bi->dma = dma;
 	bi->page = page;
 	bi->page_offset = 0;
+	bi->pagecnt_bias = 1;
 
 	return true;
 }
@@ -966,7 +967,10 @@ static void i40e_reuse_rx_page(struct i40e_ring *rx_ring,
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
 	/* transfer page from old buffer to new buffer */
-	*new_buff = *old_buff;
+	new_buff->dma		= old_buff->dma;
+	new_buff->page		= old_buff->page;
+	new_buff->page_offset	= old_buff->page_offset;
+	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
 }
 
 /**
@@ -1018,6 +1022,7 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 #if (PAGE_SIZE >= 8192)
 	unsigned int last_offset = PAGE_SIZE - I40E_RXBUFFER_2048;
 #endif
+	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias--;
 
 	/* Is any reuse possible? */
 	if (unlikely(!i40e_page_is_reusable(page)))
@@ -1025,7 +1030,7 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 
 #if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
-	if (unlikely(page_count(page) != 1))
+	if (unlikely(page_count(page) != pagecnt_bias))
 		return false;
 
 	/* flip page offset to other buffer */
@@ -1038,8 +1043,14 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer,
 		return false;
 #endif
 
-	/* Inc ref count on page before passing it up to the stack */
-	get_page(page);
+	/* If we have drained the page fragment pool we need to update
+	 * the pagecnt_bias and page count so that we fully restock the
+	 * number of references the driver holds.
+	 */
+	if (unlikely(pagecnt_bias == 1)) {
+		page_ref_add(page, USHRT_MAX);
+		rx_buffer->pagecnt_bias = USHRT_MAX;
+	}
 
 	return true;
 }
@@ -1087,7 +1098,6 @@ static bool i40e_add_rx_frag(struct i40e_ring *rx_ring,
 			return true;
 
 		/* this page cannot be reused so discard it */
-		__free_pages(page, 0);
 		return false;
 	}
 
@@ -1181,6 +1191,8 @@ struct sk_buff *i40evf_fetch_rx_buffer(struct i40e_ring *rx_ring,
 		/* we are not reusing the buffer so unmap it */
 		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
 				     DMA_FROM_DEVICE, I40E_RX_DMA_ATTR);
+		__page_frag_cache_drain(rx_buffer->page,
+					rx_buffer->pagecnt_bias);
 	}
 
 	/* clear contents of buffer_info */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 0135121..7b41df1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -244,7 +244,12 @@ struct i40e_tx_buffer {
 struct i40e_rx_buffer {
 	dma_addr_t dma;
 	struct page *page;
-	unsigned int page_offset;
+#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
+	__u32 page_offset;
+#else
+	__u16 page_offset;
+#endif
+	__u16 pagecnt_bias;
 };
 
 struct i40e_queue_stats {
-- 
2.4.11

