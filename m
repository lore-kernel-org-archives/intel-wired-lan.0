From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 26 Apr 2016 23:29:29 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Remove unused parameter
Message-ID: <4C5EDC162D52824D9E7FB1446983F3EE962AF43C@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ixgbevf_update_xcast_mode() is not using the netdev parameter; removing it since it's unnecessary.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 4 +---
 drivers/net/ethernet/intel/ixgbevf/vf.h           | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 007cbe0..bcbadac 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1908,7 +1908,7 @@ static void ixgbevf_set_rx_mode(struct net_device *netdev)
 
 	spin_lock_bh(&adapter->mbx_lock);
 
-	hw->mac.ops.update_xcast_mode(hw, netdev, xcast_mode);
+	hw->mac.ops.update_xcast_mode(hw, xcast_mode);
 
 	/* reprogram multicast list */
 	hw->mac.ops.update_mc_addr_list(hw, netdev); diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 4d613a4..9511da0 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -475,13 +475,11 @@ static s32 ixgbevf_update_mc_addr_list_vf(struct ixgbe_hw *hw,
 /**
  *  ixgbevf_update_xcast_mode - Update Multicast mode
  *  @hw: pointer to the HW structure
- *  @netdev: pointer to net device structure
  *  @xcast_mode: new multicast mode
  *
  *  Updates the Multicast Mode of VF.
  **/
-static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw,
-				     struct net_device *netdev, int xcast_mode)
+static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int 
+xcast_mode)
 {
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	u32 msgbuf[2];
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index ef9f773..a407c15 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -63,7 +63,7 @@ struct ixgbe_mac_operations {
 	s32 (*set_uc_addr)(struct ixgbe_hw *, u32, u8 *);
 	s32 (*init_rx_addrs)(struct ixgbe_hw *);
 	s32 (*update_mc_addr_list)(struct ixgbe_hw *, struct net_device *);
-	s32 (*update_xcast_mode)(struct ixgbe_hw *, struct net_device *, int);
+	s32 (*update_xcast_mode)(struct ixgbe_hw *, int);
 	s32 (*enable_mc)(struct ixgbe_hw *);
 	s32 (*disable_mc)(struct ixgbe_hw *);
 	s32 (*clear_vfta)(struct ixgbe_hw *);

