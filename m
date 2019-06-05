From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Wed, 5 Jun 2019 10:40:52 -0500
Subject: [Intel-wired-lan] [PATCH][next] i40e/i40e_virtchnl_pf: Use
 struct_size() in kzalloc()
Message-ID: <20190605154052.GA7571@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct virtchnl_iwarp_qvlist_info {
	...
        struct virtchnl_iwarp_qv_info qv_info[1];
};

size = sizeof(struct virtchnl_iwarp_qvlist_info) + (sizeof(struct virtchnl_iwarp_qv_info) * count;
instance = kzalloc(size, GFP_KERNEL);

and

struct virtchnl_vf_resource {
	...
        struct virtchnl_vsi_resource vsi_res[1];
};

size = sizeof(struct virtchnl_vf_resource) + sizeof(struct virtchnl_vsi_resource) * count;
instance = kzalloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, qv_info, count), GFP_KERNEL);

and

instance = kzalloc(struct_size(instance, vsi_res, count), GFP_KERNEL);

Notice that, in the first case above, variable size is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c    | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 479bc60c8f71..1d6e65fc8a7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -440,7 +440,7 @@ static int i40e_config_iwarp_qvlist(struct i40e_vf *vf,
 	struct virtchnl_iwarp_qv_info *qv_info;
 	u32 v_idx, i, reg_idx, reg;
 	u32 next_q_idx, next_q_type;
-	u32 msix_vf, size;
+	u32 msix_vf;
 	int ret = 0;
 
 	msix_vf = pf->hw.func_caps.num_msix_vectors_vf;
@@ -454,11 +454,10 @@ static int i40e_config_iwarp_qvlist(struct i40e_vf *vf,
 		goto err_out;
 	}
 
-	size = sizeof(struct virtchnl_iwarp_qvlist_info) +
-	       (sizeof(struct virtchnl_iwarp_qv_info) *
-						(qvlist_info->num_vectors - 1));
 	kfree(vf->qvlist_info);
-	vf->qvlist_info = kzalloc(size, GFP_KERNEL);
+	vf->qvlist_info = kzalloc(struct_size(vf->qvlist_info, qv_info,
+					      qvlist_info->num_vectors - 1),
+				  GFP_KERNEL);
 	if (!vf->qvlist_info) {
 		ret = -ENOMEM;
 		goto err_out;
@@ -1845,7 +1844,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	struct i40e_vsi *vsi;
 	int num_vsis = 1;
-	int len = 0;
+	size_t len = 0;
 	int ret;
 
 	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
@@ -1853,9 +1852,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	len = (sizeof(struct virtchnl_vf_resource) +
-	       sizeof(struct virtchnl_vsi_resource) * num_vsis);
-
+	len = struct_size(vfres, vsi_res, num_vsis);
 	vfres = kzalloc(len, GFP_KERNEL);
 	if (!vfres) {
 		aq_ret = I40E_ERR_NO_MEMORY;
-- 
2.21.0

