From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Mon, 10 Jan 2022 13:11:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 4/4] i40e: Add sending
 commands in atomic context
In-Reply-To: <20220110131142.8481-1-jedrzej.jagielski@intel.com>
References: <20220110131142.8481-1-jedrzej.jagielski@intel.com>
Message-ID: <20220110131142.8481-5-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change functions:
- i40e_aq_add_macvlan
- i40e_aq_remove_macvlan
- i40e_aq_delete_element
- i40e_aq_add_vsi
- i40e_aq_update_vsi_params
to explicitly use i40e_asq_send_command_atomic(..., true)
instead of i40e_asq_send_command, as they use mutexes and do some
work in an atomic context.
Without this change setting vlan via netdev will fail with
call trace cased by bug "BUG: scheduling while atomic".

Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index a15b09b39979..214400623dd9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1899,8 +1899,9 @@ i40e_status i40e_aq_add_vsi(struct i40e_hw *hw,
 
 	desc.flags |= cpu_to_le16((u16)(I40E_AQ_FLAG_BUF | I40E_AQ_FLAG_RD));
 
-	status = i40e_asq_send_command(hw, &desc, &vsi_ctx->info,
-				    sizeof(vsi_ctx->info), cmd_details);
+	status = i40e_asq_send_command_atomic(hw, &desc, &vsi_ctx->info,
+					      sizeof(vsi_ctx->info),
+					      cmd_details, true);
 
 	if (status)
 		goto aq_add_vsi_exit;
@@ -2287,8 +2288,9 @@ i40e_status i40e_aq_update_vsi_params(struct i40e_hw *hw,
 
 	desc.flags |= cpu_to_le16((u16)(I40E_AQ_FLAG_BUF | I40E_AQ_FLAG_RD));
 
-	status = i40e_asq_send_command(hw, &desc, &vsi_ctx->info,
-				    sizeof(vsi_ctx->info), cmd_details);
+	status = i40e_asq_send_command_atomic(hw, &desc, &vsi_ctx->info,
+					      sizeof(vsi_ctx->info),
+					      cmd_details, true);
 
 	vsi_ctx->vsis_allocated = le16_to_cpu(resp->vsi_used);
 	vsi_ctx->vsis_unallocated = le16_to_cpu(resp->vsi_free);
@@ -2695,8 +2697,8 @@ i40e_aq_add_macvlan(struct i40e_hw *hw, u16 seid,
 
 	buf_size = i40e_prepare_add_macvlan(mv_list, &desc, count, seid);
 
-	status = i40e_asq_send_command(hw, &desc, mv_list, buf_size,
-				       cmd_details);
+	status = i40e_asq_send_command_atomic(hw, &desc, mv_list, buf_size,
+					      cmd_details, true);
 
 	return status;
 }
@@ -2773,8 +2775,8 @@ i40e_status i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 seid,
 	if (buf_size > I40E_AQ_LARGE_BUF)
 		desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);
 
-	status = i40e_asq_send_command(hw, &desc, mv_list, buf_size,
-				       cmd_details);
+	status = i40e_asq_send_command_atomic(hw, &desc, mv_list, buf_size,
+					      cmd_details, true);
 
 	return status;
 }
@@ -3975,7 +3977,8 @@ i40e_status i40e_aq_delete_element(struct i40e_hw *hw, u16 seid,
 
 	cmd->seid = cpu_to_le16(seid);
 
-	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+	status = i40e_asq_send_command_atomic(hw, &desc, NULL, 0,
+					      cmd_details, true);
 
 	return status;
 }
-- 
2.27.0

