From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:27 -0700
Subject: [Intel-wired-lan] [next PATCH S34 07/12] i40e: Fix uninitialized
	variable
In-Reply-To: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460542112-20166-8-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

We have an uninitialized variable warning for valid_len for one case in
validate_vf_mesg. To fix this, just initialize it to 0 at the top of the
function and remove all of the now redundant assignments to 0 in the
individual cases.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-Id: Iacbd97f4c521ed8d662eef803a598d8707708cfd
---
Testing Hints: Should net no functional change - make sure nothing
broke.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 747cb28..4f0214e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2356,7 +2356,7 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
 				   u32 v_retval, u8 *msg, u16 msglen)
 {
 	bool err_msg_format = false;
-	int valid_len;
+	int valid_len = 0;
 
 	/* Check if VF is disabled. */
 	if (test_bit(I40E_VF_STAT_DISABLED, &vf->vf_states))
@@ -2368,13 +2368,10 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
 		valid_len = sizeof(struct i40e_virtchnl_version_info);
 		break;
 	case I40E_VIRTCHNL_OP_RESET_VF:
-		valid_len = 0;
 		break;
 	case I40E_VIRTCHNL_OP_GET_VF_RESOURCES:
 		if (VF_IS_V11(vf))
 			valid_len = sizeof(u32);
-		else
-			valid_len = 0;
 		break;
 	case I40E_VIRTCHNL_OP_CONFIG_TX_QUEUE:
 		valid_len = sizeof(struct i40e_virtchnl_txq_info);
@@ -2489,7 +2486,6 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
 		}
 		break;
 	case I40E_VIRTCHNL_OP_GET_RSS_HENA_CAPS:
-		valid_len = 0;
 		break;
 	case I40E_VIRTCHNL_OP_SET_RSS_HENA:
 		valid_len = sizeof(struct i40e_virtchnl_rss_hena);
-- 
2.4.3

