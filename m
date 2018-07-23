From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon, 23 Jul 2018 10:37:40 -0700
Subject: [Intel-wired-lan] [PATCH 01/13] ice: Fix static analyser warning
In-Reply-To: <20180723173752.19676-1-anirudh.venkataramanan@intel.com>
References: <20180723173752.19676-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180723173752.19676-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes one of the smatch (a static analysis tool) warnings
reported by Dan Carpenter. ICE_LG_ACT_GENERIC_OFFSET_M is the right mask
to use but it appears that ICE_LG_ACT_GENERIC_VALUE_M was used instead,
which resulted in the following smatch warning:

ice_add_marker_act() warn: odd binop '0x380000 & 0x7fff8'

Additionally, use a new define ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX
instead of magic number '7'.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
 drivers/net/ethernet/intel/ice/ice_switch.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 7541ec2270b3..6d3e11659ba5 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -594,6 +594,7 @@ struct ice_sw_rule_lg_act {
 #define ICE_LG_ACT_GENERIC_OFFSET_M	(0x7 << ICE_LG_ACT_GENERIC_OFFSET_S)
 #define ICE_LG_ACT_GENERIC_PRIORITY_S	22
 #define ICE_LG_ACT_GENERIC_PRIORITY_M	(0x7 << ICE_LG_ACT_GENERIC_PRIORITY_S)
+#define ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX	7
 
 	/* Action = 7 - Set Stat count */
 #define ICE_LG_ACT_STAT_COUNT		0x7
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 723d15f1e90b..750d2051a976 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -645,7 +645,8 @@ ice_add_marker_act(struct ice_hw *hw, struct ice_fltr_mgmt_list_entry *m_ent,
 	act |= (1 << ICE_LG_ACT_GENERIC_VALUE_S) & ICE_LG_ACT_GENERIC_VALUE_M;
 	lg_act->pdata.lg_act.act[1] = cpu_to_le32(act);
 
-	act = (7 << ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_VALUE_M;
+	act = (ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX <<
+	       ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_OFFSET_M;
 
 	/* Third action Marker value */
 	act |= ICE_LG_ACT_GENERIC;
-- 
2.14.3

