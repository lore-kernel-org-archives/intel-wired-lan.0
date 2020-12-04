From: alardam@gmail.com <alardam@gmail.com>
Date: Fri,  4 Dec 2020 11:28:59 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 3/5] xsk: add usage of xdp
 properties flags
In-Reply-To: <20201204102901.109709-1-marekx.majtyka@intel.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
Message-ID: <20201204102901.109709-4-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Change necessary condition check for XSK from ndo functions to
xdp properties flags.

Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 net/xdp/xsk_buff_pool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 96bb607853ad..7ff82e2b2b43 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -158,8 +158,7 @@ static int __xp_assign_dev(struct xsk_buff_pool *pool,
 		/* For copy-mode, we are done. */
 		return 0;
 
-	if (!netdev->netdev_ops->ndo_bpf ||
-	    !netdev->netdev_ops->ndo_xsk_wakeup) {
+	if ((netdev->xdp_properties & XDP_F_FULL_ZC) != XDP_F_FULL_ZC) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-- 
2.27.0

