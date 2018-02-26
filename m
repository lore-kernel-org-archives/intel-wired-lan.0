From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 26 Feb 2018 10:15:45 -0800
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbe: remove unneeded ipsec state
 free callback
In-Reply-To: <20180226181545.11151-1-jeffrey.t.kirsher@intel.com>
References: <20180226181545.11151-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180226181545.11151-3-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@oracle.com>

With commit 7f05b467a735 ("xfrm: check for xdo_dev_state_free")
we no longer need to add an empty callback function
to the driver, so now let's remove the useless code.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 8623013e517e..f2254528dcfc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -724,23 +724,10 @@ static bool ixgbe_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return true;
 }
 
-/**
- * ixgbe_ipsec_free - called by xfrm garbage collections
- * @xs: pointer to transformer state struct
- *
- * We don't have any garbage to collect, so we shouldn't bother
- * implementing this function, but the XFRM code doesn't check for
- * existence before calling the API callback.
- **/
-static void ixgbe_ipsec_free(struct xfrm_state *xs)
-{
-}
-
 static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
 	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
 	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
 	.xdo_dev_offload_ok = ixgbe_ipsec_offload_ok,
-	.xdo_dev_state_free = ixgbe_ipsec_free,
 };
 
 /**
-- 
2.14.3

