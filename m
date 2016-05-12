From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 13 May 2016 01:51:55 +0800
Subject: [Intel-wired-lan] [PATCH net] driver: ixgbevf:
	ixgbevf_write/read_posted_mbx should use IXGBE_ERR_MBX to
	initialize ret_val
Message-ID: <c74ebf3e68d0207e95f71086693916fe99f10658.1463075515.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Now ixgbevf_write/read_posted_mbx use -IXGBE_ERR_MBX as the initiative
return value, but it's incorrect, cause in ixgbevf_vlan_rx_add_vid(),
it use err == IXGBE_ERR_MBX, the err returned from mac.ops.set_vfta,
and in ixgbevf_set_vfta_vf, it return from write/read_posted. so we
should initialize err with IXGBE_ERR_MBX, instead of -IXGBE_ERR_MBX.

With this fix, the other functions that called it also can work well,
cause they only care about if err is 0 or not.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/mbx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.c b/drivers/net/ethernet/intel/ixgbevf/mbx.c
index dc68fea..567ed6d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.c
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.c
@@ -85,7 +85,7 @@ static s32 ixgbevf_poll_for_ack(struct ixgbe_hw *hw)
 static s32 ixgbevf_read_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size)
 {
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
-	s32 ret_val = -IXGBE_ERR_MBX;
+	s32 ret_val = IXGBE_ERR_MBX;
 
 	if (!mbx->ops.read)
 		goto out;
@@ -111,7 +111,7 @@ out:
 static s32 ixgbevf_write_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size)
 {
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
-	s32 ret_val = -IXGBE_ERR_MBX;
+	s32 ret_val = IXGBE_ERR_MBX;
 
 	/* exit if either we can't write or there isn't a defined timeout */
 	if (!mbx->ops.write || !mbx->timeout)
-- 
2.1.0

