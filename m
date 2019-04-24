From: Alice Michael <alice.michael@intel.com>
Date: Wed, 24 Apr 2019 05:20:51 -0700
Subject: [Intel-wired-lan] [next PATCH S5 06/10] i40e: add input validation
 for virtchnl handlers
In-Reply-To: <20190424122055.27896-1-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
Message-ID: <20190424122055.27896-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sergey Nemov <sergey.nemov@intel.com>

Change some data to unsigned int instead of integer when we compare.

Check LUT values in VIRTCHNL_OP_CONFIG_RSS_LUT handler.

Also enhance error/warning messages to print the real values of
I40E_MAX_VF_QUEUES, I40E_MAX_VF_VSI and I40E_DEFAULT_QUEUES_PER_VF
instead of plain text.

Refactor code to comply with 'check first then assign' policy.

Remove duplicate checks for VIRTCHNL_OP_CONFIG_RSS_KEY and
VIRTCHNL_OP_CONFIG_RSS_LUT opcodes in i40e_vc_process_vf_msg(). We have
the very same checks inside the handlers already.

Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 74 ++++++++-----------
 1 file changed, 31 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4061da6c9dcb..4f4521d39725 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -470,14 +470,15 @@ static int i40e_config_iwarp_qvlist(struct i40e_vf *vf,
 		qv_info = &qvlist_info->qv_info[i];
 		if (!qv_info)
 			continue;
-		v_idx = qv_info->v_idx;
 
 		/* Validate vector id belongs to this vf */
-		if (!i40e_vc_isvalid_vector_id(vf, v_idx)) {
+		if (!i40e_vc_isvalid_vector_id(vf, qv_info->v_idx)) {
 			ret = -EINVAL;
 			goto err_free;
 		}
 
+		v_idx = qv_info->v_idx;
+
 		vf->qvlist_info->qv_info[i] = *qv_info;
 
 		reg_idx = ((msix_vf - 1) * vf->vf_id) + (v_idx - 1);
@@ -2327,7 +2328,6 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_queue_select *vqs =
 	    (struct virtchnl_queue_select *)msg;
 	struct i40e_pf *pf = vf->pf;
-	u16 vsi_id = vqs->vsi_id;
 	i40e_status aq_ret = 0;
 	int i;
 
@@ -2336,7 +2336,7 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
+	if (!i40e_vc_isvalid_vsi_id(vf, vqs->vsi_id)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2436,18 +2436,14 @@ static int i40e_vc_request_queues_msg(struct i40e_vf *vf, u8 *msg)
 {
 	struct virtchnl_vf_res_request *vfres =
 		(struct virtchnl_vf_res_request *)msg;
-	int req_pairs = vfres->num_queue_pairs;
-	int cur_pairs = vf->num_queue_pairs;
+	u16 req_pairs = vfres->num_queue_pairs;
+	u8 cur_pairs = vf->num_queue_pairs;
 	struct i40e_pf *pf = vf->pf;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states))
 		return -EINVAL;
 
-	if (req_pairs <= 0) {
-		dev_err(&pf->pdev->dev,
-			"VF %d tried to request %d queues.  Ignoring.\n",
-			vf->vf_id, req_pairs);
-	} else if (req_pairs > I40E_MAX_VF_QUEUES) {
+	if (req_pairs > I40E_MAX_VF_QUEUES) {
 		dev_err(&pf->pdev->dev,
 			"VF %d tried to request more than %d queues.\n",
 			vf->vf_id,
@@ -2596,12 +2592,11 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 	    (struct virtchnl_ether_addr_list *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	u16 vsi_id = al->vsi_id;
 	i40e_status ret = 0;
 	int i;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
-	    !i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
+	    !i40e_vc_isvalid_vsi_id(vf, al->vsi_id)) {
 		ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2666,12 +2661,11 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 	    (struct virtchnl_ether_addr_list *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	u16 vsi_id = al->vsi_id;
 	i40e_status ret = 0;
 	int i;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
-	    !i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
+	    !i40e_vc_isvalid_vsi_id(vf, al->vsi_id)) {
 		ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2735,7 +2729,6 @@ static int i40e_vc_add_vlan_msg(struct i40e_vf *vf, u8 *msg)
 	    (struct virtchnl_vlan_filter_list *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	u16 vsi_id = vfl->vsi_id;
 	i40e_status aq_ret = 0;
 	int i;
 
@@ -2746,7 +2739,7 @@ static int i40e_vc_add_vlan_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
-	    !i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
+	    !i40e_vc_isvalid_vsi_id(vf, vfl->vsi_id)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2807,12 +2800,11 @@ static int i40e_vc_remove_vlan_msg(struct i40e_vf *vf, u8 *msg)
 	    (struct virtchnl_vlan_filter_list *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	u16 vsi_id = vfl->vsi_id;
 	i40e_status aq_ret = 0;
 	int i;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
-	    !i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
+	    !i40e_vc_isvalid_vsi_id(vf, vfl->vsi_id)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2929,11 +2921,10 @@ static int i40e_vc_config_rss_key(struct i40e_vf *vf, u8 *msg)
 		(struct virtchnl_rss_key *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	u16 vsi_id = vrk->vsi_id;
 	i40e_status aq_ret = 0;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
-	    !i40e_vc_isvalid_vsi_id(vf, vsi_id) ||
+	    !i40e_vc_isvalid_vsi_id(vf, vrk->vsi_id) ||
 	    (vrk->key_len != I40E_HKEY_ARRAY_SIZE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
@@ -2960,16 +2951,22 @@ static int i40e_vc_config_rss_lut(struct i40e_vf *vf, u8 *msg)
 		(struct virtchnl_rss_lut *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
-	u16 vsi_id = vrl->vsi_id;
 	i40e_status aq_ret = 0;
+	u16 i;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
-	    !i40e_vc_isvalid_vsi_id(vf, vsi_id) ||
+	    !i40e_vc_isvalid_vsi_id(vf, vrl->vsi_id) ||
 	    (vrl->lut_entries != I40E_VF_HLUT_ARRAY_SIZE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
 
+	for (i = 0; i < vrl->lut_entries; i++)
+		if (vrl->lut[i] >= vf->num_queue_pairs) {
+			aq_ret = I40E_ERR_PARAM;
+			goto err;
+		}
+
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	aq_ret = i40e_config_rss(vsi, NULL, vrl->lut, I40E_VF_HLUT_ARRAY_SIZE);
 	/* send the response to the VF */
@@ -3050,14 +3047,15 @@ static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg)
  **/
 static int i40e_vc_enable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
 {
-	struct i40e_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
 	i40e_status aq_ret = 0;
+	struct i40e_vsi *vsi;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
 
+	vsi = vf->pf->vsi[vf->lan_vsi_idx];
 	i40e_vlan_stripping_enable(vsi);
 
 	/* send the response to the VF */
@@ -3075,14 +3073,15 @@ static int i40e_vc_enable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
  **/
 static int i40e_vc_disable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
 {
-	struct i40e_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
 	i40e_status aq_ret = 0;
+	struct i40e_vsi *vsi;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
 
+	vsi = vf->pf->vsi[vf->lan_vsi_idx];
 	i40e_vlan_stripping_disable(vsi);
 
 	/* send the response to the VF */
@@ -3540,8 +3539,9 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 		(struct virtchnl_tc_info *)msg;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_link_status *ls = &pf->hw.phy.link_info;
-	int i, adq_request_qps = 0, speed = 0;
+	int i, adq_request_qps = 0;
 	i40e_status aq_ret = 0;
+	u64 speed = 0;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
@@ -3567,8 +3567,8 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 	/* max number of traffic classes for VF currently capped at 4 */
 	if (!tci->num_tc || tci->num_tc > I40E_MAX_VF_VSI) {
 		dev_err(&pf->pdev->dev,
-			"VF %d trying to set %u TCs, valid range 1-4 TCs per VF\n",
-			vf->vf_id, tci->num_tc);
+			"VF %d trying to set %u TCs, valid range 1-%u TCs per VF\n",
+			vf->vf_id, tci->num_tc, I40E_MAX_VF_VSI);
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3578,8 +3578,9 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 		if (!tci->list[i].count ||
 		    tci->list[i].count > I40E_DEFAULT_QUEUES_PER_VF) {
 			dev_err(&pf->pdev->dev,
-				"VF %d: TC %d trying to set %u queues, valid range 1-4 queues per TC\n",
-				vf->vf_id, i, tci->list[i].count);
+				"VF %d: TC %d trying to set %u queues, valid range 1-%u queues per TC\n",
+				vf->vf_id, i, tci->list[i].count,
+				I40E_DEFAULT_QUEUES_PER_VF);
 			aq_ret = I40E_ERR_PARAM;
 			goto err;
 		}
@@ -3739,19 +3740,6 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 	/* perform basic checks on the msg */
 	ret = virtchnl_vc_validate_vf_msg(&vf->vf_ver, v_opcode, msg, msglen);
 
-	/* perform additional checks specific to this driver */
-	if (v_opcode == VIRTCHNL_OP_CONFIG_RSS_KEY) {
-		struct virtchnl_rss_key *vrk = (struct virtchnl_rss_key *)msg;
-
-		if (vrk->key_len != I40E_HKEY_ARRAY_SIZE)
-			ret = -EINVAL;
-	} else if (v_opcode == VIRTCHNL_OP_CONFIG_RSS_LUT) {
-		struct virtchnl_rss_lut *vrl = (struct virtchnl_rss_lut *)msg;
-
-		if (vrl->lut_entries != I40E_VF_HLUT_ARRAY_SIZE)
-			ret = -EINVAL;
-	}
-
 	if (ret) {
 		i40e_vc_send_resp_to_vf(vf, v_opcode, I40E_ERR_PARAM);
 		dev_err(&pf->pdev->dev, "Invalid message from VF %d, opcode %d, len %d\n",
-- 
2.19.2

