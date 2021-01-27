From: Alexander Lobakin <alobakin@pm.me>
Date: Wed, 27 Jan 2021 20:11:12 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/4] skbuff: constify
 skb_propagate_pfmemalloc() "page" argument
In-Reply-To: <20210127201031.98544-1-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
Message-ID: <20210127201031.98544-3-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function doesn't write anything to the page struct itself,
so this argument can be const.

Misc: align second argument to the brace while at it.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 include/linux/skbuff.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9313b5aaf45b..b027526da4f9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2943,8 +2943,8 @@ static inline struct page *dev_alloc_page(void)
  *	@page: The page that was allocated from skb_alloc_page
  *	@skb: The skb that may need pfmemalloc set
  */
-static inline void skb_propagate_pfmemalloc(struct page *page,
-					     struct sk_buff *skb)
+static inline void skb_propagate_pfmemalloc(const struct page *page,
+					    struct sk_buff *skb)
 {
 	if (page_is_pfmemalloc(page))
 		skb->pfmemalloc = true;
-- 
2.30.0


