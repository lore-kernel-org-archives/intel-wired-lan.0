From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:47 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 07/21] octeontx2: Move devlink
 registration to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <c711bbd0519dfdf3d28141cf9aa159d05f94aab7.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

This change prevents from users to access device before devlink is fully
configured. This change allows us to delete call to devlink_params_publish()
and impossible check during unregister flow.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c   | 10 ++--------
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c | 15 +++------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index de9562acd04b..70bacd38a6d9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1510,7 +1510,6 @@ int rvu_register_dl(struct rvu *rvu)
 		return -ENOMEM;
 	}
 
-	devlink_register(dl);
 	rvu_dl = devlink_priv(dl);
 	rvu_dl->dl = dl;
 	rvu_dl->rvu = rvu;
@@ -1531,13 +1530,11 @@ int rvu_register_dl(struct rvu *rvu)
 		goto err_dl_health;
 	}
 
-	devlink_params_publish(dl);
-
+	devlink_register(dl);
 	return 0;
 
 err_dl_health:
 	rvu_health_reporters_destroy(rvu);
-	devlink_unregister(dl);
 	devlink_free(dl);
 	return err;
 }
@@ -1547,12 +1544,9 @@ void rvu_unregister_dl(struct rvu *rvu)
 	struct rvu_devlink *rvu_dl = rvu->rvu_dl;
 	struct devlink *dl = rvu_dl->dl;
 
-	if (!dl)
-		return;
-
+	devlink_unregister(dl);
 	devlink_params_unregister(dl, rvu_af_dl_params,
 				  ARRAY_SIZE(rvu_af_dl_params));
 	rvu_health_reporters_destroy(rvu);
-	devlink_unregister(dl);
 	devlink_free(dl);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 3de18f9433ae..777a27047c8e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -108,7 +108,6 @@ int otx2_register_dl(struct otx2_nic *pfvf)
 		return -ENOMEM;
 	}
 
-	devlink_register(dl);
 	otx2_dl = devlink_priv(dl);
 	otx2_dl->dl = dl;
 	otx2_dl->pfvf = pfvf;
@@ -122,12 +121,10 @@ int otx2_register_dl(struct otx2_nic *pfvf)
 		goto err_dl;
 	}
 
-	devlink_params_publish(dl);
-
+	devlink_register(dl);
 	return 0;
 
 err_dl:
-	devlink_unregister(dl);
 	devlink_free(dl);
 	return err;
 }
@@ -135,16 +132,10 @@ int otx2_register_dl(struct otx2_nic *pfvf)
 void otx2_unregister_dl(struct otx2_nic *pfvf)
 {
 	struct otx2_devlink *otx2_dl = pfvf->dl;
-	struct devlink *dl;
-
-	if (!otx2_dl || !otx2_dl->dl)
-		return;
-
-	dl = otx2_dl->dl;
+	struct devlink *dl = otx2_dl->dl;
 
+	devlink_unregister(dl);
 	devlink_params_unregister(dl, otx2_dl_params,
 				  ARRAY_SIZE(otx2_dl_params));
-
-	devlink_unregister(dl);
 	devlink_free(dl);
 }
-- 
2.31.1

