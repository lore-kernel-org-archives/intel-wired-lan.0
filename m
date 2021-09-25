From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:45 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 05/21] net: hinic: Open device
 for the user access when it is ready
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <9956e9af5948084d725c547e307eb13656d569fc.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Move devlink registration to be the last command in device activation,
so it opens the driver to accept such devlink commands from the user
when it is fully initialized.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
index b2ece3adbc72..657a15447bd0 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
@@ -754,11 +754,9 @@ static int init_pfhwdev(struct hinic_pfhwdev *pfhwdev)
 		return err;
 	}
 
-	hinic_devlink_register(hwdev->devlink_dev);
 	err = hinic_func_to_func_init(hwdev);
 	if (err) {
 		dev_err(&hwif->pdev->dev, "Failed to init mailbox\n");
-		hinic_devlink_unregister(hwdev->devlink_dev);
 		hinic_pf_to_mgmt_free(&pfhwdev->pf_to_mgmt);
 		return err;
 	}
@@ -781,7 +779,7 @@ static int init_pfhwdev(struct hinic_pfhwdev *pfhwdev)
 	}
 
 	hinic_set_pf_action(hwif, HINIC_PF_MGMT_ACTIVE);
-
+	hinic_devlink_register(hwdev->devlink_dev);
 	return 0;
 }
 
@@ -793,6 +791,7 @@ static void free_pfhwdev(struct hinic_pfhwdev *pfhwdev)
 {
 	struct hinic_hwdev *hwdev = &pfhwdev->hwdev;
 
+	hinic_devlink_unregister(hwdev->devlink_dev);
 	hinic_set_pf_action(hwdev->hwif, HINIC_PF_MGMT_INIT);
 
 	if (!HINIC_IS_VF(hwdev->hwif)) {
@@ -810,8 +809,6 @@ static void free_pfhwdev(struct hinic_pfhwdev *pfhwdev)
 
 	hinic_func_to_func_free(hwdev);
 
-	hinic_devlink_unregister(hwdev->devlink_dev);
-
 	hinic_pf_to_mgmt_free(&pfhwdev->pf_to_mgmt);
 }
 
-- 
2.31.1

