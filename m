From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:05 -0800
Subject: [Intel-wired-lan] [PATCH S14 05/15] ice: Gather the rx buf clean-up
 logic for better reuse
In-Reply-To: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190213185115.25877-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Pull out the code responsible for page counting and buffer recycling so
that it will be possible to clean up the rx buffers in cases where we
won't allocate skb (ex. XDP)

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 76 ++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 1c49d245d889..0eb594abe6ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -498,19 +498,42 @@ static bool ice_page_is_reserved(struct page *page)
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
 
+/**
+ * ice_rx_buf_adjust_pg_offset - Prepare rx buffer for reuse
+ * @rx_buf: Rx buffer to adjust
+ * @size: Size of adjustment
+ *
+ * Update the offset within page so that rx buf will be ready to be reused.
+ * For systems with PAGE_SIZE < 8192 this function will flip the page offset
+ * so the second half of page assigned to rx buffer will be used, otherwise
+ * the offset is moved by the @size bytes
+ */
+static void
+ice_rx_buf_adjust_pg_offset(struct ice_rx_buf *rx_buf, unsigned int size)
+{
+#if (PAGE_SIZE < 8192)
+	/* flip page offset to other buffer */
+	rx_buf->page_offset ^= size;
+#else
+	/* move offset up to the next cache line */
+	rx_buf->page_offset += size;
+#endif
+}
+
 /**
  * ice_can_reuse_rx_page - Determine if page can be reused for another rx
  * @rx_buf: buffer containing the page
- * @truesize: the offset that needs to be applied to page
  *
  * If page is reusable, we have a green light for calling ice_reuse_rx_page,
  * which will assign the current buffer to the buffer that next_to_alloc is
  * pointing to; otherwise, the dma mapping needs to be destroyed and
  * page freed
  */
-static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf,
-				  unsigned int truesize)
+static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
 {
+#if (PAGE_SIZE >= 8192)
+	unsigned int last_offset = PAGE_SIZE - ICE_RXBUF_2048;
+#endif
 	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
 	struct page *page = rx_buf->page;
 
@@ -522,14 +545,8 @@ static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf,
 	/* if we are only owner of page we can reuse it */
 	if (unlikely((page_count(page) - pagecnt_bias) > 1))
 		return false;
-
-	/* flip page offset to other buffer */
-	rx_buf->page_offset ^= truesize;
 #else
-	/* move offset up to the next cache line */
-	rx_buf->page_offset += truesize;
-
-	if (rx_buf->page_offset > PAGE_SIZE - ICE_RXBUF_2048)
+	if (rx_buf->page_offset > last_offset)
 		return false;
 #endif /* PAGE_SIZE < 8192) */
 
@@ -556,10 +573,9 @@ static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf,
  * less than the skb header size, otherwise it will just attach the page as
  * a frag to the skb.
  *
- * The function will then update the page offset if necessary and return
- * true if the buffer can be reused by the adapter.
+ * The function will then update the page offset
  */
-static bool
+static void
 ice_add_rx_frag(struct ice_rx_buf *rx_buf, struct sk_buff *skb,
 		unsigned int size)
 {
@@ -582,14 +598,8 @@ ice_add_rx_frag(struct ice_rx_buf *rx_buf, struct sk_buff *skb,
 	if (size <= ICE_RX_HDR_SIZE) {
 		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
 
-		/* page is not reserved, we can reuse buffer as-is */
-		if (likely(!ice_page_is_reserved(page))) {
-			rx_buf->pagecnt_bias++;
-			return true;
-		}
-
-		/* this page cannot be reused so discard it */
-		return false;
+		rx_buf->pagecnt_bias++;
+		return;
 	}
 
 	/* we need the header to contain the greater of either ETH_HLEN or
@@ -610,8 +620,7 @@ ice_add_rx_frag(struct ice_rx_buf *rx_buf, struct sk_buff *skb,
 add_tail_frag:
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 			(unsigned long)va & ~PAGE_MASK, size, truesize);
-
-	return ice_can_reuse_rx_page(rx_buf, truesize);
+	ice_rx_buf_adjust_pg_offset(rx_buf, truesize);
 }
 
 /**
@@ -697,6 +706,7 @@ ice_fetch_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
 				       GFP_ATOMIC | __GFP_NOWARN);
 		if (unlikely(!skb)) {
 			rx_ring->rx_stats.alloc_buf_failed++;
+			rx_buf->pagecnt_bias++;
 			return NULL;
 		}
 
@@ -706,8 +716,23 @@ ice_fetch_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
 	}
 
 	/* pull page into skb */
-	if (ice_add_rx_frag(rx_buf, skb, size)) {
+	ice_add_rx_frag(rx_buf, skb, size);
+
+	return skb;
+}
+
+/**
+ * ice_put_rx_buf - Clean up used buffer and either recycle or free
+ * @rx_ring: Rx descriptor ring to transact packets on
+ * @rx_buf: Rx buffer to pull data from
+ *
+ * This function will  clean up the contents of the rx_buf. It will
+ * either recycle the buffer or unmap it and free the associated resources.
+ */
+static void ice_put_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
+{
 		/* hand second half of page back to the ring */
+	if (ice_can_reuse_rx_page(rx_buf)) {
 		ice_reuse_rx_page(rx_ring, rx_buf);
 		rx_ring->rx_stats.page_reuse_count++;
 	} else {
@@ -719,8 +744,6 @@ ice_fetch_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
 
 	/* clear contents of buffer_info */
 	rx_buf->page = NULL;
-
-	return skb;
 }
 
 /**
@@ -1007,6 +1030,7 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		if (!skb)
 			break;
 
+		ice_put_rx_buf(rx_ring, rx_buf);
 		cleaned_count++;
 
 		/* skip if it is NOP desc */
-- 
2.14.5

