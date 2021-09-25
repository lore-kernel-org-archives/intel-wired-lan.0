From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:55 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 15/21] qed: Move devlink
 registration to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <01bc35bd99dc5d2dcbf55bbf4a86f0bde1c50087.1632565508.git.leonro@nvidia.com>
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
 drivers/net/ethernet/qlogic/qed/qed_devlink.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_devlink.c b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
index c51f9590fe19..6bb4e165b592 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_devlink.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
@@ -215,7 +215,6 @@ struct devlink *qed_devlink_register(struct qed_dev *cdev)
 	qdevlink = devlink_priv(dl);
 	qdevlink->cdev = cdev;
 
-	devlink_register(dl);
 	rc = devlink_params_register(dl, qed_devlink_params,
 				     ARRAY_SIZE(qed_devlink_params));
 	if (rc)
@@ -226,15 +225,13 @@ struct devlink *qed_devlink_register(struct qed_dev *cdev)
 					   QED_DEVLINK_PARAM_ID_IWARP_CMT,
 					   value);
 
-	devlink_params_publish(dl);
 	cdev->iwarp_cmt = false;
 
 	qed_fw_reporters_create(dl);
-
+	devlink_register(dl);
 	return dl;
 
 err_unregister:
-	devlink_unregister(dl);
 	devlink_free(dl);
 
 	return ERR_PTR(rc);
@@ -245,11 +242,11 @@ void qed_devlink_unregister(struct devlink *devlink)
 	if (!devlink)
 		return;
 
+	devlink_unregister(devlink);
 	qed_fw_reporters_destroy(devlink);
 
 	devlink_params_unregister(devlink, qed_devlink_params,
 				  ARRAY_SIZE(qed_devlink_params));
 
-	devlink_unregister(devlink);
 	devlink_free(devlink);
 }
-- 
2.31.1

