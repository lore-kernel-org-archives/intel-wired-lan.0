From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:59 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 19/21] ptp: ocp: Move devlink
 registration to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <1541e7cd8262ce9db7544669438d0f4360068dd2.1632565508.git.leonro@nvidia.com>
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
 drivers/ptp/ptp_ocp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4c25467198e3..34f943c8c9fd 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2455,7 +2455,6 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	devlink_register(devlink);
 	err = pci_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "pci_enable_device\n");
@@ -2497,7 +2496,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out;
 
 	ptp_ocp_info(bp);
-
+	devlink_register(devlink);
 	return 0;
 
 out:
@@ -2506,7 +2505,6 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_disable:
 	pci_disable_device(pdev);
 out_unregister:
-	devlink_unregister(devlink);
 	devlink_free(devlink);
 	return err;
 }
@@ -2517,11 +2515,11 @@ ptp_ocp_remove(struct pci_dev *pdev)
 	struct ptp_ocp *bp = pci_get_drvdata(pdev);
 	struct devlink *devlink = priv_to_devlink(bp);
 
+	devlink_unregister(devlink);
 	ptp_ocp_detach(bp);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
 
-	devlink_unregister(devlink);
 	devlink_free(devlink);
 }
 
-- 
2.31.1

