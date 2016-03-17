From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 17 Mar 2016 09:41:28 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v3 10/12] i40e: Lower some
	message levels
In-Reply-To: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
References: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458232890-110933-11-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

These conditions can happen any time VFs are enabled or disabled and are
not really indicative of fatal problems unless they happen continuously.

Lower the log level so that people don't get scared.

Testing Hints: Enable and disable lots of VFs until
you see the messages. Note the log level.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 66763c1..f93a649 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1103,8 +1103,8 @@ static int i40e_vc_send_msg_to_vf(struct i40e_vf *vf, u32 v_opcode,
 	/* single place to detect unsuccessful return values */
 	if (v_retval) {
 		vf->num_invalid_msgs++;
-		dev_err(&pf->pdev->dev, "VF %d failed opcode %d, error: %d\n",
-			vf->vf_id, v_opcode, v_retval);
+		dev_info(&pf->pdev->dev, "VF %d failed opcode %d, retval: %d\n",
+			 vf->vf_id, v_opcode, v_retval);
 		if (vf->num_invalid_msgs >
 		    I40E_DEFAULT_NUM_INVALID_MSGS_ALLOWED) {
 			dev_err(&pf->pdev->dev,
@@ -1122,9 +1122,9 @@ static int i40e_vc_send_msg_to_vf(struct i40e_vf *vf, u32 v_opcode,
 	aq_ret = i40e_aq_send_msg_to_vf(hw, abs_vf_id,	v_opcode, v_retval,
 					msg, msglen, NULL);
 	if (aq_ret) {
-		dev_err(&pf->pdev->dev,
-			"Unable to send the message to VF %d aq_err %d\n",
-			vf->vf_id, pf->hw.aq.asq_last_status);
+		dev_info(&pf->pdev->dev,
+			 "Unable to send the message to VF %d aq_err %d\n",
+			 vf->vf_id, pf->hw.aq.asq_last_status);
 		return -EIO;
 	}
 
-- 
2.4.3

