From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 18 Apr 2018 11:23:27 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Set rq_last_status when cleaning rq
Message-ID: <20180418182327.31854-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Shaw <jeffrey.b.shaw@intel.com>

Prior to this commit, the rq_last_status was only set when hardware
responded with an error. This leads to rq_last_status being invalid
in the future when hardware eventually responds without error. This
commit resolves the issue by unconditionally setting rq_last_status
with the value returned in the descriptor.

Fixes: 940b61af02f4 ("ice: Initialize PF and setup miscellaneous
interrupt")

Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 5909a4407e38..7c511f144ed6 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1014,10 +1014,10 @@ ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	desc = ICE_CTL_Q_DESC(cq->rq, ntc);
 	desc_idx = ntc;
 
+	cq->rq_last_status = (enum ice_aq_err)le16_to_cpu(desc->retval);
 	flags = le16_to_cpu(desc->flags);
 	if (flags & ICE_AQ_FLAG_ERR) {
 		ret_code = ICE_ERR_AQ_ERROR;
-		cq->rq_last_status = (enum ice_aq_err)le16_to_cpu(desc->retval);
 		ice_debug(hw, ICE_DBG_AQ_MSG,
 			  "Control Receive Queue Event received with error 0x%x\n",
 			  cq->rq_last_status);
-- 
2.14.3

