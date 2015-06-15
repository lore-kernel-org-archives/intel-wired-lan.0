From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Date: Mon, 15 Jun 2015 10:47:36 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbevf: refactor
	ixgbevf_update_mc_addr_list_vf
Message-ID: <7F861DC0615E0C47A872E6F3C5FCDDBD05EDEFA0@BPXM14GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Add ixgbevf_request_mc_promisc_vf which is for request VF multicast
promiscuous mode, and move the codes from ixgbevf_update_mc_addr_list_vf.

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index b5aac76..89aecd0 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -426,6 +426,24 @@ static void ixgbevf_write_msg_read_ack(struct ixgbe_hw *hw,
 		mbx->ops.read_posted(hw, retmsg, size);
 }
 
+static s32 ixgbevf_request_mc_promisc_vf(struct ixgbe_hw *hw)
+{
+	struct ixgbevf_adapter *adapter = hw->back;
+	u32 msgbuf[IXGBE_VFMAILBOX_SIZE];
+
+	dev_info(&adapter->pdev->dev, "Request MC PROMISC\n");
+
+	memset(msgbuf, 0, sizeof(msgbuf));
+
+	/* enabling multicast promiscuous */
+	msgbuf[0] = IXGBE_VF_SET_MC_PROMISC;
+	msgbuf[1] = 1;
+
+	ixgbevf_write_msg_read_ack(hw, msgbuf, 2);
+
+	return 0;
+}
+
 /**
  *  ixgbevf_update_mc_addr_list_vf - Update Multicast addresses
  *  @hw: pointer to the HW structure
@@ -457,18 +475,9 @@ static s32 ixgbevf_update_mc_addr_list_vf(struct ixgbe_hw *hw,
 		 */
 		if (hw->api_version == ixgbe_mbox_api_12) {
 			if (!hw->mac.mc_promisc) {
-				struct ixgbevf_adapter *adapter = hw->back;
-
-				dev_info(&adapter->pdev->dev, "Request MC PROMISC\n");
-
-				/* enabling multicast promiscuous */
-				msgbuf[0] = IXGBE_VF_SET_MC_PROMISC;
-				msgbuf[1] = 1;
-				ixgbevf_write_msg_read_ack(hw, msgbuf, 2);
-
+				ixgbevf_request_mc_promisc_vf(hw);
 				hw->mac.mc_promisc = true;
 			}
-
 			return 0;
 		}
 		cnt = 30;
-- 
1.8.3.1

