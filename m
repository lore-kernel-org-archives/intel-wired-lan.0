From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  8 Nov 2019 06:23:24 -0800
Subject: [Intel-wired-lan] [PATCH S33 08/15] ice: Refactor removal of VLAN
 promiscuous rules
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <20191108142331.10221-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently ice_clear_vsi_promisc() detects if the VLAN ID sent is not 0
and sets the recipe_id to ICE_SW_LKUP_PROMISC_VLAN in that case and
ICE_SW_LKUP_PROMISC if the VLAN_ID is 0. However this doesn't allow VLAN
0 promiscuous rules to be removed, but they can be added. Fix this by
checking if the promisc_mask contains ICE_PROMISC_VLAN_RX or
ICE_PROMISC_VLAN_TX. This change was made to match what is being done
for ice_set_vsi_promisc().

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 77d211ea3aae..b5a53f862a83 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2428,7 +2428,7 @@ ice_clear_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
 	if (!ice_is_vsi_valid(hw, vsi_handle))
 		return ICE_ERR_PARAM;
 
-	if (vid)
+	if (promisc_mask & (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX))
 		recipe_id = ICE_SW_LKUP_PROMISC_VLAN;
 	else
 		recipe_id = ICE_SW_LKUP_PROMISC;
@@ -2440,13 +2440,18 @@ ice_clear_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
 
 	mutex_lock(rule_lock);
 	list_for_each_entry(itr, rule_head, list_entry) {
+		struct ice_fltr_info *fltr_info;
 		u8 fltr_promisc_mask = 0;
 
 		if (!ice_vsi_uses_fltr(itr, vsi_handle))
 			continue;
+		fltr_info = &itr->fltr_info;
+
+		if (recipe_id == ICE_SW_LKUP_PROMISC_VLAN &&
+		    vid != fltr_info->l_data.mac_vlan.vlan_id)
+			continue;
 
-		fltr_promisc_mask |=
-			ice_determine_promisc_mask(&itr->fltr_info);
+		fltr_promisc_mask |= ice_determine_promisc_mask(fltr_info);
 
 		/* Skip if filter is not completely specified by given mask */
 		if (fltr_promisc_mask & ~promisc_mask)
@@ -2454,7 +2459,7 @@ ice_clear_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
 
 		status = ice_add_entry_to_vsi_fltr_list(hw, vsi_handle,
 							&remove_list_head,
-							&itr->fltr_info);
+							fltr_info);
 		if (status) {
 			mutex_unlock(rule_lock);
 			goto free_fltr_list;
-- 
2.20.1

