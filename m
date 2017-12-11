From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 11 Dec 2017 10:36:49 -0800
Subject: [Intel-wired-lan] [PATCH 1/9] ixgbevf: add function for checking if
 we can reuse page
In-Reply-To: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
Message-ID: <20171211183649.21524.3888.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Introduce ixgbevf_can_reuse_page() similar to the change in ixgbe from
commit af43da0dba0b
("ixgbe: Add function for checking to see if we can reuse page")

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   59 ++++++++++++---------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ed5c3ae..7ffd429 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -754,6 +754,38 @@ static inline bool ixgbevf_page_is_reserved(struct page *page)
 	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
 }
 
+static bool ixgbevf_can_reuse_rx_page(struct ixgbevf_rx_buffer *rx_buffer,
+				      struct page *page,
+				      const unsigned int truesize)
+{
+	/* avoid re-using remote pages */
+	if (unlikely(ixgbevf_page_is_reserved(page)))
+		return false;
+
+#if (PAGE_SIZE < 8192)
+	/* if we are only owner of page we can reuse it */
+	if (unlikely(page_count(page) != 1))
+		return false;
+
+	/* flip page offset to other buffer */
+	rx_buffer->page_offset ^= IXGBEVF_RX_BUFSZ;
+
+#else
+	/* move offset up to the next cache line */
+	rx_buffer->page_offset += truesize;
+
+	if (rx_buffer->page_offset > (PAGE_SIZE - IXGBEVF_RX_BUFSZ))
+		return false;
+
+#endif
+	/* Even if we own the page, we are not allowed to use atomic_set()
+	 * This would break get_page_unless_zero() users.
+	 */
+	page_ref_inc(page);
+
+	return true;
+}
+
 /**
  * ixgbevf_add_rx_frag - Add contents of Rx buffer to sk_buff
  * @rx_ring: rx descriptor ring to transact packets on
@@ -815,32 +847,7 @@ static bool ixgbevf_add_rx_frag(struct ixgbevf_ring *rx_ring,
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 			(unsigned long)va & ~PAGE_MASK, size, truesize);
 
-	/* avoid re-using remote pages */
-	if (unlikely(ixgbevf_page_is_reserved(page)))
-		return false;
-
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely(page_count(page) != 1))
-		return false;
-
-	/* flip page offset to other buffer */
-	rx_buffer->page_offset ^= IXGBEVF_RX_BUFSZ;
-
-#else
-	/* move offset up to the next cache line */
-	rx_buffer->page_offset += truesize;
-
-	if (rx_buffer->page_offset > (PAGE_SIZE - IXGBEVF_RX_BUFSZ))
-		return false;
-
-#endif
-	/* Even if we own the page, we are not allowed to use atomic_set()
-	 * This would break get_page_unless_zero() users.
-	 */
-	page_ref_inc(page);
-
-	return true;
+	return ixgbevf_can_reuse_rx_page(rx_buffer, page, truesize);
 }
 
 static struct sk_buff *ixgbevf_fetch_rx_buffer(struct ixgbevf_ring *rx_ring,

