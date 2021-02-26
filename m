From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 26 Feb 2021 13:19:32 -0800
Subject: [Intel-wired-lan] [PATCH net 13/13] ice: Cleanup fltr list in case
 of allocation issues
In-Reply-To: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
Message-ID: <20210226211932.46683-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Robert Malz <robertx.malz@intel.com>

When ice_remove_vsi_lkup_fltr is called, by calling
ice_add_to_vsi_fltr_list local copy of vsi filter list
is created. If any issues during creation of vsi filter
list occurs it up for the caller to free already
allocated memory. This patch ensures proper memory
deallocation in these cases.

Fixes: 80d144c9ac82 ("ice: Refactor switch rule management structures and functions")
Signed-off-by: Robert Malz <robertx.malz@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 387d3f6cd71e..834cbd3f7b31 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2624,7 +2624,7 @@ ice_remove_vsi_lkup_fltr(struct ice_hw *hw, u16 vsi_handle,
 					  &remove_list_head);
 	mutex_unlock(rule_lock);
 	if (status)
-		return;
+		goto free_fltr_list;
 
 	switch (lkup) {
 	case ICE_SW_LKUP_MAC:
@@ -2647,6 +2647,7 @@ ice_remove_vsi_lkup_fltr(struct ice_hw *hw, u16 vsi_handle,
 		break;
 	}
 
+free_fltr_list:
 	list_for_each_entry_safe(fm_entry, tmp, &remove_list_head, list_entry) {
 		list_del(&fm_entry->list_entry);
 		devm_kfree(ice_hw_to_dev(hw), fm_entry);
-- 
2.20.1

