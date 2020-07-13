From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:15 -0700
Subject: [Intel-wired-lan] [PATCH S50 12/15] ice: cleanup VSI on probe fail
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marcin Szycik <marcin.szycik@intel.com>

As part of ice_setup_pf_sw() a PF VSI is setup; release the VSI in case of
failure.

Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e6d758aa9a2f..840e35e5f6f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3991,7 +3991,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	if (err) {
 		dev_err(dev, "probe failed sending driver version %s. error: %d\n",
 			UTS_RELEASE, err);
-		goto err_alloc_sw_unroll;
+		goto err_send_version_unroll;
 	}
 
 	/* since everything is good, start the service timer */
@@ -4000,19 +4000,19 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	err = ice_init_link_events(pf->hw.port_info);
 	if (err) {
 		dev_err(dev, "ice_init_link_events failed: %d\n", err);
-		goto err_alloc_sw_unroll;
+		goto err_send_version_unroll;
 	}
 
 	err = ice_init_nvm_phy_type(pf->hw.port_info);
 	if (err) {
 		dev_err(dev, "ice_init_nvm_phy_type failed: %d\n", err);
-		goto err_alloc_sw_unroll;
+		goto err_send_version_unroll;
 	}
 
 	err = ice_update_link_info(pf->hw.port_info);
 	if (err) {
 		dev_err(dev, "ice_update_link_info failed: %d\n", err);
-		goto err_alloc_sw_unroll;
+		goto err_send_version_unroll;
 	}
 
 	ice_init_link_dflt_override(pf->hw.port_info);
@@ -4023,7 +4023,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		err = ice_init_phy_user_cfg(pf->hw.port_info);
 		if (err) {
 			dev_err(dev, "ice_init_phy_user_cfg failed: %d\n", err);
-			goto err_alloc_sw_unroll;
+			goto err_send_version_unroll;
 		}
 
 		if (!test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags)) {
@@ -4077,6 +4077,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	clear_bit(__ICE_DOWN, pf->state);
 	return 0;
 
+err_send_version_unroll:
+	ice_vsi_release_all(pf);
 err_alloc_sw_unroll:
 	ice_devlink_destroy_port(pf);
 	set_bit(__ICE_SERVICE_DIS, pf->state);
-- 
2.20.1

