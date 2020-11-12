From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 Nov 2020 16:43:26 -0800
Subject: [Intel-wired-lan] [net-next PATCH 3/7] ice: allow reading inactive
 flash security revision
In-Reply-To: <20201112004330.2896993-1-jacob.e.keller@intel.com>
References: <20201112004330.2896993-1-jacob.e.keller@intel.com>
Message-ID: <20201112004330.2896993-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Modify ice_get_nvm_srev and ice_get_orom_srev to take the
ice_flash_bank enumeration that specifies whether to read from the
active or the inactive flash module. Rename and refactor the
ice_read_active_nvm_module and ice_read_active_orom_module functions to
take the bank enum value as well.

With this change, ice_get_nvm_srev and ice_get_orom_srev will be usable
in a future change to implement reading the version data for a pending
flash image.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 36 +++++++++++++-----------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 0e949114359c..88a9e17744f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -348,8 +348,9 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
 }
 
 /**
- * ice_read_active_nvm_module - Read from the active main NVM module
+ * ice_read_nvm_module - Read from the active main NVM module
  * @hw: pointer to the HW structure
+ * @bank: whether to read from active or inactive NVM module
  * @offset: offset into the NVM module to read, in words
  * @data: storage for returned word value
  *
@@ -357,15 +358,15 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
  * header at the start of the NVM module.
  */
 static enum ice_status
-ice_read_active_nvm_module(struct ice_hw *hw, u32 offset, u16 *data)
+ice_read_nvm_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u16 *data)
 {
-	return ice_read_flash_module(hw, ICE_ACTIVE_FLASH_BANK,
-				     ICE_SR_1ST_NVM_BANK_PTR, offset, data);
+	return ice_read_flash_module(hw, bank, ICE_SR_1ST_NVM_BANK_PTR, offset, data);
 }
 
 /**
- * ice_read_active_orom_module - Read from the active Option ROM module
+ * ice_read_orom_module - Read from the active Option ROM module
  * @hw: pointer to the HW structure
+ * @bank: whether to read from active or inactive OROM module
  * @offset: offset into the OROM module to read, in words
  * @data: storage for returned word value
  *
@@ -374,10 +375,9 @@ ice_read_active_nvm_module(struct ice_hw *hw, u32 offset, u16 *data)
  * module instead of at the beginning.
  */
 static enum ice_status
-ice_read_active_orom_module(struct ice_hw *hw, u32 offset, u16 *data)
+ice_read_orom_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u16 *data)
 {
-	return ice_read_flash_module(hw, ICE_ACTIVE_FLASH_BANK,
-				     ICE_SR_1ST_OROM_BANK_PTR, offset, data);
+	return ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR, offset, data);
 }
 
 /**
@@ -529,21 +529,22 @@ ice_read_pba_string(struct ice_hw *hw, u8 *pba_num, u32 pba_num_size)
 /**
  * ice_get_nvm_srev - Read the security revision from the NVM CSS header
  * @hw: pointer to the HW struct
+ * @bank: whether to read from the active or inactive flash bank
  * @srev: storage for security revision
  *
  * Read the security revision out of the CSS header of the active NVM module
  * bank.
  */
-static enum ice_status ice_get_nvm_srev(struct ice_hw *hw, u32 *srev)
+static enum ice_status ice_get_nvm_srev(struct ice_hw *hw, enum ice_bank_select bank, u32 *srev)
 {
 	enum ice_status status;
 	u16 srev_l, srev_h;
 
-	status = ice_read_active_nvm_module(hw, ICE_NVM_CSS_SREV_L, &srev_l);
+	status = ice_read_nvm_module(hw, bank, ICE_NVM_CSS_SREV_L, &srev_l);
 	if (status)
 		return status;
 
-	status = ice_read_active_nvm_module(hw, ICE_NVM_CSS_SREV_H, &srev_h);
+	status = ice_read_nvm_module(hw, bank, ICE_NVM_CSS_SREV_H, &srev_h);
 	if (status)
 		return status;
 
@@ -587,7 +588,7 @@ ice_get_nvm_ver_info(struct ice_hw *hw, struct ice_nvm_info *nvm)
 
 	nvm->eetrack = (eetrack_hi << 16) | eetrack_lo;
 
-	status = ice_get_nvm_srev(hw, &nvm->srev);
+	status = ice_get_nvm_srev(hw, ICE_ACTIVE_FLASH_BANK, &nvm->srev);
 	if (status)
 		ice_debug(hw, ICE_DBG_NVM, "Failed to read NVM security revision.\n");
 
@@ -597,12 +598,13 @@ ice_get_nvm_ver_info(struct ice_hw *hw, struct ice_nvm_info *nvm)
 /**
  * ice_get_orom_srev - Read the security revision from the OROM CSS header
  * @hw: pointer to the HW struct
+ * @bank: whether to read from active or inactive flash module
  * @srev: storage for security revision
  *
  * Read the security revision out of the CSS header of the active OROM module
  * bank.
  */
-static enum ice_status ice_get_orom_srev(struct ice_hw *hw, u32 *srev)
+static enum ice_status ice_get_orom_srev(struct ice_hw *hw, enum ice_bank_select bank, u32 *srev)
 {
 	enum ice_status status;
 	u16 srev_l, srev_h;
@@ -615,16 +617,16 @@ static enum ice_status ice_get_orom_srev(struct ice_hw *hw, u32 *srev)
 	}
 
 	/* calculate how far into the Option ROM the CSS header starts. Note
-	 * that ice_read_active_orom_module takes a word offset so we need to
+	 * that ice_read_orom_module takes a word offset so we need to
 	 * divide by 2 here.
 	 */
 	css_start = (hw->flash.banks.orom_size - ICE_NVM_OROM_TRAILER_LENGTH) / 2;
 
-	status = ice_read_active_orom_module(hw, css_start + ICE_NVM_CSS_SREV_L, &srev_l);
+	status = ice_read_orom_module(hw, bank, css_start + ICE_NVM_CSS_SREV_L, &srev_l);
 	if (status)
 		return status;
 
-	status = ice_read_active_orom_module(hw, css_start + ICE_NVM_CSS_SREV_H, &srev_h);
+	status = ice_read_orom_module(hw, bank, css_start + ICE_NVM_CSS_SREV_H, &srev_h);
 	if (status)
 		return status;
 
@@ -685,7 +687,7 @@ ice_get_orom_ver_info(struct ice_hw *hw, struct ice_orom_info *orom)
 	orom->build = (u16)((combo_ver & ICE_OROM_VER_BUILD_MASK) >>
 			    ICE_OROM_VER_BUILD_SHIFT);
 
-	status = ice_get_orom_srev(hw, &orom->srev);
+	status = ice_get_orom_srev(hw, ICE_ACTIVE_FLASH_BANK, &orom->srev);
 	if (status)
 		ice_debug(hw, ICE_DBG_NVM, "Failed to read Option ROM security revision.\n");
 
-- 
2.29.0

