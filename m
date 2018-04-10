From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 10 Apr 2018 10:49:53 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v7 04/10] igb: Add support for
 MAC address filters specifying source addresses
In-Reply-To: <20180410174959.18757-1-vinicius.gomes@intel.com>
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
Message-ID: <20180410174959.18757-5-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Makes it possible to direct packets to queues based on their source
address. Documents the expected usage of the 'flags' parameter.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 .../net/ethernet/intel/igb/e1000_defines.h    |  1 +
 drivers/net/ethernet/intel/igb/igb.h          |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c     | 40 ++++++++++++++++---
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 98534f765e0e..5417edbe3125 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -491,6 +491,7 @@
  * manageability enabled, allowing us room for 15 multicast addresses.
  */
 #define E1000_RAH_AV  0x80000000        /* Receive descriptor valid */
+#define E1000_RAH_ASEL_SRC_ADDR 0x00010000
 #define E1000_RAL_MAC_ADDR_LEN 4
 #define E1000_RAH_MAC_ADDR_LEN 2
 #define E1000_RAH_POOL_MASK 0x03FC0000
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 8dbc399b345e..f3ecda46f287 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -474,6 +474,7 @@ struct igb_mac_addr {
 
 #define IGB_MAC_STATE_DEFAULT	0x1
 #define IGB_MAC_STATE_IN_USE	0x2
+#define IGB_MAC_STATE_SRC_ADDR  0x4
 
 /* board specific private data structure */
 struct igb_adapter {
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 976898d39d6e..2033ec3c9b27 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6844,8 +6844,14 @@ static void igb_set_default_mac_filter(struct igb_adapter *adapter)
 	igb_rar_set_index(adapter, 0);
 }
 
-static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
-			      const u8 queue)
+/* Add a MAC filter for 'addr' directing matching traffic to 'queue',
+ * 'flags' is used to indicate what kind of match is made, match is by
+ * default for the destination address, if matching by source address
+ * is desired the flag IGB_MAC_STATE_SRC_ADDR can be used.
+ */
+static int igb_add_mac_filter_flags(struct igb_adapter *adapter,
+				    const u8 *addr, const u8 queue,
+				    const u8 flags)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count -
@@ -6865,7 +6871,7 @@ static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 
 		ether_addr_copy(adapter->mac_table[i].addr, addr);
 		adapter->mac_table[i].queue = queue;
-		adapter->mac_table[i].state |= IGB_MAC_STATE_IN_USE;
+		adapter->mac_table[i].state |= IGB_MAC_STATE_IN_USE | flags;
 
 		igb_rar_set_index(adapter, i);
 		return i;
@@ -6874,8 +6880,21 @@ static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 	return -ENOSPC;
 }
 
-static int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
+static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 			      const u8 queue)
+{
+	return igb_add_mac_filter_flags(adapter, addr, queue, 0);
+}
+
+/* Remove a MAC filter for 'addr' directing matching traffic to
+ * 'queue', 'flags' is used to indicate what kind of match need to be
+ * removed, match is by default for the destination address, if
+ * matching by source address is to be removed the flag
+ * IGB_MAC_STATE_SRC_ADDR can be used.
+ */
+static int igb_del_mac_filter_flags(struct igb_adapter *adapter,
+				    const u8 *addr, const u8 queue,
+				    const u8 flags)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count -
@@ -6892,12 +6911,14 @@ static int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 	for (i = 0; i < rar_entries; i++) {
 		if (!(adapter->mac_table[i].state & IGB_MAC_STATE_IN_USE))
 			continue;
+		if ((adapter->mac_table[i].state & flags) != flags)
+			continue;
 		if (adapter->mac_table[i].queue != queue)
 			continue;
 		if (!ether_addr_equal(adapter->mac_table[i].addr, addr))
 			continue;
 
-		adapter->mac_table[i].state &= ~IGB_MAC_STATE_IN_USE;
+		adapter->mac_table[i].state = 0;
 		memset(adapter->mac_table[i].addr, 0, ETH_ALEN);
 		adapter->mac_table[i].queue = 0;
 
@@ -6908,6 +6929,12 @@ static int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 	return -ENOENT;
 }
 
+static int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
+			      const u8 queue)
+{
+	return igb_del_mac_filter_flags(adapter, addr, queue, 0);
+}
+
 static int igb_uc_sync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
@@ -8751,6 +8778,9 @@ static void igb_rar_set_index(struct igb_adapter *adapter, u32 index)
 		if (is_valid_ether_addr(addr))
 			rar_high |= E1000_RAH_AV;
 
+		if (adapter->mac_table[index].state & IGB_MAC_STATE_SRC_ADDR)
+			rar_high |= E1000_RAH_ASEL_SRC_ADDR;
+
 		switch (hw->mac.type) {
 		case e1000_82575:
 		case e1000_i210:
-- 
2.17.0

