From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 17 Mar 2016 09:41:20 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v3 02/12] i40e: Remove unused
	variable
In-Reply-To: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
References: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458232890-110933-3-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This variable is vestigial, a remnant of the primordial code from which
this driver spawned. We can safely remove it.

Testing Hints: VFs initialize and pass traffic.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2bde41b..80174de 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1182,8 +1182,8 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	struct i40e_pf *pf = vf->pf;
 	i40e_status aq_ret = 0;
 	struct i40e_vsi *vsi;
-	int i = 0, len = 0;
 	int num_vsis = 1;
+	int len = 0;
 	int ret;
 
 	if (!test_bit(I40E_VF_STAT_INIT, &vf->vf_states)) {
@@ -1238,15 +1238,14 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	vfres->num_queue_pairs = vf->num_queue_pairs;
 	vfres->max_vectors = pf->hw.func_caps.num_msix_vectors_vf;
 	if (vf->lan_vsi_idx) {
-		vfres->vsi_res[i].vsi_id = vf->lan_vsi_id;
-		vfres->vsi_res[i].vsi_type = I40E_VSI_SRIOV;
-		vfres->vsi_res[i].num_queue_pairs = vsi->alloc_queue_pairs;
+		vfres->vsi_res[0].vsi_id = vf->lan_vsi_id;
+		vfres->vsi_res[0].vsi_type = I40E_VSI_SRIOV;
+		vfres->vsi_res[0].num_queue_pairs = vsi->alloc_queue_pairs;
 		/* VFs only use TC 0 */
-		vfres->vsi_res[i].qset_handle
+		vfres->vsi_res[0].qset_handle
 					  = le16_to_cpu(vsi->info.qs_handle[0]);
-		ether_addr_copy(vfres->vsi_res[i].default_mac_addr,
+		ether_addr_copy(vfres->vsi_res[0].default_mac_addr,
 				vf->default_lan_addr.addr);
-		i++;
 	}
 	set_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states);
 
-- 
2.4.3

