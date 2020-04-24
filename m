From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:16 -0700
Subject: [Intel-wired-lan] [PATCH 12/19] igc: Fix NFC rules with multicast
 addresses
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-13-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Multicast MAC addresses are valid address for NFC rules but
igc_add_mac_filter() is currently rejecting them. In fact, the I225
controller doesn't impose any constraint on the address value so this
patch gets rid of the address validation check in MAC filter APIs.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7d9a2da4feee..b0c4206f9c7d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2250,9 +2250,6 @@ int igc_add_mac_filter(struct igc_adapter *adapter,
 	struct net_device *dev = adapter->netdev;
 	int index;
 
-	if (!is_valid_ether_addr(addr))
-		return -EINVAL;
-
 	index = igc_find_mac_filter(adapter, type, addr);
 	if (index >= 0)
 		goto update_filter;
@@ -2284,9 +2281,6 @@ int igc_del_mac_filter(struct igc_adapter *adapter,
 	struct net_device *dev = adapter->netdev;
 	int index;
 
-	if (!is_valid_ether_addr(addr))
-		return -EINVAL;
-
 	index = igc_find_mac_filter(adapter, type, addr);
 	if (index < 0)
 		return -ENOENT;
-- 
2.26.0

