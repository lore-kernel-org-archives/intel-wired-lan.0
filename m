From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 25 Aug 2020 19:27:35 +0200
Subject: [Intel-wired-lan] [PATCH net v3 2/3] ixgbe: avoid premature Rx
 buffer reuse
In-Reply-To: <20200825172736.27318-1-bjorn.topel@gmail.com>
References: <20200825172736.27318-1-bjorn.topel@gmail.com>
Message-ID: <20200825172736.27318-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The page recycle code, incorrectly, relied on that a page fragment
could not be freed inside xdp_do_redirect(). This assumption leads to
that page fragments that are used by the stack/XDP redirect can be
reused and overwritten.

To avoid this, store the page count prior invoking xdp_do_redirect().

Fixes: 6453073987ba ("ixgbe: add initial support for xdp redirect")
Reported-and-analyzed-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2f8a4cfc5fa1..824c776a3abc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1945,7 +1945,8 @@ static inline bool ixgbe_page_is_reserved(struct page *page)
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
 
-static bool ixgbe_can_reuse_rx_page(struct ixgbe_rx_buffer *rx_buffer)
+static bool ixgbe_can_reuse_rx_page(struct ixgbe_rx_buffer *rx_buffer,
+				    int rx_buffer_pgcnt)
 {
 	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
 	struct page *page = rx_buffer->page;
@@ -1956,7 +1957,7 @@ static bool ixgbe_can_reuse_rx_page(struct ixgbe_rx_buffer *rx_buffer)
 
 #if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
-	if (unlikely((page_ref_count(page) - pagecnt_bias) > 1))
+	if (unlikely((rx_buffer_pgcnt - pagecnt_bias) > 1))
 		return false;
 #else
 	/* The last offset is a bit aggressive in that we assume the
@@ -2021,11 +2022,18 @@ static void ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
 static struct ixgbe_rx_buffer *ixgbe_get_rx_buffer(struct ixgbe_ring *rx_ring,
 						   union ixgbe_adv_rx_desc *rx_desc,
 						   struct sk_buff **skb,
-						   const unsigned int size)
+						   const unsigned int size,
+						   int *rx_buffer_pgcnt)
 {
 	struct ixgbe_rx_buffer *rx_buffer;
 
 	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+	*rx_buffer_pgcnt =
+#if (PAGE_SIZE < 8192)
+		page_count(rx_buffer->page);
+#else
+		0;
+#endif
 	prefetchw(rx_buffer->page);
 	*skb = rx_buffer->skb;
 
@@ -2055,9 +2063,10 @@ static struct ixgbe_rx_buffer *ixgbe_get_rx_buffer(struct ixgbe_ring *rx_ring,
 
 static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 				struct ixgbe_rx_buffer *rx_buffer,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				int rx_buffer_pgcnt)
 {
-	if (ixgbe_can_reuse_rx_page(rx_buffer)) {
+	if (ixgbe_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
 		/* hand second half of page back to the ring */
 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
@@ -2308,6 +2317,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 		union ixgbe_adv_rx_desc *rx_desc;
 		struct ixgbe_rx_buffer *rx_buffer;
 		struct sk_buff *skb;
+		int rx_buffer_pgcnt;
 		unsigned int size;
 
 		/* return some buffers to hardware, one at a time is too slow */
@@ -2327,7 +2337,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 		 */
 		dma_rmb();
 
-		rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
+		rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size, &rx_buffer_pgcnt);
 
 		/* retrieve a buffer from the ring */
 		if (!skb) {
@@ -2372,7 +2382,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			break;
 		}
 
-		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb);
+		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt);
 		cleaned_count++;
 
 		/* place incomplete frames back on ring for completion */
-- 
2.25.1

