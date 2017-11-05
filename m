From: Colin King <colin.king@canonical.com>
Date: Sun,  5 Nov 2017 13:04:29 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: remove redundant initialization of
 read_size
Message-ID: <20171105130429.6399-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Variable read_size is initialized and this value is never read, it is
instead set inside the do-loop, hence the intialization is redundant
and can be removed. Cleans up clang warning:

drivers/net/ethernet/intel/i40e/i40e_nvm.c:390:6: warning: Value stored
to 'read_size' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 0ccab0a5d717..8f444a40c3f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -387,7 +387,7 @@ static i40e_status i40e_read_nvm_buffer_aq(struct i40e_hw *hw, u16 offset,
 					   u16 *words, u16 *data)
 {
 	i40e_status ret_code;
-	u16 read_size = *words;
+	u16 read_size;
 	bool last_cmd = false;
 	u16 words_read = 0;
 	u16 i = 0;
-- 
2.14.1

