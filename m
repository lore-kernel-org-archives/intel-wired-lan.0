From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 Nov 2020 16:43:27 -0800
Subject: [Intel-wired-lan] [net-next PATCH 4/7] ice: allow reading arbitrary
 size data with read_flash_module
In-Reply-To: <20201112004330.2896993-1-jacob.e.keller@intel.com>
References: <20201112004330.2896993-1-jacob.e.keller@intel.com>
Message-ID: <20201112004330.2896993-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Refactor ice_read_flash_module so that it takes a size and a length
value, rather than always reading in 2-byte increments. The
ice_read_nvm_module and ice_read_orom_module wrapper functions will
still read a u16 with the byte-swapping enabled.

This will be used in a future change to implement reading of the CIVD
data from the Option ROM module.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 34 ++++++++++++++++--------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 88a9e17744f3..ff99815402d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -306,10 +306,11 @@ static u32 ice_get_flash_bank_offset(struct ice_hw *hw, enum ice_bank_select ban
  * @hw: pointer to the HW structure
  * @bank: which bank of the module to read
  * @module: the module to read
- * @offset: the offset into the module in words
+ * @offset: the offset into the module in bytes
  * @data: storage for the word read from the flash
+ * @length: bytes of data to read
  *
- * Read a word from the specified flash module. The bank parameter indicates
+ * Read data from the specified flash module. The bank parameter indicates
  * whether or not to read from the active bank or the inactive bank of that
  * module.
  *
@@ -319,11 +320,9 @@ static u32 ice_get_flash_bank_offset(struct ice_hw *hw, enum ice_bank_select ban
  */
 static enum ice_status
 ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
-		      u32 offset, u16 *data)
+		      u32 offset, u8 *data, u32 length)
 {
-	u32 bytes = sizeof(u16);
 	enum ice_status status;
-	__le16 data_local;
 	u32 start;
 
 	start = ice_get_flash_bank_offset(hw, bank, module);
@@ -337,10 +336,7 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
 	if (status)
 		return status;
 
-	status = ice_read_flat_nvm(hw, start + offset * sizeof(u16), &bytes,
-				   (__force u8 *)&data_local, false);
-	if (!status)
-		*data = le16_to_cpu(data_local);
+	status = ice_read_flat_nvm(hw, start + offset, &length, data, false);
 
 	ice_release_nvm(hw);
 
@@ -360,7 +356,15 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
 static enum ice_status
 ice_read_nvm_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u16 *data)
 {
-	return ice_read_flash_module(hw, bank, ICE_SR_1ST_NVM_BANK_PTR, offset, data);
+	enum ice_status status;
+	__le16 data_local;
+
+	status = ice_read_flash_module(hw, bank, ICE_SR_1ST_NVM_BANK_PTR, offset * sizeof(u16),
+				       (__force u8 *)&data_local, sizeof(u16));
+	if (!status)
+		*data = le16_to_cpu(data_local);
+
+	return status;
 }
 
 /**
@@ -377,7 +381,15 @@ ice_read_nvm_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u1
 static enum ice_status
 ice_read_orom_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset, u16 *data)
 {
-	return ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR, offset, data);
+	enum ice_status status;
+	__le16 data_local;
+
+	status = ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR, offset * sizeof(u16),
+				       (__force u8 *)&data_local, sizeof(u16));
+	if (!status)
+		*data = le16_to_cpu(data_local);
+
+	return status;
 }
 
 /**
-- 
2.29.0

