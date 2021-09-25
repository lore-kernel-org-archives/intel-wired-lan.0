From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:57 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 17/21] netdevsim: Move devlink
 registration to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <87822c7b4f20182c37758a2c0b9bb84a0a3edaf8.1632565508.git.leonro@nvidia.com>
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
 drivers/net/netdevsim/dev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index b2214bc9efe2..cb6645012a30 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1470,7 +1470,6 @@ int nsim_dev_probe(struct nsim_bus_dev *nsim_bus_dev)
 	if (err)
 		goto err_devlink_free;
 
-	devlink_register(devlink);
 	err = devlink_params_register(devlink, nsim_devlink_params,
 				      ARRAY_SIZE(nsim_devlink_params));
 	if (err)
@@ -1511,9 +1510,9 @@ int nsim_dev_probe(struct nsim_bus_dev *nsim_bus_dev)
 	if (err)
 		goto err_psample_exit;
 
-	devlink_params_publish(devlink);
-	devlink_reload_enable(devlink);
 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
+	devlink_register(devlink);
+	devlink_reload_enable(devlink);
 	return 0;
 
 err_psample_exit:
@@ -1534,7 +1533,6 @@ int nsim_dev_probe(struct nsim_bus_dev *nsim_bus_dev)
 	devlink_params_unregister(devlink, nsim_devlink_params,
 				  ARRAY_SIZE(nsim_devlink_params));
 err_dl_unregister:
-	devlink_unregister(devlink);
 	devlink_resources_unregister(devlink, NULL);
 err_devlink_free:
 	devlink_free(devlink);
@@ -1569,6 +1567,7 @@ void nsim_dev_remove(struct nsim_bus_dev *nsim_bus_dev)
 	struct devlink *devlink = priv_to_devlink(nsim_dev);
 
 	devlink_reload_disable(devlink);
+	devlink_unregister(devlink);
 
 	nsim_dev_reload_destroy(nsim_dev);
 
@@ -1576,7 +1575,6 @@ void nsim_dev_remove(struct nsim_bus_dev *nsim_bus_dev)
 	nsim_dev_debugfs_exit(nsim_dev);
 	devlink_params_unregister(devlink, nsim_devlink_params,
 				  ARRAY_SIZE(nsim_devlink_params));
-	devlink_unregister(devlink);
 	devlink_resources_unregister(devlink, NULL);
 	devlink_free(devlink);
 }
-- 
2.31.1

