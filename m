From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 23 Sep 2021 21:12:48 +0300
Subject: [Intel-wired-lan] [PATCH net-next 1/6] bnxt_en: Check devlink
 allocation and registration status
In-Reply-To: <cover.1632420430.git.leonro@nvidia.com>
References: <cover.1632420430.git.leonro@nvidia.com>
Message-ID: <e7708737fadf4fe6f152afc76145c728c201adad.1632420430.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

devlink is a software interface that doesn't depend on any hardware
capabilities. The failure in SW means memory issues, wrong parameters,
programmer error e.t.c.

Like any other such interface in the kernel, the returned status of
devlink APIs should be checked and propagated further and not ignored.

Fixes: 4ab0c6a8ffd7 ("bnxt_en: add support to enable VF-representors")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  5 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 13 ++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h | 13 -------------
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 037767b370d5..4c483fd91dbe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13370,7 +13370,9 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	bnxt_inv_fw_health_reg(bp);
-	bnxt_dl_register(bp);
+	rc = bnxt_dl_register(bp);
+	if (rc)
+		goto init_err_dl;
 
 	rc = register_netdev(dev);
 	if (rc)
@@ -13390,6 +13392,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 init_err_cleanup:
 	bnxt_dl_unregister(bp);
+init_err_dl:
 	bnxt_shutdown_tc(bp);
 	bnxt_clear_int_mode(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index bf7d3c17049b..dc0851f709f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -134,7 +134,7 @@ void bnxt_dl_fw_reporters_create(struct bnxt *bp)
 {
 	struct bnxt_fw_health *health = bp->fw_health;
 
-	if (!bp->dl || !health)
+	if (!health)
 		return;
 
 	if (!(bp->fw_cap & BNXT_FW_CAP_HOT_RESET) || health->fw_reset_reporter)
@@ -188,7 +188,7 @@ void bnxt_dl_fw_reporters_destroy(struct bnxt *bp, bool all)
 {
 	struct bnxt_fw_health *health = bp->fw_health;
 
-	if (!bp->dl || !health)
+	if (!health)
 		return;
 
 	if ((all || !(bp->fw_cap & BNXT_FW_CAP_HOT_RESET)) &&
@@ -781,6 +781,7 @@ int bnxt_dl_register(struct bnxt *bp)
 {
 	const struct devlink_ops *devlink_ops;
 	struct devlink_port_attrs attrs = {};
+	struct bnxt_dl *bp_dl;
 	struct devlink *dl;
 	int rc;
 
@@ -795,7 +796,9 @@ int bnxt_dl_register(struct bnxt *bp)
 		return -ENOMEM;
 	}
 
-	bnxt_link_bp_to_dl(bp, dl);
+	bp->dl = dl;
+	bp_dl = devlink_priv(dl);
+	bp_dl->bp = bp;
 
 	/* Add switchdev eswitch mode setting, if SRIOV supported */
 	if (pci_find_ext_capability(bp->pdev, PCI_EXT_CAP_ID_SRIOV) &&
@@ -826,7 +829,6 @@ int bnxt_dl_register(struct bnxt *bp)
 err_dl_port_unreg:
 	devlink_port_unregister(&bp->dl_port);
 err_dl_free:
-	bnxt_link_bp_to_dl(bp, NULL);
 	devlink_free(dl);
 	return rc;
 }
@@ -835,9 +837,6 @@ void bnxt_dl_unregister(struct bnxt *bp)
 {
 	struct devlink *dl = bp->dl;
 
-	if (!dl)
-		return;
-
 	if (BNXT_PF(bp)) {
 		bnxt_dl_params_unregister(bp);
 		devlink_port_unregister(&bp->dl_port);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
index d889f240da2b..406dc655a5fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
@@ -20,19 +20,6 @@ static inline struct bnxt *bnxt_get_bp_from_dl(struct devlink *dl)
 	return ((struct bnxt_dl *)devlink_priv(dl))->bp;
 }
 
-/* To clear devlink pointer from bp, pass NULL dl */
-static inline void bnxt_link_bp_to_dl(struct bnxt *bp, struct devlink *dl)
-{
-	bp->dl = dl;
-
-	/* add a back pointer in dl to bp */
-	if (dl) {
-		struct bnxt_dl *bp_dl = devlink_priv(dl);
-
-		bp_dl->bp = bp;
-	}
-}
-
 #define NVM_OFF_MSIX_VEC_PER_PF_MAX	108
 #define NVM_OFF_MSIX_VEC_PER_PF_MIN	114
 #define NVM_OFF_IGNORE_ARI		164
-- 
2.31.1

