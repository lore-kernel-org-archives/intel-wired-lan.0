From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:01:00 -0700
Subject: [Intel-wired-lan] [PATCH 10/12] igc: Refactor
 igc_mac_entry_can_be_used()
In-Reply-To: <20200318230102.36952-1-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
Message-ID: <20200318230102.36952-11-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The helper igc_mac_entry_can_be_used() implementation is a bit
convoluted since it does two different things: find a not-in-use slot
in mac_table or find an in-use slot where the address and address type
match. This patch does a code refactoring and break it up into two
helper functions.

With this patch we might traverse mac_table twice in some situations,
but this is not harmful performance-wise (mac_table has only 16 entries
and adding mac filters is not hot-path), and it improves igc_add_mac_
filter() readability considerably.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 80 +++++++++++++----------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 25d0431f4f4a..0264e424bd07 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2177,25 +2177,44 @@ static void igc_nfc_filter_restore(struct igc_adapter *adapter)
 	spin_unlock(&adapter->nfc_lock);
 }
 
-/* If the filter to be added and an already existing filter express
- * the same address and address type, it should be possible to only
- * override the other configurations, for example the queue to steer
- * traffic.
- */
-static bool igc_mac_entry_can_be_used(const struct igc_mac_addr *entry,
-				      const u8 *addr, const u8 flags)
+static int igc_find_mac_filter(struct igc_adapter *adapter, const u8 *addr,
+			       u8 flags)
 {
-	if (!(entry->state & IGC_MAC_STATE_IN_USE))
-		return true;
+	int max_entries = adapter->hw.mac.rar_entry_count;
+	struct igc_mac_addr *entry;
+	int i;
 
-	if ((entry->state & IGC_MAC_STATE_SRC_ADDR) !=
-	    (flags & IGC_MAC_STATE_SRC_ADDR))
-		return false;
+	for (i = 0; i < max_entries; i++) {
+		entry = &adapter->mac_table[i];
 
-	if (!ether_addr_equal(addr, entry->addr))
-		return false;
+		if (!(entry->state & IGC_MAC_STATE_IN_USE))
+			continue;
+		if (!ether_addr_equal(addr, entry->addr))
+			continue;
+		if ((entry->state & IGC_MAC_STATE_SRC_ADDR) !=
+		    (flags & IGC_MAC_STATE_SRC_ADDR))
+			continue;
 
-	return true;
+		return i;
+	}
+
+	return -1;
+}
+
+static int igc_get_avail_mac_filter_slot(struct igc_adapter *adapter)
+{
+	int max_entries = adapter->hw.mac.rar_entry_count;
+	struct igc_mac_addr *entry;
+	int i;
+
+	for (i = 0; i < max_entries; i++) {
+		entry = &adapter->mac_table[i];
+
+		if (!(entry->state & IGC_MAC_STATE_IN_USE))
+			return i;
+	}
+
+	return -1;
 }
 
 /* Add MAC address filter to adapter.
@@ -2213,33 +2232,28 @@ static bool igc_mac_entry_can_be_used(const struct igc_mac_addr *entry,
 int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 		       const s8 queue, const u8 flags)
 {
-	struct igc_hw *hw = &adapter->hw;
-	int rar_entries = hw->mac.rar_entry_count;
-	int i;
+	int index;
 
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
 	if (flags & IGC_MAC_STATE_SRC_ADDR)
 		return -ENOTSUPP;
 
-	/* Search for the first empty entry in the MAC table.
-	 * Do not touch entries at the end of the table reserved for the VF MAC
-	 * addresses.
-	 */
-	for (i = 0; i < rar_entries; i++) {
-		if (!igc_mac_entry_can_be_used(&adapter->mac_table[i],
-					       addr, flags))
-			continue;
+	index = igc_find_mac_filter(adapter, addr, flags);
+	if (index >= 0)
+		goto update_queue_assignment;
 
-		ether_addr_copy(adapter->mac_table[i].addr, addr);
-		adapter->mac_table[i].queue = queue;
-		adapter->mac_table[i].state |= IGC_MAC_STATE_IN_USE | flags;
+	index = igc_get_avail_mac_filter_slot(adapter);
+	if (index < 0)
+		return -ENOSPC;
 
-		igc_set_mac_filter_hw(adapter, i, addr, queue);
-		return 0;
-	}
+	ether_addr_copy(adapter->mac_table[index].addr, addr);
+	adapter->mac_table[index].state |= IGC_MAC_STATE_IN_USE | flags;
+update_queue_assignment:
+	adapter->mac_table[index].queue = queue;
 
-	return -ENOSPC;
+	igc_set_mac_filter_hw(adapter, index, addr, queue);
+	return 0;
 }
 
 /* Delete MAC address filter from adapter.
-- 
2.25.0

