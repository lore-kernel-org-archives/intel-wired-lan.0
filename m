From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:33 -0700
Subject: [Intel-wired-lan] [PATCH 10/16] ice: Fix forward to queue group
 logic
In-Reply-To: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002339.11107-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When adding a rule, queue region size needs to be provided as log base 2
of the number of queues in region. Fix that.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 47815359e2ec..822442fee327 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -656,6 +656,7 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 	u8 *eth_hdr;
 	u32 act = 0;
 	__be16 *off;
+	u8 q_rgn;
 
 	if (opc == ice_aqc_opc_remove_sw_rules) {
 		s_rule->pdata.lkup_tx_rx.act = 0;
@@ -694,14 +695,19 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 		act |= (f_info->fwd_id.q_id << ICE_SINGLE_ACT_Q_INDEX_S) &
 			ICE_SINGLE_ACT_Q_INDEX_M;
 		break;
+	case ICE_DROP_PACKET:
+		act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP |
+			ICE_SINGLE_ACT_VALID_BIT;
+		break;
 	case ICE_FWD_TO_QGRP:
+		q_rgn = f_info->qgrp_size > 0 ?
+			(u8)ilog2(f_info->qgrp_size) : 0;
 		act |= ICE_SINGLE_ACT_TO_Q;
-		act |= (f_info->qgrp_size << ICE_SINGLE_ACT_Q_REGION_S) &
+		act |= (f_info->fwd_id.q_id << ICE_SINGLE_ACT_Q_INDEX_S) &
+			ICE_SINGLE_ACT_Q_INDEX_M;
+		act |= (q_rgn << ICE_SINGLE_ACT_Q_REGION_S) &
 			ICE_SINGLE_ACT_Q_REGION_M;
 		break;
-	case ICE_DROP_PACKET:
-		act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP;
-		break;
 	default:
 		return;
 	}
-- 
2.14.3

