From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 23 Feb 2018 17:20:35 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 7/8] igb: Add support for
 adding offloaded clsflower filters
In-Reply-To: <20180224012036.5834-1-vinicius.gomes@intel.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
Message-ID: <20180224012036.5834-8-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This allows filters added by tc-flower and specifying MAC addresses,
Ethernet types, and the VLAN priority field, to be offloaded to the
controller.

This reuses most of the infrastructure used by ethtool, ethtool can be
used to read these filters, but modification and deletion can only be
done via tc-flower.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |   5 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c |  13 ++-
 drivers/net/ethernet/intel/igb/igb_main.c    | 140 ++++++++++++++++++++++++++-
 3 files changed, 152 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index e06d6fdcb2ce..05d8c827d33e 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -463,6 +463,7 @@ struct igb_nfc_input {
 struct igb_nfc_filter {
 	struct hlist_node nfc_node;
 	struct igb_nfc_input filter;
+	unsigned long cookie;
 	u16 etype_reg_index;
 	u16 sw_idx;
 	u16 action;
@@ -747,4 +748,8 @@ int igb_add_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 int igb_del_mac_filter(struct igb_adapter *adapter, const u8 *addr,
 		       const u8 queue, const u8 flags);
 
+int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
+				 struct igb_nfc_filter *input,
+				 u16 sw_idx);
+
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index d8686a0f5b5d..5386eb68ab15 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2918,9 +2918,9 @@ int igb_erase_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
 	return 0;
 }
 
-static int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
-					struct igb_nfc_filter *input,
-					u16 sw_idx)
+int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
+				 struct igb_nfc_filter *input,
+				 u16 sw_idx)
 {
 	struct igb_nfc_filter *rule, *parent;
 	int err = -EINVAL;
@@ -2935,8 +2935,11 @@ static int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
 		parent = rule;
 	}
 
-	/* if there is an old rule occupying our place remove it */
-	if (rule && (rule->sw_idx == sw_idx)) {
+	/* if there is an old rule occupying our place remove it, also
+	 * only allow rules added by ethtool to be removed, these
+	 * rules don't have a cookie
+	 */
+	if (rule && (!rule->cookie && rule->sw_idx == sw_idx)) {
 		if (!input)
 			err = igb_erase_filter(adapter, rule);
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5344261e6f45..b1d401e77d62 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2497,10 +2497,148 @@ static int igb_offload_cbs(struct igb_adapter *adapter,
 	return 0;
 }
 
+#define ETHER_TYPE_FULL_MASK ((__force __be16)~0)
+
+static int igb_parse_cls_flower(struct igb_adapter *adapter,
+				struct tc_cls_flower_offload *f,
+				int traffic_class,
+				struct igb_nfc_filter *input)
+{
+	if (f->dissector->used_keys &
+	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT(FLOW_DISSECTOR_KEY_VLAN))) {
+		dev_err(&adapter->pdev->dev, "Unsupported key used: 0x%x\n",
+			f->dissector->used_keys);
+		return -EOPNOTSUPP;
+	}
+
+	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		struct flow_dissector_key_eth_addrs *key =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_ETH_ADDRS,
+						  f->key);
+
+		struct flow_dissector_key_eth_addrs *mask =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_ETH_ADDRS,
+						  f->mask);
+
+		if (is_broadcast_ether_addr(mask->dst)) {
+			input->filter.match_flags |=
+				IGB_FILTER_FLAG_DST_MAC_ADDR;
+			ether_addr_copy(input->filter.dst_addr, key->dst);
+		}
+
+		if (is_broadcast_ether_addr(mask->src)) {
+			input->filter.match_flags |=
+				IGB_FILTER_FLAG_SRC_MAC_ADDR;
+			ether_addr_copy(input->filter.src_addr, key->src);
+		}
+	}
+
+	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_dissector_key_basic *key =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_BASIC,
+						  f->key);
+
+		struct flow_dissector_key_basic *mask =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_BASIC,
+						  f->mask);
+
+		if (mask->n_proto == ETHER_TYPE_FULL_MASK) {
+			input->filter.match_flags |=
+				IGB_FILTER_FLAG_ETHER_TYPE;
+			input->filter.etype = key->n_proto;
+		}
+	}
+
+	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_VLAN)) {
+		struct flow_dissector_key_vlan *key =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_VLAN,
+						  f->key);
+		struct flow_dissector_key_vlan *mask =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_VLAN,
+						  f->mask);
+
+		if (mask->vlan_priority) {
+			input->filter.match_flags |= IGB_FILTER_FLAG_VLAN_TCI;
+			input->filter.vlan_tci = key->vlan_priority;
+		}
+	}
+
+	input->action = traffic_class;
+	input->cookie = f->cookie;
+
+	return 0;
+}
+
 static int igb_configure_clsflower(struct igb_adapter *adapter,
 				   struct tc_cls_flower_offload *cls_flower)
 {
-	return -EOPNOTSUPP;
+	struct igb_nfc_filter *input, *rule;
+	u16 location = 0;
+	int err, tc;
+
+	if (!(adapter->netdev->hw_features & NETIF_F_NTUPLE))
+		return -EOPNOTSUPP;
+
+	tc = tc_classid_to_hwtc(adapter->netdev, cls_flower->classid);
+	if (tc < 0) {
+		dev_err(&adapter->pdev->dev, "Invalid traffic class\n");
+		return -EINVAL;
+	}
+
+	input = kzalloc(sizeof(*input), GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	err = igb_parse_cls_flower(adapter, cls_flower, tc, input);
+	if (err < 0)
+		goto error_parse;
+
+	spin_lock(&adapter->nfc_lock);
+
+	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
+		if (!memcmp(&input->filter, &rule->filter,
+			    sizeof(input->filter))) {
+			err = -EEXIST;
+			dev_err(&adapter->pdev->dev,
+				"tc-flower: this filter is already set\n");
+			goto error_locked;
+		}
+
+		if (rule->sw_idx > location)
+			location = rule->sw_idx;
+	}
+
+	if (adapter->nfc_filter_count != 0)
+		location++;
+
+	input->sw_idx = location;
+
+	err = igb_add_filter(adapter, input);
+	if (err < 0)
+		goto error_locked;
+
+	igb_update_ethtool_nfc_entry(adapter, input, location);
+
+	spin_unlock(&adapter->nfc_lock);
+
+	return 0;
+
+error_locked:
+	spin_unlock(&adapter->nfc_lock);
+
+error_parse:
+	kfree(input);
+
+	return err;
 }
 
 static int igb_delete_clsflower(struct igb_adapter *adapter,
-- 
2.16.2

