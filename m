From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri,  4 Sep 2020 15:53:27 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 2/6] xdp: introduce
 xdp_do_redirect_ext() function
In-Reply-To: <20200904135332.60259-1-bjorn.topel@gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
Message-ID: <20200904135332.60259-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Introduce the xdp_do_redirect_ext() which returns additional
information to the caller. For now, it is the type of map that the
packet was redirected to.

This enables the driver to have more fine-grained control, e.g. is the
redirect fails due to full AF_XDP Rx queue (error code ENOBUFS and map
is XSKMAP), a zero-copy enabled driver should yield to userland as
soon as possible.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/linux/filter.h |  2 ++
 net/core/filter.c      | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 995625950cc1..0060c2c8abc3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -942,6 +942,8 @@ static inline int xdp_ok_fwd_dev(const struct net_device *fwd,
  */
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 			    struct xdp_buff *xdp, struct bpf_prog *prog);
+int xdp_do_redirect_ext(struct net_device *dev, struct xdp_buff *xdp,
+			struct bpf_prog *xdp_prog, enum bpf_map_type *map_type);
 int xdp_do_redirect(struct net_device *dev,
 		    struct xdp_buff *xdp,
 		    struct bpf_prog *prog);
diff --git a/net/core/filter.c b/net/core/filter.c
index 47eef9a0be6a..ce6098210a23 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3596,8 +3596,8 @@ void bpf_clear_redirect_map(struct bpf_map *map)
 	}
 }
 
-int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
-		    struct bpf_prog *xdp_prog)
+int xdp_do_redirect_ext(struct net_device *dev, struct xdp_buff *xdp,
+			struct bpf_prog *xdp_prog, enum bpf_map_type *map_type)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	struct bpf_map *map = READ_ONCE(ri->map);
@@ -3609,6 +3609,8 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 	ri->tgt_value = NULL;
 	WRITE_ONCE(ri->map, NULL);
 
+	*map_type = BPF_MAP_TYPE_UNSPEC;
+
 	if (unlikely(!map)) {
 		fwd = dev_get_by_index_rcu(dev_net(dev), index);
 		if (unlikely(!fwd)) {
@@ -3618,6 +3620,7 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 
 		err = dev_xdp_enqueue(fwd, xdp, dev);
 	} else {
+		*map_type = map->map_type;
 		err = __bpf_tx_xdp_map(dev, fwd, map, xdp);
 	}
 
@@ -3630,6 +3633,15 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map, index, err);
 	return err;
 }
+EXPORT_SYMBOL_GPL(xdp_do_redirect_ext);
+
+int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
+		    struct bpf_prog *xdp_prog)
+{
+	enum bpf_map_type dummy;
+
+	return xdp_do_redirect_ext(dev, xdp, xdp_prog, &dummy);
+}
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
 static int xdp_do_generic_redirect_map(struct net_device *dev,
-- 
2.25.1

