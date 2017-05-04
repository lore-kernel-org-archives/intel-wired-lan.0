From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed,  3 May 2017 19:51:49 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 05/13] virtchnl: move some
	code to core driver
In-Reply-To: <20170504025157.71107-1-jeffrey.t.kirsher@intel.com>
References: <20170504025157.71107-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170504025157.71107-6-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Before moving this function over to virtchnl.h, move
some driver specific checks that had snuck into a fairly
generic function, back into the caller of the function.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 27b1174..63dcc61 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2549,10 +2549,6 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
 	bool err_msg_format = false;
 	int valid_len = 0;
 
-	/* Check if VF is disabled. */
-	if (test_bit(I40E_VF_STATE_DISABLED, &vf->vf_states))
-		return I40E_ERR_PARAM;
-
 	/* Validate message length. */
 	switch (v_opcode) {
 	case VIRTCHNL_OP_VERSION:
@@ -2657,10 +2653,6 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_rss_key *vrk =
 				(struct virtchnl_rss_key *)msg;
-			if (vrk->key_len != I40E_HKEY_ARRAY_SIZE) {
-				err_msg_format = true;
-				break;
-			}
 			valid_len += vrk->key_len - 1;
 		}
 		break;
@@ -2669,10 +2661,6 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_rss_lut *vrl =
 				(struct virtchnl_rss_lut *)msg;
-			if (vrl->lut_entries != I40E_VF_HLUT_ARRAY_SIZE) {
-				err_msg_format = true;
-				break;
-			}
 			valid_len += vrl->lut_entries - 1;
 		}
 		break;
@@ -2719,9 +2707,27 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 	if (local_vf_id >= pf->num_alloc_vfs)
 		return -EINVAL;
 	vf = &(pf->vf[local_vf_id]);
+
+	/* Check if VF is disabled. */
+	if (test_bit(I40E_VF_STATE_DISABLED, &vf->vf_states))
+		return I40E_ERR_PARAM;
+
 	/* perform basic checks on the msg */
 	ret = i40e_vc_validate_vf_msg(vf, v_opcode, v_retval, msg, msglen);
 
+	/* perform additional checks specific to this driver */
+	if (v_opcode == VIRTCHNL_OP_CONFIG_RSS_KEY) {
+		struct virtchnl_rss_key *vrk = (struct virtchnl_rss_key *)msg;
+
+		if (vrk->key_len != I40E_HKEY_ARRAY_SIZE)
+			ret = -EINVAL;
+	} else if (v_opcode == VIRTCHNL_OP_CONFIG_RSS_LUT) {
+		struct virtchnl_rss_lut *vrl = (struct virtchnl_rss_lut *)msg;
+
+		if (vrl->lut_entries != I40E_VF_HLUT_ARRAY_SIZE)
+			ret = -EINVAL;
+	}
+
 	if (ret) {
 		dev_err(&pf->pdev->dev, "Invalid message from VF %d, opcode %d, len %d\n",
 			local_vf_id, v_opcode, msglen);
-- 
1.8.3.1

