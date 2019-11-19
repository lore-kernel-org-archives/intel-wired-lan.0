From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 Nov 2019 13:43:51 +0200
Subject: [Intel-wired-lan] [PATCH v1 03/15] igc: Remove no need declaration
 of the igc_set_default_mac_filter
Message-ID: <20191119114351.41780-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We want to avoid forward-declarations of function if possible.
Rearrange the igc_set_default_mac_filter function implementation.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 91 +++++++++++++++----------------
 1 file changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 87823a04427e..4484e7ab0a53 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -54,7 +54,6 @@ MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
 /* forward declaration */
 static int igc_sw_init(struct igc_adapter *);
 static void igc_configure(struct igc_adapter *adapter);
-static void igc_set_default_mac_filter(struct igc_adapter *adapter);
 static void igc_set_rx_mode(struct net_device *netdev);
 static void igc_write_itr(struct igc_q_vector *q_vector);
 static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector);
@@ -770,6 +769,51 @@ static void igc_setup_tctl(struct igc_adapter *adapter)
 }
 
 /**
+ * igc_rar_set_index - Sync RAL[index] and RAH[index] registers with MAC table
+ * @adapter: address of board private structure
+ * @index: Index of the RAR entry which need to be synced with MAC table
+ */
+static void igc_rar_set_index(struct igc_adapter *adapter, u32 index)
+{
+	u8 *addr = adapter->mac_table[index].addr;
+	struct igc_hw *hw = &adapter->hw;
+	u32 rar_low, rar_high;
+
+	/* HW expects these to be in network order when they are plugged
+	 * into the registers which are little endian.  In order to guarantee
+	 * that ordering we need to do an leXX_to_cpup here in order to be
+	 * ready for the byteswap that occurs with writel
+	 */
+	rar_low = le32_to_cpup((__le32 *)(addr));
+	rar_high = le16_to_cpup((__le16 *)(addr + 4));
+
+	/* Indicate to hardware the Address is Valid. */
+	if (adapter->mac_table[index].state & IGC_MAC_STATE_IN_USE) {
+		if (is_valid_ether_addr(addr))
+			rar_high |= IGC_RAH_AV;
+
+		rar_high |= IGC_RAH_POOL_1 <<
+			adapter->mac_table[index].queue;
+	}
+
+	wr32(IGC_RAL(index), rar_low);
+	wrfl();
+	wr32(IGC_RAH(index), rar_high);
+	wrfl();
+}
+
+/* Set default MAC address for the PF in the first RAR entry */
+static void igc_set_default_mac_filter(struct igc_adapter *adapter)
+{
+	struct igc_mac_addr *mac_table = &adapter->mac_table[0];
+
+	ether_addr_copy(mac_table->addr, adapter->hw.mac.addr);
+	mac_table->state = IGC_MAC_STATE_DEFAULT | IGC_MAC_STATE_IN_USE;
+
+	igc_rar_set_index(adapter, 0);
+}
+
+/**
  * igc_set_mac - Change the Ethernet Address of the NIC
  * @netdev: network interface device structure
  * @p: pointer to an address structure
@@ -2430,51 +2474,6 @@ static void igc_configure(struct igc_adapter *adapter)
 	}
 }
 
-/**
- * igc_rar_set_index - Sync RAL[index] and RAH[index] registers with MAC table
- * @adapter: address of board private structure
- * @index: Index of the RAR entry which need to be synced with MAC table
- */
-static void igc_rar_set_index(struct igc_adapter *adapter, u32 index)
-{
-	u8 *addr = adapter->mac_table[index].addr;
-	struct igc_hw *hw = &adapter->hw;
-	u32 rar_low, rar_high;
-
-	/* HW expects these to be in network order when they are plugged
-	 * into the registers which are little endian.  In order to guarantee
-	 * that ordering we need to do an leXX_to_cpup here in order to be
-	 * ready for the byteswap that occurs with writel
-	 */
-	rar_low = le32_to_cpup((__le32 *)(addr));
-	rar_high = le16_to_cpup((__le16 *)(addr + 4));
-
-	/* Indicate to hardware the Address is Valid. */
-	if (adapter->mac_table[index].state & IGC_MAC_STATE_IN_USE) {
-		if (is_valid_ether_addr(addr))
-			rar_high |= IGC_RAH_AV;
-
-		rar_high |= IGC_RAH_POOL_1 <<
-			adapter->mac_table[index].queue;
-	}
-
-	wr32(IGC_RAL(index), rar_low);
-	wrfl();
-	wr32(IGC_RAH(index), rar_high);
-	wrfl();
-}
-
-/* Set default MAC address for the PF in the first RAR entry */
-static void igc_set_default_mac_filter(struct igc_adapter *adapter)
-{
-	struct igc_mac_addr *mac_table = &adapter->mac_table[0];
-
-	ether_addr_copy(mac_table->addr, adapter->hw.mac.addr);
-	mac_table->state = IGC_MAC_STATE_DEFAULT | IGC_MAC_STATE_IN_USE;
-
-	igc_rar_set_index(adapter, 0);
-}
-
 /* If the filter to be added and an already existing filter express
  * the same address and address type, it should be possible to only
  * override the other configurations, for example the queue to steer
-- 
2.11.0

