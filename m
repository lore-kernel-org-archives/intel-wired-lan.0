From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue,  4 Sep 2018 20:11:03 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 2/4] net: xsk: add a simple
 buffer reuse queue
In-Reply-To: <20180904181105.10983-1-bjorn.topel@gmail.com>
References: <20180904181105.10983-1-bjorn.topel@gmail.com>
Message-ID: <20180904181105.10983-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jakub Kicinski <jakub.kicinski@netronome.com>

XSK UMEM is strongly single producer single consumer so reuse of
frames is challenging.  Add a simple "stash" of FILL packets to
reuse for drivers to optionally make use of.  This is useful
when driver has to free (ndo_stop) or resize a ring with an active
AF_XDP ZC socket.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 include/net/xdp_sock.h | 43 +++++++++++++++++++++++++++++++++
 net/xdp/xdp_umem.c     |  2 ++
 net/xdp/xsk_queue.c    | 55 ++++++++++++++++++++++++++++++++++++++++++
 net/xdp/xsk_queue.h    |  3 +++
 4 files changed, 103 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 932ca0dad6f3..7b55206da138 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -14,6 +14,7 @@
 #include <net/sock.h>
 
 struct net_device;
+struct xdp_umem_fq_reuse;
 struct xsk_queue;
 
 struct xdp_umem_page {
@@ -37,6 +38,7 @@ struct xdp_umem {
 	struct page **pgs;
 	u32 npgs;
 	struct net_device *dev;
+	struct xdp_umem_fq_reuse *fq_reuse;
 	u16 queue_id;
 	bool zc;
 	spinlock_t xsk_list_lock;
@@ -139,4 +141,45 @@ static inline dma_addr_t xdp_umem_get_dma(struct xdp_umem *umem, u64 addr)
 }
 #endif /* CONFIG_XDP_SOCKETS */
 
+struct xdp_umem_fq_reuse {
+	u32 nentries;
+	u32 length;
+	u64 handles[];
+};
+
+/* Following functions are not thread-safe in any way */
+struct xdp_umem_fq_reuse *xsk_reuseq_prepare(u32 nentries);
+struct xdp_umem_fq_reuse *xsk_reuseq_swap(struct xdp_umem *umem,
+					  struct xdp_umem_fq_reuse *newq);
+void xsk_reuseq_free(struct xdp_umem_fq_reuse *rq);
+
+/* Reuse-queue aware version of FILL queue helpers */
+static inline u64 *xsk_umem_peek_addr_rq(struct xdp_umem *umem, u64 *addr)
+{
+	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
+
+	if (!rq->length)
+		return xsk_umem_peek_addr(umem, addr);
+
+	*addr = rq->handles[rq->length - 1];
+	return addr;
+}
+
+static inline void xsk_umem_discard_addr_rq(struct xdp_umem *umem)
+{
+	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
+
+	if (!rq->length)
+		xsk_umem_discard_addr(umem);
+	else
+		rq->length--;
+}
+
+static inline void xsk_umem_fq_reuse(struct xdp_umem *umem, u64 addr)
+{
+	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
+
+	rq->handles[rq->length++] = addr;
+}
+
 #endif /* _LINUX_XDP_SOCK_H */
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index b3b632c5aeae..555427b3e0fe 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -165,6 +165,8 @@ static void xdp_umem_release(struct xdp_umem *umem)
 		umem->cq = NULL;
 	}
 
+	xsk_reuseq_destroy(umem);
+
 	xdp_umem_unpin_pages(umem);
 
 	task = get_pid_task(umem->pid, PIDTYPE_PID);
diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index 2dc1384d9f27..b66504592d9b 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -3,7 +3,9 @@
  * Copyright(c) 2018 Intel Corporation.
  */
 
+#include <linux/log2.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 
 #include "xsk_queue.h"
 
@@ -62,3 +64,56 @@ void xskq_destroy(struct xsk_queue *q)
 	page_frag_free(q->ring);
 	kfree(q);
 }
+
+struct xdp_umem_fq_reuse *xsk_reuseq_prepare(u32 nentries)
+{
+	struct xdp_umem_fq_reuse *newq;
+
+	/* Check for overflow */
+	if (nentries > (u32)roundup_pow_of_two(nentries))
+		return NULL;
+	nentries = roundup_pow_of_two(nentries);
+
+	newq = kvmalloc(struct_size(newq, handles, nentries), GFP_KERNEL);
+	if (!newq)
+		return NULL;
+	memset(newq, 0, offsetof(typeof(*newq), handles));
+
+	newq->nentries = nentries;
+	return newq;
+}
+EXPORT_SYMBOL_GPL(xsk_reuseq_prepare);
+
+struct xdp_umem_fq_reuse *xsk_reuseq_swap(struct xdp_umem *umem,
+					  struct xdp_umem_fq_reuse *newq)
+{
+	struct xdp_umem_fq_reuse *oldq = umem->fq_reuse;
+
+	if (!oldq) {
+		umem->fq_reuse = newq;
+		return NULL;
+	}
+
+	if (newq->nentries < oldq->length)
+		return newq;
+
+	memcpy(newq->handles, oldq->handles,
+	       array_size(oldq->length, sizeof(u64)));
+	newq->length = oldq->length;
+
+	umem->fq_reuse = newq;
+	return oldq;
+}
+EXPORT_SYMBOL_GPL(xsk_reuseq_swap);
+
+void xsk_reuseq_free(struct xdp_umem_fq_reuse *rq)
+{
+	kvfree(rq);
+}
+EXPORT_SYMBOL_GPL(xsk_reuseq_free);
+
+void xsk_reuseq_destroy(struct xdp_umem *umem)
+{
+	xsk_reuseq_free(umem->fq_reuse);
+	umem->fq_reuse = NULL;
+}
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 82252cccb4e0..bcb5cbb40419 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -258,4 +258,7 @@ void xskq_set_umem(struct xsk_queue *q, u64 size, u64 chunk_mask);
 struct xsk_queue *xskq_create(u32 nentries, bool umem_queue);
 void xskq_destroy(struct xsk_queue *q_ops);
 
+/* Executed by the core when the entire UMEM gets freed */
+void xsk_reuseq_destroy(struct xdp_umem *umem);
+
 #endif /* _LINUX_XSK_QUEUE_H */
-- 
2.17.1

