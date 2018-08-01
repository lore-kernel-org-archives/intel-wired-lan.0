From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 31 Jul 2018 20:47:27 -0700
Subject: [Intel-wired-lan] [PATCH v3 11/13] ice: Fix couple of null pointer
 dereference issues
In-Reply-To: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
References: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180801034729.3864-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When ice_ena_msix_range() fails to reserve vectors, a devm_kfree() warning
was seen in the error flow path. So check pf->irq_tracker before use in
ice_clear_interrupt_scheme().

In ice_vsi_cfg(), check vsi->netdev before use.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1487aac09e99..6ac74511c4ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3255,8 +3255,10 @@ static void ice_clear_interrupt_scheme(struct ice_pf *pf)
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
@@ -4110,11 +4112,12 @@ static int ice_vsi_cfg(struct ice_vsi *vsi)
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

