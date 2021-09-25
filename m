From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:49 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 09/21] net/mlx4: Move
 devlink_register to be the last initialization command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <486f4512a0d472b8732067018d2ec8c4f3f45763.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Refactor the code to make sure that devlink_register() is the last
command during initialization stage.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 27ed4694fbea..9541f3a920c8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -4015,7 +4015,6 @@ static int mlx4_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	mutex_init(&dev->persist->interface_state_mutex);
 	mutex_init(&dev->persist->pci_status_mutex);
 
-	devlink_register(devlink);
 	ret = devlink_params_register(devlink, mlx4_devlink_params,
 				      ARRAY_SIZE(mlx4_devlink_params));
 	if (ret)
@@ -4025,16 +4024,15 @@ static int mlx4_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_params_unregister;
 
-	devlink_params_publish(devlink);
-	devlink_reload_enable(devlink);
 	pci_save_state(pdev);
+	devlink_register(devlink);
+	devlink_reload_enable(devlink);
 	return 0;
 
 err_params_unregister:
 	devlink_params_unregister(devlink, mlx4_devlink_params,
 				  ARRAY_SIZE(mlx4_devlink_params));
 err_devlink_unregister:
-	devlink_unregister(devlink);
 	kfree(dev->persist);
 err_devlink_free:
 	devlink_free(devlink);
@@ -4138,6 +4136,7 @@ static void mlx4_remove_one(struct pci_dev *pdev)
 	int active_vfs = 0;
 
 	devlink_reload_disable(devlink);
+	devlink_unregister(devlink);
 
 	if (mlx4_is_slave(dev))
 		persist->interface_state |= MLX4_INTERFACE_STATE_NOWAIT;
@@ -4173,7 +4172,6 @@ static void mlx4_remove_one(struct pci_dev *pdev)
 	mlx4_pci_disable_device(dev);
 	devlink_params_unregister(devlink, mlx4_devlink_params,
 				  ARRAY_SIZE(mlx4_devlink_params));
-	devlink_unregister(devlink);
 	kfree(dev->persist);
 	devlink_free(devlink);
 }
-- 
2.31.1

