From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 10 Feb 2016 15:16:30 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix error code path when setting
	MAC address
Message-ID: <20160210231630.9713.65406.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Return error when a MAC address change is rejected by the PF.

This will prevent the user from modifying the MAC address when
that operation is not permitted.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   12 ++++++++----
 drivers/net/ethernet/intel/ixgbevf/vf.c           |    4 +++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 11d6d7e..98dca80 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3668,19 +3668,23 @@ static int ixgbevf_set_mac(struct net_device *netdev, void *p)
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct sockaddr *addr = p;
+	int err;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
-	ether_addr_copy(hw->mac.addr, addr->sa_data);
-
 	spin_lock_bh(&adapter->mbx_lock);
 
-	hw->mac.ops.set_rar(hw, 0, hw->mac.addr, 0);
+	err = hw->mac.ops.set_rar(hw, 0, addr->sa_data, 0);
 
 	spin_unlock_bh(&adapter->mbx_lock);
 
+	if (err)
+		return -EPERM;
+
+	ether_addr_copy(hw->mac.addr, addr->sa_data);
+	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 61a98f4..4d613a4 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -408,8 +408,10 @@ static s32 ixgbevf_set_rar_vf(struct ixgbe_hw *hw, u32 index, u8 *addr,
 
 	/* if nacked the address was rejected, use "perm_addr" */
 	if (!ret_val &&
-	    (msgbuf[0] == (IXGBE_VF_SET_MAC_ADDR | IXGBE_VT_MSGTYPE_NACK)))
+	    (msgbuf[0] == (IXGBE_VF_SET_MAC_ADDR | IXGBE_VT_MSGTYPE_NACK))) {
 		ixgbevf_get_mac_addr_vf(hw, hw->mac.addr);
+		return IXGBE_ERR_MBX;
+	}
 
 	return ret_val;
 }

