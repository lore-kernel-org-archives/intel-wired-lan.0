From: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
Date: Mon, 4 Nov 2019 05:32:25 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e/iavf: Fix msg interface between
 VF and PF
Message-ID: <1572845537.13810.225.camel@harmonicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From af5ab2aaa51882bb7111b026882fe217ed81c15b Mon Sep 17 00:00:00 2001
From: Arkady Gilinsky <arkady.gilinsky@harmonicinc
.com>
Date: Sun, 3 Nov 2019 20:37:21 +0200
Subject: [PATCH net] i40e/iavf: Fix msg interface between VF and PF

?* The original issue was that iavf driver passing TX/RX queues
???as bitmap in iavf_disable_queues and the i40e driver
???interprets this message as an absolute number in
???i40e_vc_disable_queues_msg, so the validation in the
???latter function always fail.
???This commit reorganize the msg interface between i40e and iavf
???between the iavf_disable_queues and i40e_vc_disable_queues_msg
???functions (also for iavf_enable_queues and i40e_vc_enable_queues_msg).
???Now both drivers operate with number of queues instead of
???bitmap. Also the commit introduces range check in
???i40e_vc_enable_queues_msg function.

Signed-off-by: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
---
?drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 23 ++++++++++++++++------
?drivers/net/ethernet/intel/iavf/iavf_virtchnl.c????|??6 ++++--
?2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3d2440838822..c650eb91982a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2352,13 +2352,22 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
?		goto error_param;
?	}
?
-	/* Use the queue bit map sent by the VF */
-	if (i40e_ctrl_vf_rx_rings(pf->vsi[vf->lan_vsi_idx], vqs->rx_queues,
+	if ((vqs->rx_queues == 0 && vqs->tx_queues == 0) ||
+	????vqs->rx_queues > I40E_MAX_VF_QUEUES ||
+	????vqs->tx_queues > I40E_MAX_VF_QUEUES) {
+		aq_ret = I40E_ERR_PARAM;
+		goto error_param;
+	}
+
+	/* Build the queue bit map from value sent by the VF */
+	if (i40e_ctrl_vf_rx_rings(pf->vsi[vf->lan_vsi_idx],
+				??BIT(vqs->rx_queues) - 1,
?				??true)) {
?		aq_ret = I40E_ERR_TIMEOUT;
?		goto error_param;
?	}
-	if (i40e_ctrl_vf_tx_rings(pf->vsi[vf->lan_vsi_idx], vqs->tx_queues,
+	if (i40e_ctrl_vf_tx_rings(pf->vsi[vf->lan_vsi_idx],
+				??BIT(vqs->tx_queues) - 1,
?				??true)) {
?		aq_ret = I40E_ERR_TIMEOUT;
?		goto error_param;
@@ -2416,13 +2425,15 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg)
?		goto error_param;
?	}
?
-	/* Use the queue bit map sent by the VF */
-	if (i40e_ctrl_vf_tx_rings(pf->vsi[vf->lan_vsi_idx], vqs->tx_queues,
+	/* Build the queue bit map from value sent by the VF */
+	if (i40e_ctrl_vf_tx_rings(pf->vsi[vf->lan_vsi_idx],
+				??BIT(vqs->tx_queues) - 1,
?				??false)) {
?		aq_ret = I40E_ERR_TIMEOUT;
?		goto error_param;
?	}
-	if (i40e_ctrl_vf_rx_rings(pf->vsi[vf->lan_vsi_idx], vqs->rx_queues,
+	if (i40e_ctrl_vf_rx_rings(pf->vsi[vf->lan_vsi_idx],
+				??BIT(vqs->rx_queues) - 1,
?				??false)) {
?		aq_ret = I40E_ERR_TIMEOUT;
?		goto error_param;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index c46770eba320..271f144bf05b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -308,7 +308,8 @@ void iavf_enable_queues(struct iavf_adapter *adapter)
?	}
?	adapter->current_op = VIRTCHNL_OP_ENABLE_QUEUES;
?	vqs.vsi_id = adapter->vsi_res->vsi_id;
-	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
+	/* Send the queues number to PF */
+	vqs.tx_queues = adapter->num_active_queues;
?	vqs.rx_queues = vqs.tx_queues;
?	adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_QUEUES;
?	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_QUEUES,
@@ -333,7 +334,8 @@ void iavf_disable_queues(struct iavf_adapter *adapter)
?	}
?	adapter->current_op = VIRTCHNL_OP_DISABLE_QUEUES;
?	vqs.vsi_id = adapter->vsi_res->vsi_id;
-	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
+	/* Send the queues number to PF */
+	vqs.tx_queues = adapter->num_active_queues;
?	vqs.rx_queues = vqs.tx_queues;
?	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_QUEUES;
?	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_QUEUES,
--?
2.11.0

