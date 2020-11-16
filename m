From: alardam@gmail.com <alardam@gmail.com>
Date: Mon, 16 Nov 2020 10:34:47 +0100
Subject: [Intel-wired-lan] [PATCH 3/8] xsk: add usage of xdp netdev_features
 flags
In-Reply-To: <20201116093452.7541-1-marekx.majtyka@intel.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
Message-ID: <20201116093452.7541-4-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Change necessary condition check for XSK from ndo functions to
netdev_features flags.

Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 net/xdp/xsk_buff_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 8a3bf4e1318e..76922696ad3c 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -159,8 +159,8 @@ static int __xp_assign_dev(struct xsk_buff_pool *pool,
 		/* For copy-mode, we are done. */
 		return 0;
 
-	if (!netdev->netdev_ops->ndo_bpf ||
-	    !netdev->netdev_ops->ndo_xsk_wakeup) {
+	if (!(NETIF_F_XDP & netdev->features &&
+	      NETIF_F_AF_XDP_ZC & netdev->features)) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-- 
2.20.1

