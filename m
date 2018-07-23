From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon, 23 Jul 2018 10:37:50 -0700
Subject: [Intel-wired-lan] [PATCH 11/13] ice: Fix couple of null pointer
 dereference issues
In-Reply-To: <20180723173752.19676-1-anirudh.venkataramanan@intel.com>
References: <20180723173752.19676-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180723173752.19676-12-anirudh.venkataramanan@intel.com>
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
index bcd39654ab4b..e5b8eb0c4581 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3259,8 +3259,10 @@ static void ice_clear_interrupt_scheme(struct ice_pf *pf)
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
@@ -4114,11 +4116,12 @@ static int ice_vsi_cfg(struct ice_vsi *vsi)
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
2.14.3

