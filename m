From: Andre Guedes <andre.guedes@intel.com>
Date: Wed,  1 Apr 2020 14:41:43 -0700
Subject: [Intel-wired-lan] [PATCH v2 07/12] igc: Remove 'queue' check in
 igc_del_mac_filter()
In-Reply-To: <20200318230102.36952-8-andre.guedes@intel.com>
References: <20200318230102.36952-8-andre.guedes@intel.com>
Message-ID: <20200401214142.2779-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igc_add_mac_filter() doesn't allow us to have more than one entry with
the same address and address type in adapter->mac_table so checking if
'queue' matches in igc_del_mac_filter() isn't necessary. This patch
removes that check.

This patch also takes the opportunity to improve the igc_del_mac_filter
documentation and remove comment which is not applicable to this I225
controller.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
---
v2: Fix function documentation to follow kernel-doc style.
---
 drivers/net/ethernet/intel/igc/igc_main.c | 25 ++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 37c8980a43a0..961a7c642e44 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2234,14 +2234,17 @@ static int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 	return -ENOSPC;
 }
 
-/* Remove a MAC filter for 'addr' directing matching traffic to
- * 'queue', 'flags' is used to indicate what kind of match need to be
- * removed, match is by default for the destination address, if
- * matching by source address is to be removed the flag
- * IGC_MAC_STATE_SRC_ADDR can be used.
+/**
+ * igc_del_mac_filter() - Delete MAC address filter.
+ * @adapter: Pointer to adapter where the filter should be deleted from.
+ * @addr: MAC address.
+ * @flags: Set IGC_MAC_STATE_SRC_ADDR bit to indicate @address is a source
+ *         address.
+ *
+ * Return: 0 in case of success, negative errno code otherwise.
  */
 static int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
-			      const u8 queue, const u8 flags)
+			      const u8 flags)
 {
 	struct igc_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count;
@@ -2250,17 +2253,11 @@ static int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
 
-	/* Search for matching entry in the MAC table based on given address
-	 * and queue. Do not touch entries at the end of the table reserved
-	 * for the VF MAC addresses.
-	 */
 	for (i = 0; i < rar_entries; i++) {
 		if (!(adapter->mac_table[i].state & IGC_MAC_STATE_IN_USE))
 			continue;
 		if (flags && (adapter->mac_table[i].state & flags) != flags)
 			continue;
-		if (adapter->mac_table[i].queue != queue)
-			continue;
 		if (!ether_addr_equal(adapter->mac_table[i].addr, addr))
 			continue;
 
@@ -2296,7 +2293,7 @@ static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
-	return igc_del_mac_filter(adapter, addr, adapter->num_rx_queues, 0);
+	return igc_del_mac_filter(adapter, addr, 0);
 }
 
 /**
@@ -3741,7 +3738,7 @@ int igc_add_mac_steering_filter(struct igc_adapter *adapter,
 int igc_del_mac_steering_filter(struct igc_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags)
 {
-	return igc_del_mac_filter(adapter, addr, queue,
+	return igc_del_mac_filter(adapter, addr,
 				  IGC_MAC_STATE_QUEUE_STEERING | flags);
 }
 
-- 
2.26.0

