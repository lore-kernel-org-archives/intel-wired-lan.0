From: Greg Edwards <gedwards@ddn.com>
Date: Wed, 28 Jun 2017 09:22:24 -0600
Subject: [Intel-wired-lan] [PATCH 1/3] igb: add argument names to mailbox op
	function declarations
In-Reply-To: <20170628152226.25369-1-gedwards@ddn.com>
References: <20170628152226.25369-1-gedwards@ddn.com>
Message-ID: <20170628152226.25369-2-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 drivers/net/ethernet/intel/igb/e1000_hw.h  | 15 ++++++++-------
 drivers/net/ethernet/intel/igb/e1000_mbx.h | 12 ++++++------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_hw.h b/drivers/net/ethernet/intel/igb/e1000_hw.h
index 2fb2213cd562..fd7865a8d2e3 100644
--- a/drivers/net/ethernet/intel/igb/e1000_hw.h
+++ b/drivers/net/ethernet/intel/igb/e1000_hw.h
@@ -491,13 +491,14 @@ struct e1000_fc_info {
 
 struct e1000_mbx_operations {
 	s32 (*init_params)(struct e1000_hw *hw);
-	s32 (*read)(struct e1000_hw *, u32 *, u16,  u16);
-	s32 (*write)(struct e1000_hw *, u32 *, u16, u16);
-	s32 (*read_posted)(struct e1000_hw *, u32 *, u16,  u16);
-	s32 (*write_posted)(struct e1000_hw *, u32 *, u16, u16);
-	s32 (*check_for_msg)(struct e1000_hw *, u16);
-	s32 (*check_for_ack)(struct e1000_hw *, u16);
-	s32 (*check_for_rst)(struct e1000_hw *, u16);
+	s32 (*read)(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+	s32 (*write)(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+	s32 (*read_posted)(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+	s32 (*write_posted)(struct e1000_hw *hw, u32 *msg, u16 size,
+			    u16 mbx_id);
+	s32 (*check_for_msg)(struct e1000_hw *hw, u16 mbx_id);
+	s32 (*check_for_ack)(struct e1000_hw *hw, u16 mbx_id);
+	s32 (*check_for_rst)(struct e1000_hw *hw, u16 mbx_id);
 };
 
 struct e1000_mbx_stats {
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.h b/drivers/net/ethernet/intel/igb/e1000_mbx.h
index 3e7fed73df15..73d90aeb48b2 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.h
@@ -67,11 +67,11 @@
 
 #define E1000_PF_CONTROL_MSG	0x0100 /* PF control message */
 
-s32 igb_read_mbx(struct e1000_hw *, u32 *, u16, u16);
-s32 igb_write_mbx(struct e1000_hw *, u32 *, u16, u16);
-s32 igb_check_for_msg(struct e1000_hw *, u16);
-s32 igb_check_for_ack(struct e1000_hw *, u16);
-s32 igb_check_for_rst(struct e1000_hw *, u16);
-s32 igb_init_mbx_params_pf(struct e1000_hw *);
+s32 igb_read_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+s32 igb_write_mbx(struct e1000_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+s32 igb_check_for_msg(struct e1000_hw *hw, u16 mbx_id);
+s32 igb_check_for_ack(struct e1000_hw *hw, u16 mbx_id);
+s32 igb_check_for_rst(struct e1000_hw *hw, u16 mbx_id);
+s32 igb_init_mbx_params_pf(struct e1000_hw *hw);
 
 #endif /* _E1000_MBX_H_ */
-- 
2.9.4

