From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Tue, 22 Dec 2015 14:25:06 -0800
Subject: [Intel-wired-lan] [next PATCH S24 04/12] i40e: X722 changes to
	access nvm
In-Reply-To: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450823114-29514-5-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

X722 does not have access to SRCTL registers, it has to do this through
the AQ.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 49 ++++++++++++++++++------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 79c0053..59edd33 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -212,24 +212,6 @@ read_nvm_exit:
 }
 
 /**
- * __i40e_read_nvm_word - Reads nvm word, assumes caller does the locking
- * @hw: pointer to the HW structure
- * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
- * @data: word read from the Shadow RAM
- *
- * Reads one 16 bit word from the Shadow RAM using the GLNVM_SRCTL register.
- **/
-static i40e_status __i40e_read_nvm_word(struct i40e_hw *hw,
-					u16 offset,
-					u16 *data)
-{
-	i40e_status ret_code = 0;
-
-	ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
-	return ret_code;
-}
-
-/**
  * i40e_read_nvm_aq - Read Shadow RAM.
  * @hw: pointer to the HW structure.
  * @module_pointer: module pointer location in words from the NVM beginning
@@ -298,6 +280,32 @@ static i40e_status i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
 }
 
 /**
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
+	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
+		ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
+		if (!ret_code) {
+			ret_code = i40e_read_nvm_word_aq(hw, offset, data);
+			i40e_release_nvm(hw);
+		}
+	} else {
+			ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
+	}
+	return ret_code;
+}
+
+/**
  * i40e_read_nvm_word - Reads nvm word and acquire lock if necessary
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
@@ -427,7 +435,10 @@ static i40e_status __i40e_read_nvm_buffer(struct i40e_hw *hw,
 {
 	i40e_status ret_code = 0;
 
-	ret_code = i40e_read_nvm_buffer_srctl(hw, offset, words, data);
+	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
+		ret_code = i40e_read_nvm_buffer_aq(hw, offset, words, data);
+	else
+		ret_code = i40e_read_nvm_buffer_srctl(hw, offset, words, data);
 	return ret_code;
 }
 
-- 
2.1.0

