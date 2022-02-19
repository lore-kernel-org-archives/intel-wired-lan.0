From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 18 Feb 2022 16:27:22 -0800
Subject: [Intel-wired-lan] [PATCH] fixup! ice: convert VF storage to hash
 table with krefs and RCU
Message-ID: <20220219002722.2594405-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rebase conflict on my end caused a missing hunk to remove the
mutex_destroy outside the ice_release_vf.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 29282dfb3a94..45fe36db076a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -666,8 +666,6 @@ void ice_free_vfs(struct ice_pf *pf)
 				vf->vf_id);
 
 		mutex_unlock(&vf->cfg_lock);
-
-		mutex_destroy(&vf->cfg_lock);
 	}
 
 	if (ice_sriov_free_msix_res(pf))

base-commit: 81003a1453e724321ed9cc9f75fb92d74884c413
-- 
2.35.1.129.gb80121027d12

