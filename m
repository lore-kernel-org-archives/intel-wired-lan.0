From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  4 Jun 2018 14:05:57 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 07/11] xsk: wire upp Tx zero-copy
 functions
In-Reply-To: <20180604120601.18123-1-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
Message-ID: <20180604120601.18123-8-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Here we add the functionality required to support zero-copy Tx, and
also exposes various zero-copy related functions for the netdevs.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 include/net/xdp_sock.h |  9 +++++++
 net/xdp/xdp_umem.c     | 29 +++++++++++++++++++--
 net/xdp/xdp_umem.h     |  8 +++++-
 net/xdp/xsk.c          | 70 +++++++++++++++++++++++++++++++++++++++++++++-----
 net/xdp/xsk_queue.h    | 32 ++++++++++++++++++++++-
 5 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index d93d3aac3fc9..9fe472f2ac95 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -9,6 +9,7 @@
 #include <linux/workqueue.h>
 #include <linux/if_xdp.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <net/sock.h>
 
@@ -42,6 +43,8 @@ struct xdp_umem {
 	struct net_device *dev;
 	u16 queue_id;
 	bool zc;
+	spinlock_t xsk_list_lock;
+	struct list_head xsk_list;
 };
 
 struct xdp_sock {
@@ -53,6 +56,8 @@ struct xdp_sock {
 	struct list_head flush_node;
 	u16 queue_id;
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
+	struct list_head list;
+	bool zc;
 	/* Protects multiple processes in the control path */
 	struct mutex mutex;
 	u64 rx_dropped;
@@ -64,8 +69,12 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 void xsk_flush(struct xdp_sock *xs);
 bool xsk_is_setup_for_bpf_map(struct xdp_sock *xs);
+/* Used from netdev driver */
 u64 *xsk_umem_peek_addr(struct xdp_umem *umem, u64 *addr);
 void xsk_umem_discard_addr(struct xdp_umem *umem);
+void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries);
+bool xsk_umem_consume_tx(struct xdp_umem *umem, dma_addr_t *dma, u32 *len);
+void xsk_umem_consume_tx_done(struct xdp_umem *umem);
 #else
 static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index f729d79b8d91..7eb4948a38d2 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -17,6 +17,29 @@
 
 #define XDP_UMEM_MIN_CHUNK_SIZE 2048
 
+void xdp_add_sk_umem(struct xdp_umem *umem, struct xdp_sock *xs)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&umem->xsk_list_lock, flags);
+	list_add_rcu(&xs->list, &umem->xsk_list);
+	spin_unlock_irqrestore(&umem->xsk_list_lock, flags);
+}
+
+void xdp_del_sk_umem(struct xdp_umem *umem, struct xdp_sock *xs)
+{
+	unsigned long flags;
+
+	if (xs->dev) {
+		spin_lock_irqsave(&umem->xsk_list_lock, flags);
+		list_del_rcu(&xs->list);
+		spin_unlock_irqrestore(&umem->xsk_list_lock, flags);
+
+		if (umem->zc)
+			synchronize_net();
+	}
+}
+
 int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
 			u32 queue_id, u16 flags)
 {
@@ -35,7 +58,7 @@ int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
 
 	dev_hold(dev);
 
-	if (dev->netdev_ops->ndo_bpf) {
+	if (dev->netdev_ops->ndo_bpf && dev->netdev_ops->ndo_xsk_async_xmit) {
 		bpf.command = XDP_QUERY_XSK_UMEM;
 
 		rtnl_lock();
@@ -70,7 +93,7 @@ int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
 	return force_zc ? -ENOTSUPP : 0; /* fail or fallback */
 }
 
-void xdp_umem_clear_dev(struct xdp_umem *umem)
+static void xdp_umem_clear_dev(struct xdp_umem *umem)
 {
 	struct netdev_bpf bpf;
 	int err;
@@ -283,6 +306,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->npgs = size / PAGE_SIZE;
 	umem->pgs = NULL;
 	umem->user = NULL;
+	INIT_LIST_HEAD(&umem->xsk_list);
+	spin_lock_init(&umem->xsk_list_lock);
 
 	refcount_set(&umem->users, 1);
 
diff --git a/net/xdp/xdp_umem.h b/net/xdp/xdp_umem.h
index 674508a32a4d..f11560334f88 100644
--- a/net/xdp/xdp_umem.h
+++ b/net/xdp/xdp_umem.h
@@ -13,12 +13,18 @@ static inline char *xdp_umem_get_data(struct xdp_umem *umem, u64 addr)
 	return umem->pages[addr >> PAGE_SHIFT].addr + (addr & (PAGE_SIZE - 1));
 }
 
+static inline dma_addr_t xdp_umem_get_dma(struct xdp_umem *umem, u64 addr)
+{
+	return umem->pages[addr >> PAGE_SHIFT].dma + (addr & (PAGE_SIZE - 1));
+}
+
 int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
 			u32 queue_id, u16 flags);
-void xdp_umem_clear_dev(struct xdp_umem *umem);
 bool xdp_umem_validate_queues(struct xdp_umem *umem);
 void xdp_get_umem(struct xdp_umem *umem);
 void xdp_put_umem(struct xdp_umem *umem);
+void xdp_add_sk_umem(struct xdp_umem *umem, struct xdp_sock *xs);
+void xdp_del_sk_umem(struct xdp_umem *umem, struct xdp_sock *xs);
 struct xdp_umem *xdp_umem_create(struct xdp_umem_reg *mr);
 
 #endif /* XDP_UMEM_H_ */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ab64bd8260ea..ddca4bf1cfc8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
+#include <linux/rculist.h>
 #include <net/xdp_sock.h>
 #include <net/xdp.h>
 
@@ -138,6 +139,59 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	return err;
 }
 
+void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries)
+{
+	xskq_produce_flush_addr_n(umem->cq, nb_entries);
+}
+EXPORT_SYMBOL(xsk_umem_complete_tx);
+
+void xsk_umem_consume_tx_done(struct xdp_umem *umem)
+{
+	struct xdp_sock *xs;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(xs, &umem->xsk_list, list) {
+		xs->sk.sk_write_space(&xs->sk);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(xsk_umem_consume_tx_done);
+
+bool xsk_umem_consume_tx(struct xdp_umem *umem, dma_addr_t *dma, u32 *len)
+{
+	struct xdp_desc desc;
+	struct xdp_sock *xs;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(xs, &umem->xsk_list, list) {
+		if (!xskq_peek_desc(xs->tx, &desc))
+			continue;
+
+		if (xskq_produce_addr_lazy(umem->cq, desc.addr))
+			goto out;
+
+		*dma = xdp_umem_get_dma(umem, desc.addr);
+		*len = desc.len;
+
+		xskq_discard_desc(xs->tx);
+		rcu_read_unlock();
+		return true;
+	}
+
+out:
+	rcu_read_unlock();
+	return false;
+}
+EXPORT_SYMBOL(xsk_umem_consume_tx);
+
+static int xsk_zc_xmit(struct sock *sk)
+{
+	struct xdp_sock *xs = xdp_sk(sk);
+	struct net_device *dev = xs->dev;
+
+	return dev->netdev_ops->ndo_xsk_async_xmit(dev, xs->queue_id);
+}
+
 static void xsk_destruct_skb(struct sk_buff *skb)
 {
 	u64 addr = (u64)(long)skb_shinfo(skb)->destructor_arg;
@@ -151,7 +205,6 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 			    size_t total_len)
 {
-	bool need_wait = !(m->msg_flags & MSG_DONTWAIT);
 	u32 max_batch = TX_BATCH_SIZE;
 	struct xdp_sock *xs = xdp_sk(sk);
 	bool sent_frame = false;
@@ -161,8 +214,6 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 
 	if (unlikely(!xs->tx))
 		return -ENOBUFS;
-	if (need_wait)
-		return -EOPNOTSUPP;
 
 	mutex_lock(&xs->mutex);
 
@@ -192,7 +243,7 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 			goto out;
 		}
 
-		skb = sock_alloc_send_skb(sk, len, !need_wait, &err);
+		skb = sock_alloc_send_skb(sk, len, 1, &err);
 		if (unlikely(!skb)) {
 			err = -EAGAIN;
 			goto out;
@@ -235,6 +286,7 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 
 static int xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 {
+	bool need_wait = !(m->msg_flags & MSG_DONTWAIT);
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 
@@ -242,8 +294,10 @@ static int xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		return -ENXIO;
 	if (unlikely(!(xs->dev->flags & IFF_UP)))
 		return -ENETDOWN;
+	if (need_wait)
+		return -EOPNOTSUPP;
 
-	return xsk_generic_xmit(sk, m, total_len);
+	return (xs->zc) ? xsk_zc_xmit(sk) : xsk_generic_xmit(sk, m, total_len);
 }
 
 static unsigned int xsk_poll(struct file *file, struct socket *sock,
@@ -419,10 +473,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	}
 
 	xs->dev = dev;
-	xs->queue_id = sxdp->sxdp_queue_id;
-
+	xs->zc = xs->umem->zc;
+	xs->queue_id = qid;
 	xskq_set_umem(xs->rx, &xs->umem->props);
 	xskq_set_umem(xs->tx, &xs->umem->props);
+	xdp_add_sk_umem(xs->umem, xs);
 
 out_unlock:
 	if (err)
@@ -660,6 +715,7 @@ static void xsk_destruct(struct sock *sk)
 
 	xskq_destroy(xs->rx);
 	xskq_destroy(xs->tx);
+	xdp_del_sk_umem(xs->umem, xs);
 	xdp_put_umem(xs->umem);
 
 	sk_refcnt_debug_dec(sk);
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 5246ed420a16..ef6a6f0ec949 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -11,6 +11,7 @@
 #include <net/xdp_sock.h>
 
 #define RX_BATCH_SIZE 16
+#define LAZY_UPDATE_THRESHOLD 128
 
 struct xdp_ring {
 	u32 producer ____cacheline_aligned_in_smp;
@@ -61,9 +62,14 @@ static inline u32 xskq_nb_avail(struct xsk_queue *q, u32 dcnt)
 	return (entries > dcnt) ? dcnt : entries;
 }
 
+static inline u32 xskq_nb_free_lazy(struct xsk_queue *q, u32 producer)
+{
+	return q->nentries - (producer - q->cons_tail);
+}
+
 static inline u32 xskq_nb_free(struct xsk_queue *q, u32 producer, u32 dcnt)
 {
-	u32 free_entries = q->nentries - (producer - q->cons_tail);
+	u32 free_entries = xskq_nb_free_lazy(q, producer);
 
 	if (free_entries >= dcnt)
 		return free_entries;
@@ -123,6 +129,9 @@ static inline int xskq_produce_addr(struct xsk_queue *q, u64 addr)
 {
 	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
 
+	if (xskq_nb_free(q, q->prod_tail, LAZY_UPDATE_THRESHOLD) == 0)
+		return -ENOSPC;
+
 	ring->desc[q->prod_tail++ & q->ring_mask] = addr;
 
 	/* Order producer and data */
@@ -132,6 +141,27 @@ static inline int xskq_produce_addr(struct xsk_queue *q, u64 addr)
 	return 0;
 }
 
+static inline int xskq_produce_addr_lazy(struct xsk_queue *q, u64 addr)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+
+	if (xskq_nb_free(q, q->prod_head, LAZY_UPDATE_THRESHOLD) == 0)
+		return -ENOSPC;
+
+	ring->desc[q->prod_head++ & q->ring_mask] = addr;
+	return 0;
+}
+
+static inline void xskq_produce_flush_addr_n(struct xsk_queue *q,
+					     u32 nb_entries)
+{
+	/* Order producer and data */
+	smp_wmb();
+
+	q->prod_tail += nb_entries;
+	WRITE_ONCE(q->ring->producer, q->prod_tail);
+}
+
 static inline int xskq_reserve_addr(struct xsk_queue *q)
 {
 	if (xskq_nb_free(q, q->prod_head, 1) == 0)
-- 
2.14.1

