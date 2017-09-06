From: Stefano Brivio <sbrivio@redhat.com>
Date: Wed,  6 Sep 2017 10:11:39 +0200
Subject: [Intel-wired-lan] [PATCH net 2/2] i40e: Avoid some useless
	variables and initializers in nvm functions
In-Reply-To: <cover.1504684488.git.sbrivio@redhat.com>
References: <cover.1504684488.git.sbrivio@redhat.com>
Message-ID: <d0881adf53a3f0a546b3e7940b92b4ce938e7e50.1504684488.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes: 09f79fd49d94 ("i40e: avoid NVM acquire deadlock during NVM update")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 200779d5c124..4a8a81cd3e32 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -294,13 +294,10 @@ static i40e_status i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
 static i40e_status __i40e_read_nvm_word(struct i40e_hw *hw,
 					u16 offset, u16 *data)
 {
-	i40e_status ret_code = 0;
-
 	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
-		ret_code = i40e_read_nvm_word_aq(hw, offset, data);
-	else
-		ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
-	return ret_code;
+		return i40e_read_nvm_word_aq(hw, offset, data);
+
+	return i40e_read_nvm_word_srctl(hw, offset, data);
 }
 
 /**
@@ -314,7 +311,7 @@ static i40e_status __i40e_read_nvm_word(struct i40e_hw *hw,
 i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 			       u16 *data)
 {
-	i40e_status ret_code = 0;
+	i40e_status ret_code;
 
 	ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
 	if (ret_code)
@@ -429,13 +426,10 @@ static i40e_status __i40e_read_nvm_buffer(struct i40e_hw *hw,
 					  u16 offset, u16 *words,
 					  u16 *data)
 {
-	i40e_status ret_code = 0;
-
 	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
-		ret_code = i40e_read_nvm_buffer_aq(hw, offset, words, data);
-	else
-		ret_code = i40e_read_nvm_buffer_srctl(hw, offset, words, data);
-	return ret_code;
+		return i40e_read_nvm_buffer_aq(hw, offset, words, data);
+
+	return i40e_read_nvm_buffer_srctl(hw, offset, words, data);
 }
 
 /**
-- 
2.9.4

