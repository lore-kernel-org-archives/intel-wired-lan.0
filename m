From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:58 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 18/21] net: wwan: iosm: Move
 devlink_register to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <6a63d8f6484a46c9120155082a396b44ce86bd1c.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

This change prevents from users to access device before devlink is
fully configured. Indirectly this change fixes the commit mentioned
below where devlink_unregister() was prematurely removed.

Fixes: db4278c55fa5 ("devlink: Make devlink_register to be void")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/wwan/iosm/iosm_ipc_devlink.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_devlink.c b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
index 42dbe7fe663c..6fe56f73011b 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_devlink.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
@@ -305,7 +305,6 @@ struct iosm_devlink *ipc_devlink_init(struct iosm_imem *ipc_imem)
 	ipc_devlink->devlink_ctx = devlink_ctx;
 	ipc_devlink->pcie = ipc_imem->pcie;
 	ipc_devlink->dev = ipc_imem->dev;
-	devlink_register(devlink_ctx);
 
 	rc = devlink_params_register(devlink_ctx, iosm_devlink_params,
 				     ARRAY_SIZE(iosm_devlink_params));
@@ -315,7 +314,6 @@ struct iosm_devlink *ipc_devlink_init(struct iosm_imem *ipc_imem)
 		goto param_reg_fail;
 	}
 
-	devlink_params_publish(devlink_ctx);
 	ipc_devlink->cd_file_info = list;
 
 	rc = ipc_devlink_create_region(ipc_devlink);
@@ -334,6 +332,7 @@ struct iosm_devlink *ipc_devlink_init(struct iosm_imem *ipc_imem)
 	init_completion(&ipc_devlink->devlink_sio.read_sem);
 	skb_queue_head_init(&ipc_devlink->devlink_sio.rx_list);
 
+	devlink_register(devlink_ctx);
 	dev_dbg(ipc_devlink->dev, "iosm devlink register success");
 
 	return ipc_devlink;
@@ -341,7 +340,6 @@ struct iosm_devlink *ipc_devlink_init(struct iosm_imem *ipc_imem)
 chnl_get_fail:
 	ipc_devlink_destroy_region(ipc_devlink);
 region_create_fail:
-	devlink_params_unpublish(devlink_ctx);
 	devlink_params_unregister(devlink_ctx, iosm_devlink_params,
 				  ARRAY_SIZE(iosm_devlink_params));
 param_reg_fail:
@@ -358,8 +356,8 @@ void ipc_devlink_deinit(struct iosm_devlink *ipc_devlink)
 {
 	struct devlink *devlink_ctx = ipc_devlink->devlink_ctx;
 
+	devlink_unregister(devlink_ctx);
 	ipc_devlink_destroy_region(ipc_devlink);
-	devlink_params_unpublish(devlink_ctx);
 	devlink_params_unregister(devlink_ctx, iosm_devlink_params,
 				  ARRAY_SIZE(iosm_devlink_params));
 	if (ipc_devlink->devlink_sio.devlink_read_pend) {
@@ -370,6 +368,5 @@ void ipc_devlink_deinit(struct iosm_devlink *ipc_devlink)
 		skb_queue_purge(&ipc_devlink->devlink_sio.rx_list);
 
 	ipc_imem_sys_devlink_close(ipc_devlink);
-	devlink_unregister(devlink_ctx);
 	devlink_free(devlink_ctx);
 }
-- 
2.31.1

