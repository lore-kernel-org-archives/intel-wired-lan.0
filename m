From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:45 +0300
Subject: [Intel-wired-lan] [PATCH ipsec-next 8/8] xfrm: drop not needed
 flags variable in XFRM offload struct
In-Reply-To: <cover.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
Message-ID: <b0c39ee6e266ee021b810259fd73f5701fa929d1.1651743750.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

After drivers were converted to rely on direction, the flags is not
used anymore and can be removed.

Reviewed-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h     | 1 -
 net/xfrm/xfrm_device.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 45422f7be0c5..736c349de8bf 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -136,7 +136,6 @@ struct xfrm_dev_offload {
 	netdevice_tracker	dev_tracker;
 	struct net_device	*real_dev;
 	unsigned long		offload_handle;
-	u8			flags;
 	u8			dir : 2;
 };
 
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index c818afca9137..35c7e89b2e7d 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -264,8 +264,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	xso->dev = dev;
 	netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
 	xso->real_dev = dev;
-	/* Don't forward bit that is not implemented */
-	xso->flags = xuo->flags & ~XFRM_OFFLOAD_IPV6;
 
 	if (xuo->flags & XFRM_OFFLOAD_INBOUND)
 		xso->dir = XFRM_DEV_OFFLOAD_IN;
@@ -274,7 +272,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	err = dev->xfrmdev_ops->xdo_dev_state_add(x);
 	if (err) {
-		xso->flags = 0;
 		xso->dev = NULL;
 		xso->dir = 0;
 		xso->real_dev = NULL;
-- 
2.35.1

