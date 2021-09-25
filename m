From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:46 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 06/21] ice: Open devlink when
 device is ready
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <23884bb7be2cc08ae00c551a6bb7d200a75b5117.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Move devlink_registration routine to be the last command, when the
device is fully initialized.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index aacc0b345bbe..627adf8fb89d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4258,8 +4258,6 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	pf->msg_enable = netif_msg_init(debug, ICE_DFLT_NETIF_M);
 
-	ice_devlink_register(pf);
-
 #ifndef CONFIG_DYNAMIC_DEBUG
 	if (debug < -1)
 		hw->debug_mask = debug;
@@ -4493,6 +4491,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		dev_warn(dev, "RDMA is not supported on this device\n");
 	}
 
+	ice_devlink_register(pf);
 	return 0;
 
 err_init_aux_unroll:
@@ -4516,7 +4515,6 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	ice_devlink_destroy_regions(pf);
 	ice_deinit_hw(hw);
 err_exit_unroll:
-	ice_devlink_unregister(pf);
 	pci_disable_pcie_error_reporting(pdev);
 	pci_disable_device(pdev);
 	return err;
@@ -4593,6 +4591,7 @@ static void ice_remove(struct pci_dev *pdev)
 	struct ice_pf *pf = pci_get_drvdata(pdev);
 	int i;
 
+	ice_devlink_unregister(pf);
 	for (i = 0; i < ICE_MAX_RESET_WAIT; i++) {
 		if (!ice_is_reset_in_progress(pf->state))
 			break;
@@ -4629,7 +4628,6 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_deinit_pf(pf);
 	ice_devlink_destroy_regions(pf);
 	ice_deinit_hw(&pf->hw);
-	ice_devlink_unregister(pf);
 
 	/* Issue a PFR as part of the prescribed driver unload flow.  Do not
 	 * do it via ice_schedule_reset() since there is no need to rebuild
-- 
2.31.1

