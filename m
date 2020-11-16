From: alardam@gmail.com <alardam@gmail.com>
Date: Mon, 16 Nov 2020 10:34:48 +0100
Subject: [Intel-wired-lan] [PATCH 4/8] xsk: add check for full support of
 XDP in bind
In-Reply-To: <20201116093452.7541-1-marekx.majtyka@intel.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
Message-ID: <20201116093452.7541-5-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Add check for full support of XDP in AF_XDP socket bind.

To be able to use an AF_XDP socket with zero-copy, there needs to be
support for both XDP_REDIRECT in the driver (XDP native mode) and the
driver needs to support zero-copy. The problem is that there are
drivers out there that only support XDP partially, so it is possible
to successfully load the XDP program in native mode, but it will still
not be able to support zero-copy as it does not have XDP_REDIRECT
support. We can now alleviate this problem by using the new XDP netdev
capability that signifies if full XDP support is indeed present. This
check can be triggered by a new bind flag called
XDP_CHECK_NATIVE_MODE.

To simplify usage, this check is triggered automatically from inside
libbpf library via turning on the new XDP_CHECK_NATIVE_MODE flag if and
only if the driver mode is selected for the socket. As a result, the
xsk_bind function decides if the native mode for a given interface makes
sense or not using xdp netdev feature flags. Eventually the xsk socket is
bound or an error is returned. Apart from this change and to catch all
invalid inputs in a single place, an additional check is set to forbid
sbk mode and zero copy settings at the same time as that combination makes
no sense.

Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 include/uapi/linux/if_xdp.h       |  1 +
 net/xdp/xsk.c                     |  4 ++--
 net/xdp/xsk_buff_pool.c           | 17 ++++++++++++++++-
 tools/include/uapi/linux/if_xdp.h |  1 +
 tools/lib/bpf/xsk.c               |  3 +++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index a78a8096f4ce..8f47754dacce 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -25,6 +25,7 @@
  * application.
  */
 #define XDP_USE_NEED_WAKEUP (1 << 3)
+#define XDP_CHECK_NATIVE_MODE (1 << 4)
 
 /* Flags for xsk_umem_config flags */
 #define XDP_UMEM_UNALIGNED_CHUNK_FLAG (1 << 0)
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index cfbec3989a76..a9c386083377 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -658,7 +658,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 
 	flags = sxdp->sxdp_flags;
 	if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY |
-		      XDP_USE_NEED_WAKEUP))
+		      XDP_USE_NEED_WAKEUP | XDP_CHECK_NATIVE_MODE))
 		return -EINVAL;
 
 	rtnl_lock();
@@ -686,7 +686,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		struct socket *sock;
 
 		if ((flags & XDP_COPY) || (flags & XDP_ZEROCOPY) ||
-		    (flags & XDP_USE_NEED_WAKEUP)) {
+		    (flags & XDP_USE_NEED_WAKEUP) || (flags & XDP_CHECK_NATIVE_MODE)) {
 			/* Cannot specify flags for shared sockets. */
 			err = -EINVAL;
 			goto out_unlock;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 76922696ad3c..231d88ddd978 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -123,7 +123,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 static int __xp_assign_dev(struct xsk_buff_pool *pool,
 			   struct net_device *netdev, u16 queue_id, u16 flags)
 {
-	bool force_zc, force_copy;
+	bool force_zc, force_copy, force_check;
 	struct netdev_bpf bpf;
 	int err = 0;
 
@@ -131,10 +131,24 @@ static int __xp_assign_dev(struct xsk_buff_pool *pool,
 
 	force_zc = flags & XDP_ZEROCOPY;
 	force_copy = flags & XDP_COPY;
+	force_check = flags & XDP_CHECK_NATIVE_MODE;
+
 
 	if (force_zc && force_copy)
 		return -EINVAL;
 
+	if (!(flags & XDP_SHARED_UMEM)) {
+		if (force_check) {
+			/* forbid driver mode without full XDP support */
+			if (!(NETIF_F_XDP & netdev->features))
+				return -EOPNOTSUPP;
+		} else {
+			/* forbid skb mode and zero copy */
+			if (force_zc)
+				return -EINVAL;
+		}
+	}
+
 	if (xsk_get_pool_from_qid(netdev, queue_id))
 		return -EBUSY;
 
@@ -206,6 +220,7 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_umem *umem,
 		return -EINVAL;
 
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
+	flags |= XDP_SHARED_UMEM;
 	if (pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
 
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index a78a8096f4ce..8f47754dacce 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -25,6 +25,7 @@
  * application.
  */
 #define XDP_USE_NEED_WAKEUP (1 << 3)
+#define XDP_CHECK_NATIVE_MODE (1 << 4)
 
 /* Flags for xsk_umem_config flags */
 #define XDP_UMEM_UNALIGNED_CHUNK_FLAG (1 << 0)
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 9bc537d0b92d..7951f7ea6db3 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -18,6 +18,7 @@
 #include <linux/ethtool.h>
 #include <linux/filter.h>
 #include <linux/if_ether.h>
+#include <linux/if_link.h>
 #include <linux/if_packet.h>
 #include <linux/if_xdp.h>
 #include <linux/kernel.h>
@@ -827,6 +828,8 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 		sxdp.sxdp_shared_umem_fd = umem->fd;
 	} else {
 		sxdp.sxdp_flags = xsk->config.bind_flags;
+		if (xsk->config.xdp_flags & XDP_FLAGS_DRV_MODE)
+			sxdp.sxdp_flags |= XDP_CHECK_NATIVE_MODE;
 	}
 
 	err = bind(xsk->fd, (struct sockaddr *)&sxdp, sizeof(sxdp));
-- 
2.20.1

