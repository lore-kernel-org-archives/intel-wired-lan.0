From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:51 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 11/21] mlxsw: core: Register
 devlink instance last
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <ca198a30949abb3bdf283ff87e6e718be355d0cf.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Make sure that devlink is open to receive user input when all
parameters are initialized.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 9a570fa167b6..9e831e8b607a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1973,9 +1973,6 @@ __mlxsw_core_bus_device_register(const struct mlxsw_bus_info *mlxsw_bus_info,
 	if (err)
 		goto err_emad_init;
 
-	if (!reload)
-		devlink_register(devlink);
-
 	if (!reload) {
 		err = mlxsw_core_params_register(mlxsw_core);
 		if (err)
@@ -2010,10 +2007,10 @@ __mlxsw_core_bus_device_register(const struct mlxsw_bus_info *mlxsw_bus_info,
 			goto err_driver_init;
 	}
 
-	devlink_params_publish(devlink);
-
-	if (!reload)
+	if (!reload) {
+		devlink_register(devlink);
 		devlink_reload_enable(devlink);
+	}
 
 	return 0;
 
@@ -2030,8 +2027,6 @@ __mlxsw_core_bus_device_register(const struct mlxsw_bus_info *mlxsw_bus_info,
 	if (!reload)
 		mlxsw_core_params_unregister(mlxsw_core);
 err_register_params:
-	if (!reload)
-		devlink_unregister(devlink);
 	mlxsw_emad_fini(mlxsw_core);
 err_emad_init:
 	kfree(mlxsw_core->lag.mapping);
@@ -2080,8 +2075,10 @@ void mlxsw_core_bus_device_unregister(struct mlxsw_core *mlxsw_core,
 {
 	struct devlink *devlink = priv_to_devlink(mlxsw_core);
 
-	if (!reload)
+	if (!reload) {
 		devlink_reload_disable(devlink);
+		devlink_unregister(devlink);
+	}
 	if (devlink_is_reload_failed(devlink)) {
 		if (!reload)
 			/* Only the parts that were not de-initialized in the
@@ -2092,7 +2089,6 @@ void mlxsw_core_bus_device_unregister(struct mlxsw_core *mlxsw_core,
 			return;
 	}
 
-	devlink_params_unpublish(devlink);
 	if (mlxsw_core->driver->fini)
 		mlxsw_core->driver->fini(mlxsw_core);
 	mlxsw_env_fini(mlxsw_core->env);
@@ -2101,8 +2097,6 @@ void mlxsw_core_bus_device_unregister(struct mlxsw_core *mlxsw_core,
 	mlxsw_core_health_fini(mlxsw_core);
 	if (!reload)
 		mlxsw_core_params_unregister(mlxsw_core);
-	if (!reload)
-		devlink_unregister(devlink);
 	mlxsw_emad_fini(mlxsw_core);
 	kfree(mlxsw_core->lag.mapping);
 	mlxsw_ports_fini(mlxsw_core, reload);
@@ -2116,7 +2110,6 @@ void mlxsw_core_bus_device_unregister(struct mlxsw_core *mlxsw_core,
 
 reload_fail_deinit:
 	mlxsw_core_params_unregister(mlxsw_core);
-	devlink_unregister(devlink);
 	devlink_resources_unregister(devlink, NULL);
 	devlink_free(devlink);
 }
-- 
2.31.1

