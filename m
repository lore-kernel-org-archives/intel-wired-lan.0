From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:39 -0700
Subject: [Intel-wired-lan] [next PATCH S4 10/11] i40e: missing input
 validation on VF message handling by the PF
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <20190329220840.51187-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Martyna Szapar <martyna.szapar@intel.com>

Patch is adding missing input validation on VF message handling
by the PF to the functions with opcodes:
	VIRTCHNL_OP_CONFIG_VSI_QUEUES = 6
	VIRTCHNL_OP_CONFIG_IRQ_MAP = 7,
	VIRTCHNL_OP_DISABLE_QUEUES = 9,
	VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE = 14,

Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 58 ++++++++++++++-----
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  2 +
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d0e3677b7dc8..6a812eeaba8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2014,6 +2014,16 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf, u8 *msg)
 		goto err_out;
 	}
 
+	if (info->flags > I40E_MAX_VF_PROMISC_FLAGS) {
+		aq_ret = I40E_ERR_PARAM;
+		goto err_out;
+	}
+
+	if (!i40e_vc_isvalid_vsi_id(vf, info->vsi_id)) {
+		aq_ret = I40E_ERR_PARAM;
+		goto err_out;
+	}
+
 	/* Multicast promiscuous handling*/
 	if (info->flags & FLAG_VF_MULTICAST_PROMISC)
 		allmulti = true;
@@ -2068,17 +2078,16 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_queue_pair_info *qpi;
 	struct i40e_pf *pf = vf->pf;
 	u16 vsi_id, vsi_queue_id = 0;
+	u16 num_qps_all = 0;
 	i40e_status aq_ret = 0;
 	int i, j = 0, idx = 0;
 
-	vsi_id = qci->vsi_id;
-
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
 
-	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
+	if (!i40e_vc_isvalid_vsi_id(vf, qci->vsi_id)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2088,10 +2097,27 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
+	if (vf->adq_enabled) {
+		for (i = 0; i < I40E_MAX_VF_VSI; i++)
+			num_qps_all += vf->ch[i].num_qps;
+		if (num_qps_all != qci->num_queue_pairs) {
+			aq_ret = I40E_ERR_PARAM;
+			goto error_param;
+		}
+	}
+
+	vsi_id = qci->vsi_id;
+
 	for (i = 0; i < qci->num_queue_pairs; i++) {
 		qpi = &qci->qpair[i];
 
 		if (!vf->adq_enabled) {
+			if (!i40e_vc_isvalid_queue_id(vf, vsi_id,
+						      qpi->txq.queue_id)) {
+				aq_ret = I40E_ERR_PARAM;
+				goto error_param;
+			}
+
 			vsi_queue_id = qpi->txq.queue_id;
 
 			if (qpi->txq.vsi_id != qci->vsi_id ||
@@ -2102,10 +2128,8 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 			}
 		}
 
-		if (!i40e_vc_isvalid_queue_id(vf, vsi_id, vsi_queue_id)) {
-			aq_ret = I40E_ERR_PARAM;
-			goto error_param;
-		}
+		if (vf->adq_enabled)
+			vsi_id = vf->ch[idx].vsi_id;
 
 		if (i40e_config_vsi_rx_queue(vf, vsi_id, vsi_queue_id,
 					     &qpi->rxq) ||
@@ -2129,7 +2153,6 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 				j++;
 				vsi_queue_id++;
 			}
-			vsi_id = vf->ch[idx].vsi_id;
 		}
 	}
 	/* set vsi num_queue_pairs in use to num configured by VF */
@@ -2188,7 +2211,7 @@ static int i40e_vc_config_irq_map_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_irq_map_info *irqmap_info =
 	    (struct virtchnl_irq_map_info *)msg;
 	struct virtchnl_vector_map *map;
-	u16 vsi_id, vector_id;
+	u16 vsi_id;
 	i40e_status aq_ret = 0;
 	int i;
 
@@ -2197,16 +2220,21 @@ static int i40e_vc_config_irq_map_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
+	if (irqmap_info->num_vectors >
+	    vf->pf->hw.func_caps.num_msix_vectors_vf) {
+		aq_ret = I40E_ERR_PARAM;
+		goto error_param;
+	}
+
 	for (i = 0; i < irqmap_info->num_vectors; i++) {
 		map = &irqmap_info->vecmap[i];
-		vector_id = map->vector_id;
-		vsi_id = map->vsi_id;
 		/* validate msg params */
-		if (!i40e_vc_isvalid_vector_id(vf, vector_id) ||
-		    !i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
+		if (!i40e_vc_isvalid_vector_id(vf, map->vector_id) ||
+		    !i40e_vc_isvalid_vsi_id(vf, map->vsi_id)) {
 			aq_ret = I40E_ERR_PARAM;
 			goto error_param;
 		}
+		vsi_id = map->vsi_id;
 
 		if (i40e_validate_queue_map(vf, vsi_id, map->rxq_map)) {
 			aq_ret = I40E_ERR_PARAM;
@@ -2354,7 +2382,9 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if ((0 == vqs->rx_queues) && (0 == vqs->tx_queues)) {
+	if ((vqs->rx_queues == 0 && vqs->tx_queues == 0) ||
+	    vqs->rx_queues > I40E_MAX_VF_QUEUES ||
+	    vqs->tx_queues > I40E_MAX_VF_QUEUES) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index f9621026beef..f65cc0c16550 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -17,6 +17,8 @@
 #define I40E_VLAN_MASK			0xFFF
 #define I40E_PRIORITY_MASK		0xE000
 
+#define I40E_MAX_VF_PROMISC_FLAGS	3
+
 /* Various queue ctrls */
 enum i40e_queue_ctrl {
 	I40E_QUEUE_CTRL_UNKNOWN = 0,
-- 
2.19.2

