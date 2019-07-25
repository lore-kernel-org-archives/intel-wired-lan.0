From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 02:53:59 -0700
Subject: [Intel-wired-lan] [PATCH S25 10/12] ice: add validation in
 OP_CONFIG_VSI_QUEUES VF message
In-Reply-To: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725095401.24590-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

Check num_queue_pairs to avoid access to unallocated field of
vsi->tx_rings/vsi->rx_rings. Without this validation we can set
vsi->alloc_txq/vsi->alloc_rxq to value smaller than ICE_MAX_BASE_QS_PER_VF
and send this command with num_queue_pairs greater than
vsi->alloc_txq/vsi->alloc_rxq. This lead to access to unallocated memory.

In VF vsi alloc_txq and alloc_rxq should be the same. Get minimum
because looks more readable.

Also add validation for ring_len param. It should be greater than 32 and
be multiple of 32. Incorrect value leads to hang traffic on PF.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 31 ++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 377e6d495c14..cd8662ac133d 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1713,6 +1713,19 @@ static bool ice_vc_isvalid_q_id(struct ice_vf *vf, u16 vsi_id, u8 qid)
 	return (vsi && (qid < vsi->alloc_txq));
 }
 
+/**
+ * ice_vc_isvalid_ring_len
+ * @ring_len: length of ring
+ *
+ * check for the valid ring count, should be multiple of ICE_REQ_DESC_MULTIPLE
+ */
+static bool ice_vc_isvalid_ring_len(u16 ring_len)
+{
+	return (ring_len >= ICE_MIN_NUM_DESC &&
+		ring_len <= ICE_MAX_NUM_DESC &&
+		!(ring_len % ICE_REQ_DESC_MULTIPLE));
+}
+
 /**
  * ice_vc_config_rss_key
  * @vf: pointer to the VF info
@@ -2108,16 +2121,17 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (qci->num_queue_pairs > ICE_MAX_BASE_QS_PER_VF) {
-		dev_err(&pf->pdev->dev,
-			"VF-%d requesting more than supported number of queues: %d\n",
-			vf->vf_id, qci->num_queue_pairs);
+	vsi = pf->vsi[vf->lan_vsi_idx];
+	if (!vsi) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
-	if (!vsi) {
+	if (qci->num_queue_pairs > ICE_MAX_BASE_QS_PER_VF ||
+	    qci->num_queue_pairs > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
+		dev_err(&pf->pdev->dev,
+			"VF-%d requesting more than supported number of queues: %d\n",
+			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
 	}
@@ -2128,6 +2142,8 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		    qpi->rxq.vsi_id != qci->vsi_id ||
 		    qpi->rxq.queue_id != qpi->txq.queue_id ||
 		    qpi->txq.headwb_enabled ||
+		    !ice_vc_isvalid_ring_len(qpi->txq.ring_len) ||
+		    !ice_vc_isvalid_ring_len(qpi->rxq.ring_len) ||
 		    !ice_vc_isvalid_q_id(vf, qci->vsi_id, qpi->txq.queue_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
@@ -2138,7 +2154,8 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		/* copy Rx queue info from VF into VSI */
 		vsi->rx_rings[i]->dma = qpi->rxq.dma_ring_addr;
 		vsi->rx_rings[i]->count = qpi->rxq.ring_len;
-		if (qpi->rxq.databuffer_size > ((16 * 1024) - 128)) {
+		if (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
+		    qpi->rxq.databuffer_size < 1024) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
-- 
2.20.1

