From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 23 Sep 2021 21:12:49 +0300
Subject: [Intel-wired-lan] [PATCH net-next 2/6] bnxt_en: Properly remove
 port parameter support
In-Reply-To: <cover.1632420430.git.leonro@nvidia.com>
References: <cover.1632420430.git.leonro@nvidia.com>
Message-ID: <7b85ce0d2a5056af2c7e14dbd16c55d86aac659c.1632420431.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

This driver doesn't have any port parameters and registers
devlink port parameters with empty table. Remove the useless
calls to devlink_port_params_register and _unregister.

Fixes: da203dfa89ce ("Revert "devlink: Add a generic wake_on_lan port parameter"")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index dc0851f709f5..ed95e28d60ef 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -736,9 +736,6 @@ static const struct devlink_param bnxt_dl_params[] = {
 			     NULL),
 };
 
-static const struct devlink_param bnxt_dl_port_params[] = {
-};
-
 static int bnxt_dl_params_register(struct bnxt *bp)
 {
 	int rc;
@@ -753,14 +750,6 @@ static int bnxt_dl_params_register(struct bnxt *bp)
 			    rc);
 		return rc;
 	}
-	rc = devlink_port_params_register(&bp->dl_port, bnxt_dl_port_params,
-					  ARRAY_SIZE(bnxt_dl_port_params));
-	if (rc) {
-		netdev_err(bp->dev, "devlink_port_params_register failed\n");
-		devlink_params_unregister(bp->dl, bnxt_dl_params,
-					  ARRAY_SIZE(bnxt_dl_params));
-		return rc;
-	}
 	devlink_params_publish(bp->dl);
 
 	return 0;
@@ -773,8 +762,6 @@ static void bnxt_dl_params_unregister(struct bnxt *bp)
 
 	devlink_params_unregister(bp->dl, bnxt_dl_params,
 				  ARRAY_SIZE(bnxt_dl_params));
-	devlink_port_params_unregister(&bp->dl_port, bnxt_dl_port_params,
-				       ARRAY_SIZE(bnxt_dl_port_params));
 }
 
 int bnxt_dl_register(struct bnxt *bp)
-- 
2.31.1

