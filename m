From: Gangfeng Huang <gangfeng.huang@ni.com>
Date: Wed, 28 Oct 2015 09:56:59 +0800
Subject: [Intel-wired-lan] [PATCH net-next] igb: add support for nfc
	addition and removal of filters
In-Reply-To: <dennis.ying@ni.com>
References: <dennis.ying@ni.com>
Message-ID: <1445997419-11781-1-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Ruhao Gao" <ruhao.gao@ni.com>

This patch is meant to allow for nfc to insert and remove ethertype filter
and VLAN priority filter by ethtool. Ethtool interface has it's own rules
manager

Example:
Add an ethertype filter:
$ ethtool -N eth0 flow-type ether vlan-etype 0x88F7 action 2
Add an VLAN priority filter:
$ ethtool -N eth0 flow-type ether vlan 0x6002 vlan-mask 0xE000 action 2 loc 1
Show all filters:
$ ethtool -n eth0
4 RX rings available
Total 2 rules

Filter: 1
	Flow Type: Raw Ethernet
	Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
	Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
	Ethertype: 0x0 mask: 0xFFFF
	VLAN EtherType: 0x0 mask: 0xffff
	VLAN: 0x6002 mask: 0xe000
	User-defined: 0x0 mask: 0xffffffffffffffff
	Action: Direct to queue 2

Filter: 15
	Flow Type: Raw Ethernet
	Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
	Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
	Ethertype: 0x0 mask: 0xFFFF
	VLAN EtherType: 0x88f7 mask: 0x0
	VLAN: 0x0 mask: 0xe000
	User-defined: 0x0 mask: 0xffffffffffffffff
	Action: Direct to queue 2

Delete the filter by location:
$ ethtool -N delete 15

Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.h   |    5 +
 drivers/net/ethernet/intel/igb/e1000_defines.h |    6 +
 drivers/net/ethernet/intel/igb/e1000_regs.h    |    1 +
 drivers/net/ethernet/intel/igb/igb.h           |   66 +++++
 drivers/net/ethernet/intel/igb/igb_ethtool.c   |  356 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c      |   33 +++
 drivers/net/ethernet/intel/igb/igb_ptp.c       |    4 +-
 7 files changed, 469 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
index 2154aea..c4a34e1 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.h
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
@@ -187,7 +187,12 @@ struct e1000_adv_tx_context_desc {
 
 /* ETQF register bit definitions */
 #define E1000_ETQF_FILTER_ENABLE   (1 << 26)
+#define E1000_ETQF_IMM_INT         (1 << 29)
 #define E1000_ETQF_1588            (1 << 30)
+#define E1000_ETQF_QUEUE_ENABLE    (1 << 31)
+#define E1000_ETQF_QUEUE_SHIFT     16
+#define E1000_ETQF_QUEUE_MASK      0x00070000
+#define E1000_ETQF_ETYPE_MASK      0x0000FFFF
 
 /* FTQF register bit definitions */
 #define E1000_FTQF_VF_BP               0x00008000
diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index f8684aa..41f6d74 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -1014,4 +1014,10 @@
 #define E1000_RTTBCNRC_RF_INT_MASK	\
 	(E1000_RTTBCNRC_RF_DEC_MASK << E1000_RTTBCNRC_RF_INT_SHIFT)
 
+/* VLAN Priority Filter */
+#define E1000_RCTL_VLAN_FILTER_ENABLE     (0x1 << 18)
+#define E1000_VLAPQF_QUEUE_SEL(_n, q_idx) (q_idx << ((_n) * 4))
+#define E1000_VLAPQF_P_VALID(_n)          (0x1 << (3 + (_n) * 4))
+#define E1000_VLAPQF_QUEUE_MASK            0x03
+
 #endif
diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
index 6f0490d..1e2edd2 100644
--- a/drivers/net/ethernet/intel/igb/e1000_regs.h
+++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
@@ -123,6 +123,7 @@
 #define E1000_FTQF0 E1000_FTQF(0)
 #define E1000_SYNQF(_n) (0x055FC + (4 * (_n))) /* SYN Packet Queue Fltr */
 #define E1000_ETQF(_n)  (0x05CB0 + (4 * (_n))) /* EType Queue Fltr */
+#define E1000_VLAPQF    0x055B0 /* VLAN Priority Queue Fltr*/
 
 #define E1000_RQDPC(_n) (0x0C030 + ((_n) * 0x40))
 
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index c2bd4f9..7a320b3 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -343,11 +343,62 @@ struct hwmon_buff {
 	};
 #endif
 
+/* The number of L2 ether-type filter registers, Index 3 is reserved
+ * for PTP 1588 timestamp
+ */
+#define MAX_ETYPE_FILTER  (4 - 1)
+
+/* ETQF filter list: one static filter per filter consumer. This is
+ *                   to avoid filter collisions later. Add new filters
+ *                   here!!
+ *
+ * Current filters:
+ *    1588 (0x88f7):         Filter 3
+ */
+#define IGB_ETQF_FILTER_1588   3
+
 #define IGB_N_EXTTS	2
 #define IGB_N_PEROUT	2
 #define IGB_N_SDP	4
 #define IGB_RETA_SIZE	128
 
+/* Software ATR input stream values and masks */
+#define IGB_ATR_HASH_MASK     0x7fff
+#define IGB_ATR_L4TYPE_MASK      0x3
+#define IGB_ATR_L4TYPE_UDP       0x1
+#define IGB_ATR_L4TYPE_TCP       0x2
+#define IGB_ATR_L4TYPE_SCTP      0x3
+#define IGB_ATR_L4TYPE_IPV6_MASK 0x4
+enum igb_atr_flow_type {
+	IGB_ATR_FLOW_TYPE_IPV4   = 0x0,
+	IGB_ATR_FLOW_TYPE_UDPV4  = 0x1,
+	IGB_ATR_FLOW_TYPE_TCPV4  = 0x2,
+	IGB_ATR_FLOW_TYPE_SCTPV4 = 0x3,
+	IGB_ATR_FLOW_TYPE_IPV6   = 0x4,
+	IGB_ATR_FLOW_TYPE_UDPV6  = 0x5,
+	IGB_ATR_FLOW_TYPE_TCPV6  = 0x6,
+	IGB_ATR_FLOW_TYPE_SCTPV6 = 0x7,
+	IGB_ATR_FLOW_TYPE_ETHER  = 0x8,
+};
+
+#define IGB_MAX_RXNFC_FILTERS 16
+
+/* Flow Director ATR input struct. */
+struct igb_atr_input {
+	/* Byte layout in order, all values with MSB first:
+	* flow_type  - 1 byte
+	* vlan_id    - 2 bytes
+	* dst_port   - 2 bytes
+	* etype      - 2 bytes
+	* etype_mask - 2 bytes
+	*/
+	u8     flow_type;
+	__be16 vlan_id;
+	__be16 dst_port; /* reserved for 2-tuple filter */
+	__be16 etype;
+	__be16 etype_mask;
+};
+
 /* board specific private data structure */
 struct igb_adapter {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
@@ -463,6 +514,20 @@ struct igb_adapter {
 	int copper_tries;
 	struct e1000_info ei;
 	u16 eee_advert;
+
+	/* rxnfc support */
+	struct hlist_head nfc_filter_list;
+	unsigned int nfc_filter_count;
+	spinlock_t nfc_perfect_lock;
+	bool etype_bitmap[MAX_ETYPE_FILTER];
+};
+
+struct igb_nfc_filter {
+	struct hlist_node nfc_node;
+	struct igb_atr_input filter;
+	u16 etype_reg_index;
+	u16 sw_idx;
+	u16 action;
 };
 
 #define IGB_FLAG_HAS_MSI		(1 << 0)
@@ -480,6 +545,7 @@ struct igb_adapter {
 #define IGB_FLAG_MAS_ENABLE		(1 << 12)
 #define IGB_FLAG_HAS_MSIX		(1 << 13)
 #define IGB_FLAG_EEE			(1 << 14)
+#define IGB_FLAG_RX_FILTER		(1 << 15)
 
 /* Media Auto Sense */
 #define IGB_MAS_ENABLE_0		0X0001
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index b7b9c67..52c735f 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2425,6 +2425,66 @@ static int igb_get_ts_info(struct net_device *dev,
 	}
 }
 
+static int igb_get_ethtool_nfc_entry(struct igb_adapter *adapter,
+				     struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp = &cmd->fs;
+	struct igb_nfc_filter *rule = NULL;
+
+	/* report total rule count */
+	cmd->data = IGB_MAX_RXNFC_FILTERS;
+
+	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
+		if (fsp->location <= rule->sw_idx)
+			break;
+	}
+
+	if (!rule || fsp->location != rule->sw_idx)
+		return -EINVAL;
+
+	/* fill out the flow spec entry */
+
+	/* set flow type field */
+	switch (rule->filter.flow_type) {
+	case IGB_ATR_FLOW_TYPE_ETHER:
+		fsp->flow_type = ETHER_FLOW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fsp->h_ext.vlan_tci = rule->filter.vlan_id;
+	fsp->m_ext.vlan_tci = ~htons(VLAN_PRIO_MASK);
+	fsp->h_ext.vlan_etype = rule->filter.etype;
+	fsp->m_ext.vlan_etype = rule->filter.etype_mask;
+	fsp->flow_type |= FLOW_EXT;
+	fsp->ring_cookie = rule->action;
+
+	return 0;
+}
+
+static int igb_get_ethtool_nfc_all(struct igb_adapter *adapter,
+				   struct ethtool_rxnfc *cmd,
+				   u32 *rule_locs)
+{
+	struct igb_nfc_filter *rule;
+	int cnt = 0;
+
+	/* report total rule count */
+	cmd->data = IGB_MAX_RXNFC_FILTERS;
+
+	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
+		if (cnt == cmd->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[cnt] = rule->sw_idx;
+		cnt++;
+	}
+
+	cmd->rule_cnt = cnt;
+
+	return 0;
+}
+
 static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
 				 struct ethtool_rxnfc *cmd)
 {
@@ -2478,6 +2538,16 @@ static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		cmd->data = adapter->num_rx_queues;
 		ret = 0;
 		break;
+	case ETHTOOL_GRXCLSRLCNT:
+		cmd->rule_cnt = adapter->nfc_filter_count;
+		ret = 0;
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		ret = igb_get_ethtool_nfc_entry(adapter, cmd);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		ret = igb_get_ethtool_nfc_all(adapter, cmd, rule_locs);
+		break;
 	case ETHTOOL_GRXFH:
 		ret = igb_get_rss_hash_opts(adapter, cmd);
 		break;
@@ -2592,6 +2662,287 @@ static int igb_set_rss_hash_opt(struct igb_adapter *adapter,
 	return 0;
 }
 
+static void igb_clear_etype_filter_regs(struct igb_adapter *adapter,
+					u16 reg_index)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 etqf = rd32(E1000_ETQF(reg_index));
+
+	etqf &= ~E1000_ETQF_QUEUE_ENABLE;
+	etqf &= ~E1000_ETQF_QUEUE_MASK;
+	etqf &= ~E1000_ETQF_FILTER_ENABLE;
+
+	wr32(E1000_ETQF(reg_index), etqf);
+
+	adapter->etype_bitmap[reg_index] = false;
+}
+
+static void igb_clear_vlan_prio_filter(struct igb_adapter *adapter,
+				       u16 vlan_id)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 vlapqf;
+	u8 vlan_priority;
+
+	vlan_priority = (vlan_id & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+
+	vlapqf = rd32(E1000_VLAPQF);
+	vlapqf &= ~E1000_VLAPQF_P_VALID(vlan_priority);
+	vlapqf &= ~E1000_VLAPQF_QUEUE_SEL(vlan_priority,
+						E1000_VLAPQF_QUEUE_MASK);
+
+	wr32(E1000_VLAPQF, vlapqf);
+}
+
+static int igb_erase_filter(struct igb_adapter *adapter,
+			    struct igb_nfc_filter *input)
+{
+	if (input->filter.etype != 0)
+		igb_clear_etype_filter_regs(adapter,
+					    input->etype_reg_index);
+
+	if (input->filter.vlan_id != 0)
+		igb_clear_vlan_prio_filter(adapter,
+					   ntohs(input->filter.vlan_id));
+
+	return 0;
+}
+
+static int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
+					struct igb_nfc_filter *input,
+					u16 sw_idx)
+{
+	struct igb_nfc_filter *rule, *parent;
+	int err = -EINVAL;
+
+	parent = NULL;
+	rule = NULL;
+
+	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
+		/* hash found, or no matching entry */
+		if (rule->sw_idx >= sw_idx)
+			break;
+		parent = rule;
+	}
+
+	/* if there is an old rule occupying our place remove it */
+	if (rule && (rule->sw_idx == sw_idx)) {
+		if (!input)
+			err = igb_erase_filter(adapter, rule);
+
+		hlist_del(&rule->nfc_node);
+		kfree(rule);
+		adapter->nfc_filter_count--;
+	}
+
+	/* If no input this was a delete, err should be 0 if a rule was
+	 * successfully found and removed from the list else -EINVAL
+	 */
+	if (!input)
+		return err;
+
+	/* initialize node */
+	INIT_HLIST_NODE(&input->nfc_node);
+
+	/* add filter to the list */
+	if (parent)
+		hlist_add_behind(&parent->nfc_node, &input->nfc_node);
+	else
+		hlist_add_head(&input->nfc_node, &adapter->nfc_filter_list);
+
+	/* update counts */
+	adapter->nfc_filter_count++;
+
+	return 0;
+}
+
+static int igb_flowspec_to_flow_type(struct ethtool_rx_flow_spec *fsp,
+				     u8 *flow_type)
+{
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case ETHER_FLOW:
+		*flow_type = IGB_ATR_FLOW_TYPE_ETHER;
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
+static int igb_rxnfc_write_etype_filter(struct igb_adapter *adapter,
+					struct igb_nfc_filter *input)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u8 i;
+	u32 etqf;
+	u16 etype;
+
+	/* find an empty etype filter register */
+	for (i = 0; i < MAX_ETYPE_FILTER; ++i) {
+		if (!adapter->etype_bitmap[i])
+			break;
+	}
+	if (i == MAX_ETYPE_FILTER) {
+		dev_err(&adapter->pdev->dev, "ethtool -N: etype filters are all used.\n");
+		return -EINVAL;
+	}
+
+	adapter->etype_bitmap[i] = true;
+
+	etqf = rd32(E1000_ETQF(i));
+	etype = ntohs(input->filter.etype & input->filter.etype_mask);
+
+	etqf |= E1000_ETQF_FILTER_ENABLE;
+	etqf &= ~E1000_ETQF_ETYPE_MASK;
+	etqf |= (etype & E1000_ETQF_ETYPE_MASK);
+
+	etqf &= ~E1000_ETQF_QUEUE_MASK;
+	etqf |= ((input->action << E1000_ETQF_QUEUE_SHIFT)
+		& E1000_ETQF_QUEUE_MASK);
+	etqf |= E1000_ETQF_QUEUE_ENABLE;
+
+	wr32(E1000_ETQF(i), etqf);
+
+	input->etype_reg_index = i;
+
+	return 0;
+}
+
+static int igb_rxnfc_write_vlan_prio_filter(struct igb_adapter *adapter,
+					    struct igb_nfc_filter *input)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 vlapqf;
+	u8 vlan_priority;
+	u16 queue_index;
+
+	vlapqf = rd32(E1000_VLAPQF);
+	vlan_priority = (ntohs(input->filter.vlan_id) & VLAN_PRIO_MASK)
+				>> VLAN_PRIO_SHIFT;
+	queue_index = (vlapqf >> (vlan_priority * 4)) & E1000_VLAPQF_QUEUE_MASK;
+
+	/* check whether this vlan prio is already set */
+	if ((vlapqf & E1000_VLAPQF_P_VALID(vlan_priority)) &&
+	    (queue_index != input->action)) {
+		dev_err(&adapter->pdev->dev, "ethtool rxnfc set vlan prio filter failed.\n");
+		return -EEXIST;
+	}
+
+	vlapqf |= E1000_VLAPQF_P_VALID(vlan_priority);
+	vlapqf |= E1000_VLAPQF_QUEUE_SEL(vlan_priority, input->action);
+
+	wr32(E1000_VLAPQF, vlapqf);
+
+	return 0;
+}
+
+static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
+				     struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp =
+		(struct ethtool_rx_flow_spec *)&cmd->fs;
+	struct igb_nfc_filter *input, *rule;
+	int err = 0;
+
+	if (!(adapter->flags & IGB_FLAG_RX_FILTER))
+		return -EOPNOTSUPP;
+
+	/* Don't allow programming if the action is a queue greater than
+	 * the number of online Rx queues.
+	 */
+	if ((fsp->ring_cookie == RX_CLS_FLOW_DISC) ||
+	    (fsp->ring_cookie >= adapter->num_rx_queues)) {
+		dev_err(&adapter->pdev->dev, "ethtool -N: The specified action is invalid\n");
+		return -EINVAL;
+	}
+
+	/* Don't allow indexes to exist outside of available space */
+	if (fsp->location >= IGB_MAX_RXNFC_FILTERS) {
+		dev_err(&adapter->pdev->dev, "Location out of range\n");
+		return -EINVAL;
+	}
+
+	if (fsp->h_ext.vlan_tci != 0 &&
+	    ((u16)~ntohs(fsp->m_ext.vlan_tci) != VLAN_PRIO_MASK)) {
+		dev_err(&adapter->pdev->dev,
+			"ethtool: only support vlan prio filter. Set the vlan mask to 0xe000\n");
+		return -EINVAL;
+	}
+
+	input = kzalloc(sizeof(*input), GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	/* set SW index */
+	input->sw_idx = fsp->location;
+
+	/* record flow type */
+	if (!igb_flowspec_to_flow_type(fsp, &input->filter.flow_type)) {
+		dev_err(&adapter->pdev->dev, "Unrecognized flow type\n");
+		goto err_out;
+	}
+
+	if (fsp->flow_type & FLOW_EXT) {
+		input->filter.vlan_id = fsp->h_ext.vlan_tci;
+		input->filter.etype = fsp->h_ext.vlan_etype;
+		input->filter.etype_mask = fsp->m_ext.vlan_etype;
+	}
+
+	input->action = fsp->ring_cookie;
+
+	spin_lock(&adapter->nfc_perfect_lock);
+
+	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
+		if (!memcmp(&input->filter, &rule->filter,
+			    sizeof(input->filter))) {
+			err = -EEXIST;
+			dev_err(&adapter->pdev->dev,
+				"ethtool: this filter is already set\n");
+			goto err_out_w_lock;
+		}
+	}
+
+	/* set etype filter register */
+	if (input->filter.etype != 0) {
+		err = igb_rxnfc_write_etype_filter(adapter, input);
+		if (err)
+			goto err_out_w_lock;
+	}
+
+	/* set vlan prio filter register */
+	if (input->filter.vlan_id != 0) {
+		err = igb_rxnfc_write_vlan_prio_filter(adapter, input);
+		if (err)
+			goto err_out_w_lock;
+	}
+
+	igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+
+	spin_unlock(&adapter->nfc_perfect_lock);
+	return 0;
+
+err_out_w_lock:
+	spin_unlock(&adapter->nfc_perfect_lock);
+err_out:
+	kfree(input);
+	return err;
+}
+
+static int igb_del_ethtool_nfc_entry(struct igb_adapter *adapter,
+				     struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp =
+		(struct ethtool_rx_flow_spec *)&cmd->fs;
+	int err;
+
+	spin_lock(&adapter->nfc_perfect_lock);
+	err = igb_update_ethtool_nfc_entry(adapter, NULL, fsp->location);
+	spin_unlock(&adapter->nfc_perfect_lock);
+
+	return err;
+}
+
 static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
@@ -2601,6 +2952,11 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	case ETHTOOL_SRXFH:
 		ret = igb_set_rss_hash_opt(adapter, cmd);
 		break;
+	case ETHTOOL_SRXCLSRLINS:
+		ret = igb_add_ethtool_nfc_entry(adapter, cmd);
+		break;
+	case ETHTOOL_SRXCLSRLDEL:
+		ret = igb_del_ethtool_nfc_entry(adapter, cmd);
 	default:
 		break;
 	}
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 41e2740..092fc25 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -176,6 +176,8 @@ static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
 				 struct ifla_vf_info *ivi);
 static void igb_check_vf_rate_limit(struct igb_adapter *);
 
+static void igb_nfc_filter_exit(struct igb_adapter *adapter);
+
 #ifdef CONFIG_PCI_IOV
 static int igb_vf_configure(struct igb_adapter *adapter, int vf);
 static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs);
@@ -2049,6 +2051,11 @@ static int igb_set_features(struct net_device *netdev,
 	if (!(changed & NETIF_F_RXALL))
 		return 0;
 
+	if (features & NETIF_F_NTUPLE)
+		adapter->flags |= IGB_FLAG_RX_FILTER;
+	else
+		adapter->flags &= ~IGB_FLAG_RX_FILTER;
+
 	netdev->features = features;
 
 	if (netif_running(netdev))
@@ -2390,6 +2397,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	switch (hw->mac.type) {
 	case e1000_i210:
+		netdev->hw_features |= NETIF_F_NTUPLE;
+		adapter->flags |= IGB_FLAG_RX_FILTER;
 	case e1000_i211:
 		if (igb_get_flash_presence_i210(hw)) {
 			if (hw->nvm.ops.validate(hw) < 0) {
@@ -2949,6 +2958,10 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 
 	spin_lock_init(&adapter->stats64_lock);
+
+	/* n-tuple support exists, always init our spinlock */
+	spin_lock_init(&adapter->nfc_perfect_lock);
+
 #ifdef CONFIG_PCI_IOV
 	switch (hw->mac.type) {
 	case e1000_82576:
@@ -3132,6 +3145,8 @@ static int __igb_close(struct net_device *netdev, bool suspending)
 	igb_down(adapter);
 	igb_free_irq(adapter);
 
+	igb_nfc_filter_exit(adapter);
+
 	igb_free_all_tx_resources(adapter);
 	igb_free_all_rx_resources(adapter);
 
@@ -8075,4 +8090,22 @@ int igb_reinit_queues(struct igb_adapter *adapter)
 
 	return err;
 }
+
+static void igb_nfc_filter_exit(struct igb_adapter *adapter)
+{
+	struct hlist_node *node2;
+	struct igb_nfc_filter *filter;
+
+	spin_lock(&adapter->nfc_perfect_lock);
+
+	hlist_for_each_entry_safe(filter, node2,
+				  &adapter->nfc_filter_list, nfc_node) {
+		hlist_del(&filter->nfc_node);
+		kfree(filter);
+	}
+	adapter->nfc_filter_count = 0;
+
+	spin_unlock(&adapter->nfc_perfect_lock);
+}
+
 /* igb_main.c */
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index c3a9392c..bba6ed3 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -908,12 +908,12 @@ static int igb_ptp_set_timestamp_mode(struct igb_adapter *adapter,
 
 	/* define ethertype filter for timestamped packets */
 	if (is_l2)
-		wr32(E1000_ETQF(3),
+		wr32(E1000_ETQF(IGB_ETQF_FILTER_1588),
 		     (E1000_ETQF_FILTER_ENABLE | /* enable filter */
 		      E1000_ETQF_1588 | /* enable timestamping */
 		      ETH_P_1588));     /* 1588 eth protocol type */
 	else
-		wr32(E1000_ETQF(3), 0);
+		wr32(E1000_ETQF(IGB_ETQF_FILTER_1588), 0);
 
 	/* L4 Queue Filter[3]: filter by destination port and protocol */
 	if (is_l4) {
-- 
1.7.9.5

