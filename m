From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  5 Nov 2020 11:28:07 +0100
Subject: [Intel-wired-lan] [RFC PATCH bpf-next v2 4/9] xsk: check need
 wakeup flag in sendmsg()
In-Reply-To: <20201105102812.152836-1-bjorn.topel@gmail.com>
References: <20201105102812.152836-1-bjorn.topel@gmail.com>
Message-ID: <20201105102812.152836-5-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Add a check for need wake up in sendmsg(), so that if a user calls
sendmsg() when no wakeup is needed, do not trigger a wakeup.

To simplify the need wakeup check in the syscall, unconditionally
enable the need wakeup flag for Tx. This has a side-effect for poll();
If poll() is called for a socket without enabled need wakeup, a Tx
wakeup is unconditionally performed.

The wakeup matrix for AF_XDP now looks like:

need wakeup | poll()       | sendmsg()   | recvmsg()
------------+--------------+-------------+------------
disabled    | wake Tx      | wake Tx     | nop
enabled     | check flag;  | check flag; | check flag;
            |   wake Tx/Rx |   wake Tx   |   wake Rx

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 net/xdp/xsk.c           |  6 +++++-
 net/xdp/xsk_buff_pool.c | 13 ++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 17d51d1a5752..2e5b9f27c7a3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -465,13 +465,17 @@ static int xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 	bool need_wait = !(m->msg_flags & MSG_DONTWAIT);
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
+	struct xsk_buff_pool *pool;
 
 	if (unlikely(!xsk_is_bound(xs)))
 		return -ENXIO;
 	if (unlikely(need_wait))
 		return -EOPNOTSUPP;
 
-	return __xsk_sendmsg(sk);
+	pool = xs->pool;
+	if (pool->cached_need_wakeup & XDP_WAKEUP_TX)
+		return __xsk_sendmsg(sk);
+	return 0;
 }
 
 static int xsk_recvmsg(struct socket *sock, struct msghdr *m, size_t len, int flags)
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 64c9e55d4d4e..a4acb5e9576f 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -144,14 +144,13 @@ static int __xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		return err;
 
-	if (flags & XDP_USE_NEED_WAKEUP) {
+	if (flags & XDP_USE_NEED_WAKEUP)
 		pool->uses_need_wakeup = true;
-		/* Tx needs to be explicitly woken up the first time.
-		 * Also for supporting drivers that do not implement this
-		 * feature. They will always have to call sendto().
-		 */
-		pool->cached_need_wakeup = XDP_WAKEUP_TX;
-	}
+	/* Tx needs to be explicitly woken up the first time.  Also
+	 * for supporting drivers that do not implement this
+	 * feature. They will always have to call sendto() or poll().
+	 */
+	pool->cached_need_wakeup = XDP_WAKEUP_TX;
 
 	dev_hold(netdev);
 
-- 
2.27.0

