From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:55:01 -0700
Subject: [Intel-wired-lan] [PATCH S46 4/9] ice: Allow VF to request reset as
 soon as it's initialized
In-Reply-To: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005506.5113-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

A VF driver has the ability to request reset via VIRTCHNL_OP_RESET_VF.
This is a required step in VF driver load. Currently, the PF is only
allowing a VF to request reset using this method after the VF has
already communicated resources via VIRTCHNL_OP_GET_VF_RESOURCES.
However, this is incorrect because the VF can request reset before
requesting resources. Fix this by allowing the VF to request a reset
once it has been initialized.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 0ca614fa97bb..48ab7d89729e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1989,7 +1989,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
  */
 static void ice_vc_reset_vf_msg(struct ice_vf *vf)
 {
-	if (test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+	if (test_bit(ICE_VF_STATE_INIT, vf->vf_states))
 		ice_reset_vf(vf, false);
 }
 
-- 
2.20.1

