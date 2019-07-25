From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 02:53:57 -0700
Subject: [Intel-wired-lan] [PATCH S25 08/12] ice: Introduce a local variable
 for a VSI in the rebuild path
In-Reply-To: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725095401.24590-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

When a VSI is accessed inside the ice_for_each_vsi macro in the rebuild
path (ice_vsi_rebuild_all() and ice_vsi_replay_all()), it is referred to
as pf->vsi[i]. Introduce local variables to improve readability.

Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1abbea7a69e1..f8746609f065 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3740,22 +3740,23 @@ static int ice_vsi_rebuild_all(struct ice_pf *pf)
 
 	/* loop through pf->vsi array and reinit the VSI if found */
 	ice_for_each_vsi(pf, i) {
+		struct ice_vsi *vsi = pf->vsi[i];
 		int err;
 
-		if (!pf->vsi[i])
+		if (!vsi)
 			continue;
 
-		err = ice_vsi_rebuild(pf->vsi[i], true);
+		err = ice_vsi_rebuild(vsi, true);
 		if (err) {
 			dev_err(&pf->pdev->dev,
 				"VSI at index %d rebuild failed\n",
-				pf->vsi[i]->idx);
+				vsi->idx);
 			return err;
 		}
 
 		dev_info(&pf->pdev->dev,
 			 "VSI at index %d rebuilt. vsi_num = 0x%x\n",
-			 pf->vsi[i]->idx, pf->vsi[i]->vsi_num);
+			 vsi->idx, vsi->vsi_num);
 	}
 
 	return 0;
@@ -3773,25 +3774,27 @@ static int ice_vsi_replay_all(struct ice_pf *pf)
 
 	/* loop through pf->vsi array and replay the VSI if found */
 	ice_for_each_vsi(pf, i) {
-		if (!pf->vsi[i])
+		struct ice_vsi *vsi = pf->vsi[i];
+
+		if (!vsi)
 			continue;
 
-		ret = ice_replay_vsi(hw, pf->vsi[i]->idx);
+		ret = ice_replay_vsi(hw, vsi->idx);
 		if (ret) {
 			dev_err(&pf->pdev->dev,
 				"VSI at index %d replay failed %d\n",
-				pf->vsi[i]->idx, ret);
+				vsi->idx, ret);
 			return -EIO;
 		}
 
 		/* Re-map HW VSI number, using VSI handle that has been
 		 * previously validated in ice_replay_vsi() call above
 		 */
-		pf->vsi[i]->vsi_num = ice_get_hw_vsi_num(hw, pf->vsi[i]->idx);
+		vsi->vsi_num = ice_get_hw_vsi_num(hw, vsi->idx);
 
 		dev_info(&pf->pdev->dev,
 			 "VSI at index %d filter replayed successfully - vsi_num %i\n",
-			 pf->vsi[i]->idx, pf->vsi[i]->vsi_num);
+			 vsi->idx, vsi->vsi_num);
 	}
 
 	/* Clean up replay filter after successful re-configuration */
-- 
2.20.1

