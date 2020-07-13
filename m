From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:08 -0700
Subject: [Intel-wired-lan] [PATCH S50 05/15] ice: return correct error code
 from ice_aq_sw_rules
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

Return ICE_ERR_DOES_NOT_EXIST return code if admin command error code is
ICE_AQ_RC_ENOENT (not exist). ice_aq_sw_rules is used when switch
rule is getting added/deleted/updated. In case of delete/update
switch rule, admin command can return ICE_AQ_RC_ENOENT error code
if such rule does not exist, hence return ICE_ERR_DOES_NOT_EXIST error
code from ice_aq_sw_rule, so that caller of this function can decide
how to handle ICE_ERR_DOES_NOT_EXIST.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index ee434b8d794d..cd23c15d6579 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -481,6 +481,7 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list, u16 rule_list_sz,
 		u8 num_rules, enum ice_adminq_opc opc, struct ice_sq_cd *cd)
 {
 	struct ice_aq_desc desc;
+	enum ice_status status;
 
 	if (opc != ice_aqc_opc_add_sw_rules &&
 	    opc != ice_aqc_opc_update_sw_rules &&
@@ -492,7 +493,12 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list, u16 rule_list_sz,
 	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
 	desc.params.sw_rules.num_rules_fltr_entry_index =
 		cpu_to_le16(num_rules);
-	return ice_aq_send_cmd(hw, &desc, rule_list, rule_list_sz, cd);
+	status = ice_aq_send_cmd(hw, &desc, rule_list, rule_list_sz, cd);
+	if (opc != ice_aqc_opc_add_sw_rules &&
+	    hw->adminq.sq_last_status == ICE_AQ_RC_ENOENT)
+		status = ICE_ERR_DOES_NOT_EXIST;
+
+	return status;
 }
 
 /* ice_init_port_info - Initialize port_info with switch configuration data
-- 
2.20.1

