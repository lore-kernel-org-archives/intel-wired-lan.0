From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 09 Jun 2016 10:45:34 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix NACK check in
	ixgbevf_set_uc_addr_vf()
Message-ID: <20160609174534.25671.50164.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the NACK check in ixgbevf_set_uc_addr_vf() for instances where
index != 0.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index e670d3b..aa2b1e8 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -256,7 +256,7 @@ static s32 ixgbevf_get_mac_addr_vf(struct ixgbe_hw *hw, u8 *mac_addr)
 static s32 ixgbevf_set_uc_addr_vf(struct ixgbe_hw *hw, u32 index, u8 *addr)
 {
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
-	u32 msgbuf[3];
+	u32 msgbuf[3], msgbuf_chk;
 	u8 *msg_addr = (u8 *)(&msgbuf[1]);
 	s32 ret_val;
 
@@ -268,6 +268,8 @@ static s32 ixgbevf_set_uc_addr_vf(struct ixgbe_hw *hw, u32 index, u8 *addr)
 	 */
 	msgbuf[0] |= index << IXGBE_VT_MSGINFO_SHIFT;
 	msgbuf[0] |= IXGBE_VF_SET_MACVLAN;
+	msgbuf_chk = msgbuf[0];
+
 	if (addr)
 		ether_addr_copy(msg_addr, addr);
 	ret_val = mbx->ops.write_posted(hw, msgbuf, 3);
@@ -275,12 +277,12 @@ static s32 ixgbevf_set_uc_addr_vf(struct ixgbe_hw *hw, u32 index, u8 *addr)
 	if (!ret_val)
 		ret_val = mbx->ops.read_posted(hw, msgbuf, 3);
 
-	msgbuf[0] &= ~IXGBE_VT_MSGTYPE_CTS;
+	if (!ret_val) {
+		msgbuf[0] &= ~IXGBE_VT_MSGTYPE_CTS;
 
-	if (!ret_val)
-		if (msgbuf[0] ==
-		    (IXGBE_VF_SET_MACVLAN | IXGBE_VT_MSGTYPE_NACK))
-			ret_val = -ENOMEM;
+		if (msgbuf[0] == (msgbuf_chk | IXGBE_VT_MSGTYPE_NACK))
+			return -ENOMEM;
+	}
 
 	return ret_val;
 }

