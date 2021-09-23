From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 23 Sep 2021 21:12:51 +0300
Subject: [Intel-wired-lan] [PATCH net-next 4/6] devlink: Remove single line
 function obfuscations
In-Reply-To: <cover.1632420430.git.leonro@nvidia.com>
References: <cover.1632420430.git.leonro@nvidia.com>
Message-ID: <a56f5eece50f146ea170571a9dde24079522937f.1632420431.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in extra one line functions to call relevant
functions only once.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/core/devlink.c | 89 ++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 55 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 9c071f4e609f..3ea33c689790 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -10117,13 +10117,26 @@ void devlink_params_unpublish(struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_params_unpublish);
 
-static int
-__devlink_param_driverinit_value_get(struct list_head *param_list, u32 param_id,
-				     union devlink_param_value *init_val)
+/**
+ *	devlink_param_driverinit_value_get - get configuration parameter
+ *					     value for driver initializing
+ *
+ *	@devlink: devlink
+ *	@param_id: parameter ID
+ *	@init_val: value of parameter in driverinit configuration mode
+ *
+ *	This function should be used by the driver to get driverinit
+ *	configuration for initialization after reload command.
+ */
+int devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
+				       union devlink_param_value *init_val)
 {
 	struct devlink_param_item *param_item;
 
-	param_item = devlink_param_find_by_id(param_list, param_id);
+	if (!devlink_reload_supported(devlink->ops))
+		return -EOPNOTSUPP;
+
+	param_item = devlink_param_find_by_id(&devlink->param_list, param_id);
 	if (!param_item)
 		return -EINVAL;
 
@@ -10139,17 +10152,26 @@ __devlink_param_driverinit_value_get(struct list_head *param_list, u32 param_id,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(devlink_param_driverinit_value_get);
 
-static int
-__devlink_param_driverinit_value_set(struct devlink *devlink,
-				     unsigned int port_index,
-				     struct list_head *param_list, u32 param_id,
-				     union devlink_param_value init_val,
-				     enum devlink_command cmd)
+/**
+ *	devlink_param_driverinit_value_set - set value of configuration
+ *					     parameter for driverinit
+ *					     configuration mode
+ *
+ *	@devlink: devlink
+ *	@param_id: parameter ID
+ *	@init_val: value of parameter to set for driverinit configuration mode
+ *
+ *	This function should be used by the driver to set driverinit
+ *	configuration mode default value.
+ */
+int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
+				       union devlink_param_value init_val)
 {
 	struct devlink_param_item *param_item;
 
-	param_item = devlink_param_find_by_id(param_list, param_id);
+	param_item = devlink_param_find_by_id(&devlink->param_list, param_id);
 	if (!param_item)
 		return -EINVAL;
 
@@ -10163,52 +10185,9 @@ __devlink_param_driverinit_value_set(struct devlink *devlink,
 		param_item->driverinit_value = init_val;
 	param_item->driverinit_value_valid = true;
 
-	devlink_param_notify(devlink, port_index, param_item, cmd);
+	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
 	return 0;
 }
-
-/**
- *	devlink_param_driverinit_value_get - get configuration parameter
- *					     value for driver initializing
- *
- *	@devlink: devlink
- *	@param_id: parameter ID
- *	@init_val: value of parameter in driverinit configuration mode
- *
- *	This function should be used by the driver to get driverinit
- *	configuration for initialization after reload command.
- */
-int devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
-				       union devlink_param_value *init_val)
-{
-	if (!devlink_reload_supported(devlink->ops))
-		return -EOPNOTSUPP;
-
-	return __devlink_param_driverinit_value_get(&devlink->param_list,
-						    param_id, init_val);
-}
-EXPORT_SYMBOL_GPL(devlink_param_driverinit_value_get);
-
-/**
- *	devlink_param_driverinit_value_set - set value of configuration
- *					     parameter for driverinit
- *					     configuration mode
- *
- *	@devlink: devlink
- *	@param_id: parameter ID
- *	@init_val: value of parameter to set for driverinit configuration mode
- *
- *	This function should be used by the driver to set driverinit
- *	configuration mode default value.
- */
-int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
-				       union devlink_param_value init_val)
-{
-	return __devlink_param_driverinit_value_set(devlink, 0,
-						    &devlink->param_list,
-						    param_id, init_val,
-						    DEVLINK_CMD_PARAM_NEW);
-}
 EXPORT_SYMBOL_GPL(devlink_param_driverinit_value_set);
 
 /**
-- 
2.31.1

