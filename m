From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:01:02 -0700
Subject: [Intel-wired-lan] [PATCH 12/12] igc: Add debug messages to MAC
 filter code
In-Reply-To: <20200318230102.36952-1-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
Message-ID: <20200318230102.36952-13-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds log messages to functions related to the MAC address
filtering code to ease debugging.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 24 +++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index fa7cf33c58a9..abbe0e1e0cf5 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -776,6 +776,7 @@ static void igc_setup_tctl(struct igc_adapter *adapter)
 static void igc_set_mac_filter_hw(struct igc_adapter *adapter, int index,
 				  const u8 *addr, int queue)
 {
+	struct net_device *dev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
 	u32 ral, rah;
 
@@ -795,6 +796,8 @@ static void igc_set_mac_filter_hw(struct igc_adapter *adapter, int index,
 
 	wr32(IGC_RAL(index), ral);
 	wr32(IGC_RAH(index), rah);
+
+	netdev_dbg(dev, "MAC address filter set in HW: index %d", index);
 }
 
 /* Clear MAC address filter in hardware.
@@ -804,6 +807,7 @@ static void igc_set_mac_filter_hw(struct igc_adapter *adapter, int index,
  */
 static void igc_clear_mac_filter_hw(struct igc_adapter *adapter, int index)
 {
+	struct net_device *dev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
 
 	if (WARN_ON(index >= hw->mac.rar_entry_count))
@@ -811,18 +815,24 @@ static void igc_clear_mac_filter_hw(struct igc_adapter *adapter, int index)
 
 	wr32(IGC_RAL(index), 0);
 	wr32(IGC_RAH(index), 0);
+
+	netdev_dbg(dev, "MAC address filter cleared in HW: index %d", index);
 }
 
 /* Set default MAC address for the PF in the first RAR entry */
 static void igc_set_default_mac_filter(struct igc_adapter *adapter)
 {
 	struct igc_mac_addr *mac_table = &adapter->mac_table[0];
+	struct net_device *dev = adapter->netdev;
+	u8 *addr = adapter->hw.mac.addr;
+
+	netdev_dbg(dev, "Set default MAC address filter: address %pM", addr);
 
-	ether_addr_copy(mac_table->addr, adapter->hw.mac.addr);
+	ether_addr_copy(mac_table->addr, addr);
 	mac_table->state = IGC_MAC_STATE_DEFAULT | IGC_MAC_STATE_IN_USE;
 	mac_table->queue = -1;
 
-	igc_set_mac_filter_hw(adapter, 0, mac_table->addr, mac_table->queue);
+	igc_set_mac_filter_hw(adapter, 0, addr, mac_table->queue);
 }
 
 /**
@@ -2232,6 +2242,7 @@ static int igc_get_avail_mac_filter_slot(struct igc_adapter *adapter)
 int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 		       const s8 queue, const u8 flags)
 {
+	struct net_device *dev = adapter->netdev;
 	int index;
 
 	if (!is_valid_ether_addr(addr))
@@ -2247,6 +2258,9 @@ int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 	if (index < 0)
 		return -ENOSPC;
 
+	netdev_dbg(dev, "Add MAC address filter: index %d address %pM queue %d",
+		   index, addr, queue);
+
 	ether_addr_copy(adapter->mac_table[index].addr, addr);
 	adapter->mac_table[index].state |= IGC_MAC_STATE_IN_USE | flags;
 update_queue_assignment:
@@ -2268,6 +2282,7 @@ int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 		       const u8 flags)
 {
+	struct net_device *dev = adapter->netdev;
 	struct igc_mac_addr *entry;
 	int index;
 
@@ -2285,9 +2300,14 @@ int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 		 * We just reset to its default value i.e. disable queue
 		 * assignment.
 		 */
+		netdev_dbg(dev, "Disable default MAC filter queue assignment");
+
 		entry->queue = -1;
 		igc_set_mac_filter_hw(adapter, 0, addr, entry->queue);
 	} else {
+		netdev_dbg(dev, "Delete MAC address filter: index %d address %pM",
+			   index, addr);
+
 		entry->state = 0;
 		entry->queue = -1;
 		memset(entry->addr, 0, ETH_ALEN);
-- 
2.25.0

