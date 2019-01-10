From: Piotr Skajewski <piotrx.skajewski@intel.com>
Date: Thu, 10 Jan 2019 12:29:01 +0100
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix packet loss when updating
 multicast table
Message-ID: <1547119741-34056-1-git-send-email-piotrx.skajewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change fixing 2 issues with:
    - Packet loss when updating the MTA
    - Multicast packets are received even after leaving the MC group

Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h        |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |  4 ----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 10 +++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c  | 22 ++++++++--------------
 4 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 08d85e3..3f58a16 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -918,6 +918,7 @@ int ixgbe_update_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 #ifdef CONFIG_IXGBE_DCB
 void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter);
 #endif
+int ixgbe_write_mc_addr_list(struct net_device *netdev);
 int ixgbe_setup_tc(struct net_device *dev, u8 tc);
 void ixgbe_tx_ctxtdesc(struct ixgbe_ring *, u32, u32, u32, u32);
 void ixgbe_do_reset(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 0bd1294..ce7b2d8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2075,10 +2075,6 @@ s32 ixgbe_update_mc_addr_list_generic(struct ixgbe_hw *hw,
 	hw->addr_ctrl.num_mc_addrs = netdev_mc_count(netdev);
 	hw->addr_ctrl.mta_in_use = 0;
 
-	/* Clear mta_shadow */
-	hw_dbg(hw, " Clearing MTA\n");
-	memset(&hw->mac.mta_shadow, 0, sizeof(hw->mac.mta_shadow));
-
 	/* Update mta shadow */
 	netdev_for_each_mc_addr(ha, netdev) {
 		hw_dbg(hw, " Adding the multicast addresses:\n");
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index daff818..1899489 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4695,7 +4695,7 @@ static void ixgbe_restore_vlan(struct ixgbe_adapter *adapter)
  *                0 on no addresses written
  *                X on writing X addresses to MTA
  **/
-static int ixgbe_write_mc_addr_list(struct net_device *netdev)
+int ixgbe_write_mc_addr_list(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -4703,15 +4703,15 @@ static int ixgbe_write_mc_addr_list(struct net_device *netdev)
 	if (!netif_running(netdev))
 		return 0;
 
+#ifdef CONFIG_PCI_IOV
+	ixgbe_restore_vf_multicasts(adapter);
+#endif
+
 	if (hw->mac.ops.update_mc_addr_list)
 		hw->mac.ops.update_mc_addr_list(hw, netdev);
 	else
 		return -ENOMEM;
 
-#ifdef CONFIG_PCI_IOV
-	ixgbe_restore_vf_multicasts(adapter);
-#endif
-
 	return netdev_mc_count(netdev);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 345701a..97e0d88 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -364,9 +364,6 @@ static int ixgbe_set_vf_multicasts(struct ixgbe_adapter *adapter,
 	struct vf_data_storage *vfinfo = &adapter->vfinfo[vf];
 	struct ixgbe_hw *hw = &adapter->hw;
 	int i;
-	u32 vector_bit;
-	u32 vector_reg;
-	u32 mta_reg;
 	u32 vmolr = IXGBE_READ_REG(hw, IXGBE_VMOLR(vf));
 
 	/* only so many hash values supported */
@@ -387,16 +384,12 @@ static int ixgbe_set_vf_multicasts(struct ixgbe_adapter *adapter,
 		vfinfo->vf_mc_hashes[i] = hash_list[i];
 	}
 
-	for (i = 0; i < vfinfo->num_vf_mc_hashes; i++) {
-		vector_reg = (vfinfo->vf_mc_hashes[i] >> 5) & 0x7F;
-		vector_bit = vfinfo->vf_mc_hashes[i] & 0x1F;
-		mta_reg = IXGBE_READ_REG(hw, IXGBE_MTA(vector_reg));
-		mta_reg |= BIT(vector_bit);
-		IXGBE_WRITE_REG(hw, IXGBE_MTA(vector_reg), mta_reg);
-	}
 	vmolr |= IXGBE_VMOLR_ROMPE;
 	IXGBE_WRITE_REG(hw, IXGBE_VMOLR(vf), vmolr);
 
+	/* Sync up the PF and VF in the same MTA table */
+	ixgbe_write_mc_addr_list(adapter->netdev);
+
 	return 0;
 }
 
@@ -408,7 +401,10 @@ void ixgbe_restore_vf_multicasts(struct ixgbe_adapter *adapter)
 	int i, j;
 	u32 vector_bit;
 	u32 vector_reg;
-	u32 mta_reg;
+
+	/* Clear mta_shadow */
+	hw_dbg(hw, " Clearing MTA\n");
+	memset(&hw->mac.mta_shadow, 0, sizeof(hw->mac.mta_shadow));
 
 	for (i = 0; i < adapter->num_vfs; i++) {
 		u32 vmolr = IXGBE_READ_REG(hw, IXGBE_VMOLR(i));
@@ -417,9 +413,7 @@ void ixgbe_restore_vf_multicasts(struct ixgbe_adapter *adapter)
 			hw->addr_ctrl.mta_in_use++;
 			vector_reg = (vfinfo->vf_mc_hashes[j] >> 5) & 0x7F;
 			vector_bit = vfinfo->vf_mc_hashes[j] & 0x1F;
-			mta_reg = IXGBE_READ_REG(hw, IXGBE_MTA(vector_reg));
-			mta_reg |= BIT(vector_bit);
-			IXGBE_WRITE_REG(hw, IXGBE_MTA(vector_reg), mta_reg);
+			hw->mac.mta_shadow[vector_reg] |= (1 << vector_bit);
 		}
 
 		if (vfinfo->num_vf_mc_hashes)
-- 
1.8.3.1

