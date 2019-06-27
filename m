From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Jun 2019 07:41:00 -0700
Subject: [Intel-wired-lan] [PATCH S23 14/15] ice: Use smaller sized integer
 types
In-Reply-To: <20190627144101.24280-1-anthony.l.nguyen@intel.com>
References: <20190627144101.24280-1-anthony.l.nguyen@intel.com>
Message-ID: <20190627144101.24280-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawel Kaminski <pawel.kaminski@intel.com>

The max number queues supported by the device is 768; we only need
a u16 to represent this.

Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f2ebbe83ae4c..72a9e79dd76d 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2339,11 +2339,11 @@ static int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_vf_res_request *vfres =
 		(struct virtchnl_vf_res_request *)msg;
-	int req_queues = vfres->num_queue_pairs;
+	u16 req_queues = vfres->num_queue_pairs;
 	struct ice_pf *pf = vf->pf;
-	int max_allowed_vf_queues;
-	int tx_rx_queue_left;
-	int cur_queues;
+	u16 max_allowed_vf_queues;
+	u16 tx_rx_queue_left;
+	u16 cur_queues;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
@@ -2353,10 +2353,10 @@ static int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	cur_queues = vf->num_vf_qs;
 	tx_rx_queue_left = min_t(int, pf->q_left_tx, pf->q_left_rx);
 	max_allowed_vf_queues = tx_rx_queue_left + cur_queues;
-	if (req_queues <= 0) {
+	if (!req_queues) {
 		dev_err(&pf->pdev->dev,
-			"VF %d tried to request %d queues. Ignoring.\n",
-			vf->vf_id, req_queues);
+			"VF %d tried to request 0 queues. Ignoring.\n",
+			vf->vf_id);
 	} else if (req_queues > ICE_MAX_BASE_QS_PER_VF) {
 		dev_err(&pf->pdev->dev,
 			"VF %d tried to request more than %d queues.\n",
-- 
2.20.1

