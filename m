From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:24:27 -0700
Subject: [Intel-wired-lan] [PATCH S19 03/15] ice: Remove braces for single
 statement blocks
In-Reply-To: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172439.27908-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix checkpatch warning "WARNING:BRACES: braces {} are not necessary
for single statement blocks"

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 693f5d09326a..80d01ee2e967 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1903,9 +1903,8 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	}
 
 	vsi = pf->vsi[vf->lan_vsi_idx];
-	if (!vsi) {
+	if (!vsi)
 		goto error_param;
-	}
 
 	if (qci->num_queue_pairs > ICE_MAX_BASE_QS_PER_VF) {
 		dev_err(&pf->pdev->dev,
-- 
2.20.1

