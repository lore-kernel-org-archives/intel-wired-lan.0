From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 23 Feb 2018 17:20:33 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 5/8] igb: Add support for
 ethtool MAC address filters
In-Reply-To: <20180224012036.5834-1-vinicius.gomes@intel.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
Message-ID: <20180224012036.5834-6-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This adds the capability of configuring the queue steering of arriving
packets based on their source and destination MAC addresses.

In practical terms this adds support for the following use cases,
characterized by these examples:

$ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
(this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
to the RX queue 0)

$ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 action 3
(this will direct packets with destination address "44:44:44:44:44:44"
to the RX queue 3)

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |   9 +++
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 110 ++++++++++++++++++++++++++-
 drivers/net/ethernet/intel/igb/igb_main.c    |   8 +-
 3 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index d5cd5f6708d9..e06d6fdcb2ce 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -440,6 +440,8 @@ struct hwmon_buff {
 enum igb_filter_match_flags {
 	IGB_FILTER_FLAG_ETHER_TYPE = 0x1,
 	IGB_FILTER_FLAG_VLAN_TCI   = 0x2,
+	IGB_FILTER_FLAG_SRC_MAC_ADDR   = 0x4,
+	IGB_FILTER_FLAG_DST_MAC_ADDR   = 0x8,
 };
 
 #define IGB_MAX_RXNFC_FILTERS 16
@@ -454,6 +456,8 @@ struct igb_nfc_input {
 	u8 match_flags;
 	__be16 etype;
 	__be16 vlan_tci;
+	u8 src_addr[ETH_ALEN];
+	u8 dst_addr[ETH_ALEN];
 };
 
 struct igb_nfc_filter {
@@ -738,4 +742,9 @@ int igb_add_filter(struct igb_adapter *adapter,
 int igb_erase_filter(struct igb_adapter *adapter,
 		     struct igb_nfc_filter *input);
 
+int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
+		       const u8 queue, const u8 flags);
+int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
+		       const u8 queue, const u8 flags);
+
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 143f0bb34e4d..d8686a0f5b5d 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -152,6 +152,9 @@ static const char igb_priv_flags_strings[][ETH_GSTRING_LEN] = {
 
 #define IGB_PRIV_FLAGS_STR_LEN ARRAY_SIZE(igb_priv_flags_strings)
 
+static const u8 broadcast_addr[ETH_ALEN] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
 static int igb_get_link_ksettings(struct net_device *netdev,
 				  struct ethtool_link_ksettings *cmd)
 {
@@ -2494,6 +2497,25 @@ static int igb_get_ethtool_nfc_entry(struct igb_adapter *adapter,
 			fsp->h_ext.vlan_tci = rule->filter.vlan_tci;
 			fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
 		}
+		if (rule->filter.match_flags & IGB_FILTER_FLAG_DST_MAC_ADDR) {
+			ether_addr_copy(fsp->h_u.ether_spec.h_dest,
+					rule->filter.dst_addr);
+			/* As we only support matching by the full
+			 * mask, return the mask to userspace
+			 */
+			ether_addr_copy(fsp->m_u.ether_spec.h_dest,
+					broadcast_addr);
+		}
+		if (rule->filter.match_flags & IGB_FILTER_FLAG_SRC_MAC_ADDR) {
+			ether_addr_copy(fsp->h_u.ether_spec.h_source,
+					rule->filter.src_addr);
+			/* As we only support matching by the full
+			 * mask, return the mask to userspace
+			 */
+			ether_addr_copy(fsp->m_u.ether_spec.h_source,
+					broadcast_addr);
+		}
+
 		return 0;
 	}
 	return -EINVAL;
@@ -2698,6 +2720,58 @@ static int igb_set_rss_hash_opt(struct igb_adapter *adapter,
 	return 0;
 }
 
+static int igb_rxnfc_write_dst_mac_filter(struct igb_adapter *adapter,
+					  struct igb_nfc_filter *input)
+{
+	int err;
+
+	err = igb_add_mac_filter(adapter, input->filter.dst_addr,
+				 input->action, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int igb_rxnfc_write_src_mac_filter(struct igb_adapter *adapter,
+					  struct igb_nfc_filter *input)
+{
+	int err;
+
+	err = igb_add_mac_filter(adapter, input->filter.src_addr,
+				 input->action, IGB_MAC_STATE_SRC_ADDR);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int igb_rxnfc_del_dst_mac_filter(struct igb_adapter *adapter,
+					struct igb_nfc_filter *input)
+{
+	int err;
+
+	err = igb_del_mac_filter(adapter, input->filter.dst_addr,
+				 input->action, 0);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int igb_rxnfc_del_src_mac_filter(struct igb_adapter *adapter,
+					struct igb_nfc_filter *input)
+{
+	int err;
+
+	err = igb_del_mac_filter(adapter, input->filter.src_addr,
+				 input->action, IGB_MAC_STATE_SRC_ADDR);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static int igb_rxnfc_write_etype_filter(struct igb_adapter *adapter,
 					struct igb_nfc_filter *input)
 {
@@ -2775,6 +2849,18 @@ int igb_add_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
 			return err;
 	}
 
+	if (input->filter.match_flags & IGB_FILTER_FLAG_DST_MAC_ADDR) {
+		err = igb_rxnfc_write_dst_mac_filter(adapter, input);
+		if (err)
+			return err;
+	}
+
+	if (input->filter.match_flags & IGB_FILTER_FLAG_SRC_MAC_ADDR) {
+		err = igb_rxnfc_write_src_mac_filter(adapter, input);
+		if (err)
+			return err;
+	}
+
 	if (input->filter.match_flags & IGB_FILTER_FLAG_VLAN_TCI)
 		err = igb_rxnfc_write_vlan_prio_filter(adapter, input);
 
@@ -2823,6 +2909,12 @@ int igb_erase_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
 		igb_clear_vlan_prio_filter(adapter,
 					   ntohs(input->filter.vlan_tci));
 
+	if (input->filter.match_flags & IGB_FILTER_FLAG_SRC_MAC_ADDR)
+		igb_rxnfc_del_src_mac_filter(adapter, input);
+
+	if (input->filter.match_flags & IGB_FILTER_FLAG_DST_MAC_ADDR)
+		igb_rxnfc_del_dst_mac_filter(adapter, input);
+
 	return 0;
 }
 
@@ -2904,10 +2996,6 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if ((fsp->flow_type & ~FLOW_EXT) != ETHER_FLOW)
 		return -EINVAL;
 
-	if (fsp->m_u.ether_spec.h_proto != ETHER_TYPE_FULL_MASK &&
-	    fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK))
-		return -EINVAL;
-
 	input = kzalloc(sizeof(*input), GFP_KERNEL);
 	if (!input)
 		return -ENOMEM;
@@ -2917,6 +3005,20 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 		input->filter.match_flags = IGB_FILTER_FLAG_ETHER_TYPE;
 	}
 
+	/* Only support matching addresses by the full mask */
+	if (is_broadcast_ether_addr(fsp->m_u.ether_spec.h_source)) {
+		input->filter.match_flags |= IGB_FILTER_FLAG_SRC_MAC_ADDR;
+		ether_addr_copy(input->filter.src_addr,
+				fsp->h_u.ether_spec.h_source);
+	}
+
+	/* Only support matching addresses by the full mask */
+	if (is_broadcast_ether_addr(fsp->m_u.ether_spec.h_dest)) {
+		input->filter.match_flags |= IGB_FILTER_FLAG_DST_MAC_ADDR;
+		ether_addr_copy(input->filter.dst_addr,
+				fsp->h_u.ether_spec.h_dest);
+	}
+
 	if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
 		if (fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK)) {
 			err = -EINVAL;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index db66b697fe3b..5dfbdf05f765 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6842,8 +6842,8 @@ static void igb_set_default_mac_filter(struct igb_adapter *adapter)
  * default for the destination address, if matching by source address
  * is desired the flag IGB_MAC_STATE_SRC_ADDR can be used.
  */
-static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
-			      const u8 queue, const u8 flags)
+int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
+		       const u8 queue, const u8 flags)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count -
@@ -6878,8 +6878,8 @@ static int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
  * matching by source address is to be removed the flag
  * IGB_MAC_STATE_SRC_ADDR can be used.
  */
-static int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
-			      const u8 queue, const u8 flags)
+int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
+		       const u8 queue, const u8 flags)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count -
-- 
2.16.2

