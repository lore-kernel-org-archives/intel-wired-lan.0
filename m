From: Brett Creeley <brett.creeley@intel.com>
Date: Fri,  6 Aug 2021 09:58:49 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Use ether_addr_copy() instead of
 memcpy
Message-ID: <20210806165849.687933-1-brett.creeley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To save the netdev->dev_addr the driver is using memcpy with the length
of a MAC address. ether_addr_copy() is meant specifically for this, so
use it.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b85e34caa619..ddabbd186e47 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5221,7 +5221,7 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
 		 * modified outside of the driver and needs to be restored back
 		 * to this value.
 		 */
-		memcpy(netdev->dev_addr, mac, netdev->addr_len);
+		ether_addr_copy(netdev->dev_addr, mac);
 		netdev_dbg(netdev, "filter for MAC %pM already exists\n", mac);
 		return 0;
 	}
@@ -5238,7 +5238,7 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
 	}
 
 	/* change the netdev's MAC address */
-	memcpy(netdev->dev_addr, mac, netdev->addr_len);
+	ether_addr_copy(netdev->dev_addr, mac);
 	netdev_dbg(vsi->netdev, "updated MAC address to %pM\n",
 		   netdev->dev_addr);
 
-- 
2.26.3

