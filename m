From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 10 Nov 2020 12:01:33 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next v2 4/5] xsk: introduce batched Tx
 descriptor interfaces
In-Reply-To: <1605006094-31097-1-git-send-email-magnus.karlsson@gmail.com>
References: <1605006094-31097-1-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <1605006094-31097-5-git-send-email-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Introduce batched descriptor interfaces in the xsk core code for the
Tx path to be used in the driver to write a code path with higher
performance. This interface will be used by the i40e driver in the
next patch. Though other drivers would likely benefit from this new
interface too.

Note that batching is only implemented for the common case when
there is only one socket bound to the same device and queue id. When
this is not the case, we fall back to the old non-batched version of
the function.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 include/net/xdp_sock_drv.h |  7 ++++
 net/xdp/xsk.c              | 57 ++++++++++++++++++++++++++++
 net/xdp/xsk_queue.h        | 92 +++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 143 insertions(+), 13 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 5b1ee8a..4e295541 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -13,6 +13,7 @@
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
+u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *desc, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
 struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
 					    u16 queue_id);
@@ -128,6 +129,12 @@ static inline bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,
 	return false;
 }
 
+static inline u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *desc,
+						 u32 max)
+{
+	return 0;
+}
+
 static inline void xsk_tx_release(struct xsk_buff_pool *pool)
 {
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b71a32e..37f70cd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -332,6 +332,63 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 }
 EXPORT_SYMBOL(xsk_tx_peek_desc);
 
+static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, struct xdp_desc *descs,
+					u32 max_entries)
+{
+	u32 nb_pkts = 0;
+
+	while (nb_pkts < max_entries && xsk_tx_peek_desc(pool, &descs[nb_pkts]))
+		nb_pkts++;
+
+	xsk_tx_release(pool);
+	return nb_pkts;
+}
+
+u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *descs,
+				   u32 max_entries)
+{
+	struct xdp_sock *xs;
+	u32 nb_pkts;
+
+	rcu_read_lock();
+	if (!list_is_singular(&pool->xsk_tx_list)) {
+		/* Fallback to the non-batched version */
+		rcu_read_unlock();
+		return xsk_tx_peek_release_fallback(pool, descs, max_entries);
+	}
+
+	xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);
+	if (!xs) {
+		nb_pkts = 0;
+		goto out;
+	}
+
+	nb_pkts = xskq_cons_peek_desc_batch(xs->tx, descs, pool, max_entries);
+	if (!nb_pkts) {
+		xs->tx->queue_empty_descs++;
+		goto out;
+	}
+
+	/* This is the backpressure mechanism for the Tx path. Try to
+	 * reserve space in the completion queue for all packets, but
+	 * if there are fewer slots available, just process that many
+	 * packets. This avoids having to implement any buffering in
+	 * the Tx path.
+	 */
+	nb_pkts = xskq_prod_reserve_addr_batch(pool->cq, descs, nb_pkts);
+	if (!nb_pkts)
+		goto out;
+
+	xskq_cons_release_n(xs->tx, nb_pkts);
+	__xskq_cons_release(xs->tx);
+	xs->sk.sk_write_space(&xs->sk);
+
+out:
+	rcu_read_unlock();
+	return nb_pkts;
+}
+EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
+
 static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 {
 	struct net_device *dev = xs->dev;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 74fac80..7350f87 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -199,6 +199,33 @@ static inline bool xskq_cons_read_desc(struct xsk_queue *q,
 	return false;
 }
 
+static inline u32 xskq_cons_read_desc_batch(struct xsk_queue *q,
+					    struct xdp_desc *descs,
+					    struct xsk_buff_pool *pool, u32 max)
+{
+	u32 cached_cons = q->cached_cons, nb_entries = 0;
+
+	while (cached_cons != q->cached_prod && nb_entries < max) {
+		struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
+		u32 idx = cached_cons & q->ring_mask;
+
+		descs[nb_entries] = ring->desc[idx];
+		if (unlikely(!xskq_cons_is_valid_desc(q, &descs[nb_entries], pool))) {
+			if (nb_entries) {
+				/* Invalid entry detected. Return what we have. */
+				return nb_entries;
+			}
+			/* Use non-batch version to progress beyond invalid entry/entries */
+			return xskq_cons_read_desc(q, descs, pool) ? 1 : 0;
+		}
+
+		nb_entries++;
+		cached_cons++;
+	}
+
+	return nb_entries;
+}
+
 /* Functions for consumers */
 
 static inline void __xskq_cons_release(struct xsk_queue *q)
@@ -220,17 +247,22 @@ static inline void xskq_cons_get_entries(struct xsk_queue *q)
 	__xskq_cons_peek(q);
 }
 
-static inline bool xskq_cons_has_entries(struct xsk_queue *q, u32 cnt)
+static inline u32 xskq_cons_nb_entries(struct xsk_queue *q, u32 max)
 {
 	u32 entries = q->cached_prod - q->cached_cons;
 
-	if (entries >= cnt)
-		return true;
+	if (entries >= max)
+		return max;
 
 	__xskq_cons_peek(q);
 	entries = q->cached_prod - q->cached_cons;
 
-	return entries >= cnt;
+	return entries >= max ? max : entries;
+}
+
+static inline bool xskq_cons_has_entries(struct xsk_queue *q, u32 cnt)
+{
+	return xskq_cons_nb_entries(q, cnt) >= cnt ? true : false;
 }
 
 static inline bool xskq_cons_peek_addr_unchecked(struct xsk_queue *q, u64 *addr)
@@ -249,16 +281,28 @@ static inline bool xskq_cons_peek_desc(struct xsk_queue *q,
 	return xskq_cons_read_desc(q, desc, pool);
 }
 
+static inline u32 xskq_cons_peek_desc_batch(struct xsk_queue *q, struct xdp_desc *descs,
+					    struct xsk_buff_pool *pool, u32 max)
+{
+	u32 entries = xskq_cons_nb_entries(q, max);
+
+	return xskq_cons_read_desc_batch(q, descs, pool, entries);
+}
+
+/* To improve performance in the xskq_cons_release functions, only update local state here.
+ * Reflect this to global state when we get new entries from the ring in
+ * xskq_cons_get_entries() and whenever Rx or Tx processing are completed in the NAPI loop.
+ */
 static inline void xskq_cons_release(struct xsk_queue *q)
 {
-	/* To improve performance, only update local state here.
-	 * Reflect this to global state when we get new entries
-	 * from the ring in xskq_cons_get_entries() and whenever
-	 * Rx or Tx processing are completed in the NAPI loop.
-	 */
 	q->cached_cons++;
 }
 
+static inline void xskq_cons_release_n(struct xsk_queue *q, u32 cnt)
+{
+	q->cached_cons += cnt;
+}
+
 static inline bool xskq_cons_is_full(struct xsk_queue *q)
 {
 	/* No barriers needed since data is not accessed */
@@ -268,18 +312,23 @@ static inline bool xskq_cons_is_full(struct xsk_queue *q)
 
 /* Functions for producers */
 
-static inline bool xskq_prod_is_full(struct xsk_queue *q)
+static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
 {
 	u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
 
-	if (free_entries)
-		return false;
+	if (free_entries >= max)
+		return max;
 
 	/* Refresh the local tail pointer */
 	q->cached_cons = READ_ONCE(q->ring->consumer);
 	free_entries = q->nentries - (q->cached_prod - q->cached_cons);
 
-	return !free_entries;
+	return free_entries >= max ? max : free_entries;
+}
+
+static inline bool xskq_prod_is_full(struct xsk_queue *q)
+{
+	return xskq_prod_nb_free(q, 1) ? false : true;
 }
 
 static inline int xskq_prod_reserve(struct xsk_queue *q)
@@ -304,6 +353,23 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 	return 0;
 }
 
+static inline u32 xskq_prod_reserve_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
+					       u32 max)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+	u32 nb_entries, i, cached_prod;
+
+	nb_entries = xskq_prod_nb_free(q, max);
+
+	/* A, matches D */
+	cached_prod = q->cached_prod;
+	for (i = 0; i < nb_entries; i++)
+		ring->desc[cached_prod++ & q->ring_mask] = descs[i].addr;
+	q->cached_prod = cached_prod;
+
+	return nb_entries;
+}
+
 static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
 					 u64 addr, u32 len)
 {
-- 
2.7.4

