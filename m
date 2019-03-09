From: Kangjie Lu <kjlu@umn.edu>
Date: Fri,  8 Mar 2019 21:31:23 -0600
Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: fix a missing check of
 ixgbevf_write_msg_read_ack
Message-ID: <20190309033123.30001-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If ixgbevf_write_msg_read_ack fails, return its error code upstream

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index cd3b81300cc7..d5ce49636548 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -508,9 +508,8 @@ static s32 ixgbevf_update_mc_addr_list_vf(struct ixgbe_hw *hw,
 		vector_list[i++] = ixgbevf_mta_vector(hw, ha->addr);
 	}
 
-	ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, IXGBE_VFMAILBOX_SIZE);
-
-	return 0;
+	return ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+			IXGBE_VFMAILBOX_SIZE);
 }
 
 /**
-- 
2.17.1

