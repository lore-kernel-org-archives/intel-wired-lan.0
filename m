From: Greg Edwards <gedwards@ddn.com>
Date: Wed, 28 Jun 2017 09:22:26 -0600
Subject: [Intel-wired-lan] [PATCH 3/3] igb: do not drop PF mailbox lock
	after read of VF message
In-Reply-To: <20170628152226.25369-1-gedwards@ddn.com>
References: <20170628152226.25369-1-gedwards@ddn.com>
Message-ID: <20170628152226.25369-4-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the PF receives a mailbox message from the VF, it grabs the mailbox
lock, reads the VF message from the mailbox, ACKs the message and drops
the lock.

While the PF is performing the action for the VF message, nothing
prevents another VF message from being posted to the mailbox.  The
current code handles this condition by just dropping any new VF messages
without processing them.  This results in a mailbox timeout in the VM
for posted messages waiting for an ACK, and the VF is reset by the
igbvf_watchdog_task in the VM.

Given the right sequence of VF messages and mailbox timeouts, this
condition can go on ad infinitum.

Modify the PF mailbox read method to take an 'unlock' argument that
optionally leaves the mailbox locked by the PF after reading the VF
message.  This ensures another VF message is not posted to the mailbox
until after the PF has completed processing the VF message and written
its reply.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 drivers/net/ethernet/intel/igb/e1000_hw.h  |  3 ++-
 drivers/net/ethernet/intel/igb/e1000_mbx.c | 18 ++++++++++++------
 drivers/net/ethernet/intel/igb/e1000_mbx.h |  3 ++-
 drivers/net/ethernet/intel/igb/igb_main.c  | 14 ++++++++++----
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_hw.h b/drivers/net/ethernet/intel/igb/e1000_hw.h
index 6076f258a0a5..6ea9f702ba0f 100644
--- a/drivers/net/ethernet/intel/igb/e1000_hw.h
+++ b/drivers/net/ethernet/intel/igb/e1000_hw.h
@@ -491,7 +491,8 @@ struct e1000_fc_info {
 
 struct e1000_mbx_operations {
 	s32 (*init_params)(struct e1000_hw *hw);
-	s32 (*read)(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+	s32 (*read)(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id,
+		    bool unlock);
 	s32 (*write)(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
 	s32 (*read_posted)(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
 	s32 (*write_posted)(struct e1000_hw *hw, u32 *msg, u16 size,
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.c b/drivers/net/ethernet/intel/igb/e1000_mbx.c
index 6aa44723507b..bffd58f7b2a1 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.c
@@ -32,7 +32,8 @@
  *
  *  returns SUCCESS if it successfully read message from buffer
  **/
-s32 igb_read_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id)
+s32 igb_read_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id,
+		 bool unlock)
 {
 	struct e1000_mbx_info *mbx = &hw->mbx;
 	s32 ret_val = -E1000_ERR_MBX;
@@ -42,7 +43,7 @@ s32 igb_read_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id)
 		size = mbx->size;
 
 	if (mbx->ops.read)
-		ret_val = mbx->ops.read(hw, msg, size, mbx_id);
+		ret_val = mbx->ops.read(hw, msg, size, mbx_id, unlock);
 
 	return ret_val;
 }
@@ -222,7 +223,7 @@ static s32 igb_read_posted_mbx(struct e1000_hw *hw, u32 *msg, u16 size,
 	ret_val = igb_poll_for_msg(hw, mbx_id);
 
 	if (!ret_val)
-		ret_val = mbx->ops.read(hw, msg, size, mbx_id);
+		ret_val = mbx->ops.read(hw, msg, size, mbx_id, true);
 out:
 	return ret_val;
 }
@@ -423,13 +424,14 @@ static s32 igb_write_mbx_pf(struct e1000_hw *hw, u32 *msg, u16 size,
  *  @msg: The message buffer
  *  @size: Length of buffer
  *  @vf_number: the VF index
+ *  @unlock: unlock the mailbox when done?
  *
  *  This function copies a message from the mailbox buffer to the caller's
  *  memory buffer.  The presumption is that the caller knows that there was
  *  a message due to a VF request so no polling for message is needed.
  **/
 static s32 igb_read_mbx_pf(struct e1000_hw *hw, u32 *msg, u16 size,
-			   u16 vf_number)
+			   u16 vf_number, bool unlock)
 {
 	s32 ret_val;
 	u16 i;
@@ -443,8 +445,12 @@ static s32 igb_read_mbx_pf(struct e1000_hw *hw, u32 *msg, u16 size,
 	for (i = 0; i < size; i++)
 		msg[i] = array_rd32(E1000_VMBMEM(vf_number), i);
 
-	/* Acknowledge the message and release buffer */
-	wr32(E1000_P2VMAILBOX(vf_number), E1000_P2VMAILBOX_ACK);
+	/* Acknowledge the message and release mailbox lock (or not) */
+	if (unlock)
+		wr32(E1000_P2VMAILBOX(vf_number), E1000_P2VMAILBOX_ACK);
+	else
+		wr32(E1000_P2VMAILBOX(vf_number),
+		     E1000_P2VMAILBOX_ACK | E1000_P2VMAILBOX_PFU);
 
 	/* update stats */
 	hw->mbx.stats.msgs_rx++;
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.h b/drivers/net/ethernet/intel/igb/e1000_mbx.h
index a98c5dc60afd..a62b08e1572e 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.h
@@ -67,7 +67,8 @@
 
 #define E1000_PF_CONTROL_MSG	0x0100 /* PF control message */
 
-s32 igb_read_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+s32 igb_read_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id,
+		 bool unlock);
 s32 igb_write_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
 s32 igb_check_for_msg(struct e1000_hw *hw, u16 mbx_id);
 s32 igb_check_for_ack(struct e1000_hw *hw, u16 mbx_id);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1cf74aa4ebd9..c046b37ad9eb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6664,32 +6664,33 @@ static void igb_rcv_msg_from_vf(struct igb_adapter *adapter, u32 vf)
 	struct vf_data_storage *vf_data = &adapter->vf_data[vf];
 	s32 retval;
 
-	retval = igb_read_mbx(hw, msgbuf, E1000_VFMAILBOX_SIZE, vf);
+	retval = igb_read_mbx(hw, msgbuf, E1000_VFMAILBOX_SIZE, vf, false);
 
 	if (retval) {
 		/* if receive failed revoke VF CTS stats and restart init */
 		dev_err(&pdev->dev, "Error receiving message from VF\n");
 		vf_data->flags &= ~IGB_VF_FLAG_CTS;
 		if (!time_after(jiffies, vf_data->last_nack + (2 * HZ)))
-			return;
+			goto unlock;
 		goto out;
 	}
 
 	/* this is a message we already processed, do nothing */
 	if (msgbuf[0] & (E1000_VT_MSGTYPE_ACK | E1000_VT_MSGTYPE_NACK))
-		return;
+		goto unlock;
 
 	/* until the vf completes a reset it should not be
 	 * allowed to start any configuration.
 	 */
 	if (msgbuf[0] == E1000_VF_RESET) {
+		/* unlocks mailbox */
 		igb_vf_reset_msg(adapter, vf);
 		return;
 	}
 
 	if (!(vf_data->flags & IGB_VF_FLAG_CTS)) {
 		if (!time_after(jiffies, vf_data->last_nack + (2 * HZ)))
-			return;
+			goto unlock;
 		retval = -1;
 		goto out;
 	}
@@ -6730,7 +6731,12 @@ static void igb_rcv_msg_from_vf(struct igb_adapter *adapter, u32 vf)
 	else
 		msgbuf[0] |= E1000_VT_MSGTYPE_ACK;
 
+	/* unlocks mailbox */
 	igb_write_mbx(hw, msgbuf, 1, vf);
+	return;
+
+unlock:
+	igb_unlock_mbx(hw, vf);
 }
 
 static void igb_msg_task(struct igb_adapter *adapter)
-- 
2.9.4

