From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:56 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 16/21] net: ethernet: ti: Move
 devlink registration to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <080c8889f80e48971dd9a1dadb4107882d83998d.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

This change prevents from users to access device before devlink is
fully configured.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 15 ++++++---------
 drivers/net/ethernet/ti/cpsw_new.c       |  7 ++-----
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index c2ea53ca92b6..0de5f4a4fe08 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2429,7 +2429,6 @@ static int am65_cpsw_nuss_register_devlink(struct am65_cpsw_common *common)
 	dl_priv = devlink_priv(common->devlink);
 	dl_priv->common = common;
 
-	devlink_register(common->devlink);
 	/* Provide devlink hook to switch mode when multiple external ports
 	 * are present NUSS switchdev driver is enabled.
 	 */
@@ -2442,7 +2441,6 @@ static int am65_cpsw_nuss_register_devlink(struct am65_cpsw_common *common)
 			dev_err(dev, "devlink params reg fail ret:%d\n", ret);
 			goto dl_unreg;
 		}
-		devlink_params_publish(common->devlink);
 	}
 
 	for (i = 1; i <= common->port_num; i++) {
@@ -2463,7 +2461,7 @@ static int am65_cpsw_nuss_register_devlink(struct am65_cpsw_common *common)
 		}
 		devlink_port_type_eth_set(dl_port, port->ndev);
 	}
-
+	devlink_register(common->devlink);
 	return ret;
 
 dl_port_unreg:
@@ -2474,7 +2472,6 @@ static int am65_cpsw_nuss_register_devlink(struct am65_cpsw_common *common)
 		devlink_port_unregister(dl_port);
 	}
 dl_unreg:
-	devlink_unregister(common->devlink);
 	devlink_free(common->devlink);
 	return ret;
 }
@@ -2485,6 +2482,8 @@ static void am65_cpsw_unregister_devlink(struct am65_cpsw_common *common)
 	struct am65_cpsw_port *port;
 	int i;
 
+	devlink_unregister(common->devlink);
+
 	for (i = 1; i <= common->port_num; i++) {
 		port = am65_common_get_port(common, i);
 		dl_port = &port->devlink_port;
@@ -2493,13 +2492,11 @@ static void am65_cpsw_unregister_devlink(struct am65_cpsw_common *common)
 	}
 
 	if (!AM65_CPSW_IS_CPSW2G(common) &&
-	    IS_ENABLED(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV)) {
-		devlink_params_unpublish(common->devlink);
-		devlink_params_unregister(common->devlink, am65_cpsw_devlink_params,
+	    IS_ENABLED(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV))
+		devlink_params_unregister(common->devlink,
+					  am65_cpsw_devlink_params,
 					  ARRAY_SIZE(am65_cpsw_devlink_params));
-	}
 
-	devlink_unregister(common->devlink);
 	devlink_free(common->devlink);
 }
 
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 204b4826303c..1530532748a8 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1810,7 +1810,6 @@ static int cpsw_register_devlink(struct cpsw_common *cpsw)
 	dl_priv = devlink_priv(cpsw->devlink);
 	dl_priv->cpsw = cpsw;
 
-	devlink_register(cpsw->devlink);
 	ret = devlink_params_register(cpsw->devlink, cpsw_devlink_params,
 				      ARRAY_SIZE(cpsw_devlink_params));
 	if (ret) {
@@ -1818,21 +1817,19 @@ static int cpsw_register_devlink(struct cpsw_common *cpsw)
 		goto dl_unreg;
 	}
 
-	devlink_params_publish(cpsw->devlink);
+	devlink_register(cpsw->devlink);
 	return ret;
 
 dl_unreg:
-	devlink_unregister(cpsw->devlink);
 	devlink_free(cpsw->devlink);
 	return ret;
 }
 
 static void cpsw_unregister_devlink(struct cpsw_common *cpsw)
 {
-	devlink_params_unpublish(cpsw->devlink);
+	devlink_unregister(cpsw->devlink);
 	devlink_params_unregister(cpsw->devlink, cpsw_devlink_params,
 				  ARRAY_SIZE(cpsw_devlink_params));
-	devlink_unregister(cpsw->devlink);
 	devlink_free(cpsw->devlink);
 }
 
-- 
2.31.1

