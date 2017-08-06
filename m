From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun,  6 Aug 2017 23:37:01 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: Fix a potential NULL pointer
	dereference
Message-ID: <20170806213701.19317-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If 'kzalloc()' fails, a NULL pointer will be dereferenced.
Return an error code (-ENOMEM) instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 979110d59f67..facd48fc15d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -423,6 +423,9 @@ static int i40e_config_iwarp_qvlist(struct i40e_vf *vf,
 	       (sizeof(struct virtchnl_iwarp_qv_info) *
 						(qvlist_info->num_vectors - 1));
 	vf->qvlist_info = kzalloc(size, GFP_KERNEL);
+	if (!vf->qvlist_info)
+		return -ENOMEM;
+
 	vf->qvlist_info->num_vectors = qvlist_info->num_vectors;
 
 	msix_vf = pf->hw.func_caps.num_msix_vectors_vf;
-- 
2.11.0

