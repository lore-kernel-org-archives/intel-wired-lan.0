From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:15:58 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 01/10] ixgbe: Drop support
 for macvlan specific unicast lists
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211558.7880.71817.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Drop the code for handling macvlan specific unicast lists. It isn't needed
since we don't take any efforts to maintain it when we bring the interface
up and it takes the slow path anyway.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   31 -------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba9..4d2c0ed 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4892,36 +4892,6 @@ int ixgbe_del_mac_filter(struct ixgbe_adapter *adapter,
 	return -ENOMEM;
 }
 
-/**
- * ixgbe_write_uc_addr_list - write unicast addresses to RAR table
- * @netdev: network interface device structure
- * @vfn: pool to associate with unicast addresses
- *
- * Writes unicast address list to the RAR table.
- * Returns: -ENOMEM on failure/insufficient address space
- *                0 on no addresses written
- *                X on writing X addresses to the RAR table
- **/
-static int ixgbe_write_uc_addr_list(struct net_device *netdev, int vfn)
-{
-	struct ixgbe_adapter *adapter = netdev_priv(netdev);
-	int count = 0;
-
-	/* return ENOMEM indicating insufficient memory for addresses */
-	if (netdev_uc_count(netdev) > ixgbe_available_rars(adapter, vfn))
-		return -ENOMEM;
-
-	if (!netdev_uc_empty(netdev)) {
-		struct netdev_hw_addr *ha;
-		netdev_for_each_uc_addr(ha, netdev) {
-			ixgbe_del_mac_filter(adapter, ha->addr, vfn);
-			ixgbe_add_mac_filter(adapter, ha->addr, vfn);
-			count++;
-		}
-	}
-	return count;
-}
-
 static int ixgbe_uc_sync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
@@ -5320,7 +5290,6 @@ static void ixgbe_macvlan_set_rx_mode(struct net_device *dev, unsigned int pool,
 		vmolr |= IXGBE_VMOLR_ROMPE;
 		hw->mac.ops.update_mc_addr_list(hw, dev);
 	}
-	ixgbe_write_uc_addr_list(adapter->netdev, pool);
 	IXGBE_WRITE_REG(hw, IXGBE_VMOLR(pool), vmolr);
 }
 

