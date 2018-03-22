From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Mar 2018 17:33:49 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v5 5/9] igb: Add support for
 enabling queue steering in filters
In-Reply-To: <20180322003353.29970-1-vinicius.gomes@intel.com>
References: <20180322003353.29970-1-vinicius.gomes@intel.com>
Message-ID: <20180322003353.29970-6-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On some igb models (82575 and i210) the MAC address filters can
control to which queue the packet will be assigned.

This extends the 'state' with one more state to signify that queue
selection should be enabled for that filter.

As 82575 parts are no longer easily obtained (and this was developed
against i210), only support for the i210 model is enabled.

These functions are exported and will be used in the next patch.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h |  1 +
 drivers/net/ethernet/intel/igb/igb.h           |  6 ++++++
 drivers/net/ethernet/intel/igb/igb_main.c      | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index a3e5514b044e..c6f552de30dd 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -491,6 +491,7 @@
  */
 #define E1000_RAH_AV  0x80000000        /* Receive descriptor valid */
 #define E1000_RAH_ASEL_SRC_ADDR 0x00010000
+#define E1000_RAH_QSEL_ENABLE 0x10000000
 #define E1000_RAL_MAC_ADDR_LEN 4
 #define E1000_RAH_MAC_ADDR_LEN 2
 #define E1000_RAH_POOL_MASK 0x03FC0000
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 4501b28ff7c5..dfef1702ba21 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -474,6 +474,7 @@ struct igb_mac_addr {
 #define IGB_MAC_STATE_DEFAULT	0x1
 #define IGB_MAC_STATE_IN_USE	0x2
 #define IGB_MAC_STATE_SRC_ADDR  0x4
+#define IGB_MAC_STATE_QUEUE_STEERING 0x8
 
 /* board specific private data structure */
 struct igb_adapter {
@@ -739,4 +740,9 @@ int igb_add_filter(struct igb_adapter *adapter,
 int igb_erase_filter(struct igb_adapter *adapter,
 		     struct igb_nfc_filter *input);
 
+int igb_add_mac_steering_filter(struct igb_adapter *adapter,
+				const u8 *addr, u8 queue, u8 flags);
+int igb_del_mac_steering_filter(struct igb_adapter *adapter,
+				const u8 *addr, u8 queue, u8 flags);
+
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a5a681f7fbb2..52cd891aa579 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6934,6 +6934,28 @@ static int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 	return igb_del_mac_filter_flags(adapter, addr, queue, 0);
 }
 
+int igb_add_mac_steering_filter(struct igb_adapter *adapter,
+				const u8 *addr, u8 queue, u8 flags)
+{
+	struct e1000_hw *hw = &adapter->hw;
+
+	/* In theory, this should be supported on 82575 as well, but
+	 * that part wasn't easily accessible during development.
+	 */
+	if (hw->mac.type != e1000_i210)
+		return -EOPNOTSUPP;
+
+	return igb_add_mac_filter_flags(adapter, addr, queue,
+					IGB_MAC_STATE_QUEUE_STEERING | flags);
+}
+
+int igb_del_mac_steering_filter(struct igb_adapter *adapter,
+				const u8 *addr, u8 queue, u8 flags)
+{
+	return igb_del_mac_filter_flags(adapter, addr, queue,
+					IGB_MAC_STATE_QUEUE_STEERING | flags);
+}
+
 static int igb_uc_sync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
@@ -8783,6 +8805,10 @@ static void igb_rar_set_index(struct igb_adapter *adapter, u32 index)
 		switch (hw->mac.type) {
 		case e1000_82575:
 		case e1000_i210:
+			if (adapter->mac_table[index].state &
+			    IGB_MAC_STATE_QUEUE_STEERING)
+				rar_high |= E1000_RAH_QSEL_ENABLE;
+
 			rar_high |= E1000_RAH_POOL_1 *
 				      adapter->mac_table[index].queue;
 			break;
-- 
2.16.2

