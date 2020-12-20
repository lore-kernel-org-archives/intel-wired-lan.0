From: Kevin Lo <kevlo@kevlo.org>
Date: Sun, 20 Dec 2020 22:18:19 +0800
Subject: [Intel-wired-lan] [PATCH v2] igc: set the default return value to
 -IGC_ERR_NVM in igc_write_nvm_srwr
Message-ID: <20201220141819.GA85707@ns.kevlo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch sets the default return value to -IGC_ERR_NVM in igc_write_nvm_srwr.
Without this change it wouldn't lead to a shadow RAM write EEWR timeout.

Fixes: ab4056126813 ("igc: Add NVM support")
Signed-off-by: Kevin Lo <kevlo@kevlo.org>
---
v2: Add a Fixes tag.
---
diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 8b67d9b49a83..b0a5cd31683e 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -221,7 +221,7 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 	struct igc_nvm_info *nvm = &hw->nvm;
 	u32 attempts = 100000;
 	u32 i, k, eewr = 0;
-	s32 ret_val = 0;
+	s32 ret_val = -IGC_ERR_NVM;
 
 	/* A check for invalid values:  offset too large, too many words,
 	 * too many words for the offset, and not enough words.
@@ -229,7 +229,6 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
 	    words == 0) {
 		hw_dbg("nvm parameter(s) out of bounds\n");
-		ret_val = -IGC_ERR_NVM;
 		goto out;
 	}
 
