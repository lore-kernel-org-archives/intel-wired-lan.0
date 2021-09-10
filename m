From: Colin King <colin.king@canonical.com>
Date: Fri, 10 Sep 2021 12:51:00 +0100
Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: Remove redundant
 initialization of variable ret_val
Message-ID: <20210910115100.45429-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The variable ret_val is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 5fc347abab3c..d459f5c8e98f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -66,9 +66,9 @@ static s32 ixgbevf_reset_hw_vf(struct ixgbe_hw *hw)
 {
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	u32 timeout = IXGBE_VF_INIT_TIMEOUT;
-	s32 ret_val = IXGBE_ERR_INVALID_MAC_ADDR;
 	u32 msgbuf[IXGBE_VF_PERMADDR_MSG_LEN];
 	u8 *addr = (u8 *)(&msgbuf[1]);
+	s32 ret_val;
 
 	/* Call adapter stop to disable tx/rx and clear interrupts */
 	hw->mac.ops.stop_adapter(hw);
-- 
2.32.0

