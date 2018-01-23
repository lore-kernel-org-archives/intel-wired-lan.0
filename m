From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Tue, 23 Jan 2018 08:51:00 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 06/12] i40e: Delete queue
 channel for ADq on VF
In-Reply-To: <20180123165106.28900-1-avinash.dayanand@intel.com>
References: <20180123165106.28900-1-avinash.dayanand@intel.com>
Message-ID: <20180123165106.28900-7-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch takes care of freeing up all the VSIs, queues and
other ADq related software and hardware resources, when a user
requests for deletion of ADq on VF.

Example command:
tc qdisc del dev eth0 root

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7d939a5..0c1c699 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1673,6 +1673,27 @@ static int i40e_vc_get_version_msg(struct i40e_vf *vf, u8 *msg)
 }
 
 /**
+ * i40e_del_qch - delete all the additional VSI's created as a part of ADq
+ * @vf: pointer to VF structure
+ **/
+static void i40e_del_qch(struct i40e_vf *vf)
+{
+	struct i40e_pf *pf = vf->pf;
+	int i;
+
+	/* first element in the array belongs to primary VF VSI and we shouldn't
+	 * delete it. we should however delete the rest of the VSIs created
+	 */
+	for (i = 1; i < vf->num_tc; i++) {
+		if (vf->ch[i].vsi_idx) {
+			i40e_vsi_release(pf->vsi[vf->ch[i].vsi_idx]);
+			vf->ch[i].vsi_idx = 0;
+			vf->ch[i].vsi_id = 0;
+		}
+	}
+}
+
+/**
  * i40e_vc_get_vf_resources_msg
  * @vf: pointer to the VF info
  * @msg: pointer to the msg buffer
@@ -2979,6 +3000,45 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 }
 
 /**
+ * i40e_vc_del_qch_msg
+ * @vf: pointer to the VF info
+ * @msg: pointer to the msg buffer
+ **/
+static int i40e_vc_del_qch_msg(struct i40e_vf *vf, u8 *msg)
+{
+	struct i40e_pf *pf = vf->pf;
+	i40e_status aq_ret = 0;
+
+	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+		aq_ret = I40E_ERR_PARAM;
+		goto err;
+	}
+
+	if (vf->adq_enabled) {
+		i40e_del_qch(vf);
+		vf->adq_enabled = false;
+		vf->num_tc = 0;
+		dev_info(&pf->pdev->dev,
+			 "Deleting Queue Channels for ADq on VF %d\n",
+			 vf->vf_id);
+	} else {
+		dev_info(&pf->pdev->dev, "VF %d trying to delete queue channels but ADq isn't enabled\n",
+			 vf->vf_id);
+		aq_ret = I40E_ERR_PARAM;
+	}
+
+	/* reset the VF in order to allocate resources */
+	i40e_vc_notify_vf_reset(vf);
+	i40e_reset_vf(vf, false);
+
+	return I40E_SUCCESS;
+
+err:
+	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DISABLE_CHANNELS,
+				       aq_ret);
+}
+
+/**
  * i40e_vc_process_vf_msg
  * @pf: pointer to the PF structure
  * @vf_id: source VF id
@@ -3110,6 +3170,9 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 	case VIRTCHNL_OP_ENABLE_CHANNELS:
 		ret = i40e_vc_add_qch_msg(vf, msg);
 		break;
+	case VIRTCHNL_OP_DISABLE_CHANNELS:
+		ret = i40e_vc_del_qch_msg(vf, msg);
+		break;
 	case VIRTCHNL_OP_UNKNOWN:
 	default:
 		dev_err(&pf->pdev->dev, "Unsupported opcode %d from VF %d\n",
-- 
2.9.4

