From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 26 Feb 2021 13:19:22 -0800
Subject: [Intel-wired-lan] [PATCH net 03/13] ice: Continue probe on link/PHY
 errors
In-Reply-To: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
Message-ID: <20210226211932.46683-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

An incorrect NVM update procedure can result in the driver failing probe.
In this case, the recommended resolution method is to update the NVM
using the right procedure. However, if the driver fails probe, the user
will not be able to update the NVM. So do not fail probe on link/PHY
errors.

Fixes: 1a3571b5938c ("ice: restore PHY settings on media insertion")
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2c23c8f468a5..53e053c997eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4192,28 +4192,25 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		goto err_send_version_unroll;
 	}
 
+	/* not a fatal error if this fails */
 	err = ice_init_nvm_phy_type(pf->hw.port_info);
-	if (err) {
+	if (err)
 		dev_err(dev, "ice_init_nvm_phy_type failed: %d\n", err);
-		goto err_send_version_unroll;
-	}
 
+	/* not a fatal error if this fails */
 	err = ice_update_link_info(pf->hw.port_info);
-	if (err) {
+	if (err)
 		dev_err(dev, "ice_update_link_info failed: %d\n", err);
-		goto err_send_version_unroll;
-	}
 
 	ice_init_link_dflt_override(pf->hw.port_info);
 
 	/* if media available, initialize PHY settings */
 	if (pf->hw.port_info->phy.link_info.link_info &
 	    ICE_AQ_MEDIA_AVAILABLE) {
+		/* not a fatal error if this fails */
 		err = ice_init_phy_user_cfg(pf->hw.port_info);
-		if (err) {
+		if (err)
 			dev_err(dev, "ice_init_phy_user_cfg failed: %d\n", err);
-			goto err_send_version_unroll;
-		}
 
 		if (!test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags)) {
 			struct ice_vsi *vsi = ice_get_main_vsi(pf);
-- 
2.20.1

