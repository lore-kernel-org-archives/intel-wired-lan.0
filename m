From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jun 2019 02:20:26 -0700
Subject: [Intel-wired-lan] [PATCH S22 15/16] ice: Remove flag to track VF
 interrupt status
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <20190626092027.52845-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

As a result of refactoring of VF VSIs interrupts code, there is no
need to track its configuration status again with ICE_VF_STATE_CFG_INTR
flag - In fact, it is not being checked anywhere in the code right now, so
this patch removes the dead code as applicable to the flag.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 -----------
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  5 -----
 2 files changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index c26f379713a4..a3849ed283eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -297,13 +297,6 @@ void ice_free_vfs(struct ice_pf *pf)
 		if (test_bit(ICE_VF_STATE_INIT, pf->vf[i].vf_states)) {
 			/* disable VF qp mappings */
 			ice_dis_vf_mappings(&pf->vf[i]);
-
-			/* Set this state so that assigned VF vectors can be
-			 * reclaimed by PF for reuse in ice_vsi_release(). No
-			 * need to clear this bit since pf->vf array is being
-			 * freed anyways after this for loop
-			 */
-			set_bit(ICE_VF_STATE_CFG_INTR, pf->vf[i].vf_states);
 			ice_free_vf_res(&pf->vf[i]);
 		}
 	}
@@ -551,7 +544,6 @@ static int ice_alloc_vsi_res(struct ice_vf *vf)
 	 * expect vector assignment to be changed unless there is a request for
 	 * more vectors.
 	 */
-	clear_bit(ICE_VF_STATE_CFG_INTR, vf->vf_states);
 ice_alloc_vsi_res_exit:
 	ice_free_fltr_list(&pf->pdev->dev, &tmp_add_list);
 	return status;
@@ -1283,9 +1275,6 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
 		/* assign default capabilities */
 		set_bit(ICE_VIRTCHNL_VF_CAP_L2, &vfs[i].vf_caps);
 		vfs[i].spoofchk = true;
-
-		/* Set this state so that PF driver does VF vector assignment */
-		set_bit(ICE_VF_STATE_CFG_INTR, vfs[i].vf_states);
 	}
 	pf->num_alloc_vfs = num_alloc_vfs;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index c3ca522c245a..ada69120ff38 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -30,11 +30,6 @@ enum ice_vf_states {
 	ICE_VF_STATE_DIS,
 	ICE_VF_STATE_MC_PROMISC,
 	ICE_VF_STATE_UC_PROMISC,
-	/* state to indicate if PF needs to do vector assignment for VF.
-	 * This needs to be set during first time VF initialization or later
-	 * when VF asks for more Vectors through virtchnl OP.
-	 */
-	ICE_VF_STATE_CFG_INTR,
 	ICE_VF_STATES_NBITS
 };
 
-- 
2.20.1

