From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri,  8 Jan 2016 15:58:26 -0800
Subject: [Intel-wired-lan] [v2 next PATCH S23 9/13] i40e: Make some changes
	in the nvm read code
Message-ID: <1452297506-1115-1-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

In X722, NVM reads can't be done through SRCTL registers.
And require AQ calls, which require grabbing the NVM lock.
Unfortunately some paths need the lock to be acquired once
and do a whole bunch of stuff and then release it.
This patch creates an unsafe version of the read calls, so
that it can be called from the paths that need the bulk access.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Acked-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Ia9076e9100c5cf61206a856bd279059d3a052024
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 76 +++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 6100cdd..cdc17c5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -280,7 +280,28 @@ static i40e_status i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
 }
 
 /**
- * i40e_read_nvm_word - Reads Shadow RAM
+ * __i40e_read_nvm_word - Reads nvm word, assumes caller does the locking
+ * @hw: pointer to the HW structure
+ * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
+ * @data: word read from the Shadow RAM
+ *
+ * Reads one 16 bit word from the Shadow RAM using the GLNVM_SRCTL register.
+ **/
+static i40e_status __i40e_read_nvm_word(struct i40e_hw *hw,
+					u16 offset,
+					u16 *data)
+{
+	i40e_status ret_code = 0;
+
+	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
+		ret_code = i40e_read_nvm_word_aq(hw, offset, data);
+	else
+		ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
+	return ret_code;
+}
+
+/**
+ * i40e_read_nvm_word - Reads nvm word and acquire lock if necessary
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
@@ -393,7 +414,31 @@ read_nvm_buffer_aq_exit:
 }
 
 /**
- * i40e_read_nvm_buffer - Reads Shadow RAM buffer
+ * __i40e_read_nvm_buffer - Reads nvm buffer, caller must acquire lock
+ * @hw: pointer to the HW structure
+ * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF).
+ * @words: (in) number of words to read; (out) number of words actually read
+ * @data: words read from the Shadow RAM
+ *
+ * Reads 16 bit words (data buffer) from the SR using the i40e_read_nvm_srrd()
+ * method. The buffer read is preceded by the NVM ownership take
+ * and followed by the release.
+ **/
+static i40e_status __i40e_read_nvm_buffer(struct i40e_hw *hw,
+					  u16 offset,
+					  u16 *words, u16 *data)
+{
+	i40e_status ret_code = 0;
+
+	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
+		ret_code = i40e_read_nvm_buffer_aq(hw, offset, words, data);
+	else
+		ret_code = i40e_read_nvm_buffer_srctl(hw, offset, words, data);
+	return ret_code;
+}
+
+/**
+ * i40e_read_nvm_buffer - Reads Shadow RAM buffer and acuire lock if necessary
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF).
  * @words: (in) number of words to read; (out) number of words actually read
@@ -499,15 +544,17 @@ static i40e_status i40e_calc_nvm_checksum(struct i40e_hw *hw,
 	data = (u16 *)vmem.va;
 
 	/* read pointer to VPD area */
-	ret_code = i40e_read_nvm_word(hw, I40E_SR_VPD_PTR, &vpd_module);
+	ret_code = __i40e_read_nvm_word(hw, I40E_SR_VPD_PTR,
+					&vpd_module);
 	if (ret_code) {
 		ret_code = I40E_ERR_NVM_CHECKSUM;
 		goto i40e_calc_nvm_checksum_exit;
 	}
 
 	/* read pointer to PCIe Alt Auto-load module */
-	ret_code = i40e_read_nvm_word(hw, I40E_SR_PCIE_ALT_AUTO_LOAD_PTR,
-				      &pcie_alt_module);
+	ret_code = __i40e_read_nvm_word(hw,
+					I40E_SR_PCIE_ALT_AUTO_LOAD_PTR,
+					&pcie_alt_module);
 	if (ret_code) {
 		ret_code = I40E_ERR_NVM_CHECKSUM;
 		goto i40e_calc_nvm_checksum_exit;
@@ -521,7 +568,7 @@ static i40e_status i40e_calc_nvm_checksum(struct i40e_hw *hw,
 		if ((i % I40E_SR_SECTOR_SIZE_IN_WORDS) == 0) {
 			u16 words = I40E_SR_SECTOR_SIZE_IN_WORDS;
 
-			ret_code = i40e_read_nvm_buffer(hw, i, &words, data);
+			ret_code = __i40e_read_nvm_buffer(hw, i, &words, data);
 			if (ret_code) {
 				ret_code = I40E_ERR_NVM_CHECKSUM;
 				goto i40e_calc_nvm_checksum_exit;
@@ -593,13 +640,18 @@ i40e_status i40e_validate_nvm_checksum(struct i40e_hw *hw,
 	u16 checksum_sr = 0;
 	u16 checksum_local = 0;
 
-	ret_code = i40e_calc_nvm_checksum(hw, &checksum_local);
-	if (ret_code)
+	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
+		ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
+	if (!ret_code) {
+		ret_code = i40e_calc_nvm_checksum(hw, &checksum_local);
+		if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
+			i40e_release_nvm(hw);
+		if (ret_code)
+			goto i40e_validate_nvm_checksum_exit;
+	} else {
 		goto i40e_validate_nvm_checksum_exit;
+	}
 
-	/* Do not use i40e_read_nvm_word() because we do not want to take
-	 * the synchronization semaphores twice here.
-	 */
 	i40e_read_nvm_word(hw, I40E_SR_SW_CHECKSUM_WORD, &checksum_sr);
 
 	/* Verify read checksum from EEPROM is the same as
@@ -958,6 +1010,7 @@ retry:
 		break;
 
 	case I40E_NVMUPD_CSUM_CON:
+		/* Assumes the caller has acquired the nvm */
 		status = i40e_update_nvm_checksum(hw);
 		if (status) {
 			*perrno = hw->aq.asq_last_status ?
@@ -971,6 +1024,7 @@ retry:
 		break;
 
 	case I40E_NVMUPD_CSUM_LCB:
+		/* Assumes the caller has acquired the nvm */
 		status = i40e_update_nvm_checksum(hw);
 		if (status) {
 			*perrno = hw->aq.asq_last_status ?
-- 
2.1.0

