From: Alice Michael <alice.michael@intel.com>
Date: Wed, 10 Oct 2018 11:10:10 -0700
Subject: [Intel-wired-lan] [PATCH] i40e/ixgbe/igb: fail on new wol flag
 setting WAKE_MAGICSECURE
Message-ID: <20181010181010.86131-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Todd Fujinaka <todd.fujinaka@intel.com>

There's a new flag for setting WoL filters that is only
enabled on one manufacturer's NICs, and it's not ours. Fail
with EOPNOTSUPP.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 3 ++-
 drivers/net/ethernet/intel/igb/igb_ethtool.c     | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f35a26c..ee6a6c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2377,7 +2377,8 @@ static int i40e_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 		return -EOPNOTSUPP;
 
 	/* only magic packet is supported */
-	if (wol->wolopts && (wol->wolopts != WAKE_MAGIC))
+	if (wol->wolopts && (wol->wolopts != WAKE_MAGIC)
+			  | (wol->wolopts != WAKE_FILTER))
 		return -EOPNOTSUPP;
 
 	/* is this a new value? */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index e0a0e62..7426060 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2113,7 +2113,7 @@ static int igb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
-	if (wol->wolopts & (WAKE_ARP | WAKE_MAGICSECURE))
+	if (wol->wolopts & (WAKE_ARP | WAKE_MAGICSECURE | WAKE_FILTER))
 		return -EOPNOTSUPP;
 
 	if (!(adapter->flags & IGB_FLAG_WOL_SUPPORTED))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 732b1e6..acba067 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2206,7 +2206,8 @@ static int ixgbe_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 
-	if (wol->wolopts & (WAKE_PHY | WAKE_ARP | WAKE_MAGICSECURE))
+	if (wol->wolopts & (WAKE_PHY | WAKE_ARP | WAKE_MAGICSECURE |
+			    WAKE_FILTER))
 		return -EOPNOTSUPP;
 
 	if (ixgbe_wol_exclusion(adapter, wol))
-- 
2.9.5

