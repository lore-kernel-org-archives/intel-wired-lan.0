From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:26:02 -0800
Subject: [Intel-wired-lan] [PATCH S17 16/17] ice: Use dev_err when
 ice_cfg_vsi_lan fails
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-17-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

dev_err makes more sense than dev_info when this call fails.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 399905396134..49c75371af08 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2368,7 +2368,9 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi,
 	ret = ice_cfg_vsi_lan(vsi->port_info, vsi->idx, vsi->tc_cfg.ena_tc,
 			      max_txqs);
 	if (ret) {
-		dev_info(&pf->pdev->dev, "Failed VSI lan queue config\n");
+		dev_err(&pf->pdev->dev,
+			"VSI %d failed lan queue config, error %d\n",
+			vsi->vsi_num, ret);
 		goto unroll_vector_base;
 	}
 
@@ -2869,8 +2871,9 @@ int ice_vsi_rebuild(struct ice_vsi *vsi)
 	ret = ice_cfg_vsi_lan(vsi->port_info, vsi->idx, vsi->tc_cfg.ena_tc,
 			      max_txqs);
 	if (ret) {
-		dev_info(&vsi->back->pdev->dev,
-			 "Failed VSI lan queue config\n");
+		dev_err(&pf->pdev->dev,
+			"VSI %d failed lan queue config, error %d\n",
+			vsi->vsi_num, ret);
 		goto err_vectors;
 	}
 	return 0;
-- 
2.14.5

