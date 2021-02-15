From: Colin King <colin.king@canonical.com>
Date: Mon, 15 Feb 2021 16:11:39 +0000
Subject: [Intel-wired-lan] [PATCH][next] i40e: Fix uninitialized variable
 mfs_max
Message-ID: <20210215161139.83432-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The variable mfs_max is not initialized and is being compared to find
the maximum value. Fix this by initializing it to 0.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based DCB")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 7b73a279d46e..243b0d2b7b72 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1636,7 +1636,7 @@ void i40e_dcb_hw_calculate_pool_sizes(struct i40e_hw *hw,
 	u32 total_pool_size = 0;
 	int shared_pool_size; /* Need signed variable */
 	u32 port_pb_size;
-	u32 mfs_max;
+	u32 mfs_max = 0;
 	u32 pcirtt;
 	u8 i;
 
-- 
2.30.0

