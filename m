From: Raanan Avargil <raanan.avargil@intel.com>
Date: Thu, 15 Oct 2015 15:59:49 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: Increase timeout of polling bit
	RSPCIPHY
Message-ID: <1444913989-10607-1-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Due to timing changes to the ME firmware in Skylake, this timer
needs to be increased to 300ms.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 91a5a0a..64c1f36 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1984,7 +1984,7 @@ static s32 e1000_check_reset_block_ich8lan(struct e1000_hw *hw)
 	int i = 0;
 
 	while ((blocked = !(er32(FWSM) & E1000_ICH_FWSM_RSPCIPHY)) &&
-	       (i++ < 10))
+	       (i++ < 30))
 		usleep_range(10000, 20000);
 	return blocked ? E1000_BLK_PHY_RESET : 0;
 }
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

