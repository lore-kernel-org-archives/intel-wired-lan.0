From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:11 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 08/12] xsk: wire upp Tx
 zero-copy functions
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-9-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Here we add the functionality required to support zero-copy Tx, and
also exposes various zero-copy related functions to for the netdevs.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 include/net/xdp_sock.h | 11 +++++++-
 net/xdp/xdp_umem.c     | 66 ++++++++++++++++++++++++++++++-----------------
 net/xdp/xdp_umem.h     |  9 +++++--
 net/xdp/xsk.c          | 69 ++++++++++++++++++++++++++++++++++++++++----------
 net/xdp/xsk_queue.h    | 32 ++++++++++++++++++++++-
 5 files changed, 146 insertions(+), 41 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 644684eb2caf..6d89fe84674e 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -18,6 +18,7 @@
 #include <linux/workqueue.h>
 #include <linux/if_xdp.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <net/sock.h>
 
@@ -49,6 +50,9 @@ struct xdp_umem {
 	atomic_t users;
 	struct work_struct work;
 	struct net_device *dev;
+	bool zc;
+	spinlock_t xsk_list_lock;
+	struct list_head xsk_list;
 	u16 queue_id;
 };
 
@@ -61,6 +65,8 @@ struct xdp_sock {
 	struct list_head flush_node;
 	u16 queue_id;
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
+	struct list_head list;
+	bool zc;
 	/* Protects multiple processes in the control path */
 	struct mutex mutex;
 	u64 rx_dropped;
@@ -73,9 +79,12 @@ int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 void xsk_flush(struct xdp_sock *xs);
 bool xsk_is_setup_for_bpf_map(struct xdp_sock *xs);
 
+/* Used from netdev driver */
 u32 *xsk_umem_peek_id(struct xdp_umem *umem);
 void xsk_umem_discard_id(struct xdp_umem *umem);
-
+void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries);
+bool xsk_umem_consume_tx(struct xdp_umem *umem, dma_addr_t *dma,
+			 u32 *len, u16 *offset);
 #else
 static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index f70cdaa2ef4d..b904786ac836 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -27,42 +27,49 @@
 #define XDP_UMEM_MIN_FRAME_SIZE 2048
 
 int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
-			u16 queue_id)
+			u16 queue_id, struct list_head *list_entry)
 {
 	struct netdev_bpf bpf;
+	unsigned long flags;
 	int err;
 
 	if (umem->dev) {
 		if (dev != umem->dev || queue_id != umem->queue_id)
 			return -EBUSY;
-		return 0;
-	}
-
-	dev_hold(dev);
-	if (dev->netdev_ops->ndo_bpf) {
-		bpf.command = XDP_SETUP_XSK_UMEM;
-		bpf.xsk.umem = umem;
-		bpf.xsk.queue_id = queue_id;
-
-		rtnl_lock();
-		err = dev->netdev_ops->ndo_bpf(dev, &bpf);
-		rtnl_unlock();
-
-		if (err) {
+	} else {
+		dev_hold(dev);
+
+		if (dev->netdev_ops->ndo_bpf) {
+			bpf.command = XDP_SETUP_XSK_UMEM;
+			bpf.xsk.umem = umem;
+			bpf.xsk.queue_id = queue_id;
+
+			rtnl_lock();
+			err = dev->netdev_ops->ndo_bpf(dev, &bpf);
+			rtnl_unlock();
+
+			if (err) {
+				dev_put(dev);
+				goto fallback;
+			}
+
+			umem->dev = dev;
+			umem->queue_id = queue_id;
+			umem->zc = true;
+		} else {
 			dev_put(dev);
-			return 0;
 		}
-
-		umem->dev = dev;
-		umem->queue_id = queue_id;
-		return 0;
 	}
 
-	dev_put(dev);
+fallback:
+	spin_lock_irqsave(&umem->xsk_list_lock, flags);
+	list_add_rcu(list_entry, &umem->xsk_list);
+	spin_unlock_irqrestore(&umem->xsk_list_lock, flags);
+
 	return 0;
 }
 
-void xdp_umem_clear_dev(struct xdp_umem *umem)
+static void xdp_umem_clear_dev(struct xdp_umem *umem)
 {
 	struct netdev_bpf bpf;
 	int err;
@@ -172,11 +179,22 @@ void xdp_get_umem(struct xdp_umem *umem)
 	atomic_inc(&umem->users);
 }
 
-void xdp_put_umem(struct xdp_umem *umem)
+void xdp_put_umem(struct xdp_umem *umem, struct xdp_sock *xs)
 {
+	unsigned long flags;
+
 	if (!umem)
 		return;
 
+	if (xs->dev) {
+		spin_lock_irqsave(&umem->xsk_list_lock, flags);
+		list_del_rcu(&xs->list);
+		spin_unlock_irqrestore(&umem->xsk_list_lock, flags);
+
+		if (umem->zc)
+			synchronize_net();
+	}
+
 	if (atomic_dec_and_test(&umem->users)) {
 		INIT_WORK(&umem->work, xdp_umem_release_deferred);
 		schedule_work(&umem->work);
@@ -297,6 +315,8 @@ int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->npgs = size / PAGE_SIZE;
 	umem->pgs = NULL;
 	umem->user = NULL;
+	INIT_LIST_HEAD(&umem->xsk_list);
+	spin_lock_init(&umem->xsk_list_lock);
 
 	atomic_set(&umem->users, 1);
 
diff --git a/net/xdp/xdp_umem.h b/net/xdp/xdp_umem.h
index 3bb96d156b40..5687748a9be3 100644
--- a/net/xdp/xdp_umem.h
+++ b/net/xdp/xdp_umem.h
@@ -22,6 +22,11 @@ static inline char *xdp_umem_get_data(struct xdp_umem *umem, u32 idx)
 	return umem->frames[idx].addr;
 }
 
+static inline dma_addr_t xdp_umem_get_dma(struct xdp_umem *umem, u32 idx)
+{
+	return umem->frames[idx].dma;
+}
+
 static inline char *xdp_umem_get_data_with_headroom(struct xdp_umem *umem,
 						    u32 idx)
 {
@@ -31,10 +36,10 @@ static inline char *xdp_umem_get_data_with_headroom(struct xdp_umem *umem,
 bool xdp_umem_validate_queues(struct xdp_umem *umem);
 int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr);
 void xdp_get_umem(struct xdp_umem *umem);
-void xdp_put_umem(struct xdp_umem *umem);
+void xdp_put_umem(struct xdp_umem *umem, struct xdp_sock *xs);
 int xdp_umem_create(struct xdp_umem **umem);
 
 int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
-			u16 queue_id);
+			u16 queue_id, struct list_head *list_entry);
 
 #endif /* XDP_UMEM_H_ */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a0cf9c042ed2..ac979026671f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
+#include <linux/rculist.h>
 #include <net/xdp_sock.h>
 #include <net/xdp.h>
 
@@ -141,6 +142,49 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	return err;
 }
 
+void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries)
+{
+	xskq_produce_flush_id_n(umem->cq, nb_entries);
+}
+EXPORT_SYMBOL(xsk_umem_complete_tx);
+
+bool xsk_umem_consume_tx(struct xdp_umem *umem, dma_addr_t *dma,
+			 u32 *len, u16 *offset)
+{
+	struct xdp_desc desc;
+	struct xdp_sock *xs;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(xs, &umem->xsk_list, list) {
+		if (!xskq_peek_desc(xs->tx, &desc))
+			continue;
+
+		if (xskq_produce_id_lazy(umem->cq, desc.idx))
+			goto out;
+
+		*dma = xdp_umem_get_dma(umem, desc.idx);
+		*len = desc.len;
+		*offset = desc.offset;
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
 	u32 id = (u32)(long)skb_shinfo(skb)->destructor_arg;
@@ -154,7 +198,6 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 			    size_t total_len)
 {
-	bool need_wait = !(m->msg_flags & MSG_DONTWAIT);
 	u32 max_batch = TX_BATCH_SIZE;
 	struct xdp_sock *xs = xdp_sk(sk);
 	bool sent_frame = false;
@@ -164,8 +207,6 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 
 	if (unlikely(!xs->tx))
 		return -ENOBUFS;
-	if (need_wait)
-		return -EOPNOTSUPP;
 
 	mutex_lock(&xs->mutex);
 
@@ -184,12 +225,7 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 		}
 
 		len = desc.len;
-		if (unlikely(len > xs->dev->mtu)) {
-			err = -EMSGSIZE;
-			goto out;
-		}
-
-		skb = sock_alloc_send_skb(sk, len, !need_wait, &err);
+		skb = sock_alloc_send_skb(sk, len, 1, &err);
 		if (unlikely(!skb)) {
 			err = -EAGAIN;
 			goto out;
@@ -232,6 +268,7 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 
 static int xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 {
+	bool need_wait = !(m->msg_flags & MSG_DONTWAIT);
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 
@@ -239,8 +276,10 @@ static int xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		return -ENXIO;
 	if (unlikely(!(xs->dev->flags & IFF_UP)))
 		return -ENETDOWN;
+	if (need_wait)
+		return -EOPNOTSUPP;
 
-	return xsk_generic_xmit(sk, m, total_len);
+	return (xs->zc) ? xsk_zc_xmit(sk) : xsk_generic_xmit(sk, m, total_len);
 }
 
 static unsigned int xsk_poll(struct file *file, struct socket *sock,
@@ -398,12 +437,14 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		xskq_set_umem(xs->umem->cq, &xs->umem->props);
 	}
 
-	xs->dev = dev;
-	xs->queue_id = sxdp->sxdp_queue_id;
-	err = xdp_umem_assign_dev(xs->umem, dev, xs->queue_id);
+	err = xdp_umem_assign_dev(xs->umem, dev, sxdp->sxdp_queue_id,
+				  &xs->list);
 	if (err)
 		goto out_unlock;
 
+	xs->dev = dev;
+	xs->zc = xs->umem->zc;
+	xs->queue_id = sxdp->sxdp_queue_id;
 	xskq_set_umem(xs->rx, &xs->umem->props);
 	xskq_set_umem(xs->tx, &xs->umem->props);
 
@@ -612,7 +653,7 @@ static void xsk_destruct(struct sock *sk)
 
 	xskq_destroy(xs->rx);
 	xskq_destroy(xs->tx);
-	xdp_put_umem(xs->umem);
+	xdp_put_umem(xs->umem, xs);
 
 	sk_refcnt_debug_dec(sk);
 }
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 599a8d43c69a..5533bf32a254 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -17,9 +17,11 @@
 
 #include <linux/types.h>
 #include <linux/if_xdp.h>
+#include <linux/cache.h>
 #include <net/xdp_sock.h>
 
 #define RX_BATCH_SIZE 16
+#define LAZY_UPDATE_THRESHOLD 128
 
 struct xsk_queue {
 	struct xdp_umem_props umem_props;
@@ -53,9 +55,14 @@ static inline u32 xskq_nb_avail(struct xsk_queue *q, u32 dcnt)
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
@@ -119,6 +126,9 @@ static inline int xskq_produce_id(struct xsk_queue *q, u32 id)
 {
 	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
 
+	if (xskq_nb_free(q, q->prod_tail, LAZY_UPDATE_THRESHOLD) == 0)
+		return -ENOSPC;
+
 	ring->desc[q->prod_tail++ & q->ring_mask] = id;
 
 	/* Order producer and data */
@@ -128,6 +138,26 @@ static inline int xskq_produce_id(struct xsk_queue *q, u32 id)
 	return 0;
 }
 
+static inline int xskq_produce_id_lazy(struct xsk_queue *q, u32 id)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+
+	if (xskq_nb_free(q, q->prod_head, LAZY_UPDATE_THRESHOLD) == 0)
+		return -ENOSPC;
+
+	ring->desc[q->prod_head++ & q->ring_mask] = id;
+	return 0;
+}
+
+static inline void xskq_produce_flush_id_n(struct xsk_queue *q, u32 nb_entries)
+{
+	/* Order producer and data */
+	smp_wmb();
+
+	q->prod_tail += nb_entries;
+	WRITE_ONCE(q->ring->producer, q->prod_tail);
+}
+
 static inline int xskq_reserve_id(struct xsk_queue *q)
 {
 	if (xskq_nb_free(q, q->prod_head, 1) == 0)
-- 
2.14.1

