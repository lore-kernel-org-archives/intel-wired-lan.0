From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:42 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 02/21] bnxt_en: Register
 devlink instance at the end devlink configuration
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <54d36bce5a78cdb4d51a9eaff6f2216fbbdd1004.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Move devlink_register() to be last command in devlink configuration
sequence, so no user space access will be possible till devlink instance
is fully operable. As part of this change, the devlink_params_publish
call is removed as not needed.

This change fixes forgotten devlink_params_unpublish() too.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index ed95e28d60ef..951c0c00cc95 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -745,14 +745,10 @@ static int bnxt_dl_params_register(struct bnxt *bp)
 
 	rc = devlink_params_register(bp->dl, bnxt_dl_params,
 				     ARRAY_SIZE(bnxt_dl_params));
-	if (rc) {
+	if (rc)
 		netdev_warn(bp->dev, "devlink_params_register failed. rc=%d\n",
 			    rc);
-		return rc;
-	}
-	devlink_params_publish(bp->dl);
-
-	return 0;
+	return rc;
 }
 
 static void bnxt_dl_params_unregister(struct bnxt *bp)
@@ -792,9 +788,8 @@ int bnxt_dl_register(struct bnxt *bp)
 	    bp->hwrm_spec_code > 0x10803)
 		bp->eswitch_mode = DEVLINK_ESWITCH_MODE_LEGACY;
 
-	devlink_register(dl);
 	if (!BNXT_PF(bp))
-		return 0;
+		goto out;
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = bp->pf.port_id;
@@ -811,6 +806,8 @@ int bnxt_dl_register(struct bnxt *bp)
 	if (rc)
 		goto err_dl_port_unreg;
 
+out:
+	devlink_register(dl);
 	return 0;
 
 err_dl_port_unreg:
@@ -824,10 +821,10 @@ void bnxt_dl_unregister(struct bnxt *bp)
 {
 	struct devlink *dl = bp->dl;
 
+	devlink_unregister(dl);
 	if (BNXT_PF(bp)) {
 		bnxt_dl_params_unregister(bp);
 		devlink_port_unregister(&bp->dl_port);
 	}
-	devlink_unregister(dl);
 	devlink_free(dl);
 }
-- 
2.31.1

