From: Colin King <colin.king@canonical.com>
Date: Fri, 12 Jan 2018 17:13:10 +0000
Subject: [Intel-wired-lan] [PATCH][next] ixgbe: fix comparison of offset
 with zero or NVM_INVALID_PTR
Message-ID: <20180112171310.27973-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The incorrect operator && is being used and will always return false
as offset can never be two different values at the same time. Fix this
by using the || operator instead.

Detected by CoverityScan, CID#1463806 ("Logically dead code")

Fixes: 73834aec7199 ("ixgbe: extend firmware version support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 1948e4208fb4..27de8a7f2aeb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -4084,7 +4084,7 @@ void ixgbe_get_oem_prod_version(struct ixgbe_hw *hw,
 	hw->eeprom.ops.read(hw, NVM_OEM_PROD_VER_PTR, &offset);
 
 	/* Return is offset to OEM Product Version block is invalid */
-	if (offset == 0x0 && offset == NVM_INVALID_PTR)
+	if (offset == 0x0 || offset == NVM_INVALID_PTR)
 		return;
 
 	/* Read product version block */
-- 
2.15.1

