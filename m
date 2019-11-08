From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  8 Nov 2019 06:23:22 -0800
Subject: [Intel-wired-lan] [PATCH S33 06/15] ice: Only disable VF state when
 freeing each VF resources
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <20191108142331.10221-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

It is wrong to set PF disable state flag for all VFs when freeing VF
resources - Instead, we should set VF disable state flag for each VF with
its resources being returned to the device. Right now, all VF opcodes,
mailbox communication to clear its resources as well fails - since we
already indicate that PF is in disable state, with all VFs not active. In
addition, we don't need to notify VF that PF is intending to reset it, if
it is already in disabled state.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f8d26674cf5a..869111a45d61 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -318,8 +318,9 @@ void ice_free_vfs(struct ice_pf *pf)
 	pf->num_alloc_vfs = 0;
 	for (i = 0; i < tmp; i++) {
 		if (test_bit(ICE_VF_STATE_INIT, pf->vf[i].vf_states)) {
-			/* disable VF qp mappings */
+			/* disable VF qp mappings and set VF disable state */
 			ice_dis_vf_mappings(&pf->vf[i]);
+			set_bit(ICE_VF_STATE_DIS, pf->vf[i].vf_states);
 			ice_free_vf_res(&pf->vf[i]);
 		}
 	}
@@ -1303,9 +1304,12 @@ static void ice_vc_notify_vf_reset(struct ice_vf *vf)
 	if (!vf || vf->vf_id >= vf->pf->num_alloc_vfs)
 		return;
 
-	/* verify if the VF is in either init or active before proceeding */
-	if (!test_bit(ICE_VF_STATE_INIT, vf->vf_states) &&
-	    !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+	/* Bail out if VF is in disabled state, neither initialized, nor active
+	 * state - otherwise proceed with notifications
+	 */
+	if ((!test_bit(ICE_VF_STATE_INIT, vf->vf_states) &&
+	     !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) ||
+	    test_bit(ICE_VF_STATE_DIS, vf->vf_states))
 		return;
 
 	pfe.event = VIRTCHNL_EVENT_RESET_IMPENDING;
-- 
2.20.1

