From: Qi Zhang <qi.z.zhang@intel.com>
Date: Thu, 16 Jul 2020 21:39:34 +0800
Subject: [Intel-wired-lan] [PATCH S48 v6 12/16] ice: Add new actions support
 for VF FDIR
In-Reply-To: <20200716133938.46921-1-qi.z.zhang@intel.com>
References: <20200716133938.46921-1-qi.z.zhang@intel.com>
Message-ID: <20200716133938.46921-13-qi.z.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add two new actions support for VF FDIR:

A passthrough action does not specify the destination queue, but
just allow the packet go to next pipeline stage, a typical use
cases is combined with a software mark (FDID) action.

Allow specify a 2^n continuous queues as the destination of a FDIR rule.
Packet distribution is based on current RSS configure.

Signed-off-by: Yahui Cao <yahui.cao@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fdir.c          | 12 +++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.h          |  4 ++++
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 10 ++++++++++
 include/linux/avf/virtchnl.h                       |  2 ++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index a6fce237fe84..cb455803ecf6 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -374,7 +374,14 @@ ice_fdir_get_prgm_desc(struct ice_hw *hw, struct ice_fdir_fltr *input,
 	if (input->dest_ctl == ICE_FLTR_PRGM_DESC_DEST_DROP_PKT) {
 		fdir_fltr_ctx.drop = ICE_FXD_FLTR_QW0_DROP_YES;
 		fdir_fltr_ctx.qindex = 0;
+	} else if (input->dest_ctl ==
+		   ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_OTHER) {
+		fdir_fltr_ctx.drop = ICE_FXD_FLTR_QW0_DROP_NO;
+		fdir_fltr_ctx.qindex = 0;
 	} else {
+		if (input->dest_ctl ==
+		    ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP)
+			fdir_fltr_ctx.toq = input->q_region;
 		fdir_fltr_ctx.drop = ICE_FXD_FLTR_QW0_DROP_NO;
 		fdir_fltr_ctx.qindex = input->q_index;
 	}
@@ -382,7 +389,10 @@ ice_fdir_get_prgm_desc(struct ice_hw *hw, struct ice_fdir_fltr *input,
 	fdir_fltr_ctx.cnt_index = input->cnt_index;
 	fdir_fltr_ctx.fd_vsi = ice_get_hw_vsi_num(hw, input->dest_vsi);
 	fdir_fltr_ctx.evict_ena = ICE_FXD_FLTR_QW0_EVICT_ENA_FALSE;
-	fdir_fltr_ctx.toq_prio = 3;
+	if (input->dest_ctl == ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_OTHER)
+		fdir_fltr_ctx.toq_prio = 0;
+	else
+		fdir_fltr_ctx.toq_prio = 3;
 	fdir_fltr_ctx.pcmd = add ? ICE_FXD_FLTR_QW1_PCMD_ADD :
 		ICE_FXD_FLTR_QW1_PCMD_REMOVE;
 	fdir_fltr_ctx.swap = ICE_FXD_FLTR_QW1_SWAP_NOT_SET;
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index 93f3f0d9d37b..adf237925b3c 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -42,6 +42,8 @@
 enum ice_fltr_prgm_desc_dest {
 	ICE_FLTR_PRGM_DESC_DEST_DROP_PKT,
 	ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX,
+	ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP,
+	ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_OTHER,
 };
 
 enum ice_fltr_prgm_desc_fd_status {
@@ -133,6 +135,8 @@ struct ice_fdir_fltr {
 
 	/* flex byte filter data */
 	__be16 flex_word;
+	/* queue region size (=2^q_region) */
+	u8 q_region;
 	u16 flex_offset;
 	u16 flex_fltr;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index de6ec56223e8..f06820af6153 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -904,6 +904,10 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 		struct virtchnl_filter_action *action = &as->actions[i];
 
 		switch (action->type) {
+		case VIRTCHNL_ACTION_PASSTHRU:
+			dest_num++;
+			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_OTHER;
+			break;
 		case VIRTCHNL_ACTION_DROP:
 			dest_num++;
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DROP_PKT;
@@ -913,6 +917,12 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
 			input->q_index = action->act_conf.queue.index;
 			break;
+		case VIRTCHNL_ACTION_Q_REGION:
+			dest_num++;
+			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP;
+			input->q_index = action->act_conf.queue.index;
+			input->q_region = action->act_conf.queue.region;
+			break;
 		case VIRTCHNL_ACTION_MARK:
 			mark_num++;
 			input->fltr_id = action->act_conf.mark_id;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b88740a6663b..c27faeea5200 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -578,7 +578,9 @@ enum virtchnl_action {
 	/* action types */
 	VIRTCHNL_ACTION_DROP = 0,
 	VIRTCHNL_ACTION_TC_REDIRECT,
+	VIRTCHNL_ACTION_PASSTHRU,
 	VIRTCHNL_ACTION_QUEUE,
+	VIRTCHNL_ACTION_Q_REGION,
 	VIRTCHNL_ACTION_MARK,
 	VIRTCHNL_ACTION_COUNT,
 };
-- 
2.13.6

