From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:00:51 -0700
Subject: [Intel-wired-lan] [PATCH 01/12] igc: Remove duplicate code in MAC
 filtering logic
In-Reply-To: <20200318230102.36952-1-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
Message-ID: <20200318230102.36952-2-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch does a code refactoring in the MAC address filtering logic to
get rid of some duplicate code.

IGC driver has two functions to add MAC address filters that are pretty
much the same: igc_add_mac_filter() and igc_add_mac_filter_flags(). The
only difference is that the latter allows the callee to specify the
'flags' parameter while the former has it hardcoded as zero. The same
rationale applies to filter deletion counterparts.

So this patch refactors igc_add_mac_filter() and igc_del_mac_filter() so
they handle the 'flags' parameters, removes the _flags() functions, and
fixes callees accordingly.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 112 +++-------------------
 1 file changed, 13 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a964ef18ac0c..107e9f86bd0a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2192,8 +2192,8 @@ static bool igc_mac_entry_can_be_used(const struct igc_mac_addr *entry,
  * default for the destination address, if matching by source address
  * is desired the flag IGC_MAC_STATE_SRC_ADDR can be used.
  */
-static int igc_add_mac_filter(struct igc_adapter *adapter,
-			      const u8 *addr, const u8 queue)
+static int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
+			      const u8 queue, const u8 flags)
 {
 	struct igc_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count;
@@ -2208,12 +2208,12 @@ static int igc_add_mac_filter(struct igc_adapter *adapter,
 	 */
 	for (i = 0; i < rar_entries; i++) {
 		if (!igc_mac_entry_can_be_used(&adapter->mac_table[i],
-					       addr, 0))
+					       addr, flags))
 			continue;
 
 		ether_addr_copy(adapter->mac_table[i].addr, addr);
 		adapter->mac_table[i].queue = queue;
-		adapter->mac_table[i].state |= IGC_MAC_STATE_IN_USE;
+		adapter->mac_table[i].state |= IGC_MAC_STATE_IN_USE | flags;
 
 		igc_rar_set_index(adapter, i);
 		return i;
@@ -2228,8 +2228,8 @@ static int igc_add_mac_filter(struct igc_adapter *adapter,
  * matching by source address is to be removed the flag
  * IGC_MAC_STATE_SRC_ADDR can be used.
  */
-static int igc_del_mac_filter(struct igc_adapter *adapter,
-			      const u8 *addr, const u8 queue)
+static int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
+			      const u8 queue, const u8 flags)
 {
 	struct igc_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count;
@@ -2245,7 +2245,7 @@ static int igc_del_mac_filter(struct igc_adapter *adapter,
 	for (i = 0; i < rar_entries; i++) {
 		if (!(adapter->mac_table[i].state & IGC_MAC_STATE_IN_USE))
 			continue;
-		if (adapter->mac_table[i].state != 0)
+		if (flags && (adapter->mac_table[i].state & flags) != flags)
 			continue;
 		if (adapter->mac_table[i].queue != queue)
 			continue;
@@ -2277,7 +2277,7 @@ static int igc_uc_sync(struct net_device *netdev, const unsigned char *addr)
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	int ret;
 
-	ret = igc_add_mac_filter(adapter, addr, adapter->num_rx_queues);
+	ret = igc_add_mac_filter(adapter, addr, adapter->num_rx_queues, 0);
 
 	return min_t(int, ret, 0);
 }
@@ -2286,7 +2286,7 @@ static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
-	igc_del_mac_filter(adapter, addr, adapter->num_rx_queues);
+	igc_del_mac_filter(adapter, addr, adapter->num_rx_queues, 0);
 
 	return 0;
 }
@@ -3723,104 +3723,18 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
 	return features;
 }
 
-/* Add a MAC filter for 'addr' directing matching traffic to 'queue',
- * 'flags' is used to indicate what kind of match is made, match is by
- * default for the destination address, if matching by source address
- * is desired the flag IGC_MAC_STATE_SRC_ADDR can be used.
- */
-static int igc_add_mac_filter_flags(struct igc_adapter *adapter,
-				    const u8 *addr, const u8 queue,
-				    const u8 flags)
-{
-	struct igc_hw *hw = &adapter->hw;
-	int rar_entries = hw->mac.rar_entry_count;
-	int i;
-
-	if (is_zero_ether_addr(addr))
-		return -EINVAL;
-
-	/* Search for the first empty entry in the MAC table.
-	 * Do not touch entries at the end of the table reserved for the VF MAC
-	 * addresses.
-	 */
-	for (i = 0; i < rar_entries; i++) {
-		if (!igc_mac_entry_can_be_used(&adapter->mac_table[i],
-					       addr, flags))
-			continue;
-
-		ether_addr_copy(adapter->mac_table[i].addr, addr);
-		adapter->mac_table[i].queue = queue;
-		adapter->mac_table[i].state |= IGC_MAC_STATE_IN_USE | flags;
-
-		igc_rar_set_index(adapter, i);
-		return i;
-	}
-
-	return -ENOSPC;
-}
-
 int igc_add_mac_steering_filter(struct igc_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags)
 {
-	return igc_add_mac_filter_flags(adapter, addr, queue,
-					IGC_MAC_STATE_QUEUE_STEERING | flags);
-}
-
-/* Remove a MAC filter for 'addr' directing matching traffic to
- * 'queue', 'flags' is used to indicate what kind of match need to be
- * removed, match is by default for the destination address, if
- * matching by source address is to be removed the flag
- * IGC_MAC_STATE_SRC_ADDR can be used.
- */
-static int igc_del_mac_filter_flags(struct igc_adapter *adapter,
-				    const u8 *addr, const u8 queue,
-				    const u8 flags)
-{
-	struct igc_hw *hw = &adapter->hw;
-	int rar_entries = hw->mac.rar_entry_count;
-	int i;
-
-	if (is_zero_ether_addr(addr))
-		return -EINVAL;
-
-	/* Search for matching entry in the MAC table based on given address
-	 * and queue. Do not touch entries at the end of the table reserved
-	 * for the VF MAC addresses.
-	 */
-	for (i = 0; i < rar_entries; i++) {
-		if (!(adapter->mac_table[i].state & IGC_MAC_STATE_IN_USE))
-			continue;
-		if ((adapter->mac_table[i].state & flags) != flags)
-			continue;
-		if (adapter->mac_table[i].queue != queue)
-			continue;
-		if (!ether_addr_equal(adapter->mac_table[i].addr, addr))
-			continue;
-
-		/* When a filter for the default address is "deleted",
-		 * we return it to its initial configuration
-		 */
-		if (adapter->mac_table[i].state & IGC_MAC_STATE_DEFAULT) {
-			adapter->mac_table[i].state =
-				IGC_MAC_STATE_DEFAULT | IGC_MAC_STATE_IN_USE;
-		} else {
-			adapter->mac_table[i].state = 0;
-			adapter->mac_table[i].queue = 0;
-			memset(adapter->mac_table[i].addr, 0, ETH_ALEN);
-		}
-
-		igc_rar_set_index(adapter, i);
-		return 0;
-	}
-
-	return -ENOENT;
+	return igc_add_mac_filter(adapter, addr, queue,
+				  IGC_MAC_STATE_QUEUE_STEERING | flags);
 }
 
 int igc_del_mac_steering_filter(struct igc_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags)
 {
-	return igc_del_mac_filter_flags(adapter, addr, queue,
-					IGC_MAC_STATE_QUEUE_STEERING | flags);
+	return igc_del_mac_filter(adapter, addr, queue,
+				  IGC_MAC_STATE_QUEUE_STEERING | flags);
 }
 
 static void igc_tsync_interrupt(struct igc_adapter *adapter)
-- 
2.25.0

