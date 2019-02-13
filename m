From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:04 -0800
Subject: [Intel-wired-lan] [PATCH S14 04/15] ice: Introduce bulk update for
 page count
In-Reply-To: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190213185115.25877-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

{get,put}_page are atomic operations which we use for page count
handling. The current logic for refcount handling is that we increment
it when passing a skb with the data from the first half of page up to
netstack and recycle the second half of page. This operation protects us
from losing a page since the network stack can decrement the refcount of
page from skb.

The performance can be gently improved by doing the bulk updates of
refcount instead of doing it one by one. During the buffer initialization,
maximize the page's refcount and don't allow the refcount to become
less than two.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 26 +++++++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.h |  1 +
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 03dddbd8c108..1c49d245d889 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -283,7 +283,7 @@ void ice_clean_rx_ring(struct ice_ring *rx_ring)
 			continue;
 
 		dma_unmap_page(dev, rx_buf->dma, PAGE_SIZE, DMA_FROM_DEVICE);
-		__free_pages(rx_buf->page, 0);
+		__page_frag_cache_drain(rx_buf->page, rx_buf->pagecnt_bias);
 
 		rx_buf->page = NULL;
 		rx_buf->page_offset = 0;
@@ -423,6 +423,8 @@ ice_alloc_mapped_page(struct ice_ring *rx_ring, struct ice_rx_buf *bi)
 	bi->dma = dma;
 	bi->page = page;
 	bi->page_offset = 0;
+	page_ref_add(page, USHRT_MAX - 1);
+	bi->pagecnt_bias = USHRT_MAX;
 
 	return true;
 }
@@ -509,6 +511,7 @@ static bool ice_page_is_reserved(struct page *page)
 static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf,
 				  unsigned int truesize)
 {
+	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
 	struct page *page = rx_buf->page;
 
 	/* avoid re-using remote pages */
@@ -517,7 +520,7 @@ static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf,
 
 #if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
-	if (unlikely(page_count(page) != 1))
+	if (unlikely((page_count(page) - pagecnt_bias) > 1))
 		return false;
 
 	/* flip page offset to other buffer */
@@ -530,10 +533,14 @@ static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf,
 		return false;
 #endif /* PAGE_SIZE < 8192) */
 
-	/* Even if we own the page, we are not allowed to use atomic_set()
-	 * This would break get_page_unless_zero() users.
+	/* If we have drained the page fragment pool we need to update
+	 * the pagecnt_bias and page count so that we fully restock the
+	 * number of references the driver holds.
 	 */
-	get_page(page);
+	if (unlikely(pagecnt_bias == 1)) {
+		page_ref_add(page, USHRT_MAX - 1);
+		rx_buf->pagecnt_bias = USHRT_MAX;
+	}
 
 	return true;
 }
@@ -576,11 +583,12 @@ ice_add_rx_frag(struct ice_rx_buf *rx_buf, struct sk_buff *skb,
 		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
 
 		/* page is not reserved, we can reuse buffer as-is */
-		if (likely(!ice_page_is_reserved(page)))
+		if (likely(!ice_page_is_reserved(page))) {
+			rx_buf->pagecnt_bias++;
 			return true;
+		}
 
 		/* this page cannot be reused so discard it */
-		__free_pages(page, 0);
 		return false;
 	}
 
@@ -650,6 +658,9 @@ ice_get_rx_buf(struct ice_ring *rx_ring, const unsigned int size)
 				      rx_buf->page_offset, size,
 				      DMA_FROM_DEVICE);
 
+	/* We have pulled a buffer for use, so decrement pagecnt_bias */
+	rx_buf->pagecnt_bias--;
+
 	return rx_buf;
 }
 
@@ -703,6 +714,7 @@ ice_fetch_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
 		/* we are not reusing the buffer so unmap it */
 		dma_unmap_page(rx_ring->dev, rx_buf->dma, PAGE_SIZE,
 			       DMA_FROM_DEVICE);
+		__page_frag_cache_drain(rx_buf->page, rx_buf->pagecnt_bias);
 	}
 
 	/* clear contents of buffer_info */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index b7ff0ff82517..43b39e7ce470 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -73,6 +73,7 @@ struct ice_rx_buf {
 	dma_addr_t dma;
 	struct page *page;
 	unsigned int page_offset;
+	u16 pagecnt_bias;
 };
 
 struct ice_q_stats {
-- 
2.14.5

