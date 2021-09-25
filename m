From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:23:00 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 20/21] staging: qlge: Move
 devlink registration to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <87eb1893ae465eb0ec1ed726c9ca078edc8298ac.1632565508.git.leonro@nvidia.com>
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
 drivers/staging/qlge/qlge_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 33539f6c254d..1dc849378a0f 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -4614,10 +4614,9 @@ static int qlge_probe(struct pci_dev *pdev,
 		goto netdev_free;
 	}
 
-	devlink_register(devlink);
 	err = qlge_health_create_reporters(qdev);
 	if (err)
-		goto devlink_unregister;
+		goto netdev_free;
 
 	/* Start up the timer to trigger EEH if
 	 * the bus goes dead
@@ -4628,10 +4627,9 @@ static int qlge_probe(struct pci_dev *pdev,
 	qlge_display_dev_info(ndev);
 	atomic_set(&qdev->lb_count, 0);
 	cards_found++;
+	devlink_register(devlink);
 	return 0;
 
-devlink_unregister:
-	devlink_unregister(devlink);
 netdev_free:
 	free_netdev(ndev);
 devlink_free:
@@ -4656,13 +4654,13 @@ static void qlge_remove(struct pci_dev *pdev)
 	struct net_device *ndev = qdev->ndev;
 	struct devlink *devlink = priv_to_devlink(qdev);
 
+	devlink_unregister(devlink);
 	del_timer_sync(&qdev->timer);
 	qlge_cancel_all_work_sync(qdev);
 	unregister_netdev(ndev);
 	qlge_release_all(pdev);
 	pci_disable_device(pdev);
 	devlink_health_reporter_destroy(qdev->reporter);
-	devlink_unregister(devlink);
 	devlink_free(devlink);
 	free_netdev(ndev);
 }
-- 
2.31.1

