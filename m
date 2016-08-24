From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 24 Aug 2016 11:33:50 -0700
Subject: [Intel-wired-lan] [next PATCH S44 5/6] i40e: Fix to check for NULL
In-Reply-To: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1472063631-9033-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes an issue in the virt channel code, where a return
from i40e_find_vsi_from_id was not checked for NULL when applicable.
Without this patch, there is a risk for panic and static analysis
tools complain. This patch fixes the problem by adding the check
and adding an additional input check for similar reasons.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I7e9be88eb7a3addb50eadc451c8336d9e06f5394
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 27df091..5eb2069 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -502,8 +502,16 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 	u32 qtx_ctl;
 	int ret = 0;
 
+	if (!i40e_vc_isvalid_vsi_id(vf, info->vsi_id)) {
+		ret = -ENOENT;
+		goto error_context;
+	}
 	pf_queue_id = i40e_vc_get_pf_queue_id(vf, vsi_id, vsi_queue_id);
 	vsi = i40e_find_vsi_from_id(pf, vsi_id);
+	if (!vsi) {
+		ret = -ENOENT;
+		goto error_context;
+	}
 
 	/* clear the context structure first */
 	memset(&tx_ctx, 0, sizeof(struct i40e_hmc_obj_txq));
@@ -1624,7 +1632,8 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf,
 
 	vsi = i40e_find_vsi_from_id(pf, info->vsi_id);
 	if (!test_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states) ||
-	    !i40e_vc_isvalid_vsi_id(vf, info->vsi_id)) {
+	    !i40e_vc_isvalid_vsi_id(vf, info->vsi_id) ||
+	    !vsi) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
-- 
2.4.11

