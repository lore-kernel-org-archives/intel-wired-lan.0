From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu,  9 Aug 2018 06:29:00 -0700
Subject: [Intel-wired-lan] [PATCH v4 10/13] ice: Fix a few null pointer
 dereference issues
In-Reply-To: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180809132903.22819-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

1) When ice_ena_msix_range() fails to reserve vectors, a devm_kfree()
   warning was seen in the error flow path. So check pf->irq_tracker
   before use in ice_clear_interrupt_scheme().

2) In ice_vsi_cfg(), check vsi->netdev before use.

3) In ice_get_link_status, check link_up before use.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c   | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index d5300b606d5a..ebd701ac9428 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1483,7 +1483,7 @@ enum ice_status ice_get_link_status(struct ice_port_info *pi, bool *link_up)
 	struct ice_phy_info *phy_info;
 	enum ice_status status = 0;
 
-	if (!pi)
+	if (!pi || !link_up)
 		return ICE_ERR_PARAM;
 
 	phy_info = &pi->phy;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 34be94a30a60..d5d83c8848f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3257,8 +3257,10 @@ static void ice_clear_interrupt_scheme(struct ice_pf *pf)
 	if (test_bit(ICE_FLAG_MSIX_ENA, pf->flags))
 		ice_dis_msix(pf);
 
-	devm_kfree(&pf->pdev->dev, pf->irq_tracker);
-	pf->irq_tracker = NULL;
+	if (pf->irq_tracker) {
+		devm_kfree(&pf->pdev->dev, pf->irq_tracker);
+		pf->irq_tracker = NULL;
+	}
 }
 
 /**
@@ -4112,11 +4114,12 @@ static int ice_vsi_cfg(struct ice_vsi *vsi)
 {
 	int err;
 
-	ice_set_rx_mode(vsi->netdev);
-
-	err = ice_restore_vlan(vsi);
-	if (err)
-		return err;
+	if (vsi->netdev) {
+		ice_set_rx_mode(vsi->netdev);
+		err = ice_restore_vlan(vsi);
+		if (err)
+			return err;
+	}
 
 	err = ice_vsi_cfg_txqs(vsi);
 	if (!err)
-- 
2.17.1

