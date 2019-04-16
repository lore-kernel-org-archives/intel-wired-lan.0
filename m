From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:34:57 -0700
Subject: [Intel-wired-lan] [PATCH S21 08/14] ice: Use continue instead of an
 else block
In-Reply-To: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173503.29847-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For style consistency, use continue instead of an else block in
ice_pf_dcb_recfg.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index e1db24cde38a..b2e05ba79123 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -120,12 +120,14 @@ static void ice_pf_dcb_recfg(struct ice_pf *pf)
 			tc_map = ICE_DFLT_TRAFFIC_CLASS;
 
 		ret = ice_vsi_cfg_tc(pf->vsi[v], tc_map);
-		if (ret)
+		if (ret) {
 			dev_err(&pf->pdev->dev,
 				"Failed to config TC for VSI index: %d\n",
 				pf->vsi[v]->idx);
-		else
-			ice_vsi_map_rings_to_vectors(pf->vsi[v]);
+			continue;
+		}
+
+		ice_vsi_map_rings_to_vectors(pf->vsi[v]);
 	}
 }
 
-- 
2.20.1

