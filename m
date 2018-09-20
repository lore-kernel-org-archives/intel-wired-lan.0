From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:35 -0700
Subject: [Intel-wired-lan] [PATCH 12/16] ice: Fix potential null pointer
 issues
In-Reply-To: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002339.11107-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

Add checks in the filter handling flow to avoid dereferencing
NULL pointers.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> minor cleanup for upstream submission]
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index c6d673bd5eaa..2a3d4a72ab3c 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2010,12 +2010,12 @@ ice_cfg_dflt_vsi(struct ice_hw *hw, u16 vsi_handle, bool set, u8 direction)
 enum ice_status
 ice_remove_mac(struct ice_hw *hw, struct list_head *m_list)
 {
-	struct ice_fltr_list_entry *list_itr;
+	struct ice_fltr_list_entry *list_itr, *tmp;
 
 	if (!m_list)
 		return ICE_ERR_PARAM;
 
-	list_for_each_entry(list_itr, m_list, list_entry) {
+	list_for_each_entry_safe(list_itr, tmp, m_list, list_entry) {
 		enum ice_sw_lkup_type l_type = list_itr->fltr_info.lkup_type;
 
 		if (l_type != ICE_SW_LKUP_MAC)
@@ -2037,12 +2037,12 @@ ice_remove_mac(struct ice_hw *hw, struct list_head *m_list)
 enum ice_status
 ice_remove_vlan(struct ice_hw *hw, struct list_head *v_list)
 {
-	struct ice_fltr_list_entry *v_list_itr;
+	struct ice_fltr_list_entry *v_list_itr, *tmp;
 
 	if (!v_list || !hw)
 		return ICE_ERR_PARAM;
 
-	list_for_each_entry(v_list_itr, v_list, list_entry) {
+	list_for_each_entry_safe(v_list_itr, tmp, v_list, list_entry) {
 		enum ice_sw_lkup_type l_type = v_list_itr->fltr_info.lkup_type;
 
 		if (l_type != ICE_SW_LKUP_VLAN)
@@ -2142,7 +2142,7 @@ ice_add_to_vsi_fltr_list(struct ice_hw *hw, u16 vsi_handle,
 		struct ice_fltr_info *fi;
 
 		fi = &fm_entry->fltr_info;
-		if (!ice_vsi_uses_fltr(fm_entry, vsi_handle))
+		if (!fi || !ice_vsi_uses_fltr(fm_entry, vsi_handle))
 			continue;
 
 		status = ice_add_entry_to_vsi_fltr_list(hw, vsi_handle,
@@ -2259,7 +2259,8 @@ ice_replay_vsi_fltr(struct ice_hw *hw, u16 vsi_handle, u8 recp_id,
 				goto end;
 			continue;
 		}
-		if (!test_bit(vsi_handle, itr->vsi_list_info->vsi_map))
+		if (!itr->vsi_list_info ||
+		    !test_bit(vsi_handle, itr->vsi_list_info->vsi_map))
 			continue;
 		/* Clearing it so that the logic can add it back */
 		clear_bit(vsi_handle, itr->vsi_list_info->vsi_map);
-- 
2.14.3

