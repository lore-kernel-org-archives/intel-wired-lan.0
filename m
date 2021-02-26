From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 26 Feb 2021 13:19:29 -0800
Subject: [Intel-wired-lan] [PATCH net 10/13] ice: Fix for dereference of
 NULL pointer
In-Reply-To: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
Message-ID: <20210226211932.46683-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacek Bu?atek <jacekx.bulatek@intel.com>

Add handling of allocation fault for ice_vsi_list_map_info.

Also *fi should not be NULL pointer, it is a reference to raw
data field, so remove this variable and use the reference
directly.

Fixes: 9daf8208dd4d ("ice: Add support for switch filter programming")
Signed-off-by: Jacek Bu?atek <jacekx.bulatek@intel.com>
Co-developed-by: Haiyue Wang <haiyue.wang@intel.com>
Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 67c965a3f5d2..387d3f6cd71e 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1238,6 +1238,9 @@ ice_add_update_vsi_list(struct ice_hw *hw,
 			ice_create_vsi_list_map(hw, &vsi_handle_arr[0], 2,
 						vsi_list_id);
 
+		if (!m_entry->vsi_list_info)
+			return ICE_ERR_NO_MEMORY;
+
 		/* If this entry was large action then the large action needs
 		 * to be updated to point to FWD to VSI list
 		 */
@@ -2220,6 +2223,7 @@ ice_vsi_uses_fltr(struct ice_fltr_mgmt_list_entry *fm_entry, u16 vsi_handle)
 	return ((fm_entry->fltr_info.fltr_act == ICE_FWD_TO_VSI &&
 		 fm_entry->fltr_info.vsi_handle == vsi_handle) ||
 		(fm_entry->fltr_info.fltr_act == ICE_FWD_TO_VSI_LIST &&
+		 fm_entry->vsi_list_info &&
 		 (test_bit(vsi_handle, fm_entry->vsi_list_info->vsi_map))));
 }
 
@@ -2292,14 +2296,12 @@ ice_add_to_vsi_fltr_list(struct ice_hw *hw, u16 vsi_handle,
 		return ICE_ERR_PARAM;
 
 	list_for_each_entry(fm_entry, lkup_list_head, list_entry) {
-		struct ice_fltr_info *fi;
-
-		fi = &fm_entry->fltr_info;
-		if (!fi || !ice_vsi_uses_fltr(fm_entry, vsi_handle))
+		if (!ice_vsi_uses_fltr(fm_entry, vsi_handle))
 			continue;
 
 		status = ice_add_entry_to_vsi_fltr_list(hw, vsi_handle,
-							vsi_list_head, fi);
+							vsi_list_head,
+							&fm_entry->fltr_info);
 		if (status)
 			return status;
 	}
-- 
2.20.1

