From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:04 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 01/12] xsk: remove rebind
 support
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Supporting rebind, i.e. after a successful bind the process can call
bind again without closing the socket, makes the setup state machine
more complex. Let us constrain the state space, but not supporting
rebind.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 net/xdp/xsk.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 009c5af5bba5..e59ca8e2618d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -236,14 +236,6 @@ static int xsk_init_queue(u32 entries, struct xsk_queue **queue,
 	return 0;
 }
 
-static void __xsk_release(struct xdp_sock *xs)
-{
-	/* Wait for driver to stop using the xdp socket. */
-	synchronize_net();
-
-	dev_put(xs->dev);
-}
-
 static int xsk_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -260,7 +252,9 @@ static int xsk_release(struct socket *sock)
 	local_bh_enable();
 
 	if (xs->dev) {
-		__xsk_release(xs);
+		/* Wait for driver to stop using the xdp socket. */
+		synchronize_net();
+		dev_put(xs->dev);
 		xs->dev = NULL;
 	}
 
@@ -294,9 +288,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 {
 	struct sockaddr_xdp *sxdp = (struct sockaddr_xdp *)addr;
 	struct sock *sk = sock->sk;
-	struct net_device *dev, *dev_curr;
 	struct xdp_sock *xs = xdp_sk(sk);
-	struct xdp_umem *old_umem = NULL;
+	struct net_device *dev;
 	int err = 0;
 
 	if (addr_len < sizeof(struct sockaddr_xdp))
@@ -305,7 +298,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		return -EINVAL;
 
 	mutex_lock(&xs->mutex);
-	dev_curr = xs->dev;
+	if (xs->dev) {
+		err = -EBUSY;
+		goto out_release;
+	}
+
 	dev = dev_get_by_index(sock_net(sk), sxdp->sxdp_ifindex);
 	if (!dev) {
 		err = -ENODEV;
@@ -352,7 +349,6 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		}
 
 		xdp_get_umem(umem_xs->umem);
-		old_umem = xs->umem;
 		xs->umem = umem_xs->umem;
 		sockfd_put(sock);
 	} else if (!xs->umem || !xdp_umem_validate_queues(xs->umem)) {
@@ -364,14 +360,6 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		xskq_set_umem(xs->umem->cq, &xs->umem->props);
 	}
 
-	/* Rebind? */
-	if (dev_curr && (dev_curr != dev ||
-			 xs->queue_id != sxdp->sxdp_queue_id)) {
-		__xsk_release(xs);
-		if (old_umem)
-			xdp_put_umem(old_umem);
-	}
-
 	xs->dev = dev;
 	xs->queue_id = sxdp->sxdp_queue_id;
 
-- 
2.14.1

