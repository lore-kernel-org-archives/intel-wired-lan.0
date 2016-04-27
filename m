From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 27 Apr 2016 14:14:14 -0700
Subject: [Intel-wired-lan] [next-queue v2] ixgbevf: Remove unused parameter
Message-ID: <1461791654-68864-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tony Nguyen <anthony.l.nguyen@intel.com>

ixgbevf_update_xcast_mode() is not using the netdev parameter;
removing it since it's unnecessary.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
v2: original patch was not against Jeff's dev-queue branch so did not
    take into consideration all the changes/patches that are in his queue

 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 7 ++-----
 drivers/net/ethernet/intel/ixgbevf/vf.h           | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ba17a61..5e348b1 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1922,7 +1922,7 @@ static void ixgbevf_set_rx_mode(struct net_device *netdev)
 
 	spin_lock_bh(&adapter->mbx_lock);
 
-	hw->mac.ops.update_xcast_mode(hw, netdev, xcast_mode);
+	hw->mac.ops.update_xcast_mode(hw, xcast_mode);
 
 	/* reprogram multicast list */
 	hw->mac.ops.update_mc_addr_list(hw, netdev);
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 362ed67..5af363c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -537,13 +537,11 @@ static s32 ixgbevf_hv_update_mc_addr_list_vf(struct ixgbe_hw *hw,
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
+static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 {
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	u32 msgbuf[2];
@@ -577,8 +575,7 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw,
 /**
  * Hyper-V variant - just a stub.
  */
-static s32 ixgbevf_hv_update_xcast_mode(struct ixgbe_hw *hw,
-					struct net_device *netdev, int xcast_mode)
+static s32 ixgbevf_hv_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index 6770f10..2cac610 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -64,7 +64,7 @@ struct ixgbe_mac_operations {
 	s32 (*set_uc_addr)(struct ixgbe_hw *, u32, u8 *);
 	s32 (*init_rx_addrs)(struct ixgbe_hw *);
 	s32 (*update_mc_addr_list)(struct ixgbe_hw *, struct net_device *);
-	s32 (*update_xcast_mode)(struct ixgbe_hw *, struct net_device *, int);
+	s32 (*update_xcast_mode)(struct ixgbe_hw *, int);
 	s32 (*enable_mc)(struct ixgbe_hw *);
 	s32 (*disable_mc)(struct ixgbe_hw *);
 	s32 (*clear_vfta)(struct ixgbe_hw *);
-- 
2.5.5

