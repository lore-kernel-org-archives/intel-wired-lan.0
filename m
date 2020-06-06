From: Qian Cai <cai@lca.pw>
Date: Sat,  6 Jun 2020 16:01:16 -0400
Subject: [Intel-wired-lan] [PATCH] i40e: silence an UBSAN false positive
Message-ID: <20200606200116.1398-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

virtchnl_rss_lut.lut is used for the RSS lookup table, but in
i40e_vc_config_rss_lut(), it is indexed by subscript results in a false
positive.

 UBSAN: array-index-out-of-bounds in drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2983:15
 index 1 is out of range for type 'u8 [1]'
 CPU: 34 PID: 871 Comm: kworker/34:2 Not tainted 5.7.0-next-20200605+ #5
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 03/09/2018
 Workqueue: i40e i40e_service_task [i40e]
 Call Trace:
  dump_stack+0xa7/0xea
  ubsan_epilogue+0x9/0x45
  __ubsan_handle_out_of_bounds+0x6f/0x80
  i40e_vc_process_vf_msg+0x457c/0x4660 [i40e]
  i40e_service_task+0x96c/0x1ab0 [i40e]
  process_one_work+0x57d/0xbd0
  worker_thread+0x63/0x5b0
  kthread+0x20c/0x230
  ret_from_fork+0x22/0x30

Fixes: d510497b8397 ("i40e: add input validation for virtchnl handlers")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 56b9e445732b..d5a959d91ba9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2971,6 +2971,7 @@ static int i40e_vc_config_rss_lut(struct i40e_vf *vf, u8 *msg)
 	struct i40e_vsi *vsi = NULL;
 	i40e_status aq_ret = 0;
 	u16 i;
+	u8 *lut = vrl->lut;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
 	    !i40e_vc_isvalid_vsi_id(vf, vrl->vsi_id) ||
@@ -2980,13 +2981,13 @@ static int i40e_vc_config_rss_lut(struct i40e_vf *vf, u8 *msg)
 	}
 
 	for (i = 0; i < vrl->lut_entries; i++)
-		if (vrl->lut[i] >= vf->num_queue_pairs) {
+		if (lut[i] >= vf->num_queue_pairs) {
 			aq_ret = I40E_ERR_PARAM;
 			goto err;
 		}
 
 	vsi = pf->vsi[vf->lan_vsi_idx];
-	aq_ret = i40e_config_rss(vsi, NULL, vrl->lut, I40E_VF_HLUT_ARRAY_SIZE);
+	aq_ret = i40e_config_rss(vsi, NULL, lut, I40E_VF_HLUT_ARRAY_SIZE);
 	/* send the response to the VF */
 err:
 	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_LUT,
-- 
2.21.0 (Apple Git-122.2)

