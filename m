From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 19 Jun 2019 09:58:53 -0700
Subject: [Intel-wired-lan] [net] ixgbevf: Use cached link state instead of
 re-reading the value for ethtool
Message-ID: <20190619165853.28234-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Change the ethtool link settings call to just read the cached state out of
the adapter structure instead of trying to recheck the value from the PF.
Doing this should prevent excessive reading of the mailbox.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Guilherme Piccoli <gpiccoli@canonical.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 5399787e07af..54459b69c948 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -85,22 +85,16 @@ static int ixgbevf_get_link_ksettings(struct net_device *netdev,
 				      struct ethtool_link_ksettings *cmd)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
-	struct ixgbe_hw *hw = &adapter->hw;
-	u32 link_speed = 0;
-	bool link_up;
 
 	ethtool_link_ksettings_zero_link_mode(cmd, supported);
 	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
 	cmd->base.autoneg = AUTONEG_DISABLE;
 	cmd->base.port = -1;
 
-	hw->mac.get_link_status = 1;
-	hw->mac.ops.check_link(hw, &link_speed, &link_up, false);
-
-	if (link_up) {
+	if (adapter->link_up) {
 		__u32 speed = SPEED_10000;
 
-		switch (link_speed) {
+		switch (adapter->link_speed) {
 		case IXGBE_LINK_SPEED_10GB_FULL:
 			speed = SPEED_10000;
 			break;
