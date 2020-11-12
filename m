From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 Nov 2020 16:43:25 -0800
Subject: [Intel-wired-lan] [net-next PATCH 2/7] ice: refactor interface for
 ice_read_flash_module
In-Reply-To: <20201112004330.2896993-1-jacob.e.keller@intel.com>
References: <20201112004330.2896993-1-jacob.e.keller@intel.com>
Message-ID: <20201112004330.2896993-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice_read_flash_module interface for reading from the various NVM
modules was introduced in commit 682fa08580ac ("ice: read security
revision to ice_nvm_info and ice_orom_info")

It's purpose is two-fold. First, it enables reading data from the CSS
header, used to allow accessing the image security revisions. Second, it
allowed reading from either the 1st or the 2nd NVM bank. This interface
was necessary because the device has two copies of each module. Only one
bank is active at a time, but it could be different for each module. The
driver had to determine which bank was active and then use that to
calculate the offset into the flash to read.

Future plans include allowing access to read not just from the active
flash bank, but also the inactive bank. This will be useful for enabling
display of the version information for a pending flash update.

The current abstraction in ice_read_flash_module is to specify the exact
bank to read. This requires callers to know whether to read from the 1st
or 2nd flash bank. This is the wrong abstraction level, since in most
cases the decision point from a caller's perspective is whether to read
from the active bank or the inactive bank.

Add a new ice_bank_select enumeration, used to indicate whether a flow
wants to read from the active, or inactive flash bank. Refactor
ice_read_flash_module to take this new enumeration instead of a raw
flash bank.

Have ice_read_flash_module select which bank to read from based on the
cached data we load during NVM initialization. With this change, it will
be come easier to implement reading version data from the inactive flash
banks in a future change.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c  | 116 +++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_type.h |   9 ++
 2 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index ed4d6058a90d..0e949114359c 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -233,6 +233,74 @@ void ice_release_nvm(struct ice_hw *hw)
 	ice_release_res(hw, ICE_NVM_RES_ID);
 }
 
+/**
+ * ice_get_flash_bank_offset - Get offset into requested flash bank
+ * @hw: pointer to the HW structure
+ * @bank: whether to read from the active or inactive flash bank
+ * @module: the module to read from
+ *
+ * Based on the module, lookup the module offset from the beginning of the
+ * flash.
+ *
+ * Returns the flash offset. Note that a value of zero is invalid and must be
+ * treated as an error.
+ */
+static u32 ice_get_flash_bank_offset(struct ice_hw *hw, enum ice_bank_select bank, u16 module)
+{
+	struct ice_bank_info *banks = &hw->flash.banks;
+	enum ice_flash_bank active_bank;
+	bool second_bank_active;
+	u32 offset, size;
+
+	switch (module) {
+	case ICE_SR_1ST_NVM_BANK_PTR:
+		offset = banks->nvm_ptr;
+		size = banks->nvm_size;
+		active_bank = banks->nvm_bank;
+		break;
+	case ICE_SR_1ST_OROM_BANK_PTR:
+		offset = banks->orom_ptr;
+		size = banks->orom_size;
+		active_bank = banks->orom_bank;
+		break;
+	case ICE_SR_NETLIST_BANK_PTR:
+		offset = banks->netlist_ptr;
+		size = banks->netlist_size;
+		active_bank = banks->netlist_bank;
+		break;
+	default:
+		ice_debug(hw, ICE_DBG_NVM, "Unexpected value for flash module: 0x%04x\n", module);
+		return 0;
+	}
+
+	switch (active_bank) {
+	case ICE_1ST_FLASH_BANK:
+		second_bank_active = false;
+		break;
+	case ICE_2ND_FLASH_BANK:
+		second_bank_active = true;
+		break;
+	default:
+		ice_debug(hw, ICE_DBG_NVM, "Unexpected value for active flash bank: %u\n",
+			  active_bank);
+		return 0;
+	}
+
+	/* The second flash bank is stored immediately following the first
+	 * bank. Based on whether the 1st or 2nd bank is active, and whether
+	 * we want the active or inactive bank, calculate the desired offset.
+	 */
+	switch (bank) {
+	case ICE_ACTIVE_FLASH_BANK:
+		return offset + (second_bank_active ? size : 0);
+	case ICE_INACTIVE_FLASH_BANK:
+		return offset + (second_bank_active ? 0 : size);
+	}
+
+	ice_debug(hw, ICE_DBG_NVM, "Unexpected value for flash bank selection: %u\n", bank);
+	return 0;
+}
+
 /**
  * ice_read_flash_module - Read a word from one of the main NVM modules
  * @hw: pointer to the HW structure
@@ -241,47 +309,27 @@ void ice_release_nvm(struct ice_hw *hw)
  * @offset: the offset into the module in words
  * @data: storage for the word read from the flash
  *
- * Read a word from the specified bank of the module. The bank must be either
- * the 1st or 2nd bank. The word will be read using flat NVM access, and
- * relies on the hw->flash.banks data being setup by
- * ice_determine_active_flash_banks() during initialization.
+ * Read a word from the specified flash module. The bank parameter indicates
+ * whether or not to read from the active bank or the inactive bank of that
+ * module.
+ *
+ * The word will be read using flat NVM access, and relies on the
+ * hw->flash.banks data being setup by ice_determine_active_flash_banks()
+ * during initialization.
  */
 static enum ice_status
-ice_read_flash_module(struct ice_hw *hw, enum ice_flash_bank bank, u16 module,
+ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
 		      u32 offset, u16 *data)
 {
-	struct ice_bank_info *banks = &hw->flash.banks;
 	u32 bytes = sizeof(u16);
 	enum ice_status status;
 	__le16 data_local;
-	bool second_bank;
 	u32 start;
 
-	switch (bank) {
-	case ICE_1ST_FLASH_BANK:
-		second_bank = false;
-		break;
-	case ICE_2ND_FLASH_BANK:
-		second_bank = true;
-		break;
-	case ICE_INVALID_FLASH_BANK:
-	default:
-		ice_debug(hw, ICE_DBG_NVM, "Unexpected flash bank %u\n", bank);
-		return ICE_ERR_PARAM;
-	}
-
-	switch (module) {
-	case ICE_SR_1ST_NVM_BANK_PTR:
-		start = banks->nvm_ptr + (second_bank ? banks->nvm_size : 0);
-		break;
-	case ICE_SR_1ST_OROM_BANK_PTR:
-		start = banks->orom_ptr + (second_bank ? banks->orom_size : 0);
-		break;
-	case ICE_SR_NETLIST_BANK_PTR:
-		start = banks->netlist_ptr + (second_bank ? banks->netlist_size : 0);
-		break;
-	default:
-		ice_debug(hw, ICE_DBG_NVM, "Unexpected flash module 0x%04x\n", module);
+	start = ice_get_flash_bank_offset(hw, bank, module);
+	if (!start) {
+		ice_debug(hw, ICE_DBG_NVM, "Unable to calculate flash bank offset for module 0x%04x\n",
+			  module);
 		return ICE_ERR_PARAM;
 	}
 
@@ -311,7 +359,7 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_flash_bank bank, u16 module,
 static enum ice_status
 ice_read_active_nvm_module(struct ice_hw *hw, u32 offset, u16 *data)
 {
-	return ice_read_flash_module(hw, hw->flash.banks.nvm_bank,
+	return ice_read_flash_module(hw, ICE_ACTIVE_FLASH_BANK,
 				     ICE_SR_1ST_NVM_BANK_PTR, offset, data);
 }
 
@@ -328,7 +376,7 @@ ice_read_active_nvm_module(struct ice_hw *hw, u32 offset, u16 *data)
 static enum ice_status
 ice_read_active_orom_module(struct ice_hw *hw, u32 offset, u16 *data)
 {
-	return ice_read_flash_module(hw, hw->flash.banks.orom_bank,
+	return ice_read_flash_module(hw, ICE_ACTIVE_FLASH_BANK,
 				     ICE_SR_1ST_OROM_BANK_PTR, offset, data);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 6217e8b22cc2..b9230c9158e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -350,6 +350,15 @@ enum ice_flash_bank {
 	ICE_2ND_FLASH_BANK,
 };
 
+/* Enumeration of which flash bank is desired to read from, either the active
+ * bank or the inactive bank. Used to abstract 1st and 2nd bank notion from
+ * code which just wants to read the active or inactive flash bank.
+ */
+enum ice_bank_select {
+	ICE_ACTIVE_FLASH_BANK,
+	ICE_INACTIVE_FLASH_BANK,
+};
+
 /* information for accessing NVM, OROM, and Netlist flash banks */
 struct ice_bank_info {
 	u32 nvm_ptr;				/* Pointer to 1st NVM bank */
-- 
2.29.0

