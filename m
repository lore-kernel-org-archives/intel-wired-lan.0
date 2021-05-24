From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Date: Mon, 24 May 2021 16:39:01 +0800
Subject: [Intel-wired-lan] [PATCH] ice: Remove the repeated declaration
Message-ID: <1621845541-41556-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Function 'ice_is_vsi_valid' is declared twice, remove the
repeated declaration.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 8b4f9d35c860..8fab89f146f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -243,7 +243,6 @@ ice_set_vlan_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
 
 enum ice_status ice_init_def_sw_recp(struct ice_hw *hw);
 u16 ice_get_hw_vsi_num(struct ice_hw *hw, u16 vsi_handle);
-bool ice_is_vsi_valid(struct ice_hw *hw, u16 vsi_handle);
 
 enum ice_status ice_replay_vsi_all_fltr(struct ice_hw *hw, u16 vsi_handle);
 void ice_rm_all_sw_replay_rule_info(struct ice_hw *hw);
-- 
2.7.4

