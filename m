From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 28 Jun 2019 08:03:48 -0700
Subject: [Intel-wired-lan] [PATCH S23 v2 14/15] ice: Change type for queue
 counts
Message-ID: <20190628150348.59202-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawel Kaminski <pawel.kaminski@intel.com>

A negative queue count should never exist, change the type to unsigned
to convey that.

Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
---
v2: Change type from u16 to unsigned int
    Reword commit message

 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f2ebbe83ae4c..b8fc08c1d365 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2339,11 +2339,11 @@ static int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_vf_res_request *vfres =
 		(struct virtchnl_vf_res_request *)msg;
-	int req_queues = vfres->num_queue_pairs;
+	unsigned int req_queues = vfres->num_queue_pairs;
+	unsigned int max_allowed_vf_queues;
+	unsigned int tx_rx_queue_left;
 	struct ice_pf *pf = vf->pf;
-	int max_allowed_vf_queues;
-	int tx_rx_queue_left;
-	int cur_queues;
+	unsigned int cur_queues;
 
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

