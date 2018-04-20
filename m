From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Apr 2018 01:41:39 -0700
Subject: [Intel-wired-lan] [next PATCH S90 7/8] i40e/i40evf: take into
 account queue map from vf when handling queues
In-Reply-To: <20180420084140.8081-1-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
Message-ID: <20180420084140.8081-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

The expectation of the ops VIRTCHNL_OP_ENABLE_QUEUES and
VIRTCHNL_OP_DISABLE_QUEUES is that the queue map sent by
the VF is taken into account when enabling/disabling
queues in the VF VSI. This patch makes sure that happens.

By breaking out the individual queue set up functions so
that they can be called directly from the i40e_virtchnl_pf.c
file, only the queues as specified by the queue bit map that
accompanies the enable/disable queues ops will be handled.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h             |  3 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 40 +++++++++----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 69 +++++++++++++++++++++-
 3 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1d59ab6..7a80652 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -987,6 +987,9 @@ void i40e_service_event_schedule(struct i40e_pf *pf);
 void i40e_notify_client_of_vf_msg(struct i40e_vsi *vsi, u32 vf_id,
 				  u8 *msg, u16 len);
 
+int i40e_control_wait_tx_q(int seid, struct i40e_pf *pf, int pf_q, bool is_xdp,
+			   bool enable);
+int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable);
 int i40e_vsi_start_rings(struct i40e_vsi *vsi);
 void i40e_vsi_stop_rings(struct i40e_vsi *vsi);
 void i40e_vsi_stop_rings_no_wait(struct  i40e_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0babde1..b500bbf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4235,8 +4235,8 @@ static void i40e_control_tx_q(struct i40e_pf *pf, int pf_q, bool enable)
  * @is_xdp: true if the queue is used for XDP
  * @enable: start or stop the queue
  **/
-static int i40e_control_wait_tx_q(int seid, struct i40e_pf *pf, int pf_q,
-				  bool is_xdp, bool enable)
+int i40e_control_wait_tx_q(int seid, struct i40e_pf *pf, int pf_q,
+			   bool is_xdp, bool enable)
 {
 	int ret;
 
@@ -4281,7 +4281,6 @@ static int i40e_vsi_control_tx(struct i40e_vsi *vsi, bool enable)
 		if (ret)
 			break;
 	}
-
 	return ret;
 }
 
@@ -4320,9 +4319,9 @@ static int i40e_pf_rxq_wait(struct i40e_pf *pf, int pf_q, bool enable)
  * @pf_q: the PF queue to configure
  * @enable: start or stop the queue
  *
- * This function enables or disables a single queue. Note that any delay
- * required after the operation is expected to be handled by the caller of
- * this function.
+ * This function enables or disables a single queue. Note that
+ * any delay required after the operation is expected to be
+ * handled by the caller of this function.
  **/
 static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
 {
@@ -4352,6 +4351,30 @@ static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
 }
 
 /**
+ * i40e_control_wait_rx_q
+ * @pf: the PF structure
+ * @pf_q: queue being configured
+ * @enable: start or stop the rings
+ *
+ * This function enables or disables a single queue along with waiting
+ * for the change to finish. The caller of this function should handle
+ * the delays needed in the case of disabling queues.
+ **/
+int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
+{
+	int ret = 0;
+
+	i40e_control_rx_q(pf, pf_q, enable);
+
+	/* wait for the change to finish */
+	ret = i40e_pf_rxq_wait(pf, pf_q, enable);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+/**
  * i40e_vsi_control_rx - Start or stop a VSI's rings
  * @vsi: the VSI being configured
  * @enable: start or stop the rings
@@ -4363,10 +4386,7 @@ static int i40e_vsi_control_rx(struct i40e_vsi *vsi, bool enable)
 
 	pf_q = vsi->base_queue;
 	for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
-		i40e_control_rx_q(pf, pf_q, enable);
-
-		/* wait for the change to finish */
-		ret = i40e_pf_rxq_wait(pf, pf_q, enable);
+		ret = i40e_control_wait_rx_q(pf, pf_q, enable);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
 				 "VSI seid %d Rx ring %d %sable timeout\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2ceea63..c6d24ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2154,6 +2154,51 @@ static int i40e_vc_config_irq_map_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 }
 
 /**
+ * i40e_ctrl_vf_tx_rings
+ * @vsi: the SRIOV VSI being configured
+ * @q_map: bit map of the queues to be enabled
+ * @enable: start or stop the queue
+ **/
+static int i40e_ctrl_vf_tx_rings(struct i40e_vsi *vsi, unsigned long q_map,
+				 bool enable)
+{
+	struct i40e_pf *pf = vsi->back;
+	int ret = 0;
+	u16 q_id;
+
+	for_each_set_bit(q_id, &q_map, I40E_MAX_VF_QUEUES) {
+		ret = i40e_control_wait_tx_q(vsi->seid, pf,
+					     vsi->base_queue + q_id,
+					     false /*is xdp*/, enable);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+/**
+ * i40e_ctrl_vf_rx_rings
+ * @vsi: the SRIOV VSI being configured
+ * @q_map: bit map of the queues to be enabled
+ * @enable: start or stop the queue
+ **/
+static int i40e_ctrl_vf_rx_rings(struct i40e_vsi *vsi, unsigned long q_map,
+				 bool enable)
+{
+	struct i40e_pf *pf = vsi->back;
+	int ret = 0;
+	u16 q_id;
+
+	for_each_set_bit(q_id, &q_map, I40E_MAX_VF_QUEUES) {
+		ret = i40e_control_wait_rx_q(pf, vsi->base_queue + q_id,
+					     enable);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+/**
  * i40e_vc_enable_queues_msg
  * @vf: pointer to the VF info
  * @msg: pointer to the msg buffer
@@ -2185,8 +2230,17 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 		goto error_param;
 	}
 
-	if (i40e_vsi_start_rings(pf->vsi[vf->lan_vsi_idx]))
+	/* Use the queue bit map sent by the VF */
+	if (i40e_ctrl_vf_rx_rings(pf->vsi[vf->lan_vsi_idx], vqs->rx_queues,
+				  true)) {
+		aq_ret = I40E_ERR_TIMEOUT;
+		goto error_param;
+	}
+	if (i40e_ctrl_vf_tx_rings(pf->vsi[vf->lan_vsi_idx], vqs->tx_queues,
+				  true)) {
 		aq_ret = I40E_ERR_TIMEOUT;
+		goto error_param;
+	}
 
 	/* need to start the rings for additional ADq VSI's as well */
 	if (vf->adq_enabled) {
@@ -2234,8 +2288,17 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 		goto error_param;
 	}
 
-	i40e_vsi_stop_rings(pf->vsi[vf->lan_vsi_idx]);
-
+	/* Use the queue bit map sent by the VF */
+	if (i40e_ctrl_vf_tx_rings(pf->vsi[vf->lan_vsi_idx], vqs->tx_queues,
+				  false)) {
+		aq_ret = I40E_ERR_TIMEOUT;
+		goto error_param;
+	}
+	if (i40e_ctrl_vf_rx_rings(pf->vsi[vf->lan_vsi_idx], vqs->rx_queues,
+				  false)) {
+		aq_ret = I40E_ERR_TIMEOUT;
+		goto error_param;
+	}
 error_param:
 	/* send the response to the VF */
 	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DISABLE_QUEUES,
-- 
2.9.5

