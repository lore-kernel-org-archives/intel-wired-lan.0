From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Jan 2017 08:35:34 -0800
Subject: [Intel-wired-lan] [next PATCH v2 01/11] ixgbe: Add function for
 checking to see if we can reuse page
In-Reply-To: <20170117163401.5423.37993.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
Message-ID: <20170117163524.5423.68148.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch consolidates the code for the ixgbe driver so that it is more
inline with what is already in igb.  The general idea is to just
consolidate functions that represent logical steps in the Rx process so we
can later update them more easily.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v2: Fix missing rx_ring parameter for PAGE_SIZE > 4K

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   71 +++++++++++++++----------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 3beadc8c7a0a..452a407013ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1947,6 +1947,42 @@ static inline bool ixgbe_page_is_reserved(struct page *page)
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
 
+static bool ixgbe_can_reuse_rx_page(struct ixgbe_ring *rx_ring,
+				    struct ixgbe_rx_buffer *rx_buffer,
+				    struct page *page,
+				    const unsigned int truesize)
+{
+#if (PAGE_SIZE >= 8192)
+	unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
+				   ixgbe_rx_bufsz(rx_ring);
+#endif
+	/* avoid re-using remote pages */
+	if (unlikely(ixgbe_page_is_reserved(page)))
+		return false;
+
+#if (PAGE_SIZE < 8192)
+	/* if we are only owner of page we can reuse it */
+	if (unlikely(page_count(page) != 1))
+		return false;
+
+	/* flip page offset to other buffer */
+	rx_buffer->page_offset ^= truesize;
+#else
+	/* move offset up to the next cache line */
+	rx_buffer->page_offset += truesize;
+
+	if (rx_buffer->page_offset > last_offset)
+		return false;
+#endif
+
+	/* Even if we own the page, we are not allowed to use atomic_set()
+	 * This would break get_page_unless_zero() users.
+	 */
+	page_ref_inc(page);
+
+	return true;
+}
+
 /**
  * ixgbe_add_rx_frag - Add contents of Rx buffer to sk_buff
  * @rx_ring: rx descriptor ring to transact packets on
@@ -1968,18 +2004,18 @@ static bool ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
 			      struct sk_buff *skb)
 {
 	struct page *page = rx_buffer->page;
+	unsigned char *va = page_address(page) + rx_buffer->page_offset;
 	unsigned int size = le16_to_cpu(rx_desc->wb.upper.length);
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = ixgbe_rx_bufsz(rx_ring);
 #else
 	unsigned int truesize = ALIGN(size, L1_CACHE_BYTES);
-	unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
-				   ixgbe_rx_bufsz(rx_ring);
 #endif
 
-	if ((size <= IXGBE_RX_HDR_SIZE) && !skb_is_nonlinear(skb)) {
-		unsigned char *va = page_address(page) + rx_buffer->page_offset;
+	if (unlikely(skb_is_nonlinear(skb)))
+		goto add_tail_frag;
 
+	if (size <= IXGBE_RX_HDR_SIZE) {
 		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
 
 		/* page is not reserved, we can reuse buffer as-is */
@@ -1991,34 +2027,11 @@ static bool ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
 		return false;
 	}
 
+add_tail_frag:
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 			rx_buffer->page_offset, size, truesize);
 
-	/* avoid re-using remote pages */
-	if (unlikely(ixgbe_page_is_reserved(page)))
-		return false;
-
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely(page_count(page) != 1))
-		return false;
-
-	/* flip page offset to other buffer */
-	rx_buffer->page_offset ^= truesize;
-#else
-	/* move offset up to the next cache line */
-	rx_buffer->page_offset += truesize;
-
-	if (rx_buffer->page_offset > last_offset)
-		return false;
-#endif
-
-	/* Even if we own the page, we are not allowed to use atomic_set()
-	 * This would break get_page_unless_zero() users.
-	 */
-	page_ref_inc(page);
-
-	return true;
+	return ixgbe_can_reuse_rx_page(rx_ring, rx_buffer, page, truesize);
 }
 
 static struct sk_buff *ixgbe_fetch_rx_buffer(struct ixgbe_ring *rx_ring,

