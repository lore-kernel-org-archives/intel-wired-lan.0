From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri,  2 Mar 2018 10:43:44 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 8/8] igb: Add support for
 adding offloaded clsflower filters
In-Reply-To: <20180302184344.5744-1-vinicius.gomes@intel.com>
References: <20180302184344.5744-1-vinicius.gomes@intel.com>
Message-ID: <20180302184344.5744-9-vinicius.gomes@intel.com>
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
 drivers/net/ethernet/intel/igb/igb.h      |   2 +
 drivers/net/ethernet/intel/igb/igb_main.c | 176 +++++++++++++++++++++++++++++-
 2 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 43ce6d64f693..0edd3a74d043 100644
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
@@ -601,6 +602,7 @@ struct igb_adapter {
 
 	/* RX network flow classification support */
 	struct hlist_head nfc_filter_list;
+	struct hlist_head cls_flower_list;
 	unsigned int nfc_filter_count;
 	/* lock for RX network flow classification filter */
 	spinlock_t nfc_lock;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b5a6bd37bb16..cbd2048b9110 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2397,6 +2397,12 @@ static int igb_set_features(struct net_device *netdev,
 			hlist_del(&rule->nfc_node);
 			kfree(rule);
 		}
+		hlist_for_each_entry_safe(rule, node2,
+					  &adapter->cls_flower_list, nfc_node) {
+			igb_erase_filter(adapter, rule);
+			hlist_del(&rule->nfc_node);
+			kfree(rule);
+		}
 		spin_unlock(&adapter->nfc_lock);
 		adapter->nfc_filter_count = 0;
 	}
@@ -2497,16 +2503,179 @@ static int igb_offload_cbs(struct igb_adapter *adapter,
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
+	struct igb_nfc_filter *filter, *f;
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
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return -ENOMEM;
+
+	err = igb_parse_cls_flower(adapter, cls_flower, tc, filter);
+	if (err < 0) {
+		dev_err(&adapter->pdev->dev, "Invalid cls_flower filter\n");
+		goto err_parse;
+	}
+
+	spin_lock(&adapter->nfc_lock);
+
+	hlist_for_each_entry(f, &adapter->nfc_filter_list, nfc_node) {
+		if (!memcmp(&f->filter, &filter->filter, sizeof(f->filter))) {
+			err = -EEXIST;
+			dev_err(&adapter->pdev->dev,
+				"This filter is already set in ethtool\n");
+			goto err_locked;
+		}
+	}
+
+	hlist_for_each_entry(f, &adapter->cls_flower_list, nfc_node) {
+		if (!memcmp(&f->filter, &filter->filter, sizeof(f->filter))) {
+			err = -EEXIST;
+			dev_err(&adapter->pdev->dev,
+				"This filter is already set in cls_flower\n");
+			goto err_locked;
+		}
+	}
+
+	err = igb_add_filter(adapter, filter);
+	if (err < 0)
+		goto err_locked;
+
+	hlist_add_head(&filter->nfc_node, &adapter->cls_flower_list);
+
+	spin_unlock(&adapter->nfc_lock);
+
+	return 0;
+
+err_locked:
+	spin_unlock(&adapter->nfc_lock);
+
+err_parse:
+	kfree(filter);
+
+	return err;
 }
 
 static int igb_delete_clsflower(struct igb_adapter *adapter,
 				struct tc_cls_flower_offload *cls_flower)
 {
-	return -EOPNOTSUPP;
+	struct igb_nfc_filter *filter;
+	int err;
+
+	spin_lock(&adapter->nfc_lock);
+
+	hlist_for_each_entry(filter, &adapter->cls_flower_list, nfc_node)
+		if (filter->cookie == cls_flower->cookie)
+			break;
+
+	if (!filter) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	err = igb_erase_filter(adapter, filter);
+	if (err < 0)
+		goto out;
+
+	hlist_del(&filter->nfc_node);
+	kfree(filter);
+
+out:
+	spin_unlock(&adapter->nfc_lock);
+
+	return err;
 }
 
 static int igb_setup_tc_cls_flower(struct igb_adapter *adapter,
@@ -9271,6 +9440,9 @@ static void igb_nfc_filter_exit(struct igb_adapter *adapter)
 	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node)
 		igb_erase_filter(adapter, rule);
 
+	hlist_for_each_entry(rule, &adapter->cls_flower_list, nfc_node)
+		igb_erase_filter(adapter, rule);
+
 	spin_unlock(&adapter->nfc_lock);
 }
 
-- 
2.16.2

