From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:08 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 05/12] xdp: add
 MEM_TYPE_ZERO_COPY
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-6-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Here, a new type of allocator support is added to the XDP return
API. A zero-copy allocated xdp_buff cannot be converted to an
xdp_frame. Instead is the buff has to be copied. This is not supported
at all in this commit.

Also, an opaque "handle" is added to xdp_buff. This can be used as a
context for the zero-copy allocator implementation.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/net/xdp.h | 10 ++++++++++
 net/core/xdp.c    | 47 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 0b689cf561c7..e9eee37cddd6 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -37,6 +37,7 @@ enum xdp_mem_type {
 	MEM_TYPE_PAGE_SHARED = 0, /* Split-page refcnt based model */
 	MEM_TYPE_PAGE_ORDER0,     /* Orig XDP full page model */
 	MEM_TYPE_PAGE_POOL,
+	MEM_TYPE_ZERO_COPY,
 	MEM_TYPE_MAX,
 };
 
@@ -47,6 +48,10 @@ struct xdp_mem_info {
 
 struct page_pool;
 
+struct zero_copy_allocator {
+	void (*free)(struct zero_copy_allocator *, unsigned long);
+};
+
 struct xdp_rxq_info {
 	struct net_device *dev;
 	u32 queue_index;
@@ -59,6 +64,7 @@ struct xdp_buff {
 	void *data_end;
 	void *data_meta;
 	void *data_hard_start;
+	unsigned long handle;
 	struct xdp_rxq_info *rxq;
 };
 
@@ -82,6 +88,10 @@ struct xdp_frame *convert_to_xdp_frame(struct xdp_buff *xdp)
 	int metasize;
 	int headroom;
 
+	// XXX implement clone, copy, use "native" MEM_TYPE
+	if (xdp->rxq->mem.type == MEM_TYPE_ZERO_COPY)
+		return NULL;
+
 	/* Assure headroom is available for storing info */
 	headroom = xdp->data - xdp->data_hard_start;
 	metasize = xdp->data - xdp->data_meta;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bf6758f74339..4e11895b8cd9 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -31,6 +31,7 @@ struct xdp_mem_allocator {
 	union {
 		void *allocator;
 		struct page_pool *page_pool;
+		struct zero_copy_allocator *zc_alloc;
 	};
 	struct rhash_head node;
 	struct rcu_head rcu;
@@ -261,7 +262,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 	xdp_rxq->mem.type = type;
 
 	if (!allocator) {
-		if (type == MEM_TYPE_PAGE_POOL)
+		if (type == MEM_TYPE_PAGE_POOL || type == MEM_TYPE_ZERO_COPY)
 			return -EINVAL; /* Setup time check page_pool req */
 		return 0;
 	}
@@ -308,9 +309,11 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 }
 EXPORT_SYMBOL_GPL(xdp_rxq_info_reg_mem_model);
 
-static void xdp_return(void *data, struct xdp_mem_info *mem)
+void xdp_return_frame(struct xdp_frame *xdpf)
 {
+	struct xdp_mem_info *mem = &xdpf->mem;
 	struct xdp_mem_allocator *xa;
+	void *data = xdpf->data;
 	struct page *page;
 
 	switch (mem->type) {
@@ -336,16 +339,46 @@ static void xdp_return(void *data, struct xdp_mem_info *mem)
 		/* Not possible, checked in xdp_rxq_info_reg_mem_model() */
 		break;
 	}
-}
 
-void xdp_return_frame(struct xdp_frame *xdpf)
-{
-	xdp_return(xdpf->data, &xdpf->mem);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame);
 
 void xdp_return_buff(struct xdp_buff *xdp)
 {
-	xdp_return(xdp->data, &xdp->rxq->mem);
+	struct xdp_mem_info *mem = &xdp->rxq->mem;
+	struct xdp_mem_allocator *xa;
+	void *data = xdp->data;
+	struct page *page;
+
+	switch (mem->type) {
+	case MEM_TYPE_ZERO_COPY:
+		rcu_read_lock();
+		/* mem->id is valid, checked in xdp_rxq_info_reg_mem_model() */
+		xa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
+		xa->zc_alloc->free(xa->zc_alloc, xdp->handle);
+		rcu_read_unlock();
+		break;
+	case MEM_TYPE_PAGE_POOL:
+		rcu_read_lock();
+		/* mem->id is valid, checked in xdp_rxq_info_reg_mem_model() */
+		xa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
+		page = virt_to_head_page(data);
+		if (xa)
+			page_pool_put_page(xa->page_pool, page);
+		else
+			put_page(page);
+		rcu_read_unlock();
+		break;
+	case MEM_TYPE_PAGE_SHARED:
+		page_frag_free(data);
+		break;
+	case MEM_TYPE_PAGE_ORDER0:
+		page = virt_to_page(data); /* Assumes order0 page*/
+		put_page(page);
+		break;
+	default:
+		/* Not possible, checked in xdp_rxq_info_reg_mem_model() */
+		break;
+	}
 }
 EXPORT_SYMBOL_GPL(xdp_return_buff);
-- 
2.14.1

