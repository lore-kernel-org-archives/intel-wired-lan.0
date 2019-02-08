From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:56 -0800
Subject: [Intel-wired-lan] [PATCH S12 09/14] ice: Implement flow to reset
 VFs with PFR and other resets
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-10-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

All VF VSIs need to be reset and rebuild with the main VSIs before
replaying all VSIs, so that all existing switch filters, scheduler tree
and other configuration could be replayed at once. This fixes issues when
doing PFR and CORER reset.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 23db0cda6655..dcb5a9fab87d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -394,6 +394,7 @@ static void ice_do_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_rebuild(pf);
 		clear_bit(__ICE_PREPARED_FOR_RESET, pf->state);
 		clear_bit(__ICE_PFR_REQ, pf->state);
+		ice_reset_all_vfs(pf, true);
 	}
 }
 
@@ -436,6 +437,7 @@ static void ice_reset_subtask(struct ice_pf *pf)
 			clear_bit(__ICE_PFR_REQ, pf->state);
 			clear_bit(__ICE_CORER_REQ, pf->state);
 			clear_bit(__ICE_GLOBR_REQ, pf->state);
+			ice_reset_all_vfs(pf, true);
 		}
 
 		return;
@@ -3360,10 +3362,6 @@ static int ice_vsi_rebuild_all(struct ice_pf *pf)
 		if (!pf->vsi[i])
 			continue;
 
-		/* VF VSI rebuild isn't supported yet */
-		if (pf->vsi[i]->type == ICE_VSI_VF)
-			continue;
-
 		err = ice_vsi_rebuild(pf->vsi[i], true);
 		if (err) {
 			dev_err(&pf->pdev->dev,
@@ -3500,8 +3498,6 @@ static void ice_rebuild(struct ice_pf *pf)
 		goto err_vsi_rebuild;
 	}
 
-	ice_reset_all_vfs(pf, true);
-
 	ice_for_each_vsi(pf, i) {
 		bool link_up;
 
-- 
2.14.5

