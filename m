From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 23 Feb 2018 17:20:32 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 4/8] igb: Add support for MAC
 address filters specifying source addresses
In-Reply-To: <20180224012036.5834-1-vinicius.gomes@intel.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
Message-ID: <20180224012036.5834-5-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Makes it possible to direct packets to queues based on their source
address. Documents the expected usage of the 'flags' parameter.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h |  1 +
 drivers/net/ethernet/intel/igb/igb.h           |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c      | 35 +++++++++++++++++++-------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 573bf177fd08..c6f552de30dd 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -490,6 +490,7 @@
  * manageability enabled, allowing us room for 15 multicast addresses.
  */
 #define E1000_RAH_AV  0x80000000        /* Receive descriptor valid */
+#define E1000_RAH_ASEL_SRC_ADDR 0x00010000
 #define E1000_RAH_QSEL_ENABLE 0x10000000
 #define E1000_RAL_MAC_ADDR_LEN 4
 #define E1000_RAH_MAC_ADDR_LEN 2
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 1c6b8d9176a8..d5cd5f6708d9 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -472,6 +472,7 @@ struct igb_mac_addr {
 
 #define IGB_MAC_STATE_DEFAULT	0x1
 #define IGB_MAC_STATE_IN_USE	0x2
+#define IGB_MAC_STATE_SRC_ADDR  0x4
 
 /* board specific private data structure */
 struct igb_adapter {
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 543aa99892eb..db66b697fe3b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6837,8 +6837,13 @@ static void igb_set_default_mac_filter(struct igb_adapter *adapter)
 	igb_rar_set_index(adapter, 0);
 }
 
+/* Add a MAC filter for 'addr' directing matching traffic to 'queue',
+ * 'flags' is used to indicate what kind of match is made, match is by
+ * default for the destination address, if matching by source address
+ * is desired the flag IGB_MAC_STATE_SRC_ADDR can be used.
+ */
 static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
-			      const u8 queue)
+			      const u8 queue, const u8 flags)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count -
@@ -6858,7 +6863,7 @@ static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 
 		ether_addr_copy(adapter->mac_table[i].addr, addr);
 		adapter->mac_table[i].queue = queue;
-		adapter->mac_table[i].state |= IGB_MAC_STATE_IN_USE;
+		adapter->mac_table[i].state |= (IGB_MAC_STATE_IN_USE | flags);
 
 		igb_rar_set_index(adapter, i);
 		return i;
@@ -6867,8 +6872,14 @@ static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 	return -ENOSPC;
 }
 
+/* Remove a MAC filter for 'addr' directing matching traffic to
+ * 'queue', 'flags' is used to indicate what kind of match need to be
+ * removed, match is by default for the destination address, if
+ * matching by source address is to be removed the flag
+ * IGB_MAC_STATE_SRC_ADDR can be used.
+ */
 static int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
-			      const u8 queue)
+			      const u8 queue, const u8 flags)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count -
@@ -6883,14 +6894,15 @@ static int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 	 * for the VF MAC addresses.
 	 */
 	for (i = 0; i < rar_entries; i++) {
-		if (!(adapter->mac_table[i].state & IGB_MAC_STATE_IN_USE))
+		if (!(adapter->mac_table[i].state &
+		      (IGB_MAC_STATE_IN_USE | flags)))
 			continue;
 		if (adapter->mac_table[i].queue != queue)
 			continue;
 		if (!ether_addr_equal(adapter->mac_table[i].addr, addr))
 			continue;
 
-		adapter->mac_table[i].state &= ~IGB_MAC_STATE_IN_USE;
+		adapter->mac_table[i].state &= ~(IGB_MAC_STATE_IN_USE | flags);
 		memset(adapter->mac_table[i].addr, 0, ETH_ALEN);
 		adapter->mac_table[i].queue = 0;
 
@@ -6906,7 +6918,8 @@ static int igb_uc_sync(struct net_device *netdev, const unsigned char *addr)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int ret;
 
-	ret = igb_add_mac_filter(adapter, addr, adapter->vfs_allocated_count);
+	ret = igb_add_mac_filter(adapter, addr,
+				 adapter->vfs_allocated_count, 0);
 
 	return min_t(int, ret, 0);
 }
@@ -6915,7 +6928,7 @@ static int igb_uc_unsync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
-	igb_del_mac_filter(adapter, addr, adapter->vfs_allocated_count);
+	igb_del_mac_filter(adapter, addr, adapter->vfs_allocated_count, 0);
 
 	return 0;
 }
@@ -6937,7 +6950,8 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 			if (entry->vf == vf) {
 				entry->vf = -1;
 				entry->free = true;
-				igb_del_mac_filter(adapter, entry->vf_mac, vf);
+				igb_del_mac_filter(adapter,
+						   entry->vf_mac, vf, 0);
 			}
 		}
 		break;
@@ -6968,7 +6982,7 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 			entry->vf = vf;
 			ether_addr_copy(entry->vf_mac, addr);
 
-			ret = igb_add_mac_filter(adapter, addr, vf);
+			ret = igb_add_mac_filter(adapter, addr, vf, 0);
 			ret = min_t(int, ret, 0);
 		} else {
 			ret = -ENOSPC;
@@ -8743,6 +8757,9 @@ static void igb_rar_set_index(struct igb_adapter *adapter, u32 index)
 		if (is_valid_ether_addr(addr))
 			rar_high |= E1000_RAH_AV;
 
+		if (adapter->mac_table[index].state & IGB_MAC_STATE_SRC_ADDR)
+			rar_high |= E1000_RAH_ASEL_SRC_ADDR;
+
 		switch (hw->mac.type) {
 		case e1000_82575:
 		case e1000_i210:
-- 
2.16.2

