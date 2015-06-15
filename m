From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Date: Mon, 15 Jun 2015 10:48:03 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbe,
	ixgbevf: error MC promisc unless trusted
Message-ID: <7F861DC0615E0C47A872E6F3C5FCDDBD05EDEFBF@BPXM14GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Make PF returns an error to VF multicast promiscuous mode if the VF is not
trusted. On VF, check the result from PF and fallback to previous behavior
that only 30 addresses are registered.

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |  9 +++++----
 drivers/net/ethernet/intel/ixgbevf/vf.c        | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 6c602bc..5eb3108 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1074,6 +1074,10 @@ static int ixgbe_set_vf_mc_promisc(struct ixgbe_adapter *adapter,
 	if (adapter->vfinfo[vf].mc_promisc == enable)
 		return 0;
 
+	/* Don't enable MC promisc unless VF is trusted */
+	if (enable && !adapter->vfinfo[vf].trusted)
+		return -1;
+
 	adapter->vfinfo[vf].mc_promisc = enable;
 
 	if (enable)
@@ -1513,10 +1517,7 @@ int ixgbe_ndo_set_vf_trust(struct net_device *netdev, int vf, bool setting)
 
 	adapter->vfinfo[vf].trusted = setting;
 
-	/* Reconfigure features which are only allowed for trusted VF */
-	/* VF multicast promiscuous mode */
-	if (adapter->vfinfo[vf].mc_promisc)
-		ixgbe_enable_vf_mc_promisc(adapter, vf);
+	/* TODO: reset to reconfigure features */
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 89aecd0..6547c17 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -430,6 +430,7 @@ static s32 ixgbevf_request_mc_promisc_vf(struct ixgbe_hw *hw)
 {
 	struct ixgbevf_adapter *adapter = hw->back;
 	u32 msgbuf[IXGBE_VFMAILBOX_SIZE];
+	int err;
 
 	dev_info(&adapter->pdev->dev, "Request MC PROMISC\n");
 
@@ -439,7 +440,17 @@ static s32 ixgbevf_request_mc_promisc_vf(struct ixgbe_hw *hw)
 	msgbuf[0] = IXGBE_VF_SET_MC_PROMISC;
 	msgbuf[1] = 1;
 
-	ixgbevf_write_msg_read_ack(hw, msgbuf, 2);
+	err = hw->mbx.ops.write_posted(hw, msgbuf, 2);
+	if (err)
+		return err;
+	err = hw->mbx.ops.read_posted(hw, msgbuf, 2);
+	if (err)
+		return err;
+
+	msgbuf[0] &= ~IXGBE_VT_MSGTYPE_CTS;
+
+	if (msgbuf[0] == (IXGBE_VF_SET_MC_PROMISC | IXGBE_VT_MSGTYPE_NACK))
+		return -EPERM;
 
 	return 0;
 }
@@ -474,11 +485,13 @@ static s32 ixgbevf_update_mc_addr_list_vf(struct ixgbe_hw *hw,
 		 * mode, turn it on.
 		 */
 		if (hw->api_version == ixgbe_mbox_api_12) {
-			if (!hw->mac.mc_promisc) {
-				ixgbevf_request_mc_promisc_vf(hw);
+			if (!hw->mac.mc_promisc &&
+			    !ixgbevf_request_mc_promisc_vf(hw)) {
 				hw->mac.mc_promisc = true;
 			}
-			return 0;
+			/* If we are in MC promisc, return here */
+			if (hw->mac.mc_promisc)
+				return 0;
 		}
 		cnt = 30;
 	}
-- 
1.8.3.1

