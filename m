From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Jan 2018 08:16:06 -0800
Subject: [Intel-wired-lan] [PATCH v2 next-queue 11/12] i40evf: Add support
 to apply cloud filters
In-Reply-To: <20180117161607.49344-1-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
Message-ID: <20180117161607.49344-12-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch enables a tc filter to be applied as a cloud
filter for the VF. This patch adds functions which parse the
tc filter, extract the necessary fields needed to configure the
filter and package them in a virtchnl message to be sent to the
PF to apply them.

v2: made i40evf_print_cloud_filter function static.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  48 ++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 574 ++++++++++++++++++++-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 187 +++++++
 3 files changed, 805 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 150d676..e46555a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -54,6 +54,8 @@
 #include <net/ip6_checksum.h>
 #include <net/pkt_cls.h>
 #include <net/udp.h>
+#include <net/tc_act/tc_gact.h>
+#include <net/tc_act/tc_mirred.h>
 
 #include "i40e_type.h"
 #include <linux/avf/virtchnl.h>
@@ -184,6 +186,14 @@ struct i40evf_channel_config {
 	u8 total_qps;
 };
 
+/* State of cloud filter */
+enum i40evf_cloud_filter_state_t {
+	__I40EVF_CF_INVALID,	 /* cloud filter not added */
+	__I40EVF_CF_ADD_PENDING, /* cloud filter pending add by the PF */
+	__I40EVF_CF_DEL_PENDING, /* cloud filter pending del by the PF */
+	__I40EVF_CF_ACTIVE,	 /* cloud filter is active */
+};
+
 /* Driver state. The order of these is important! */
 enum i40evf_state_t {
 	__I40EVF_STARTUP,		/* driver loaded, probe complete */
@@ -205,6 +215,36 @@ enum i40evf_critical_section_t {
 	__I40EVF_IN_REMOVE_TASK,	/* device being removed */
 };
 
+#define I40EVF_CLOUD_FIELD_OMAC		0x01
+#define I40EVF_CLOUD_FIELD_IMAC		0x02
+#define I40EVF_CLOUD_FIELD_IVLAN	0x04
+#define I40EVF_CLOUD_FIELD_TEN_ID	0x08
+#define I40EVF_CLOUD_FIELD_IIP		0x10
+
+#define I40EVF_CF_FLAGS_OMAC	I40EVF_CLOUD_FIELD_OMAC
+#define I40EVF_CF_FLAGS_IMAC	I40EVF_CLOUD_FIELD_IMAC
+#define I40EVF_CF_FLAGS_IMAC_IVLAN	(I40EVF_CLOUD_FIELD_IMAC |\
+					 I40EVF_CLOUD_FIELD_IVLAN)
+#define I40EVF_CF_FLAGS_IMAC_TEN_ID	(I40EVF_CLOUD_FIELD_IMAC |\
+					 I40EVF_CLOUD_FIELD_TEN_ID)
+#define I40EVF_CF_FLAGS_OMAC_TEN_ID_IMAC	(I40EVF_CLOUD_FIELD_OMAC |\
+						 I40EVF_CLOUD_FIELD_IMAC |\
+						 I40EVF_CLOUD_FIELD_TEN_ID)
+#define I40EVF_CF_FLAGS_IMAC_IVLAN_TEN_ID	(I40EVF_CLOUD_FIELD_IMAC |\
+						 I40EVF_CLOUD_FIELD_IVLAN |\
+						 I40EVF_CLOUD_FIELD_TEN_ID)
+#define I40EVF_CF_FLAGS_IIP	I40E_CLOUD_FIELD_IIP
+
+/* bookkeeping of cloud filters */
+struct i40evf_cloud_filter {
+	enum i40evf_cloud_filter_state_t state;
+	struct list_head list;
+	struct virtchnl_filter f;
+	unsigned long cookie;
+	bool del;		/* filter needs to be deleted */
+	bool add;		/* filter needs to be added */
+};
+
 /* board specific private data structure */
 struct i40evf_adapter {
 	struct timer_list watchdog_timer;
@@ -287,6 +327,8 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING	BIT(20)
 #define I40EVF_FLAG_AQ_ENABLE_CHANNELS		BIT(21)
 #define I40EVF_FLAG_AQ_DISABLE_CHANNELS		BIT(22)
+#define I40EVF_FLAG_AQ_ADD_CLOUD_FILTER		BIT(23)
+#define I40EVF_FLAG_AQ_DEL_CLOUD_FILTER		BIT(24)
 
 	/* OS defined structs */
 	struct net_device *netdev;
@@ -335,6 +377,10 @@ struct i40evf_adapter {
 	/* ADQ related members */
 	struct i40evf_channel_config ch_config;
 	u8 num_tc;
+	struct list_head cloud_filter_list;
+	/* lock to protest access to the cloud filter list */
+	spinlock_t cloud_filter_list_lock;
+	u16 num_cloud_filters;
 };
 
 
@@ -403,4 +449,6 @@ void i40evf_notify_client_open(struct i40e_vsi *vsi);
 void i40evf_notify_client_close(struct i40e_vsi *vsi, bool reset);
 void i40evf_enable_channels(struct i40evf_adapter *adapter);
 void i40evf_disable_channels(struct i40evf_adapter *adapter);
+void i40evf_add_cloud_filter(struct i40evf_adapter *adapter);
+void i40evf_del_cloud_filter(struct i40evf_adapter *adapter);
 #endif /* _I40EVF_H_ */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 91fff5f..f78ed62 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1028,6 +1028,7 @@ void i40evf_down(struct i40evf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct i40evf_mac_filter *f;
+	struct i40evf_cloud_filter *cf;
 
 	if (adapter->state <= __I40EVF_DOWN_PENDING)
 		return;
@@ -1051,6 +1052,13 @@ void i40evf_down(struct i40evf_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
+	/* remove all cloud filters */
+	spin_lock_bh(&adapter->cloud_filter_list_lock);
+	list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
+		cf->del = true;
+	}
+	spin_unlock_bh(&adapter->cloud_filter_list_lock);
+
 	if (!(adapter->flags & I40EVF_FLAG_PF_COMMS_FAILED) &&
 	    adapter->state != __I40EVF_RESETTING) {
 		/* cancel any current operation */
@@ -1061,6 +1069,7 @@ void i40evf_down(struct i40evf_adapter *adapter)
 		 */
 		adapter->aq_required = I40EVF_FLAG_AQ_DEL_MAC_FILTER;
 		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
+		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_CLOUD_FILTER;
 		adapter->aq_required |= I40EVF_FLAG_AQ_DISABLE_QUEUES;
 	}
 
@@ -1738,6 +1747,16 @@ static void i40evf_watchdog_task(struct work_struct *work)
 		goto watchdog_done;
 	}
 
+	if (adapter->aq_required & I40EVF_FLAG_AQ_ADD_CLOUD_FILTER) {
+		i40evf_add_cloud_filter(adapter);
+		goto watchdog_done;
+	}
+
+	if (adapter->aq_required & I40EVF_FLAG_AQ_DEL_CLOUD_FILTER) {
+		i40evf_del_cloud_filter(adapter);
+		goto watchdog_done;
+	}
+
 	schedule_delayed_work(&adapter->client_task, msecs_to_jiffies(5));
 
 	if (adapter->state == __I40EVF_RUNNING)
@@ -1761,6 +1780,7 @@ static void i40evf_disable_vf(struct i40evf_adapter *adapter)
 {
 	struct i40evf_mac_filter *f, *ftmp;
 	struct i40evf_vlan_filter *fv, *fvtmp;
+	struct i40evf_cloud_filter *cf, *cftmp;
 
 	adapter->flags |= I40EVF_FLAG_PF_COMMS_FAILED;
 
@@ -1782,7 +1802,7 @@ static void i40evf_disable_vf(struct i40evf_adapter *adapter)
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
-	/* Delete all of the filters, both MAC and VLAN. */
+	/* Delete all of the filters */
 	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
 		list_del(&f->list);
 		kfree(f);
@@ -1795,6 +1815,14 @@ static void i40evf_disable_vf(struct i40evf_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
+	spin_lock_bh(&adapter->cloud_filter_list_lock);
+	list_for_each_entry_safe(cf, cftmp, &adapter->cloud_filter_list, list) {
+		list_del(&cf->list);
+		kfree(cf);
+		adapter->num_cloud_filters--;
+	}
+	spin_unlock_bh(&adapter->cloud_filter_list_lock);
+
 	i40evf_free_misc_irq(adapter);
 	i40evf_reset_interrupt_capability(adapter);
 	i40evf_free_queues(adapter);
@@ -1824,9 +1852,11 @@ static void i40evf_reset_task(struct work_struct *work)
 	struct i40evf_adapter *adapter = container_of(work,
 						      struct i40evf_adapter,
 						      reset_task);
+	struct virtchnl_vf_resource *vfres = adapter->vf_res;
 	struct net_device *netdev = adapter->netdev;
 	struct i40e_hw *hw = &adapter->hw;
 	struct i40evf_vlan_filter *vlf;
+	struct i40evf_cloud_filter *cf;
 	struct i40evf_mac_filter *f;
 	u32 reg_val;
 	int i = 0, err;
@@ -1951,8 +1981,19 @@ static void i40evf_reset_task(struct work_struct *work)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
+	/* check if TCs are running and re-add all cloud filters */
+	spin_lock_bh(&adapter->cloud_filter_list_lock);
+	if ((vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
+	    adapter->num_tc) {
+		list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
+			cf->add = true;
+		}
+	}
+	spin_unlock_bh(&adapter->cloud_filter_list_lock);
+
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
+	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_CLOUD_FILTER;
 	i40evf_misc_irq_enable(adapter);
 
 	mod_timer(&adapter->watchdog_timer, jiffies + 2);
@@ -2303,6 +2344,24 @@ static int i40evf_validate_ch_config(struct i40evf_adapter *adapter,
 }
 
 /**
+ * i40evf_del_all_cloud_filters - delete all cloud filters
+ * on the traffic classes
+ **/
+static void i40evf_del_all_cloud_filters(struct i40evf_adapter *adapter)
+{
+	struct i40evf_cloud_filter *cf, *cftmp;
+
+	spin_lock_bh(&adapter->cloud_filter_list_lock);
+	list_for_each_entry_safe(cf, cftmp, &adapter->cloud_filter_list,
+				 list) {
+		list_del(&cf->list);
+		kfree(cf);
+		adapter->num_cloud_filters--;
+	}
+	spin_unlock_bh(&adapter->cloud_filter_list_lock);
+}
+
+/**
  * __i40evf_setup_tc - configure multiple traffic classes
  * @netdev: network interface device structure
  * @type_date: tc offload data
@@ -2335,6 +2394,7 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 			adapter->num_tc = 0;
 			netif_tx_stop_all_queues(netdev);
 			netif_tx_disable(netdev);
+			i40evf_del_all_cloud_filters(adapter);
 			adapter->aq_required = I40EVF_FLAG_AQ_DISABLE_CHANNELS;
 			goto exit;
 		} else {
@@ -2400,6 +2460,495 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 }
 
 /**
+ * i40evf_parse_cls_flower - Parse tc flower filters provided by kernel
+ * @adapter: board private structure
+ * @cls_flower: pointer to struct tc_cls_flower_offload
+ * @filter: pointer to cloud filter structure
+ */
+static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
+				   struct tc_cls_flower_offload *f,
+				   struct i40evf_cloud_filter *filter)
+{
+	u16 n_proto_mask = 0;
+	u16 n_proto_key = 0;
+	u8 field_flags = 0;
+	u16 addr_type = 0;
+	u16 n_proto = 0;
+	int i = 0;
+
+	if (f->dissector->used_keys &
+	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT(FLOW_DISSECTOR_KEY_ENC_KEYID))) {
+		dev_err(&adapter->pdev->dev, "Unsupported key used: 0x%x\n",
+			f->dissector->used_keys);
+		return -EOPNOTSUPP;
+	}
+
+	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ENC_KEYID)) {
+		struct flow_dissector_key_keyid *mask =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_ENC_KEYID,
+						  f->mask);
+
+		if (mask->keyid != 0)
+			field_flags |= I40EVF_CLOUD_FIELD_TEN_ID;
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
+		n_proto_key = ntohs(key->n_proto);
+		n_proto_mask = ntohs(mask->n_proto);
+
+		if (n_proto_key == ETH_P_ALL) {
+			n_proto_key = 0;
+			n_proto_mask = 0;
+		}
+		n_proto = n_proto_key & n_proto_mask;
+		if (n_proto != ETH_P_IP && n_proto != ETH_P_IPV6)
+			return -EINVAL;
+		if (n_proto == ETH_P_IPV6) {
+			/* specify flow type as TCP IPv6 */
+			filter->f.flow_type = VIRTCHNL_TCP_V6_FLOW;
+		}
+
+		if (key->ip_proto != IPPROTO_TCP) {
+			dev_info(&adapter->pdev->dev, "Only TCP transport is supported\n");
+			return -EINVAL;
+		}
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
+		/* use is_broadcast and is_zero to check for all 0xf or 0 */
+		if (!is_zero_ether_addr(mask->dst)) {
+			if (is_broadcast_ether_addr(mask->dst)) {
+				field_flags |= I40EVF_CLOUD_FIELD_OMAC;
+			} else {
+				dev_err(&adapter->pdev->dev, "Bad ether dest mask %pM\n",
+					mask->dst);
+				return I40E_ERR_CONFIG;
+			}
+		}
+
+		if (!is_zero_ether_addr(mask->src)) {
+			if (is_broadcast_ether_addr(mask->src)) {
+				field_flags |= I40EVF_CLOUD_FIELD_IMAC;
+			} else {
+				dev_err(&adapter->pdev->dev, "Bad ether src mask %pM\n",
+					mask->src);
+				return I40E_ERR_CONFIG;
+			}
+		}
+
+		if (!is_zero_ether_addr(key->dst))
+			if (is_valid_ether_addr(key->dst) ||
+			    is_multicast_ether_addr(key->dst)) {
+				/* set the mask if a valid dst_mac address */
+				for (i = 0; i < ETH_ALEN; i++)
+					filter->f.mask.tcp_spec.dst_mac[i] |=
+									0xff;
+				ether_addr_copy(filter->f.data.tcp_spec.dst_mac,
+						key->dst);
+			}
+
+		if (!is_zero_ether_addr(key->src))
+			if (is_valid_ether_addr(key->src) ||
+			    is_multicast_ether_addr(key->src)) {
+				/* set the mask if a valid dst_mac address */
+				for (i = 0; i < ETH_ALEN; i++)
+					filter->f.mask.tcp_spec.src_mac[i] |=
+									0xff;
+				ether_addr_copy(filter->f.data.tcp_spec.src_mac,
+						key->src);
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
+		if (mask->vlan_id) {
+			if (mask->vlan_id == VLAN_VID_MASK) {
+				field_flags |= I40EVF_CLOUD_FIELD_IVLAN;
+			} else {
+				dev_err(&adapter->pdev->dev, "Bad vlan mask %u\n",
+					mask->vlan_id);
+				return I40E_ERR_CONFIG;
+			}
+		}
+		filter->f.mask.tcp_spec.vlan_id |= 0xffff;
+		filter->f.data.tcp_spec.vlan_id = cpu_to_be16(key->vlan_id);
+	}
+
+	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_CONTROL)) {
+		struct flow_dissector_key_control *key =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_CONTROL,
+						  f->key);
+
+		addr_type = key->addr_type;
+	}
+
+	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
+		struct flow_dissector_key_ipv4_addrs *key =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_IPV4_ADDRS,
+						  f->key);
+		struct flow_dissector_key_ipv4_addrs *mask =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_IPV4_ADDRS,
+						  f->mask);
+
+		if (mask->dst) {
+			if (mask->dst == cpu_to_be32(0xffffffff)) {
+				field_flags |= I40EVF_CLOUD_FIELD_IIP;
+			} else {
+				dev_err(&adapter->pdev->dev, "Bad ip dst mask 0x%08x\n",
+					be32_to_cpu(mask->dst));
+				return I40E_ERR_CONFIG;
+			}
+		}
+
+		if (mask->src) {
+			if (mask->src == cpu_to_be32(0xffffffff)) {
+				field_flags |= I40EVF_CLOUD_FIELD_IIP;
+			} else {
+				dev_err(&adapter->pdev->dev, "Bad ip src mask 0x%08x\n",
+					be32_to_cpu(mask->dst));
+				return I40E_ERR_CONFIG;
+			}
+		}
+
+		if (field_flags & I40EVF_CLOUD_FIELD_TEN_ID) {
+			dev_info(&adapter->pdev->dev, "Tenant id not allowed for ip filter\n");
+			return I40E_ERR_CONFIG;
+		}
+		if (key->dst) {
+			filter->f.mask.tcp_spec.dst_ip[0] |= 0xffffffff;
+			filter->f.data.tcp_spec.dst_ip[0] = key->dst;
+		}
+		if (key->src) {
+			filter->f.mask.tcp_spec.src_ip[0] |= 0xffffffff;
+			filter->f.data.tcp_spec.src_ip[0] = key->src;
+		}
+	}
+
+	if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
+		struct flow_dissector_key_ipv6_addrs *key =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_IPV6_ADDRS,
+						  f->key);
+		struct flow_dissector_key_ipv6_addrs *mask =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_IPV6_ADDRS,
+						  f->mask);
+
+		/* validate mask, make sure it is not IPV6_ADDR_ANY */
+		if (ipv6_addr_any(&mask->dst)) {
+			dev_err(&adapter->pdev->dev, "Bad ipv6 dst mask 0x%02x\n",
+				IPV6_ADDR_ANY);
+			return I40E_ERR_CONFIG;
+		}
+
+		/* src and dest IPv6 address should not be LOOPBACK
+		 * (0:0:0:0:0:0:0:1) which can be represented as ::1
+		 */
+		if (ipv6_addr_loopback(&key->dst) ||
+		    ipv6_addr_loopback(&key->src)) {
+			dev_err(&adapter->pdev->dev,
+				"ipv6 addr should not be loopback\n");
+			return I40E_ERR_CONFIG;
+		}
+		if (!ipv6_addr_any(&mask->dst) || !ipv6_addr_any(&mask->src))
+			field_flags |= I40EVF_CLOUD_FIELD_IIP;
+
+		if (key->dst.s6_addr) {
+			for (i = 0; i < 4; i++)
+				filter->f.mask.tcp_spec.dst_ip[i] |= 0xffffffff;
+			memcpy(&filter->f.data.tcp_spec.dst_ip,
+			       &key->dst.s6_addr32,
+			       sizeof(filter->f.data.tcp_spec.dst_ip));
+		}
+		if (key->src.s6_addr) {
+			for (i = 0; i < 4; i++)
+				filter->f.mask.tcp_spec.src_ip[i] |= 0xffffffff;
+			memcpy(&filter->f.data.tcp_spec.src_ip,
+			       &key->src.s6_addr32,
+			       sizeof(filter->f.data.tcp_spec.src_ip));
+		}
+	}
+	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_dissector_key_ports *key =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_PORTS,
+						  f->key);
+		struct flow_dissector_key_ports *mask =
+			skb_flow_dissector_target(f->dissector,
+						  FLOW_DISSECTOR_KEY_PORTS,
+						  f->mask);
+
+		if (mask->src) {
+			if (mask->src == cpu_to_be16(0xffff)) {
+				field_flags |= I40EVF_CLOUD_FIELD_IIP;
+			} else {
+				dev_err(&adapter->pdev->dev, "Bad src port mask %u\n",
+					be16_to_cpu(mask->src));
+				return I40E_ERR_CONFIG;
+			}
+		}
+
+		if (mask->dst) {
+			if (mask->dst == cpu_to_be16(0xffff)) {
+				field_flags |= I40EVF_CLOUD_FIELD_IIP;
+			} else {
+				dev_err(&adapter->pdev->dev, "Bad dst port mask %u\n",
+					be16_to_cpu(mask->dst));
+				return I40E_ERR_CONFIG;
+			}
+		}
+		if (key->dst) {
+			filter->f.mask.tcp_spec.dst_port |= 0xffff;
+			filter->f.data.tcp_spec.dst_port = key->dst;
+		}
+
+		if (key->src) {
+			filter->f.mask.tcp_spec.src_port |= 0xffff;
+			filter->f.data.tcp_spec.src_port = key->dst;
+		}
+	}
+	filter->f.field_flags = field_flags;
+
+	return 0;
+}
+
+/**
+ * i40evf_handle_tclass - Forward to a traffic class on the device
+ * @adapter: board private structure
+ * @tc: traffic class index on the device
+ * @filter: pointer to cloud filter structure
+ */
+static int i40evf_handle_tclass(struct i40evf_adapter *adapter, u32 tc,
+				struct i40evf_cloud_filter *filter)
+{
+	if (tc == 0)
+		return 0;
+	if (tc < adapter->num_tc) {
+		if (!filter->f.data.tcp_spec.dst_port) {
+			dev_err(&adapter->pdev->dev,
+				"Specify destination port to redirect to traffic class other than TC0\n");
+			return -EINVAL;
+		}
+	}
+	/* redirect to a traffic class on the same device */
+	filter->f.action = VIRTCHNL_ACTION_TC_REDIRECT;
+	filter->f.action_meta = tc;
+	return 0;
+}
+
+/**
+ * i40evf_configure_clsflower - Add tc flower filters
+ * @adapter: board private structure
+ * @cls_flower: Pointer to struct tc_cls_flower_offload
+ */
+static int i40evf_configure_clsflower(struct i40evf_adapter *adapter,
+				      struct tc_cls_flower_offload *cls_flower)
+{
+	int tc = tc_classid_to_hwtc(adapter->netdev, cls_flower->classid);
+	struct i40evf_cloud_filter *filter = NULL;
+	int err = 0, count = 50;
+
+	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+				&adapter->crit_section)) {
+		udelay(1);
+		if (--count == 0)
+			return -EINVAL;
+	}
+
+	if (tc < 0) {
+		dev_err(&adapter->pdev->dev, "Invalid traffic class\n");
+		return -EINVAL;
+	}
+
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter) {
+		err = -ENOMEM;
+		goto clearout;
+	}
+	filter->cookie = cls_flower->cookie;
+
+	/* set the mask to all zeroes to begin with */
+	memset(&filter->f.mask.tcp_spec, 0, sizeof(struct virtchnl_l4_spec));
+	/* start out with flow type and eth type IPv4 to begin with */
+	filter->f.flow_type = VIRTCHNL_TCP_V4_FLOW;
+	err = i40evf_parse_cls_flower(adapter, cls_flower, filter);
+	if (err < 0)
+		goto err;
+
+	err = i40evf_handle_tclass(adapter, tc, filter);
+	if (err < 0)
+		goto err;
+
+	/* add filter to the list */
+	spin_lock_bh(&adapter->cloud_filter_list_lock);
+	list_add_tail(&filter->list, &adapter->cloud_filter_list);
+	adapter->num_cloud_filters++;
+	filter->add = true;
+	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_CLOUD_FILTER;
+	spin_unlock_bh(&adapter->cloud_filter_list_lock);
+err:
+	if (err)
+		kfree(filter);
+clearout:
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	return err;
+}
+
+/* i40evf_find_cf - Find the cloud filter in the list
+ * @adapter: Board private structure
+ * @cookie: filter specific cookie
+ *
+ * Returns ptr to the filter object or NULL. Must be called while holding the
+ * cloud_filter_list_lock.
+ */
+static struct i40evf_cloud_filter *i40evf_find_cf(struct i40evf_adapter *adapter,
+						  unsigned long *cookie)
+{
+	struct i40evf_cloud_filter *filter = NULL;
+
+	if (!cookie)
+		return NULL;
+
+	list_for_each_entry(filter, &adapter->cloud_filter_list, list) {
+		if (!memcmp(cookie, &filter->cookie, sizeof(filter->cookie)))
+			return filter;
+	}
+	return NULL;
+}
+
+/**
+ * i40evf_delete_clsflower - Remove tc flower filters
+ * @adapter: board private structure
+ * @cls_flower: Pointer to struct tc_cls_flower_offload
+ */
+static int i40evf_delete_clsflower(struct i40evf_adapter *adapter,
+				   struct tc_cls_flower_offload *cls_flower)
+{
+	struct i40evf_cloud_filter *filter = NULL;
+	int err = 0;
+
+	spin_lock_bh(&adapter->cloud_filter_list_lock);
+	filter = i40evf_find_cf(adapter, &cls_flower->cookie);
+	if (filter) {
+		filter->del = true;
+		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_CLOUD_FILTER;
+	} else {
+		err = -EINVAL;
+	}
+	spin_unlock_bh(&adapter->cloud_filter_list_lock);
+
+	return err;
+}
+
+/**
+ * i40evf_setup_tc_cls_flower - flower classifier offloads
+ * @netdev: net device to configure
+ * @type_data: offload data
+ */
+static int i40evf_setup_tc_cls_flower(struct i40evf_adapter *adapter,
+				      struct tc_cls_flower_offload *cls_flower)
+{
+	if (cls_flower->common.chain_index)
+		return -EOPNOTSUPP;
+
+	switch (cls_flower->command) {
+	case TC_CLSFLOWER_REPLACE:
+		return i40evf_configure_clsflower(adapter, cls_flower);
+	case TC_CLSFLOWER_DESTROY:
+		return i40evf_delete_clsflower(adapter, cls_flower);
+	case TC_CLSFLOWER_STATS:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * i40evf_setup_tc_block_cb - block callback for tc
+ * @type: type of offload
+ * @type_data: offload data
+ * @cb_priv:
+ *
+ * This function is the block callback for traffic classes
+ **/
+static int i40evf_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
+				    void *cb_priv)
+{
+	switch (type) {
+	case TC_SETUP_CLSFLOWER:
+		return i40evf_setup_tc_cls_flower(cb_priv, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
+ * i40evf_setup_tc_block - register callbacks for tc
+ * @netdev: network interface device structure
+ * @f: tc offload data
+ *
+ * This function registers block callbacks for tc
+ * offloads
+ **/
+static int i40evf_setup_tc_block(struct net_device *dev,
+				 struct tc_block_offload *f)
+{
+	struct i40evf_adapter *adapter = netdev_priv(dev);
+
+	if (f->binder_type != TCF_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
+		return -EOPNOTSUPP;
+
+	switch (f->command) {
+	case TC_BLOCK_BIND:
+		return tcf_block_cb_register(f->block, i40evf_setup_tc_block_cb,
+					     adapter, adapter);
+	case TC_BLOCK_UNBIND:
+		tcf_block_cb_unregister(f->block, i40evf_setup_tc_block_cb,
+					adapter);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
  * i40evf_setup_tc - configure multiple traffic classes
  * @netdev: network interface device structure
  * @type: type of offload
@@ -2413,10 +2962,14 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 static int i40evf_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			   void *type_data)
 {
-	if (type != TC_SETUP_QDISC_MQPRIO)
+	switch (type) {
+	case TC_SETUP_QDISC_MQPRIO:
+		return __i40evf_setup_tc(netdev, type_data);
+	case TC_SETUP_BLOCK:
+		return i40evf_setup_tc_block(netdev, type_data);
+	default:
 		return -EOPNOTSUPP;
-
-	return __i40evf_setup_tc(netdev, type_data);
+	}
 }
 
 /**
@@ -2801,6 +3354,9 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 	if (vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN)
 		hw_features |= (NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_CTAG_RX);
+	/* Enable cloud filter if ADQ is supported */
+	if (vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ)
+		hw_features |= NETIF_F_HW_TC;
 
 	netdev->hw_features |= hw_features;
 
@@ -3168,9 +3724,11 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mutex_init(&hw->aq.arq_mutex);
 
 	spin_lock_init(&adapter->mac_vlan_list_lock);
+	spin_lock_init(&adapter->cloud_filter_list_lock);
 
 	INIT_LIST_HEAD(&adapter->mac_filter_list);
 	INIT_LIST_HEAD(&adapter->vlan_filter_list);
+	INIT_LIST_HEAD(&adapter->cloud_filter_list);
 
 	INIT_WORK(&adapter->reset_task, i40evf_reset_task);
 	INIT_WORK(&adapter->adminq_task, i40evf_adminq_task);
@@ -3296,6 +3854,7 @@ static void i40evf_remove(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
 	struct i40evf_mac_filter *f, *ftmp;
+	struct i40evf_cloud_filter *cf, *cftmp;
 	struct i40e_hw *hw = &adapter->hw;
 	int err;
 	/* Indicate we are in remove and not to run reset_task */
@@ -3365,6 +3924,13 @@ static void i40evf_remove(struct pci_dev *pdev)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
+	spin_lock_bh(&adapter->cloud_filter_list_lock);
+	list_for_each_entry_safe(cf, cftmp, &adapter->cloud_filter_list, list) {
+		list_del(&cf->list);
+		kfree(cf);
+	}
+	spin_unlock_bh(&adapter->cloud_filter_list_lock);
+
 	free_netdev(netdev);
 
 	pci_disable_pcie_error_reporting(pdev);
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index b5a509f..61cae3b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1041,6 +1041,134 @@ void i40evf_disable_channels(struct i40evf_adapter *adapter)
 }
 
 /**
+ * i40evf_print_cloud_filter
+ * @adapter: adapter structure
+ * @f: cloud filter to print
+ *
+ * Print the cloud filter
+ **/
+static void i40evf_print_cloud_filter(struct i40evf_adapter *adapter,
+				      struct virtchnl_filter f)
+{
+	switch (f.flow_type) {
+	case VIRTCHNL_TCP_V4_FLOW:
+		dev_info(&adapter->pdev->dev, "dst_mac: %pM src_mac: %pM vlan_id: %hu dst_ip: %pI4 src_ip %pI4 dst_port %hu src_port %hu\n",
+			 &f.data.tcp_spec.dst_mac, &f.data.tcp_spec.src_mac,
+			 ntohs(f.data.tcp_spec.vlan_id),
+			 &f.data.tcp_spec.dst_ip[0], &f.data.tcp_spec.src_ip[0],
+			 ntohs(f.data.tcp_spec.dst_port),
+			 ntohs(f.data.tcp_spec.src_port));
+		break;
+	case VIRTCHNL_TCP_V6_FLOW:
+		dev_info(&adapter->pdev->dev, "dst_mac: %pM src_mac: %pM vlan_id: %hu dst_ip: %pI6 src_ip %pI6 dst_port %hu src_port %hu\n",
+			 &f.data.tcp_spec.dst_mac, &f.data.tcp_spec.src_mac,
+			 ntohs(f.data.tcp_spec.vlan_id),
+			 &f.data.tcp_spec.dst_ip, &f.data.tcp_spec.src_ip,
+			 ntohs(f.data.tcp_spec.dst_port),
+			 ntohs(f.data.tcp_spec.src_port));
+		break;
+	}
+}
+
+/**
+ * i40evf_add_cloud_filter
+ * @adapter: adapter structure
+ *
+ * Request that the PF add cloud filters as specified
+ * by the user via tc tool.
+ **/
+void i40evf_add_cloud_filter(struct i40evf_adapter *adapter)
+{
+	struct i40evf_cloud_filter *cf;
+	struct virtchnl_filter *f;
+	int len = 0, count = 0;
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev, "Cannot add cloud filter, command %d pending\n",
+			adapter->current_op);
+		return;
+	}
+	list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
+		if (cf->add) {
+			count++;
+			break;
+		}
+	}
+	if (!count) {
+		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_CLOUD_FILTER;
+		return;
+	}
+	adapter->current_op = VIRTCHNL_OP_ADD_CLOUD_FILTER;
+
+	len = sizeof(struct virtchnl_filter);
+	f = kzalloc(len, GFP_KERNEL);
+	if (!f)
+		return;
+
+	list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
+		if (cf->add) {
+			memcpy(f, &cf->f, sizeof(struct virtchnl_filter));
+			cf->add = false;
+			cf->state = __I40EVF_CF_ADD_PENDING;
+			i40evf_send_pf_msg(adapter,
+					   VIRTCHNL_OP_ADD_CLOUD_FILTER,
+					   (u8 *)f, len);
+		}
+	}
+	kfree(f);
+}
+
+/**
+ * i40evf_del_cloud_filter
+ * @adapter: adapter structure
+ *
+ * Request that the PF delete cloud filters as specified
+ * by the user via tc tool.
+ **/
+void i40evf_del_cloud_filter(struct i40evf_adapter *adapter)
+{
+	struct i40evf_cloud_filter *cf, *cftmp;
+	struct virtchnl_filter *f;
+	int len = 0, count = 0;
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev, "Cannot remove cloud filter, command %d pending\n",
+			adapter->current_op);
+		return;
+	}
+	list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
+		if (cf->del) {
+			count++;
+			break;
+		}
+	}
+	if (!count) {
+		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_CLOUD_FILTER;
+		return;
+	}
+	adapter->current_op = VIRTCHNL_OP_DEL_CLOUD_FILTER;
+
+	len = sizeof(struct virtchnl_filter);
+	f = kzalloc(len, GFP_KERNEL);
+	if (!f)
+		return;
+
+	list_for_each_entry_safe(cf, cftmp, &adapter->cloud_filter_list, list) {
+		if (cf->del) {
+			memcpy(f, &cf->f, sizeof(struct virtchnl_filter));
+			cf->del = false;
+			cf->state = __I40EVF_CF_DEL_PENDING;
+			i40evf_send_pf_msg(adapter,
+					   VIRTCHNL_OP_DEL_CLOUD_FILTER,
+					   (u8 *)f, len);
+		}
+	}
+	kfree(f);
+}
+
+/**
  * i40evf_request_reset
  * @adapter: adapter structure
  *
@@ -1163,6 +1291,42 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			adapter->ch_config.state = __I40EVF_TC_RUNNING;
 			netif_tx_start_all_queues(netdev);
 			break;
+		case VIRTCHNL_OP_ADD_CLOUD_FILTER: {
+			struct i40evf_cloud_filter *cf, *cftmp;
+
+			list_for_each_entry_safe(cf, cftmp,
+						 &adapter->cloud_filter_list,
+						 list) {
+				if (cf->state == __I40EVF_CF_ADD_PENDING) {
+					cf->state = __I40EVF_CF_INVALID;
+					dev_info(&adapter->pdev->dev, "Failed to add cloud filter, error %s\n",
+						 i40evf_stat_str(&adapter->hw,
+								 v_retval));
+					i40evf_print_cloud_filter(adapter,
+								  cf->f);
+					list_del(&cf->list);
+					kfree(cf);
+					adapter->num_cloud_filters--;
+				}
+			}
+			}
+			break;
+		case VIRTCHNL_OP_DEL_CLOUD_FILTER: {
+			struct i40evf_cloud_filter *cf;
+
+			list_for_each_entry(cf, &adapter->cloud_filter_list,
+					    list) {
+				if (cf->state == __I40EVF_CF_DEL_PENDING) {
+					cf->state = __I40EVF_CF_ACTIVE;
+					dev_info(&adapter->pdev->dev, "Failed to del cloud filter, error %s\n",
+						 i40evf_stat_str(&adapter->hw,
+								 v_retval));
+					i40evf_print_cloud_filter(adapter,
+								  cf->f);
+				}
+			}
+			}
+			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
 				v_retval,
@@ -1257,6 +1421,29 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 		}
 		}
 		break;
+	case VIRTCHNL_OP_ADD_CLOUD_FILTER: {
+		struct i40evf_cloud_filter *cf;
+
+		list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
+			if (cf->state == __I40EVF_CF_ADD_PENDING)
+				cf->state = __I40EVF_CF_ACTIVE;
+		}
+		}
+		break;
+	case VIRTCHNL_OP_DEL_CLOUD_FILTER: {
+		struct i40evf_cloud_filter *cf, *cftmp;
+
+		list_for_each_entry_safe(cf, cftmp, &adapter->cloud_filter_list,
+					 list) {
+			if (cf->state == __I40EVF_CF_DEL_PENDING) {
+				cf->state = __I40EVF_CF_INVALID;
+				list_del(&cf->list);
+				kfree(cf);
+				adapter->num_cloud_filters--;
+			}
+		}
+		}
+		break;
 	default:
 		if (adapter->current_op && (v_opcode != adapter->current_op))
 			dev_warn(&adapter->pdev->dev, "Expected response %d from PF, received %d\n",
-- 
2.9.4

