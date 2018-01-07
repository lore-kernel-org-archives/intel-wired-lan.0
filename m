From: Colin King <colin.king@canonical.com>
Date: Sun,  7 Jan 2018 14:51:46 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: use ARRAY_SIZE for various array
 sizing calculations
Message-ID: <20180107145146.2934-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Use the ARRAY_SIZE macro on various arrays to determine
size of the arrays. Improvement suggested by coccinelle.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 0c25006ce9af..cd79c4a73b48 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -285,7 +285,7 @@ static s32 ixgbevf_set_uc_addr_vf(struct ixgbe_hw *hw, u32 index, u8 *addr)
 		ether_addr_copy(msg_addr, addr);
 
 	ret_val = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
-					     sizeof(msgbuf) / sizeof(u32));
+					     ARRAY_SIZE(msgbuf));
 	if (!ret_val) {
 		msgbuf[0] &= ~IXGBE_VT_MSGTYPE_CTS;
 
@@ -455,8 +455,7 @@ static s32 ixgbevf_set_rar_vf(struct ixgbe_hw *hw, u32 index, u8 *addr,
 	ether_addr_copy(msg_addr, addr);
 
 	ret_val = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
-					     sizeof(msgbuf) / sizeof(u32));
-
+					     ARRAY_SIZE(msgbuf));
 	msgbuf[0] &= ~IXGBE_VT_MSGTYPE_CTS;
 
 	/* if nacked the address was rejected, use "perm_addr" */
@@ -571,7 +570,7 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 	msgbuf[1] = xcast_mode;
 
 	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
-					 sizeof(msgbuf) / sizeof(u32));
+					 ARRAY_SIZE(msgbuf));
 	if (err)
 		return err;
 
@@ -609,7 +608,7 @@ static s32 ixgbevf_set_vfta_vf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	msgbuf[0] |= vlan_on << IXGBE_VT_MSGINFO_SHIFT;
 
 	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
-					 sizeof(msgbuf) / sizeof(u32));
+					 ARRAY_SIZE(msgbuf));
 	if (err)
 		goto mbx_err;
 
@@ -813,7 +812,7 @@ static s32 ixgbevf_set_rlpml_vf(struct ixgbe_hw *hw, u16 max_size)
 	msgbuf[1] = max_size;
 
 	ret_val = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
-					     sizeof(msgbuf) / sizeof(u32));
+					     ARRAY_SIZE(msgbuf));
 	if (ret_val)
 		return ret_val;
 	if ((msgbuf[0] & IXGBE_VF_SET_LPE) &&
@@ -859,8 +858,7 @@ static int ixgbevf_negotiate_api_version_vf(struct ixgbe_hw *hw, int api)
 	msg[1] = api;
 	msg[2] = 0;
 
-	err = ixgbevf_write_msg_read_ack(hw, msg, msg,
-					 sizeof(msg) / sizeof(u32));
+	err = ixgbevf_write_msg_read_ack(hw, msg, msg, ARRAY_SIZE(msg));
 	if (!err) {
 		msg[0] &= ~IXGBE_VT_MSGTYPE_CTS;
 
@@ -911,8 +909,7 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	msg[0] = IXGBE_VF_GET_QUEUE;
 	msg[1] = msg[2] = msg[3] = msg[4] = 0;
 
-	err = ixgbevf_write_msg_read_ack(hw, msg, msg,
-					 sizeof(msg) / sizeof(u32));
+	err = ixgbevf_write_msg_read_ack(hw, msg, msg, ARRAY_SIZE(msg));
 	if (!err) {
 		msg[0] &= ~IXGBE_VT_MSGTYPE_CTS;
 
-- 
2.15.1

