From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 29 Aug 2016 16:39:28 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: add spinlocks for MTU change
	calls
Message-ID: <20160829233928.10108.99079.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Protect set_rlpml with mailbox lock to make sure tha MTU configuration
is handled properly.

This change resolves an issue where set_rlpml can fail when the VF
interface is brought up:
ixgbevf 0000:03:1d.6: Failed to set MTU at 1500

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 4044608..7eaac32 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1810,8 +1810,10 @@ static void ixgbevf_configure_rx(struct ixgbevf_adapter *adapter)
 	if (hw->mac.type >= ixgbe_mac_X550_vf)
 		ixgbevf_setup_vfmrqc(adapter);
 
+	spin_lock_bh(&adapter->mbx_lock);
 	/* notify the PF of our intent to use this size of frame */
 	ret = hw->mac.ops.set_rlpml(hw, netdev->mtu + ETH_HLEN + ETH_FCS_LEN);
+	spin_unlock_bh(&adapter->mbx_lock);
 	if (ret)
 		dev_err(&adapter->pdev->dev,
 			"Failed to set MTU at %d\n", netdev->mtu);
@@ -3758,8 +3760,10 @@ static int ixgbevf_change_mtu(struct net_device *netdev, int new_mtu)
 	if ((new_mtu < 68) || (max_frame > max_possible_frame))
 		return -EINVAL;
 
+	spin_lock_bh(&adapter->mbx_lock);
 	/* notify the PF of our intent to use this size of frame */
 	ret = hw->mac.ops.set_rlpml(hw, max_frame);
+	spin_unlock_bh(&adapter->mbx_lock);
 	if (ret)
 		return -EINVAL;
 

