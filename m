From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  4 Jun 2018 14:05:54 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 04/11] xdp: add MEM_TYPE_ZERO_COPY
In-Reply-To: <20180604120601.18123-1-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
Message-ID: <20180604120601.18123-5-bjorn.topel@gmail.com>
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
 net/core/xdp.c    | 19 ++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index a3b71a4dd71d..2deea7166a34 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -37,6 +37,7 @@ enum xdp_mem_type {
 	MEM_TYPE_PAGE_SHARED = 0, /* Split-page refcnt based model */
 	MEM_TYPE_PAGE_ORDER0,     /* Orig XDP full page model */
 	MEM_TYPE_PAGE_POOL,
+	MEM_TYPE_ZERO_COPY,
 	MEM_TYPE_MAX,
 };
 
@@ -51,6 +52,10 @@ struct xdp_mem_info {
 
 struct page_pool;
 
+struct zero_copy_allocator {
+	void (*free)(struct zero_copy_allocator *zca, unsigned long handle);
+};
+
 struct xdp_rxq_info {
 	struct net_device *dev;
 	u32 queue_index;
@@ -63,6 +68,7 @@ struct xdp_buff {
 	void *data_end;
 	void *data_meta;
 	void *data_hard_start;
+	unsigned long handle;
 	struct xdp_rxq_info *rxq;
 };
 
@@ -86,6 +92,10 @@ struct xdp_frame *convert_to_xdp_frame(struct xdp_buff *xdp)
 	int metasize;
 	int headroom;
 
+	/* TODO: implement clone, copy, use "native" MEM_TYPE */
+	if (xdp->rxq->mem.type == MEM_TYPE_ZERO_COPY)
+		return NULL;
+
 	/* Assure headroom is available for storing info */
 	headroom = xdp->data - xdp->data_hard_start;
 	metasize = xdp->data - xdp->data_meta;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index cb8c4e061a5a..9d1f22072d5d 100644
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
@@ -314,7 +315,8 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_reg_mem_model);
  * is used for those calls sites.  Thus, allowing for faster recycling
  * of xdp_frames/pages in those cases.
  */
-static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct)
+static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
+			 unsigned long handle)
 {
 	struct xdp_mem_allocator *xa;
 	struct page *page;
@@ -338,6 +340,13 @@ static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct)
 		page = virt_to_page(data); /* Assumes order0 page*/
 		put_page(page);
 		break;
+	case MEM_TYPE_ZERO_COPY:
+		/* NB! Only valid from an xdp_buff! */
+		rcu_read_lock();
+		/* mem->id is valid, checked in xdp_rxq_info_reg_mem_model() */
+		xa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
+		xa->zc_alloc->free(xa->zc_alloc, handle);
+		rcu_read_unlock();
 	default:
 		/* Not possible, checked in xdp_rxq_info_reg_mem_model() */
 		break;
@@ -346,18 +355,18 @@ static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct)
 
 void xdp_return_frame(struct xdp_frame *xdpf)
 {
-	__xdp_return(xdpf->data, &xdpf->mem, false);
+	__xdp_return(xdpf->data, &xdpf->mem, false, 0);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame);
 
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf)
 {
-	__xdp_return(xdpf->data, &xdpf->mem, true);
+	__xdp_return(xdpf->data, &xdpf->mem, true, 0);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
 
 void xdp_return_buff(struct xdp_buff *xdp)
 {
-	__xdp_return(xdp->data, &xdp->rxq->mem, true);
+	__xdp_return(xdp->data, &xdp->rxq->mem, true, xdp->handle);
 }
 EXPORT_SYMBOL_GPL(xdp_return_buff);
-- 
2.14.1

