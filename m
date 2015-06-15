From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Date: Mon, 15 Jun 2015 10:48:57 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbe: ping to reset on changing
	trust status
Message-ID: <7F861DC0615E0C47A872E6F3C5FCDDBD05EDEFDD@BPXM14GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Send a ping to reset VF on changing the status of trusting.
VF driver will reconfigure its features on reset.

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 5eb3108..7bb9926 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1212,18 +1212,23 @@ void ixgbe_disable_tx_rx(struct ixgbe_adapter *adapter)
 	IXGBE_WRITE_REG(hw, IXGBE_VFRE(1), 0);
 }
 
-void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
+static void ixgbe_ping_vf(struct ixgbe_adapter *adapter, int vf)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 ping;
+
+	ping = IXGBE_PF_CONTROL_MSG;
+	if (adapter->vfinfo[vf].clear_to_send)
+		ping |= IXGBE_VT_MSGTYPE_CTS;
+	ixgbe_write_mbx(hw, &ping, 1, vf);
+}
+
+void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
+{
 	int i;
 
-	for (i = 0 ; i < adapter->num_vfs; i++) {
-		ping = IXGBE_PF_CONTROL_MSG;
-		if (adapter->vfinfo[i].clear_to_send)
-			ping |= IXGBE_VT_MSGTYPE_CTS;
-		ixgbe_write_mbx(hw, &ping, 1, i);
-	}
+	for (i = 0 ; i < adapter->num_vfs; i++)
+		ixgbe_ping_vf(adapter, i);
 }
 
 int ixgbe_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
@@ -1517,7 +1522,11 @@ int ixgbe_ndo_set_vf_trust(struct net_device *netdev, int vf, bool setting)
 
 	adapter->vfinfo[vf].trusted = setting;
 
-	/* TODO: reset to reconfigure features */
+	/* reset VF to reconfigure features */
+	adapter->vfinfo[vf].clear_to_send = false;
+	ixgbe_ping_vf(adapter, vf);
+
+	e_info(drv, "VF %u is %strusted\n", vf, setting ? "" : "not ");
 
 	return 0;
 }
-- 
1.8.3.1

