From: Karen Sornek <karen.sornek@intel.com>
Date: Fri, 14 May 2021 11:43:13 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix failed opcode appearing
 if handling messages from VF
Message-ID: <20210514094313.133485-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix failed operation code appearing if handling messages from VF.
Implemented by waiting for VF appropriate state if request starts
handle while VF reset.
Without this patch the message handling request while VF is in
a reset state ends with error -5 (I40E_ERR_PARAM).

Fixes: 6322e63c35d6 ("i40e: properly spell I40E_VF_STATE_* flags")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 70 +++++++++++++------
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  2 +
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 139562aaf..5af16d209 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1960,6 +1960,32 @@ static int i40e_vc_send_resp_to_vf(struct i40e_vf *vf,
 	return i40e_vc_send_msg_to_vf(vf, opcode, retval, NULL, 0);
 }
 
+/**
+ * i40e_sync_vf_state
+ * @vf: pointer to the VF info
+ * @state: VF state
+ *
+ * Called from a VF message to synchronize the service with a potential
+ * VF reset state
+ **/
+static bool i40e_sync_vf_state(struct i40e_vf *vf, enum i40e_vf_states state)
+{
+	int i;
+
+	/* When handling some messages, it needs vf state to be set.
+	 * It is possible that this flag is cleared during vf reset,
+	 * so there is a need to wait until the end of the reset to
+	 * handle the request message correctly.
+	 */
+	for (i = 0; i < I40E_VF_STATE_WAIT_COUNT; i++) {
+		if (test_bit(state, &vf->vf_states))
+			return true;
+		usleep_range(10000, 20000);
+	}
+
+	return test_bit(state, &vf->vf_states);
+}
+
 /**
  * i40e_vc_get_version_msg
  * @vf: pointer to the VF info
@@ -2020,7 +2046,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	size_t len = 0;
 	int ret;
 
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_INIT)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -2157,7 +2183,7 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf, u8 *msg)
 	bool allmulti = false;
 	bool alluni = false;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err_out;
 	}
@@ -2244,7 +2270,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	int i, j = 0, idx = 0;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2387,7 +2413,7 @@ static int i40e_vc_config_irq_map_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	int i;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2559,7 +2585,7 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg)
 	struct i40e_pf *pf = vf->pf;
 	i40e_status aq_ret = 0;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2609,7 +2635,7 @@ static int i40e_vc_request_queues_msg(struct i40e_vf *vf, u8 *msg)
 	u8 cur_pairs = vf->num_queue_pairs;
 	struct i40e_pf *pf = vf->pf;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states))
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE))
 		return -EINVAL;
 
 	if (req_pairs > I40E_MAX_VF_QUEUES) {
@@ -2655,7 +2681,7 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 
 	memset(&stats, 0, sizeof(struct i40e_eth_stats));
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2780,7 +2806,7 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status ret = 0;
 	int i;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
 	    !i40e_vc_isvalid_vsi_id(vf, al->vsi_id)) {
 		ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -2852,7 +2878,7 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status ret = 0;
 	int i;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
 	    !i40e_vc_isvalid_vsi_id(vf, al->vsi_id)) {
 		ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -2996,7 +3022,7 @@ static int i40e_vc_remove_vlan_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	int i;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vfl->vsi_id)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -3116,9 +3142,9 @@ static int i40e_vc_config_rss_key(struct i40e_vf *vf, u8 *msg)
 	struct i40e_vsi *vsi = NULL;
 	i40e_status aq_ret = 0;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vrk->vsi_id) ||
-	    (vrk->key_len != I40E_HKEY_ARRAY_SIZE)) {
+	    vrk->key_len != I40E_HKEY_ARRAY_SIZE) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3147,9 +3173,9 @@ static int i40e_vc_config_rss_lut(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	u16 i;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vrl->vsi_id) ||
-	    (vrl->lut_entries != I40E_VF_HLUT_ARRAY_SIZE)) {
+	    vrl->lut_entries != I40E_VF_HLUT_ARRAY_SIZE) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3182,7 +3208,7 @@ static int i40e_vc_get_rss_hena(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	int len = 0;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3218,7 +3244,7 @@ static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg)
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status aq_ret = 0;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3243,7 +3269,7 @@ static int i40e_vc_enable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	struct i40e_vsi *vsi;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3269,7 +3295,7 @@ static int i40e_vc_disable_vlan_stripping(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	struct i40e_vsi *vsi;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3496,7 +3522,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	int i, ret;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3627,7 +3653,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	int i, ret;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err_out;
 	}
@@ -3736,7 +3762,7 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	u64 speed = 0;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -3853,7 +3879,7 @@ static int i40e_vc_del_qch_msg(struct i40e_vf *vf, u8 *msg)
 	struct i40e_pf *pf = vf->pf;
 	i40e_status aq_ret = 0;
 
-	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 091e32c1b..49575a640 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -18,6 +18,8 @@
 
 #define I40E_MAX_VF_PROMISC_FLAGS	3
 
+#define I40E_VF_STATE_WAIT_COUNT	20
+
 /* Various queue ctrls */
 enum i40e_queue_ctrl {
 	I40E_QUEUE_CTRL_UNKNOWN = 0,
-- 
2.27.0

