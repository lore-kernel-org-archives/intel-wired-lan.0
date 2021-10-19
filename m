From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>
Date: Tue, 19 Oct 2021 05:17:43 -0400
Subject: [Intel-wired-lan] [PATCH 1/1] ice: remove the unused function
 ice_aq_nvm_update_empr
Message-ID: <20211019091743.12046-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function ice_aq_nvm_update_empr is not used, so remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 16 ----------------
 drivers/net/ethernet/intel/ice/ice_nvm.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index fee37a5844cf..bad374bd7ab3 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -1106,22 +1106,6 @@ enum ice_status ice_nvm_write_activate(struct ice_hw *hw, u8 cmd_flags)
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
 }
 
-/**
- * ice_aq_nvm_update_empr
- * @hw: pointer to the HW struct
- *
- * Update empr (0x0709). This command allows SW to
- * request an EMPR to activate new FW.
- */
-enum ice_status ice_aq_nvm_update_empr(struct ice_hw *hw)
-{
-	struct ice_aq_desc desc;
-
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_nvm_update_empr);
-
-	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
-}
-
 /* ice_nvm_set_pkg_data
  * @hw: pointer to the HW struct
  * @del_pkg_data_flag: If is set then the current pkg_data store by FW
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
index c6f05f43d593..925225905491 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.h
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
@@ -39,7 +39,6 @@ enum ice_status
 ice_aq_erase_nvm(struct ice_hw *hw, u16 module_typeid, struct ice_sq_cd *cd);
 enum ice_status ice_nvm_validate_checksum(struct ice_hw *hw);
 enum ice_status ice_nvm_write_activate(struct ice_hw *hw, u8 cmd_flags);
-enum ice_status ice_aq_nvm_update_empr(struct ice_hw *hw);
 enum ice_status
 ice_nvm_set_pkg_data(struct ice_hw *hw, bool del_pkg_data_flag, u8 *data,
 		     u16 length, struct ice_sq_cd *cd);
-- 
2.27.0

