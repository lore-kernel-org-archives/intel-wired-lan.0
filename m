From: Greg Edwards <gedwards@ddn.com>
Date: Wed, 28 Jun 2017 09:22:25 -0600
Subject: [Intel-wired-lan] [PATCH 2/3] igb: expose mailbox unlock method
In-Reply-To: <20170628152226.25369-1-gedwards@ddn.com>
References: <20170628152226.25369-1-gedwards@ddn.com>
Message-ID: <20170628152226.25369-3-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a mailbox unlock method to e1000_mbx_operations, which will be used
to unlock the PF/VF mailbox by the PF.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 drivers/net/ethernet/intel/igb/e1000_hw.h  |  1 +
 drivers/net/ethernet/intel/igb/e1000_mbx.c | 39 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/igb/e1000_mbx.h |  1 +
 3 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_hw.h b/drivers/net/ethernet/intel/igb/e1000_hw.h
index fd7865a8d2e3..6076f258a0a5 100644
--- a/drivers/net/ethernet/intel/igb/e1000_hw.h
+++ b/drivers/net/ethernet/intel/igb/e1000_hw.h
@@ -499,6 +499,7 @@ struct e1000_mbx_operations {
 	s32 (*check_for_msg)(struct e1000_hw *hw, u16 mbx_id);
 	s32 (*check_for_ack)(struct e1000_hw *hw, u16 mbx_id);
 	s32 (*check_for_rst)(struct e1000_hw *hw, u16 mbx_id);
+	s32 (*unlock)(struct e1000_hw *hw, u16 mbx_id);
 };
 
 struct e1000_mbx_stats {
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.c b/drivers/net/ethernet/intel/igb/e1000_mbx.c
index 00e263f0c030..6aa44723507b 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.c
@@ -125,6 +125,24 @@ s32 igb_check_for_rst(struct e1000_hw *hw, u16 mbx_id)
 }
 
 /**
+ *  igb_unlock_mbx - unlock the mailbox
+ *  @hw: pointer to the HW structure
+ *  @mbx_id: id of mailbox to check
+ *
+ *  returns SUCCESS if the mailbox was unlocked or else ERR_MBX
+ **/
+s32 igb_unlock_mbx(struct e1000_hw *hw, u16 mbx_id)
+{
+	struct e1000_mbx_info *mbx = &hw->mbx;
+	s32 ret_val = -E1000_ERR_MBX;
+
+	if (mbx->ops.unlock)
+		ret_val = mbx->ops.unlock(hw, mbx_id);
+
+	return ret_val;
+}
+
+/**
  *  igb_poll_for_msg - Wait for message notification
  *  @hw: pointer to the HW structure
  *  @mbx_id: id of mailbox to write
@@ -341,6 +359,26 @@ static s32 igb_obtain_mbx_lock_pf(struct e1000_hw *hw, u16 vf_number)
 }
 
 /**
+ *  igb_release_mbx_lock_pf - release mailbox lock
+ *  @hw: pointer to the HW structure
+ *  @vf_number: the VF index
+ *
+ *  return SUCCESS if we released the mailbox lock
+ **/
+static s32 igb_release_mbx_lock_pf(struct e1000_hw *hw, u16 vf_number)
+{
+	u32 p2v_mailbox;
+
+	/* drop PF lock of mailbox, if set */
+	p2v_mailbox = rd32(E1000_P2VMAILBOX(vf_number));
+	if (p2v_mailbox & E1000_P2VMAILBOX_PFU)
+		wr32(E1000_P2VMAILBOX(vf_number),
+		     p2v_mailbox & ~E1000_P2VMAILBOX_PFU);
+
+	return 0;
+}
+
+/**
  *  igb_write_mbx_pf - Places a message in the mailbox
  *  @hw: pointer to the HW structure
  *  @msg: The message buffer
@@ -437,6 +475,7 @@ s32 igb_init_mbx_params_pf(struct e1000_hw *hw)
 	mbx->ops.check_for_msg = igb_check_for_msg_pf;
 	mbx->ops.check_for_ack = igb_check_for_ack_pf;
 	mbx->ops.check_for_rst = igb_check_for_rst_pf;
+	mbx->ops.unlock = igb_release_mbx_lock_pf;
 
 	mbx->stats.msgs_tx = 0;
 	mbx->stats.msgs_rx = 0;
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.h b/drivers/net/ethernet/intel/igb/e1000_mbx.h
index 73d90aeb48b2..a98c5dc60afd 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.h
@@ -72,6 +72,7 @@ s32 igb_write_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
 s32 igb_check_for_msg(struct e1000_hw *hw, u16 mbx_id);
 s32 igb_check_for_ack(struct e1000_hw *hw, u16 mbx_id);
 s32 igb_check_for_rst(struct e1000_hw *hw, u16 mbx_id);
+s32 igb_unlock_mbx(struct e1000_hw *hw, u16 mbx_id);
 s32 igb_init_mbx_params_pf(struct e1000_hw *hw);
 
 #endif /* _E1000_MBX_H_ */
-- 
2.9.4

