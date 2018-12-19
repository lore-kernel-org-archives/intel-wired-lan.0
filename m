From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Dec 2018 06:45:40 -0800
Subject: [Intel-wired-lan] [next PATCH S1 4/6] i40e: check queue pairs num
 in config queues handler
In-Reply-To: <20181219144542.85924-1-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
Message-ID: <20181219144542.85924-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sergey Nemov <sergey.nemov@intel.com>

Check if num_queue_pairs number requested by VF is less than
maximum possible value in VIRTCHNL_OP_CONFIG_VSI_QUEUES handler.

Also check if local_vf_id >= 0 in common handler since it is of
int type and can potentially be negative.

Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2ac23ebfbf31..f62937045c5d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2069,6 +2069,11 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
+	if (qci->num_queue_pairs > I40E_MAX_VF_QUEUES) {
+		aq_ret = I40E_ERR_PARAM;
+		goto error_param;
+	}
+
 	for (i = 0; i < qci->num_queue_pairs; i++) {
 		qpi = &qci->qpair[i];
 
@@ -3656,7 +3661,7 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 	int ret;
 
 	pf->vf_aq_requests++;
-	if (local_vf_id >= pf->num_alloc_vfs)
+	if (local_vf_id < 0 || local_vf_id >= pf->num_alloc_vfs)
 		return -EINVAL;
 	vf = &(pf->vf[local_vf_id]);
 
-- 
2.19.2

