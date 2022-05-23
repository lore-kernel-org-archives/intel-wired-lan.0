From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Mon, 23 May 2022 11:41:55 +0200
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix switchdev rules book
 keeping
Message-ID: <20220523094155.388032-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Adding two filters with same matching criteria ends up with
one rule in hardware with act = ICE_FWD_TO_VSI_LIST.
In order to remove them properly we have to keep the
information about vsi handle which is used in VSI bitmap
(ice_adv_fltr_mgmt_list_entry::vsi_list_info::vsi_map).

Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
Reported-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v2: compile issue fixed
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 3acd9f921c44..4abf914a3b3e 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -524,6 +524,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	 */
 	fltr->rid = rule_added.rid;
 	fltr->rule_id = rule_added.rule_id;
+	fltr->dest_id = rule_added.vsi_handle;
 
 exit:
 	kfree(list);
-- 
2.31.1

