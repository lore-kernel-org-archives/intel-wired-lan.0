From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 26 Oct 2015 19:44:37 -0400
Subject: [Intel-wired-lan] [next PATCH S20 11/15] i40e: make error message
	more useful
In-Reply-To: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445903081-155893-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If we get an invalid message from a VF, we should tell the user which VF
is being naughty, rather than making them guess.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I9252cef7baea3d8584043ed6ff12619a94e2f99c

---
Testing-hints: It is difficult to reproduce the error so just make sure
it compiles.
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9c54ca2..26f247d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1094,8 +1094,8 @@ static int i40e_vc_send_msg_to_vf(struct i40e_vf *vf, u32 v_opcode,
 	/* single place to detect unsuccessful return values */
 	if (v_retval) {
 		vf->num_invalid_msgs++;
-		dev_err(&pf->pdev->dev, "Failed opcode %d Error: %d\n",
-			v_opcode, v_retval);
+		dev_err(&pf->pdev->dev, "VF %d failed opcode %d, error: %d\n",
+			vf->vf_id, v_opcode, v_retval);
 		if (vf->num_invalid_msgs >
 		    I40E_DEFAULT_NUM_INVALID_MSGS_ALLOWED) {
 			dev_err(&pf->pdev->dev,
-- 
1.9.3

