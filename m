From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:41 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 03/13] i40e: Save off VSI
	resource count when updating VSI
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-4-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kevin Scott <kevin.c.scott@intel.com>

When updating a VSI, save off the number of allocated and unallocated
VSIs as we do when adding a VSI.

Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 4596294..b0fd684 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2157,6 +2157,9 @@ i40e_status i40e_aq_update_vsi_params(struct i40e_hw *hw,
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_add_get_update_vsi *cmd =
 		(struct i40e_aqc_add_get_update_vsi *)&desc.params.raw;
+	struct i40e_aqc_add_get_update_vsi_completion *resp =
+		(struct i40e_aqc_add_get_update_vsi_completion *)
+		&desc.params.raw;
 	i40e_status status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
@@ -2168,6 +2171,9 @@ i40e_status i40e_aq_update_vsi_params(struct i40e_hw *hw,
 	status = i40e_asq_send_command(hw, &desc, &vsi_ctx->info,
 				    sizeof(vsi_ctx->info), cmd_details);
 
+	vsi_ctx->vsis_allocated = le16_to_cpu(resp->vsi_used);
+	vsi_ctx->vsis_unallocated = le16_to_cpu(resp->vsi_free);
+
 	return status;
 }
 
-- 
2.4.3

