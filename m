From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:09 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 06/12] xsk: add zero-copy
 support for Rx
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-7-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Extend the xsk_rcv to support the new MEM_TYPE_ZERO_COPY memory, and
wireup ndo_bpf call in bind.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/net/xdp_sock.h |  7 +++++
 net/xdp/xdp_umem.c     | 60 +++++++++++++++++++++++++++++++++++++++++++
 net/xdp/xdp_umem.h     |  3 +++
 net/xdp/xsk.c          | 69 ++++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 125 insertions(+), 14 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 09068c4f068e..644684eb2caf 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -31,6 +31,7 @@ struct xdp_umem_props {
 
 struct xdp_umem_frame {
 	void *addr;
+	dma_addr_t dma;
 };
 
 struct xdp_umem {
@@ -47,6 +48,8 @@ struct xdp_umem {
 	size_t size;
 	atomic_t users;
 	struct work_struct work;
+	struct net_device *dev;
+	u16 queue_id;
 };
 
 struct xdp_sock {
@@ -69,6 +72,10 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 void xsk_flush(struct xdp_sock *xs);
 bool xsk_is_setup_for_bpf_map(struct xdp_sock *xs);
+
+u32 *xsk_umem_peek_id(struct xdp_umem *umem);
+void xsk_umem_discard_id(struct xdp_umem *umem);
+
 #else
 static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index b426cbe3151a..f70cdaa2ef4d 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -26,6 +26,64 @@
 
 #define XDP_UMEM_MIN_FRAME_SIZE 2048
 
+int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
+			u16 queue_id)
+{
+	struct netdev_bpf bpf;
+	int err;
+
+	if (umem->dev) {
+		if (dev != umem->dev || queue_id != umem->queue_id)
+			return -EBUSY;
+		return 0;
+	}
+
+	dev_hold(dev);
+	if (dev->netdev_ops->ndo_bpf) {
+		bpf.command = XDP_SETUP_XSK_UMEM;
+		bpf.xsk.umem = umem;
+		bpf.xsk.queue_id = queue_id;
+
+		rtnl_lock();
+		err = dev->netdev_ops->ndo_bpf(dev, &bpf);
+		rtnl_unlock();
+
+		if (err) {
+			dev_put(dev);
+			return 0;
+		}
+
+		umem->dev = dev;
+		umem->queue_id = queue_id;
+		return 0;
+	}
+
+	dev_put(dev);
+	return 0;
+}
+
+void xdp_umem_clear_dev(struct xdp_umem *umem)
+{
+	struct netdev_bpf bpf;
+	int err;
+
+	if (umem->dev) {
+		bpf.command = XDP_SETUP_XSK_UMEM;
+		bpf.xsk.umem = NULL;
+		bpf.xsk.queue_id = umem->queue_id;
+
+		rtnl_lock();
+		err = umem->dev->netdev_ops->ndo_bpf(umem->dev, &bpf);
+		rtnl_unlock();
+
+		if (err)
+			WARN(1, "failed to disable umem!\n");
+
+		dev_put(umem->dev);
+		umem->dev = NULL;
+	}
+}
+
 int xdp_umem_create(struct xdp_umem **umem)
 {
 	*umem = kzalloc(sizeof(**umem), GFP_KERNEL);
@@ -66,6 +124,8 @@ static void xdp_umem_release(struct xdp_umem *umem)
 	struct task_struct *task;
 	struct mm_struct *mm;
 
+	xdp_umem_clear_dev(umem);
+
 	if (umem->fq) {
 		xskq_destroy(umem->fq);
 		umem->fq = NULL;
diff --git a/net/xdp/xdp_umem.h b/net/xdp/xdp_umem.h
index 0a969384af93..3bb96d156b40 100644
--- a/net/xdp/xdp_umem.h
+++ b/net/xdp/xdp_umem.h
@@ -34,4 +34,7 @@ void xdp_get_umem(struct xdp_umem *umem);
 void xdp_put_umem(struct xdp_umem *umem);
 int xdp_umem_create(struct xdp_umem **umem);
 
+int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
+			u16 queue_id);
+
 #endif /* XDP_UMEM_H_ */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e59ca8e2618d..a0cf9c042ed2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -43,6 +43,18 @@ static struct xdp_sock *xdp_sk(struct sock *sk)
 	return (struct xdp_sock *)sk;
 }
 
+u32 *xsk_umem_peek_id(struct xdp_umem *umem)
+{
+	return xskq_peek_id(umem->fq);
+}
+EXPORT_SYMBOL(xsk_umem_peek_id);
+
+void xsk_umem_discard_id(struct xdp_umem *umem)
+{
+	xskq_discard_id(umem->fq);
+}
+EXPORT_SYMBOL(xsk_umem_discard_id);
+
 bool xsk_is_setup_for_bpf_map(struct xdp_sock *xs)
 {
 	return !!xs->rx;
@@ -50,40 +62,54 @@ bool xsk_is_setup_for_bpf_map(struct xdp_sock *xs)
 
 static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	u32 *id, len = xdp->data_end - xdp->data;
+	u32 *id, len;
 	void *buffer;
 	int err = 0;
 
-	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
-		return -EINVAL;
-
 	id = xskq_peek_id(xs->umem->fq);
 	if (!id)
 		return -ENOSPC;
 
 	buffer = xdp_umem_get_data_with_headroom(xs->umem, *id);
+	len = xdp->data_end - xdp->data;
 	memcpy(buffer, xdp->data, len);
 	err = xskq_produce_batch_desc(xs->rx, *id, len,
 				      xs->umem->frame_headroom);
-	if (!err)
+	if (!err) {
 		xskq_discard_id(xs->umem->fq);
+		xdp_return_buff(xdp);
+		return 0;
+	}
 
+	xs->rx_dropped++;
 	return err;
 }
 
-int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
+static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
+	u16 off = xdp->data - xdp->data_hard_start;
+	u32 len = xdp->data_end - xdp->data;
 	int err;
 
-	err = __xsk_rcv(xs, xdp);
-	if (likely(!err))
+	err = xskq_produce_batch_desc(xs->rx, (u32)xdp->handle, len,
+				      xs->umem->frame_headroom + off);
+	if (err) {
 		xdp_return_buff(xdp);
-	else
 		xs->rx_dropped++;
+	}
 
 	return err;
 }
 
+int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
+{
+	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
+		return -EINVAL;
+
+	return (xdp->rxq->mem.type == MEM_TYPE_ZERO_COPY) ?
+		__xsk_rcv_zc(xs, xdp) : __xsk_rcv(xs, xdp);
+}
+
 void xsk_flush(struct xdp_sock *xs)
 {
 	xskq_produce_flush_desc(xs->rx);
@@ -92,14 +118,26 @@ void xsk_flush(struct xdp_sock *xs)
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	int err;
+	u32 *id, len;
+	void *buffer;
+	int err = 0;
 
-	err = __xsk_rcv(xs, xdp);
-	if (!err)
+	id = xskq_peek_id(xs->umem->fq);
+	if (!id)
+		return -ENOSPC;
+
+	buffer = xdp_umem_get_data_with_headroom(xs->umem, *id);
+	len = xdp->data_end - xdp->data;
+	memcpy(buffer, xdp->data, len);
+	err = xskq_produce_batch_desc(xs->rx, *id, len,
+				      xs->umem->frame_headroom);
+	if (!err) {
+		xskq_discard_id(xs->umem->fq);
 		xsk_flush(xs);
-	else
-		xs->rx_dropped++;
+		return 0;
+	}
 
+	xs->rx_dropped++;
 	return err;
 }
 
@@ -362,6 +400,9 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 
 	xs->dev = dev;
 	xs->queue_id = sxdp->sxdp_queue_id;
+	err = xdp_umem_assign_dev(xs->umem, dev, xs->queue_id);
+	if (err)
+		goto out_unlock;
 
 	xskq_set_umem(xs->rx, &xs->umem->props);
 	xskq_set_umem(xs->tx, &xs->umem->props);
-- 
2.14.1

