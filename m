From: Colin King <colin.king@canonical.com>
Date: Thu, 23 Jan 2020 00:14:29 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix spelling mistake "to" -> "too"
Message-ID: <20200123001429.2831701-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a hw_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index d4055037af89..45b90eb11adb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1113,7 +1113,7 @@ i40e_status i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
 	 */
 	pba_size--;
 	if (pba_num_size < (((u32)pba_size * 2) + 1)) {
-		hw_dbg(hw, "Buffer to small for PBA data.\n");
+		hw_dbg(hw, "Buffer too small for PBA data.\n");
 		return I40E_ERR_PARAM;
 	}
 
-- 
2.24.0

