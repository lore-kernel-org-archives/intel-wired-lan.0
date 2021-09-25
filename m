From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:53 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 13/21] nfp: Move
 delink_register to be last command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <f393212ad3906808ee7eb5cff06ef2e053eb9d2b.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Open user space access to the devlink after driver is probed.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/netronome/nfp/devlink_param.c | 9 ++-------
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c  | 5 ++---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/devlink_param.c b/drivers/net/ethernet/netronome/nfp/devlink_param.c
index 36491835ac65..db297ee4d7ad 100644
--- a/drivers/net/ethernet/netronome/nfp/devlink_param.c
+++ b/drivers/net/ethernet/netronome/nfp/devlink_param.c
@@ -233,13 +233,8 @@ int nfp_devlink_params_register(struct nfp_pf *pf)
 	if (err <= 0)
 		return err;
 
-	err = devlink_params_register(devlink, nfp_devlink_params,
-				      ARRAY_SIZE(nfp_devlink_params));
-	if (err)
-		return err;
-
-	devlink_params_publish(devlink);
-	return 0;
+	return devlink_params_register(devlink, nfp_devlink_params,
+				       ARRAY_SIZE(nfp_devlink_params));
 }
 
 void nfp_devlink_params_unregister(struct nfp_pf *pf)
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index 616872928ada..5fbb7c613ff1 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -701,7 +701,6 @@ int nfp_net_pci_probe(struct nfp_pf *pf)
 	if (err)
 		goto err_unmap;
 
-	devlink_register(devlink);
 	err = nfp_shared_buf_register(pf);
 	if (err)
 		goto err_devlink_unreg;
@@ -731,6 +730,7 @@ int nfp_net_pci_probe(struct nfp_pf *pf)
 		goto err_stop_app;
 
 	mutex_unlock(&pf->lock);
+	devlink_register(devlink);
 
 	return 0;
 
@@ -748,7 +748,6 @@ int nfp_net_pci_probe(struct nfp_pf *pf)
 	nfp_shared_buf_unregister(pf);
 err_devlink_unreg:
 	cancel_work_sync(&pf->port_refresh_work);
-	devlink_unregister(devlink);
 	nfp_net_pf_app_clean(pf);
 err_unmap:
 	nfp_net_pci_unmap_mem(pf);
@@ -759,6 +758,7 @@ void nfp_net_pci_remove(struct nfp_pf *pf)
 {
 	struct nfp_net *nn, *next;
 
+	devlink_unregister(priv_to_devlink(pf));
 	mutex_lock(&pf->lock);
 	list_for_each_entry_safe(nn, next, &pf->vnics, vnic_list) {
 		if (!nfp_net_is_data_vnic(nn))
@@ -775,7 +775,6 @@ void nfp_net_pci_remove(struct nfp_pf *pf)
 
 	nfp_devlink_params_unregister(pf);
 	nfp_shared_buf_unregister(pf);
-	devlink_unregister(priv_to_devlink(pf));
 
 	nfp_net_pf_free_irqs(pf);
 	nfp_net_pf_app_clean(pf);
-- 
2.31.1

