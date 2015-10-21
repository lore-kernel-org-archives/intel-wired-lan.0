From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 22 Oct 2015 00:37:36 +0800
Subject: [Intel-wired-lan] [RFC Patch 04/12] IXGBE: Add ixgbe_ping_vf() to
	notify a specified VF via mailbox msg.
In-Reply-To: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
Message-ID: <1445445464-5056-5-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is to add ixgbe_ping_vf() to notify a specified VF. When
migration status is changed, it's necessary to notify VF the change.
VF driver will check the migrate status when it gets mailbox msg.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 19 ++++++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 89671eb..e247d67 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1318,18 +1318,23 @@ void ixgbe_disable_tx_rx(struct ixgbe_adapter *adapter)
 	IXGBE_WRITE_REG(hw, IXGBE_VFRE(1), 0);
 }
 
-void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
+void ixgbe_ping_vf(struct ixgbe_adapter *adapter, int vfn)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 ping;
+
+	ping = IXGBE_PF_CONTROL_MSG;
+	if (adapter->vfinfo[vfn].clear_to_send)
+		ping |= IXGBE_VT_MSGTYPE_CTS;
+	ixgbe_write_mbx(hw, &ping, 1, vfn);
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
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
index 2c197e6..143e2fd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
@@ -41,6 +41,7 @@ void ixgbe_msg_task(struct ixgbe_adapter *adapter);
 int ixgbe_vf_configuration(struct pci_dev *pdev, unsigned int event_mask);
 void ixgbe_disable_tx_rx(struct ixgbe_adapter *adapter);
 void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter);
+void ixgbe_ping_vf(struct ixgbe_adapter *adapter, int vfn);
 int ixgbe_ndo_set_vf_mac(struct net_device *netdev, int queue, u8 *mac);
 int ixgbe_ndo_set_vf_vlan(struct net_device *netdev, int queue, u16 vlan,
 			   u8 qos);
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

