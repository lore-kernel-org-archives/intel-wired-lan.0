From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:02 -0800
Subject: [Intel-wired-lan] [PATCH S14 02/15] ice: Pull out page reuse checks
 onto separate function
In-Reply-To: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190213185115.25877-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Introduce ice_can_reuse_rx_page which will verify whether the page can
be reused and return the boolean result to caller.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 80 +++++++++++++++++--------------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8c0a8b63670b..d1f4aef9bcc2 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -496,6 +496,48 @@ static bool ice_page_is_reserved(struct page *page)
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
 
+/**
+ * ice_can_reuse_rx_page - Determine if page can be reused for another rx
+ * @rx_buf: buffer containing the page
+ * @truesize: the offset that needs to be applied to page
+ *
+ * If page is reusable, we have a green light for calling ice_reuse_rx_page,
+ * which will assign the current buffer to the buffer that next_to_alloc is
+ * pointing to; otherwise, the dma mapping needs to be destroyed and
+ * page freed
+ */
+static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf,
+				  unsigned int truesize)
+{
+	struct page *page = rx_buf->page;
+
+	/* avoid re-using remote pages */
+	if (unlikely(ice_page_is_reserved(page)))
+		return false;
+
+#if (PAGE_SIZE < 8192)
+	/* if we are only owner of page we can reuse it */
+	if (unlikely(page_count(page) != 1))
+		return false;
+
+	/* flip page offset to other buffer */
+	rx_buf->page_offset ^= truesize;
+#else
+	/* move offset up to the next cache line */
+	rx_buf->page_offset += truesize;
+
+	if (rx_buf->page_offset > PAGE_SIZE - ICE_RXBUF_2048)
+		return false;
+#endif /* PAGE_SIZE < 8192) */
+
+	/* Even if we own the page, we are not allowed to use atomic_set()
+	 * This would break get_page_unless_zero() users.
+	 */
+	get_page(page);
+
+	return true;
+}
+
 /**
  * ice_add_rx_frag - Add contents of Rx buffer to sk_buff
  * @rx_buf: buffer containing page to add
@@ -517,17 +559,9 @@ ice_add_rx_frag(struct ice_rx_buf *rx_buf, struct sk_buff *skb,
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = ICE_RXBUF_2048;
 #else
-	unsigned int last_offset = PAGE_SIZE - ICE_RXBUF_2048;
-	unsigned int truesize;
+	unsigned int truesize = ALIGN(size, L1_CACHE_BYTES);
 #endif /* PAGE_SIZE < 8192) */
-
-	struct page *page;
-
-	page = rx_buf->page;
-
-#if (PAGE_SIZE >= 8192)
-	truesize = ALIGN(size, L1_CACHE_BYTES);
-#endif /* PAGE_SIZE >= 8192) */
+	struct page *page = rx_buf->page;
 
 	/* will the data fit in the skb we allocated? if so, just
 	 * copy it as it is pretty small anyway
@@ -549,31 +583,7 @@ ice_add_rx_frag(struct ice_rx_buf *rx_buf, struct sk_buff *skb,
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 			rx_buf->page_offset, size, truesize);
 
-	/* avoid re-using remote pages */
-	if (unlikely(ice_page_is_reserved(page)))
-		return false;
-
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely(page_count(page) != 1))
-		return false;
-
-	/* flip page offset to other buffer */
-	rx_buf->page_offset ^= truesize;
-#else
-	/* move offset up to the next cache line */
-	rx_buf->page_offset += truesize;
-
-	if (rx_buf->page_offset > last_offset)
-		return false;
-#endif /* PAGE_SIZE < 8192) */
-
-	/* Even if we own the page, we are not allowed to use atomic_set()
-	 * This would break get_page_unless_zero() users.
-	 */
-	get_page(rx_buf->page);
-
-	return true;
+	return ice_can_reuse_rx_page(rx_buf, truesize);
 }
 
 /**
-- 
2.14.5

