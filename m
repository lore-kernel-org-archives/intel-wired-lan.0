From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  6 Nov 2019 02:05:34 -0800
Subject: [Intel-wired-lan] [PATCH S32 v3 08/15] ice: Change max MSI-x
 vector_id check in cfg_irq_map
In-Reply-To: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
Message-ID: <20191106100541.48639-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we check to make sure the vector_id passed down from iavf
is less than or equal to pf->hw.func_caps.common_caps.num_msix_vectors.
This is incorrect because the vector_id is always 0-based and never
greater than or equal to the ICE_MAX_INTR_PER_VF. Fix this by checking
to make sure the vector_id is less than the max allowed interrupts per
VF (ICE_MAX_INTR_PER_VF).

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 537377448bef..eb526144a237 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2179,9 +2179,11 @@ static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
 
 		vector_id = map->vector_id;
 		vsi_id = map->vsi_id;
-		/* validate msg params */
-		if (!(vector_id < pf->hw.func_caps.common_cap
-		    .num_msix_vectors) || !ice_vc_isvalid_vsi_id(vf, vsi_id) ||
+		/* vector_id is always 0-based for each VF, and can never be
+		 * larger than or equal to the max allowed interrupts per VF
+		 */
+		if (!(vector_id < ICE_MAX_INTR_PER_VF) ||
+		    !ice_vc_isvalid_vsi_id(vf, vsi_id) ||
 		    (!vector_id && (map->rxq_map || map->txq_map))) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
-- 
2.20.1

