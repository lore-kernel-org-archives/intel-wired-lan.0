From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 23 Sep 2021 21:12:50 +0300
Subject: [Intel-wired-lan] [PATCH net-next 3/6] devlink: Delete not used
 port parameters APIs
In-Reply-To: <cover.1632420430.git.leonro@nvidia.com>
References: <cover.1632420430.git.leonro@nvidia.com>
Message-ID: <b4350cf5e246da8587a636857724fababa820dea.1632420431.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

There is no in-kernel users for the devlink port parameters API,
so let's remove it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/devlink.h |  6 ------
 net/core/devlink.c    | 42 ------------------------------------------
 2 files changed, 48 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index c902e8e5f012..a7852a257bf6 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1653,12 +1653,6 @@ void devlink_param_unregister(struct devlink *devlink,
 			      const struct devlink_param *param);
 void devlink_params_publish(struct devlink *devlink);
 void devlink_params_unpublish(struct devlink *devlink);
-int devlink_port_params_register(struct devlink_port *devlink_port,
-				 const struct devlink_param *params,
-				 size_t params_count);
-void devlink_port_params_unregister(struct devlink_port *devlink_port,
-				    const struct devlink_param *params,
-				    size_t params_count);
 int devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
 				       union devlink_param_value *init_val);
 int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 7d975057c2a9..9c071f4e609f 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -10117,48 +10117,6 @@ void devlink_params_unpublish(struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_params_unpublish);
 
-/**
- *	devlink_port_params_register - register port configuration parameters
- *
- *	@devlink_port: devlink port
- *	@params: configuration parameters array
- *	@params_count: number of parameters provided
- *
- *	Register the configuration parameters supported by the port.
- */
-int devlink_port_params_register(struct devlink_port *devlink_port,
-				 const struct devlink_param *params,
-				 size_t params_count)
-{
-	return __devlink_params_register(devlink_port->devlink,
-					 devlink_port->index,
-					 &devlink_port->param_list, params,
-					 params_count,
-					 DEVLINK_CMD_PORT_PARAM_NEW,
-					 DEVLINK_CMD_PORT_PARAM_DEL);
-}
-EXPORT_SYMBOL_GPL(devlink_port_params_register);
-
-/**
- *	devlink_port_params_unregister - unregister port configuration
- *	parameters
- *
- *	@devlink_port: devlink port
- *	@params: configuration parameters array
- *	@params_count: number of parameters provided
- */
-void devlink_port_params_unregister(struct devlink_port *devlink_port,
-				    const struct devlink_param *params,
-				    size_t params_count)
-{
-	return __devlink_params_unregister(devlink_port->devlink,
-					   devlink_port->index,
-					   &devlink_port->param_list,
-					   params, params_count,
-					   DEVLINK_CMD_PORT_PARAM_DEL);
-}
-EXPORT_SYMBOL_GPL(devlink_port_params_unregister);
-
 static int
 __devlink_param_driverinit_value_get(struct list_head *param_list, u32 param_id,
 				     union devlink_param_value *init_val)
-- 
2.31.1

