From: Alexander Lobakin <alobakin@pm.me>
Date: Sun, 31 Jan 2021 12:11:52 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 3/5] net: introduce common
 dev_page_is_reusable()
In-Reply-To: <20210131120844.7529-1-alobakin@pm.me>
References: <20210131120844.7529-1-alobakin@pm.me>
Message-ID: <20210131120844.7529-4-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A bunch of drivers test the page before reusing/recycling for two
common conditions:
 - if a page was allocated under memory pressure (pfmemalloc page);
 - if a page was allocated at a distant memory node (to exclude
   slowdowns).

Introduce a new common inline for doing this, with likely() already
folded inside to make driver code a bit simpler.

Suggested-by: David Rientjes <rientjes@google.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 include/linux/skbuff.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b027526da4f9..0e42c53b8ca9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2938,6 +2938,22 @@ static inline struct page *dev_alloc_page(void)
 	return dev_alloc_pages(0);
 }
 
+/**
+ * dev_page_is_reusable - check whether a page can be reused for network Rx
+ * @page: the page to test
+ *
+ * A page shouldn't be considered for reusing/recycling if it was allocated
+ * under memory pressure or at a distant memory node.
+ *
+ * Returns false if this page should be returned to page allocator, true
+ * otherwise.
+ */
+static inline bool dev_page_is_reusable(const struct page *page)
+{
+	return likely(page_to_nid(page) == numa_mem_id() &&
+		      !page_is_pfmemalloc(page));
+}
+
 /**
  *	skb_propagate_pfmemalloc - Propagate pfmemalloc if skb is allocated after RX page
  *	@page: The page that was allocated from skb_alloc_page
-- 
2.30.0


