From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:01:01 -0700
Subject: [Intel-wired-lan] [PATCH 11/12] igc: Refactor igc_del_mac_filter()
In-Reply-To: <20200318230102.36952-1-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
Message-ID: <20200318230102.36952-12-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch does a code refactoring in igc_del_mac_filter() so it uses
the new helper igc_find_mac_filter() and improves the comment about the
special handling when deleting the default filter.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 45 ++++++++++-------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 0264e424bd07..fa7cf33c58a9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2268,40 +2268,33 @@ int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 		       const u8 flags)
 {
-	struct igc_hw *hw = &adapter->hw;
-	int rar_entries = hw->mac.rar_entry_count;
-	int i;
+	struct igc_mac_addr *entry;
+	int index;
 
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
 
-	for (i = 0; i < rar_entries; i++) {
-		if (!(adapter->mac_table[i].state & IGC_MAC_STATE_IN_USE))
-			continue;
-		if (flags && (adapter->mac_table[i].state & flags) != flags)
-			continue;
-		if (!ether_addr_equal(adapter->mac_table[i].addr, addr))
-			continue;
+	index = igc_find_mac_filter(adapter, addr, flags);
+	if (index < 0)
+		return -ENOENT;
 
-		/* When a filter for the default address is "deleted",
-		 * we return it to its initial configuration
-		 */
-		if (adapter->mac_table[i].state & IGC_MAC_STATE_DEFAULT) {
-			adapter->mac_table[i].state =
-				IGC_MAC_STATE_DEFAULT | IGC_MAC_STATE_IN_USE;
-			adapter->mac_table[i].queue = -1;
-			igc_set_mac_filter_hw(adapter, 0, addr, -1);
-		} else {
-			adapter->mac_table[i].state = 0;
-			adapter->mac_table[i].queue = -1;
-			memset(adapter->mac_table[i].addr, 0, ETH_ALEN);
-			igc_clear_mac_filter_hw(adapter, i);
-		}
+	entry = &adapter->mac_table[index];
 
-		return 0;
+	if (entry->state & IGC_MAC_STATE_DEFAULT) {
+		/* If this is the default filter, we don't actually delete it.
+		 * We just reset to its default value i.e. disable queue
+		 * assignment.
+		 */
+		entry->queue = -1;
+		igc_set_mac_filter_hw(adapter, 0, addr, entry->queue);
+	} else {
+		entry->state = 0;
+		entry->queue = -1;
+		memset(entry->addr, 0, ETH_ALEN);
+		igc_clear_mac_filter_hw(adapter, index);
 	}
 
-	return -ENOENT;
+	return 0;
 }
 
 static int igc_uc_sync(struct net_device *netdev, const unsigned char *addr)
-- 
2.25.0

