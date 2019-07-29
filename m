From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 29 Jul 2019 02:04:51 -0700
Subject: [Intel-wired-lan] [PATCH S24 v2 09/12] ice: silence some bogus
 error messages
In-Reply-To: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
Message-ID: <20190729090454.5501-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In some circumstances, VF devices can be deactivated while a message is
in-flight. In that case, a series of  scary error message will be
printed in the log. Since these are actually harmless, check for this
case and suppress them. No harm, no foul.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  | 1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 765e3c2ed045..01ef2f290c5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1610,6 +1610,7 @@ enum ice_aq_err {
 	ICE_AQ_RC_EBUSY		= 12, /* Device or resource busy */
 	ICE_AQ_RC_EEXIST	= 13, /* Object already exists */
 	ICE_AQ_RC_ENOSPC	= 16, /* No space left or allocation failure */
+	ICE_AQ_RC_ENOSYS        = 17, /* Function not implemented */
 };
 
 /* Admin Queue command opcodes */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 73ab6222d29b..83e58e71081e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1512,10 +1512,10 @@ ice_vc_send_msg_to_vf(struct ice_vf *vf, u32 v_opcode,
 
 	aq_ret = ice_aq_send_msg_to_vf(&pf->hw, vf->vf_id, v_opcode, v_retval,
 				       msg, msglen, NULL);
-	if (aq_ret) {
+	if (aq_ret && pf->hw.mailboxq.sq_last_status != ICE_AQ_RC_ENOSYS) {
 		dev_info(&pf->pdev->dev,
-			 "Unable to send the message to VF %d aq_err %d\n",
-			 vf->vf_id, pf->hw.mailboxq.sq_last_status);
+			 "Unable to send the message to VF %d ret %d aq_err %d\n",
+			 vf->vf_id, aq_ret, pf->hw.mailboxq.sq_last_status);
 		return -EIO;
 	}
 
-- 
2.20.1

