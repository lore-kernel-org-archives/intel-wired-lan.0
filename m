From: Karen Sornek <karen.sornek@intel.com>
Date: Tue,  9 Nov 2021 08:27:44 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Refactor VF queue
 requesting
Message-ID: <20211109072744.56924-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Simplify changing number of queues for VF's by moving logic to
another function, i40e_vf_set_num_queues.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 72 +++++++++++--------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5a488ce545..fa881d9b0f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2669,6 +2669,47 @@ static int i40e_check_enough_queue(struct i40e_vf *vf, u16 needed)
 	return -ENOMEM;
 }
 
+static int i40e_set_vf_num_queues(struct i40e_vf *vf, int num_queues)
+{
+	int cur_pairs = vf->num_queue_pairs;
+	struct i40e_pf *pf = vf->pf;
+	int max_size;
+
+	if (num_queues > I40E_MAX_VF_QUEUES) {
+		dev_err(&pf->pdev->dev, "Unable to configure %d VF queues, the maximum is %d\n",
+			num_queues,
+			I40E_MAX_VF_QUEUES);
+		return -EINVAL;
+	} else if (num_queues - cur_pairs > pf->queues_left) {
+		dev_warn(&pf->pdev->dev, "Unable to configure %d VF queues, only %d available\n",
+			 num_queues - cur_pairs,
+			 pf->queues_left);
+		return -EINVAL;
+	} else if (i40e_check_enough_queue(vf, num_queues) < 0) {
+		dev_warn(&pf->pdev->dev, "VF requested %d more queues, but there is not enough for it.\n",
+			 num_queues - cur_pairs);
+		return -EINVAL;
+	}
+
+	max_size = i40e_max_lump_qp(pf);
+	if (max_size < 0) {
+		dev_err(&pf->pdev->dev, "Unable to configure %d VF queues, pile=<null>\n",
+			num_queues);
+		return -EINVAL;
+	}
+
+	if (num_queues > max_size) {
+		dev_err(&pf->pdev->dev, "Unable to configure %d VF queues, only %d available\n",
+			num_queues, max_size);
+		return -EINVAL;
+	}
+
+	/* successful request */
+	vf->num_req_queues = num_queues;
+	i40e_vc_reset_vf(vf, true);
+	return 0;
+}
+
 /**
  * i40e_vc_request_queues_msg
  * @vf: pointer to the VF info
@@ -2684,40 +2725,11 @@ static int i40e_vc_request_queues_msg(struct i40e_vf *vf, u8 *msg)
 	struct virtchnl_vf_res_request *vfres =
 		(struct virtchnl_vf_res_request *)msg;
 	u16 req_pairs = vfres->num_queue_pairs;
-	u8 cur_pairs = vf->num_queue_pairs;
-	struct i40e_pf *pf = vf->pf;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE))
 		return -EINVAL;
 
-	if (req_pairs > I40E_MAX_VF_QUEUES) {
-		dev_err(&pf->pdev->dev,
-			"VF %d tried to request more than %d queues.\n",
-			vf->vf_id,
-			I40E_MAX_VF_QUEUES);
-		vfres->num_queue_pairs = I40E_MAX_VF_QUEUES;
-	} else if (req_pairs - cur_pairs > pf->queues_left) {
-		dev_warn(&pf->pdev->dev,
-			 "VF %d requested %d more queues, but only %d left.\n",
-			 vf->vf_id,
-			 req_pairs - cur_pairs,
-			 pf->queues_left);
-		vfres->num_queue_pairs = pf->queues_left + cur_pairs;
-	} else if (i40e_check_enough_queue(vf, req_pairs) < 0) {
-		dev_warn(&pf->pdev->dev,
-			 "VF %d requested %d more queues, but there is not enough for it.\n",
-			 vf->vf_id,
-			 req_pairs - cur_pairs);
-		vfres->num_queue_pairs = cur_pairs;
-	} else {
-		/* successful request */
-		vf->num_req_queues = req_pairs;
-		i40e_vc_reset_vf(vf, true);
-		return 0;
-	}
-
-	return i40e_vc_send_msg_to_vf(vf, VIRTCHNL_OP_REQUEST_QUEUES, 0,
-				      (u8 *)vfres, sizeof(*vfres));
+	return i40e_set_vf_num_queues(vf, req_pairs);
 }
 
 /**
-- 
2.27.0

