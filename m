From: Stefano Brivio <sbrivio@redhat.com>
Date: Wed,  6 Sep 2017 10:11:38 +0200
Subject: [Intel-wired-lan] [PATCH net 1/2] i40e: Fix comment about locking
	for __i40e_read_nvm_word()
In-Reply-To: <cover.1504684488.git.sbrivio@redhat.com>
References: <cover.1504684488.git.sbrivio@redhat.com>
Message-ID: <4d27bbb33031ac1489fe6d969edd74d44155136c.1504684488.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Caller needs to acquire the lock. Called functions will not.

Fixes: 09f79fd49d94 ("i40e: avoid NVM acquire deadlock during NVM update")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 26d7e9fe6220..200779d5c124 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -281,7 +281,7 @@ static i40e_status i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
 }
 
 /**
- * __i40e_read_nvm_word - Reads nvm word, assumes called does the locking
+ * __i40e_read_nvm_word - Reads nvm word, assumes caller does the locking
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
-- 
2.9.4

