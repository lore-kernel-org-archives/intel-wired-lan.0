From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 03 Dec 2015 15:20:06 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: do not call check_link for ethtool
 in ixgbe_get_settings()
Message-ID: <20151203232006.23658.24160.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In ixgbe_get_settings() the link status and speed of the interface
are determined based on a read from the LINKS register via the call
to mac.ops.check.link(). This can cause issues where external drivers
may end up with unknown speed when calling ethtool_get_setings().

Instead of calling the mac.ops.check_link() we can report the speed
from the adapter structure which is populated by the driver.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2c5696a..6ddb2e6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -185,9 +185,7 @@ static int ixgbe_get_settings(struct net_device *netdev,
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
 	ixgbe_link_speed supported_link;
-	u32 link_speed = 0;
 	bool autoneg = false;
-	bool link_up;
 
 	hw->mac.ops.get_link_capabilities(hw, &supported_link, &autoneg);
 
@@ -313,9 +311,8 @@ static int ixgbe_get_settings(struct net_device *netdev,
 		break;
 	}
 
-	hw->mac.ops.check_link(hw, &link_speed, &link_up, false);
-	if (link_up) {
-		switch (link_speed) {
+	if (netif_carrier_ok(netdev)) {
+		switch (adapter->link_speed) {
 		case IXGBE_LINK_SPEED_10GB_FULL:
 			ethtool_cmd_speed_set(ecmd, SPEED_10000);
 			break;

