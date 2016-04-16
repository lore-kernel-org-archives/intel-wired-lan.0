From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 16 Apr 2016 22:35:08 +0200
Subject: [Intel-wired-lan] [PATCH] ixgbe: use msleep for long delays
Message-ID: <1460838941-1251989-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The newly added x550em_a support causes a link failure on ARM because of
an overly long time passed into udelay():

ERROR: "__bad_udelay" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

There are multiple variants of the ixgbe_acquire_swfw_sync_*() function,
and the other ones all use msleep(), so we can safely assume that all
callers are allowed to sleep, which makes msleep() a better replacement
than mdelay().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index c71e93ed4451..21c0fce47e15 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2765,7 +2765,7 @@ static s32 ixgbe_acquire_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
 			ixgbe_release_swfw_sync_X540(hw, hmask);
 		if (status != IXGBE_ERR_TOKEN_RETRY)
 			return status;
-		udelay(FW_PHY_TOKEN_DELAY * 1000);
+		msleep(FW_PHY_TOKEN_DELAY);
 	}
 
 	return status;
-- 
2.7.0

