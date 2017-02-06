From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 05 Feb 2017 20:32:04 -0800
Subject: [Intel-wired-lan] [next PATCH v4 11/12] igb: Break out Rx buffer
	page management
In-Reply-To: <20170206042508.14635.44702.stgit@localhost.localdomain>
References: <20170206042508.14635.44702.stgit@localhost.localdomain>
Message-ID: <20170206043144.14635.51161.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

At this point we have 2 to 3 paths that can be taken depending on what Rx
modes are enabled.  In order to better support that and improve the
maintainability I am breaking out the common bits from those paths and
making them into their own functions.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
v3: Rebase patch on v3 changes to fix pointer arithmetic mismatch
v4: Rebase on top of changes to split up buffer size and padding changes

 drivers/net/ethernet/intel/igb/igb_main.c |  233 +++++++++++++++--------------
 1 file changed, 121 insertions(+), 112 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 94fed36312ab..adb9d708aa18 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6883,8 +6883,14 @@ static void igb_reuse_rx_page(struct igb_ring *rx_ring,
 	nta++;
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
-	/* transfer page from old buffer to new buffer */
-	*new_buff = *old_buff;
+	/* Transfer page from old buffer to new buffer.
+	 * Move each member individually to avoid possible store
+	 * forwarding stalls.
+	 */
+	new_buff->dma		= old_buff->dma;
+	new_buff->page		= old_buff->page;
+	new_buff->page_offset	= old_buff->page_offset;
+	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
 }
 
 static inline bool igb_page_is_reserved(struct page *page)
@@ -6892,11 +6898,10 @@ static inline bool igb_page_is_reserved(struct page *page)
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
 
-static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
-				  struct page *page,
-				  const unsigned int truesize)
+static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer)
 {
-	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias--;
+	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
+	struct page *page = rx_buffer->page;
 
 	/* avoid re-using remote pages */
 	if (unlikely(igb_page_is_reserved(page)))
@@ -6904,14 +6909,9 @@ static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
 
 #if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
-	if (unlikely(page_ref_count(page) != pagecnt_bias))
+	if (unlikely((page_ref_count(page) - pagecnt_bias) > 1))
 		return false;
-
-	/* flip page offset to other buffer */
-	rx_buffer->page_offset ^= truesize;
 #else
-	/* move offset up to the next cache line */
-	rx_buffer->page_offset += truesize;
 #define IGB_LAST_OFFSET \
 	(SKB_WITH_OVERHEAD(PAGE_SIZE) - IGB_RXBUFFER_2048)
 
@@ -6923,7 +6923,7 @@ static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
 	 * the pagecnt_bias and page count so that we fully restock the
 	 * number of references the driver holds.
 	 */
-	if (unlikely(pagecnt_bias == 1)) {
+	if (unlikely(!pagecnt_bias)) {
 		page_ref_add(page, USHRT_MAX);
 		rx_buffer->pagecnt_bias = USHRT_MAX;
 	}
@@ -6935,22 +6935,15 @@ static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
  *  igb_add_rx_frag - Add contents of Rx buffer to sk_buff
  *  @rx_ring: rx descriptor ring to transact packets on
  *  @rx_buffer: buffer containing page to add
- *  @rx_desc: descriptor containing length of buffer written by hardware
  *  @skb: sk_buff to place the data into
+ *  @size: size of buffer to be added
  *
  *  This function will add the data contained in rx_buffer->page to the skb.
- *  This is done either through a direct copy if the data in the buffer is
- *  less than the skb header size, otherwise it will just attach the page as
- *  a frag to the skb.
- *
- *  The function will then update the page offset if necessary and return
- *  true if the buffer can be reused by the adapter.
  **/
-static bool igb_add_rx_frag(struct igb_ring *rx_ring,
+static void igb_add_rx_frag(struct igb_ring *rx_ring,
 			    struct igb_rx_buffer *rx_buffer,
-			    unsigned int size,
-			    union e1000_adv_rx_desc *rx_desc,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb,
+			    unsigned int size)
 {
 	struct page *page = rx_buffer->page;
 	void *va = page_address(page) + rx_buffer->page_offset;
@@ -6961,10 +6954,39 @@ static bool igb_add_rx_frag(struct igb_ring *rx_ring,
 				SKB_DATA_ALIGN(IGB_SKB_PAD + size) :
 				SKB_DATA_ALIGN(size);
 #endif
-	unsigned int pull_len;
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
+			rx_buffer->page_offset, size, truesize);
+#if (PAGE_SIZE < 8192)
+	rx_buffer->page_offset ^= truesize;
+#else
+	rx_buffer->page_offset += truesize;
+#endif
+}
+
+static struct sk_buff *igb_construct_skb(struct igb_ring *rx_ring,
+					 struct igb_rx_buffer *rx_buffer,
+					 union e1000_adv_rx_desc *rx_desc,
+					 unsigned int size)
+{
+	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+#if (PAGE_SIZE < 8192)
+	unsigned int truesize = igb_rx_pg_size(rx_ring) / 2;
+#else
+	unsigned int truesize = SKB_DATA_ALIGN(size);
+#endif
+	unsigned int headlen;
+	struct sk_buff *skb;
 
-	if (unlikely(skb_is_nonlinear(skb)))
-		goto add_tail_frag;
+	/* prefetch first cache line of first page */
+	prefetch(va);
+#if L1_CACHE_BYTES < 128
+	prefetch(va + L1_CACHE_BYTES);
+#endif
+
+	/* allocate a skb to store the frags */
+	skb = napi_alloc_skb(&rx_ring->q_vector->napi, IGB_RX_HDR_LEN);
+	if (unlikely(!skb))
+		return NULL;
 
 	if (unlikely(igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP))) {
 		igb_ptp_rx_pktstamp(rx_ring->q_vector, va, skb);
@@ -6972,95 +6994,29 @@ static bool igb_add_rx_frag(struct igb_ring *rx_ring,
 		size -= IGB_TS_HDR_LEN;
 	}
 
-	if (likely(size <= IGB_RX_HDR_LEN)) {
-		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
-
-		/* page is not reserved, we can reuse buffer as-is */
-		if (likely(!igb_page_is_reserved(page)))
-			return true;
-
-		/* this page cannot be reused so discard it */
-		return false;
-	}
-
-	/* we need the header to contain the greater of either ETH_HLEN or
-	 * 60 bytes if the skb->len is less than 60 for skb_pad.
-	 */
-	pull_len = eth_get_headlen(va, IGB_RX_HDR_LEN);
+	/* Determine available headroom for copy */
+	headlen = size;
+	if (headlen > IGB_RX_HDR_LEN)
+		headlen = eth_get_headlen(va, IGB_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
-	memcpy(__skb_put(skb, pull_len), va, ALIGN(pull_len, sizeof(long)));
+	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
 
 	/* update all of the pointers */
-	va += pull_len;
-	size -= pull_len;
-
-add_tail_frag:
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
-			va - page_address(page), size, truesize);
-
-	return igb_can_reuse_rx_page(rx_buffer, page, truesize);
-}
-
-static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
-					   union e1000_adv_rx_desc *rx_desc,
-					   struct sk_buff *skb)
-{
-	unsigned int size = le16_to_cpu(rx_desc->wb.upper.length);
-	struct igb_rx_buffer *rx_buffer;
-	struct page *page;
-
-	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
-	page = rx_buffer->page;
-	prefetchw(page);
-
-	/* we are reusing so sync this buffer for CPU use */
-	dma_sync_single_range_for_cpu(rx_ring->dev,
-				      rx_buffer->dma,
-				      rx_buffer->page_offset,
-				      size,
-				      DMA_FROM_DEVICE);
-
-	if (likely(!skb)) {
-		void *va = page_address(page) + rx_buffer->page_offset;
-
-		/* prefetch first cache line of first page */
-		prefetch(va);
-#if L1_CACHE_BYTES < 128
-		prefetch(va + L1_CACHE_BYTES);
+	size -= headlen;
+	if (size) {
+		skb_add_rx_frag(skb, 0, rx_buffer->page,
+				(va + headlen) - page_address(rx_buffer->page),
+				size, truesize);
+#if (PAGE_SIZE < 8192)
+		rx_buffer->page_offset ^= truesize;
+#else
+		rx_buffer->page_offset += truesize;
 #endif
-
-		/* allocate a skb to store the frags */
-		skb = napi_alloc_skb(&rx_ring->q_vector->napi, IGB_RX_HDR_LEN);
-		if (unlikely(!skb)) {
-			rx_ring->rx_stats.alloc_failed++;
-			return NULL;
-		}
-
-		/* we will be copying header into skb->data in
-		 * pskb_may_pull so it is in our interest to prefetch
-		 * it now to avoid a possible cache miss
-		 */
-		prefetchw(skb->data);
-	}
-
-	/* pull page into skb */
-	if (igb_add_rx_frag(rx_ring, rx_buffer, size, rx_desc, skb)) {
-		/* hand second half of page back to the ring */
-		igb_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		/* We are not reusing the buffer so unmap it and free
-		 * any references we are holding to it
-		 */
-		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
-				     igb_rx_pg_size(rx_ring), DMA_FROM_DEVICE,
-				     IGB_RX_DMA_ATTR);
-		__page_frag_cache_drain(page, rx_buffer->pagecnt_bias);
+		rx_buffer->pagecnt_bias++;
 	}
 
-	/* clear contents of rx_buffer */
-	rx_buffer->page = NULL;
-
 	return skb;
 }
 
@@ -7218,6 +7174,47 @@ static void igb_process_skb_fields(struct igb_ring *rx_ring,
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 }
 
+static struct igb_rx_buffer *igb_get_rx_buffer(struct igb_ring *rx_ring,
+					       const unsigned int size)
+{
+	struct igb_rx_buffer *rx_buffer;
+
+	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+	prefetchw(rx_buffer->page);
+
+	/* we are reusing so sync this buffer for CPU use */
+	dma_sync_single_range_for_cpu(rx_ring->dev,
+				      rx_buffer->dma,
+				      rx_buffer->page_offset,
+				      size,
+				      DMA_FROM_DEVICE);
+
+	rx_buffer->pagecnt_bias--;
+
+	return rx_buffer;
+}
+
+static void igb_put_rx_buffer(struct igb_ring *rx_ring,
+			      struct igb_rx_buffer *rx_buffer)
+{
+	if (igb_can_reuse_rx_page(rx_buffer)) {
+		/* hand second half of page back to the ring */
+		igb_reuse_rx_page(rx_ring, rx_buffer);
+	} else {
+		/* We are not reusing the buffer so unmap it and free
+		 * any references we are holding to it
+		 */
+		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
+				     igb_rx_pg_size(rx_ring), DMA_FROM_DEVICE,
+				     IGB_RX_DMA_ATTR);
+		__page_frag_cache_drain(rx_buffer->page,
+					rx_buffer->pagecnt_bias);
+	}
+
+	/* clear contents of rx_buffer */
+	rx_buffer->page = NULL;
+}
+
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
 	struct igb_ring *rx_ring = q_vector->rx.ring;
@@ -7227,6 +7224,8 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 
 	while (likely(total_packets < budget)) {
 		union e1000_adv_rx_desc *rx_desc;
+		struct igb_rx_buffer *rx_buffer;
+		unsigned int size;
 
 		/* return some buffers to hardware, one@a time is too slow */
 		if (cleaned_count >= IGB_RX_BUFFER_WRITE) {
@@ -7235,8 +7234,8 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 		}
 
 		rx_desc = IGB_RX_DESC(rx_ring, rx_ring->next_to_clean);
-
-		if (!rx_desc->wb.upper.length)
+		size = le16_to_cpu(rx_desc->wb.upper.length);
+		if (!size)
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -7245,13 +7244,23 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 		 */
 		dma_rmb();
 
+		rx_buffer = igb_get_rx_buffer(rx_ring, size);
+
 		/* retrieve a buffer from the ring */
-		skb = igb_fetch_rx_buffer(rx_ring, rx_desc, skb);
+		if (skb)
+			igb_add_rx_frag(rx_ring, rx_buffer, skb, size);
+		else
+			skb = igb_construct_skb(rx_ring, rx_buffer,
+						rx_desc, size);
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb)
+		if (!skb) {
+			rx_ring->rx_stats.alloc_failed++;
+			rx_buffer->pagecnt_bias++;
 			break;
+		}
 
+		igb_put_rx_buffer(rx_ring, rx_buffer);
 		cleaned_count++;
 
 		/* fetch next buffer in frame if non-eop */

