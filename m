From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:39 -0800
Subject: [Intel-wired-lan] [PATCH S11 12/16] ice: flush tx pipe on disable
 queue timeout
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Victor Raj <victor.raj@intel.com>

set the flush tx pipe flag instead of getting an EAGAIN error when FW
timesout in processing the disable tx queue command.

Signed-off-by: Victor Raj <victor.raj@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b17ade424423..63f003441300 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2450,6 +2450,7 @@ ice_aq_dis_lan_txq(struct ice_hw *hw, u8 num_qgrps,
 {
 	struct ice_aqc_dis_txqs *cmd;
 	struct ice_aq_desc desc;
+	enum ice_status status;
 	u16 i, sz = 0;
 
 	cmd = &desc.params.dis_txqs;
@@ -2485,6 +2486,8 @@ ice_aq_dis_lan_txq(struct ice_hw *hw, u8 num_qgrps,
 		break;
 	}
 
+	/* flush pipe on time out */
+	cmd->cmd_type |= ICE_AQC_Q_DIS_CMD_FLUSH_PIPE;
 	/* If no queue group info, we are in a reset flow. Issue the AQ */
 	if (!qg_list)
 		goto do_aq;
@@ -2510,7 +2513,17 @@ ice_aq_dis_lan_txq(struct ice_hw *hw, u8 num_qgrps,
 		return ICE_ERR_PARAM;
 
 do_aq:
-	return ice_aq_send_cmd(hw, &desc, qg_list, buf_size, cd);
+	status = ice_aq_send_cmd(hw, &desc, qg_list, buf_size, cd);
+	if (status) {
+		if (!qg_list)
+			ice_debug(hw, ICE_DBG_SCHED, "VM%d disable failed %d\n",
+				  vmvf_num, hw->adminq.sq_last_status);
+		else
+			ice_debug(hw, ICE_DBG_SCHED, "disable Q %d failed %d\n",
+				  le16_to_cpu(qg_list[0].q_id[0]),
+				  hw->adminq.sq_last_status);
+	}
+	return status;
 }
 
 /* End of FW Admin Queue command wrappers */
@@ -2796,8 +2809,12 @@ ice_ena_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_qgrps,
 
 	/* add the lan q */
 	status = ice_aq_add_lan_txq(hw, num_qgrps, buf, buf_size, cd);
-	if (status)
+	if (status) {
+		ice_debug(hw, ICE_DBG_SCHED, "enable Q %d failed %d\n",
+			  le16_to_cpu(buf->txqs[0].txq_id),
+			  hw->adminq.sq_last_status);
 		goto ena_txq_exit;
+	}
 
 	node.node_teid = buf->txqs[0].q_teid;
 	node.data.elem_type = ICE_AQC_ELEM_TYPE_LEAF;
-- 
2.14.5

