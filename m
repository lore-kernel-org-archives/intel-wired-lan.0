From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri,  4 Sep 2020 15:53:26 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 1/6] xsk: improve
 xdp_do_redirect() error codes
In-Reply-To: <20200904135332.60259-1-bjorn.topel@gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
Message-ID: <20200904135332.60259-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The error codes returned by xdp_do_redirect() when redirecting a frame
to an AF_XDP socket has not been very useful. A driver could not
distinguish between different errors. Prior this change the following
codes where used:

Socket not bound or incorrect queue/netdev: EINVAL
XDP frame/AF_XDP buffer size mismatch: ENOSPC
Could not allocate buffer (copy mode): ENOSPC
AF_XDP Rx buffer full: ENOSPC

After this change:

Socket not bound or incorrect queue/netdev: EINVAL
XDP frame/AF_XDP buffer size mismatch: ENOSPC
Could not allocate buffer (copy mode): ENOMEM
AF_XDP Rx buffer full: ENOBUFS

An AF_XDP zero-copy driver can now potentially determine if the
failure was due to a full Rx buffer, and if so stop processing more
frames, yielding to the userland AF_XDP application.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 net/xdp/xsk.c       | 2 +-
 net/xdp/xsk_queue.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3895697f8540..db38560c4af7 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -197,7 +197,7 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len,
 	xsk_xdp = xsk_buff_alloc(xs->pool);
 	if (!xsk_xdp) {
 		xs->rx_dropped++;
-		return -ENOSPC;
+		return -ENOMEM;
 	}
 
 	xsk_copy_xdp(xsk_xdp, xdp, len);
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 2d883f631c85..b76966cf122e 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -305,7 +305,7 @@ static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
 	u32 idx;
 
 	if (xskq_prod_is_full(q))
-		return -ENOSPC;
+		return -ENOBUFS;
 
 	/* A, matches D */
 	idx = q->cached_prod++ & q->ring_mask;
-- 
2.25.1

