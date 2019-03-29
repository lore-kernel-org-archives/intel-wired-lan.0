From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:37 -0700
Subject: [Intel-wired-lan] [next PATCH S4 08/11] i40e: Wrong truncation from
 u16 to u8
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <20190329220840.51187-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Siwik <grzegorz.siwik@intel.com>

In this patch fixed wrong truncation method from u16 to u8 during
validation.

It was changed by changing u8 to u32 parameter in method declaration
and arguments were changed to u32.

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 25490cfb06fc..d0e3677b7dc8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -196,7 +196,7 @@ static inline bool i40e_vc_isvalid_queue_id(struct i40e_vf *vf, u16 vsi_id,
  *
  * check for the valid vector id
  **/
-static inline bool i40e_vc_isvalid_vector_id(struct i40e_vf *vf, u8 vector_id)
+static inline bool i40e_vc_isvalid_vector_id(struct i40e_vf *vf, u32 vector_id)
 {
 	struct i40e_pf *pf = vf->pf;
 
-- 
2.19.2

