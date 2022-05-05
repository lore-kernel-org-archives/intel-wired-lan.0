From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:39 +0300
Subject: [Intel-wired-lan] [PATCH ipsec-next 2/8] xfrm: delete not used
 number of external headers
In-Reply-To: <cover.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
Message-ID: <099569952c609251ea4c156d6c6aed6031abafa7.1651743750.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

num_exthdrs is set but never used, so delete it.

Reviewed-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h     | 1 -
 net/xfrm/xfrm_device.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index b41278abeeaa..4e097423116c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -131,7 +131,6 @@ struct xfrm_state_offload {
 	netdevice_tracker	dev_tracker;
 	struct net_device	*real_dev;
 	unsigned long		offload_handle;
-	unsigned int		num_exthdrs;
 	u8			flags;
 };
 
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 36aa01d92b65..dbd923e1d5f0 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -264,13 +264,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	xso->dev = dev;
 	netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
 	xso->real_dev = dev;
-	xso->num_exthdrs = 1;
 	/* Don't forward bit that is not implemented */
 	xso->flags = xuo->flags & ~XFRM_OFFLOAD_IPV6;
 
 	err = dev->xfrmdev_ops->xdo_dev_state_add(x);
 	if (err) {
-		xso->num_exthdrs = 0;
 		xso->flags = 0;
 		xso->dev = NULL;
 		xso->real_dev = NULL;
-- 
2.35.1

