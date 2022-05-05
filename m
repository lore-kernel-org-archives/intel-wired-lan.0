From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:40 +0300
Subject: [Intel-wired-lan] [PATCH ipsec-next 3/8] xfrm: rename
 xfrm_state_offload struct to allow reuse
In-Reply-To: <cover.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
Message-ID: <2a59f8a4bfa849da0b3a9931bc2f687a6efdb74b.1651743750.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

The struct xfrm_state_offload has all fields needed to hold information
for offloaded policies too. In order to do not create new struct with
same fields, let's rename existing one and reuse it later.

Reviewed-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h     | 10 +++++-----
 net/xfrm/xfrm_device.c |  2 +-
 net/xfrm/xfrm_state.c  |  4 ++--
 net/xfrm/xfrm_user.c   |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 4e097423116c..bb20278d689c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -126,7 +126,7 @@ struct xfrm_state_walk {
 	struct xfrm_address_filter *filter;
 };
 
-struct xfrm_state_offload {
+struct xfrm_dev_offload {
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
 	struct net_device	*real_dev;
@@ -246,7 +246,7 @@ struct xfrm_state {
 	struct xfrm_lifetime_cur curlft;
 	struct hrtimer		mtimer;
 
-	struct xfrm_state_offload xso;
+	struct xfrm_dev_offload xso;
 
 	/* used to fix curlft->add_time when changing date */
 	long		saved_tmo;
@@ -1865,7 +1865,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x);
 
 static inline void xfrm_dev_state_advance_esn(struct xfrm_state *x)
 {
-	struct xfrm_state_offload *xso = &x->xso;
+	struct xfrm_dev_offload *xso = &x->xso;
 
 	if (xso->dev && xso->dev->xfrmdev_ops->xdo_dev_state_advance_esn)
 		xso->dev->xfrmdev_ops->xdo_dev_state_advance_esn(x);
@@ -1891,7 +1891,7 @@ static inline bool xfrm_dst_offload_ok(struct dst_entry *dst)
 
 static inline void xfrm_dev_state_delete(struct xfrm_state *x)
 {
-	struct xfrm_state_offload *xso = &x->xso;
+	struct xfrm_dev_offload *xso = &x->xso;
 
 	if (xso->dev)
 		xso->dev->xfrmdev_ops->xdo_dev_state_delete(x);
@@ -1899,7 +1899,7 @@ static inline void xfrm_dev_state_delete(struct xfrm_state *x)
 
 static inline void xfrm_dev_state_free(struct xfrm_state *x)
 {
-	struct xfrm_state_offload *xso = &x->xso;
+	struct xfrm_dev_offload *xso = &x->xso;
 	struct net_device *dev = xso->dev;
 
 	if (dev && dev->xfrmdev_ops) {
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index dbd923e1d5f0..6e4d3cb2e24d 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -212,7 +212,7 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	int err;
 	struct dst_entry *dst;
 	struct net_device *dev;
-	struct xfrm_state_offload *xso = &x->xso;
+	struct xfrm_dev_offload *xso = &x->xso;
 	xfrm_address_t *saddr;
 	xfrm_address_t *daddr;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index b749935152ba..08564e0eef20 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -751,7 +751,7 @@ xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool
 
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
-		struct xfrm_state_offload *xso;
+		struct xfrm_dev_offload *xso;
 
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			xso = &x->xso;
@@ -835,7 +835,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
-		struct xfrm_state_offload *xso;
+		struct xfrm_dev_offload *xso;
 restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			xso = &x->xso;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 64fa8fdd6bbd..7217c57a76e9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -840,7 +840,7 @@ static int copy_sec_ctx(struct xfrm_sec_ctx *s, struct sk_buff *skb)
 	return 0;
 }
 
-static int copy_user_offload(struct xfrm_state_offload *xso, struct sk_buff *skb)
+static int copy_user_offload(struct xfrm_dev_offload *xso, struct sk_buff *skb)
 {
 	struct xfrm_user_offload *xuo;
 	struct nlattr *attr;
-- 
2.35.1

