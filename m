From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Tue, 26 Oct 2021 12:38:39 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: replay advanced rules
 after reset
In-Reply-To: <20211026103840.11455-1-wojciech.drewek@intel.com>
References: <20211026103840.11455-1-wojciech.drewek@intel.com>
Message-ID: <20211026103840.11455-2-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Victor Raj <victor.raj@intel.com>

ice_replay_vsi_adv_rule will replay advanced rules for a given VSI.
Exit this function when list of rules for given recipe is empty.
Do not add rule when given vsi_handle does not match vsi_handle
from the rule info.

Use ICE_MAX_NUM_RECIPES instead of ICE_SW_LKUP_LAST in order to find
advanced rules as well.

Signed-off-by: Victor Raj <victor.raj@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_switch.c | 41 +++++++++++++++++++--
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 26f0774136ae..ef45cd1506a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4604,7 +4604,7 @@ static int ice_replay_pre_init(struct ice_hw *hw)
 	 * will allow adding rules entries back to filt_rules list,
 	 * which is operational list.
 	 */
-	for (i = 0; i < ICE_SW_LKUP_LAST; i++)
+	for (i = 0; i < ICE_MAX_NUM_RECIPES; i++)
 		list_replace_init(&sw->recp_list[i].filt_rules,
 				  &sw->recp_list[i].filt_replay_rules);
 	ice_sched_replay_agg_vsi_preinit(hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index de08ec08158d..ac54ec34bd8f 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -5659,6 +5659,38 @@ ice_rem_adv_rule_by_id(struct ice_hw *hw,
 	return -ENOENT;
 }
 
+/**
+ * ice_replay_vsi_adv_rule - Replay advanced rule for requested VSI
+ * @hw: pointer to the hardware structure
+ * @vsi_handle: driver VSI handle
+ * @list_head: list for which filters need to be replayed
+ *
+ * Replay the advanced rule for the given VSI.
+ */
+static int
+ice_replay_vsi_adv_rule(struct ice_hw *hw, u16 vsi_handle,
+			struct list_head *list_head)
+{
+	struct ice_rule_query_data added_entry = { 0 };
+	struct ice_adv_fltr_mgmt_list_entry *adv_fltr;
+	int status = 0;
+
+	if (list_empty(list_head))
+		return status;
+	list_for_each_entry(adv_fltr, list_head, list_entry) {
+		struct ice_adv_rule_info *rinfo = &adv_fltr->rule_info;
+		u16 lk_cnt = adv_fltr->lkups_cnt;
+
+		if (vsi_handle != rinfo->sw_act.vsi_handle)
+			continue;
+		status = ice_add_adv_rule(hw, adv_fltr->lkups, lk_cnt, rinfo,
+					  &added_entry);
+		if (status)
+			break;
+	}
+	return status;
+}
+
 /**
  * ice_replay_vsi_all_fltr - replay all filters stored in bookkeeping lists
  * @hw: pointer to the hardware structure
@@ -5669,14 +5701,17 @@ ice_rem_adv_rule_by_id(struct ice_hw *hw,
 int ice_replay_vsi_all_fltr(struct ice_hw *hw, u16 vsi_handle)
 {
 	struct ice_switch_info *sw = hw->switch_info;
-	int status = 0;
+	int status;
 	u8 i;
 
-	for (i = 0; i < ICE_SW_LKUP_LAST; i++) {
+	for (i = 0; i < ICE_MAX_NUM_RECIPES; i++) {
 		struct list_head *head;
 
 		head = &sw->recp_list[i].filt_replay_rules;
-		status = ice_replay_vsi_fltr(hw, vsi_handle, i, head);
+		if (!sw->recp_list[i].adv_rule)
+			status = ice_replay_vsi_fltr(hw, vsi_handle, i, head);
+		else
+			status = ice_replay_vsi_adv_rule(hw, vsi_handle, head);
 		if (status)
 			return status;
 	}
-- 
2.31.1

