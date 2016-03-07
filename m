From: Gangfeng <gangfeng.huang@ni.com>
Date: Mon, 7 Mar 2016 17:38:25 +0800
Subject: [Intel-wired-lan] [PATCH v4 1/4] igb: add support of RX network
	flow classification
In-Reply-To: <1457343508-7119-1-git-send-email-gangfeng.huang@ni.com>
References: <1457343508-7119-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1457343508-7119-2-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Gangfeng Huang <gangfeng.huang@ni.com>

This patch is meant to allow for RX network flow classification to insert
and remove Rx filter by ethtool. Ethtool interface has it's own rules
manager

Show all filters:
$ ethtool -n eth0
4 RX rings available
Total 2 rules

Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |  32 +++++
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 193 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c    |  44 ++++++
 3 files changed, 269 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 9413fa6..92867e5 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -347,6 +347,27 @@ struct hwmon_buff {
 #define IGB_N_SDP	4
 #define IGB_RETA_SIZE	128
 
+enum igb_filter_match_flags {
+	IGB_FILTER_FLAG_NONE        = 0x0,
+};
+
+#define IGB_MAX_RXNFC_FILTERS 16
+
+/* RX network flow classification data structure */
+struct igb_nfc_input {
+	/* Byte layout in order, all values with MSB first:
+	* match_flags - 1 byte
+	*/
+	u8     match_flags;
+};
+
+struct igb_nfc_filter {
+	struct hlist_node nfc_node;
+	struct igb_nfc_input filter;
+	u16 sw_idx;
+	u16 action;
+};
+
 /* board specific private data structure */
 struct igb_adapter {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
@@ -464,6 +485,12 @@ struct igb_adapter {
 	int copper_tries;
 	struct e1000_info ei;
 	u16 eee_advert;
+
+	/* RX network flow classification support */
+	struct hlist_head nfc_filter_list;
+	unsigned int nfc_filter_count;
+	/* lock for RX network flow classification filter */
+	spinlock_t nfc_lock;
 };
 
 #define IGB_FLAG_HAS_MSI		(1 << 0)
@@ -586,4 +613,9 @@ static inline struct netdev_queue *txring_txq(const struct igb_ring *tx_ring)
 	return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
 }
 
+int igb_add_filter(struct igb_adapter *adapter,
+		   struct igb_nfc_filter *input);
+int igb_erase_filter(struct igb_adapter *adapter,
+		     struct igb_nfc_filter *input);
+
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index c75e9db..9ce867c 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2607,6 +2607,48 @@ static int igb_get_ts_info(struct net_device *dev,
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
+	return -EINVAL;
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
@@ -2660,6 +2702,16 @@ static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
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
@@ -2774,6 +2826,142 @@ static int igb_set_rss_hash_opt(struct igb_adapter *adapter,
 	return 0;
 }
 
+int igb_add_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
+{
+	return -EINVAL;
+}
+
+int igb_erase_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
+{
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
+static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
+				     struct ethtool_rxnfc *cmd)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct ethtool_rx_flow_spec *fsp =
+		(struct ethtool_rx_flow_spec *)&cmd->fs;
+	struct igb_nfc_filter *input, *rule;
+	int err = 0;
+
+	if (!(netdev->hw_features & NETIF_F_NTUPLE))
+		return -ENOTSUPP;
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
+	if ((fsp->flow_type & ~FLOW_EXT) != ETHER_FLOW)
+		return -EINVAL;
+
+	input = kzalloc(sizeof(*input), GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	input->action = fsp->ring_cookie;
+	input->sw_idx = fsp->location;
+
+	spin_lock(&adapter->nfc_lock);
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
+	err = igb_add_filter(adapter, input);
+	if (err)
+		goto err_out_w_lock;
+
+	igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+
+	spin_unlock(&adapter->nfc_lock);
+	return 0;
+
+err_out_w_lock:
+	spin_unlock(&adapter->nfc_lock);
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
+	spin_lock(&adapter->nfc_lock);
+	err = igb_update_ethtool_nfc_entry(adapter, NULL, fsp->location);
+	spin_unlock(&adapter->nfc_lock);
+
+	return err;
+}
+
 static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
@@ -2783,6 +2971,11 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
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
index 1846b85..4899204 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -176,6 +176,8 @@ static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
 static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
 				 struct ifla_vf_info *ivi);
 static void igb_check_vf_rate_limit(struct igb_adapter *);
+static void igb_nfc_filter_exit(struct igb_adapter *adapter);
+static void igb_nfc_filter_restore(struct igb_adapter *adapter);
 
 #ifdef CONFIG_PCI_IOV
 static int igb_vf_configure(struct igb_adapter *adapter, int vf);
@@ -1620,6 +1622,7 @@ static void igb_configure(struct igb_adapter *adapter)
 	igb_setup_mrqc(adapter);
 	igb_setup_rctl(adapter);
 
+	igb_nfc_filter_restore(adapter);
 	igb_configure_tx(adapter);
 	igb_configure_rx(adapter);
 
@@ -2067,6 +2070,21 @@ static int igb_set_features(struct net_device *netdev,
 	if (!(changed & (NETIF_F_RXALL | NETIF_F_NTUPLE)))
 		return 0;
 
+	if (!(features & NETIF_F_NTUPLE)) {
+		struct hlist_node *node2;
+		struct igb_nfc_filter *rule;
+
+		spin_lock(&adapter->nfc_lock);
+		hlist_for_each_entry_safe(rule, node2,
+					  &adapter->nfc_filter_list, nfc_node) {
+			igb_erase_filter(adapter, rule);
+			hlist_del(&rule->nfc_node);
+			kfree(rule);
+		}
+		spin_unlock(&adapter->nfc_lock);
+		adapter->nfc_filter_count = 0;
+	}
+
 	netdev->features = features;
 
 	if (netif_running(netdev))
@@ -3213,6 +3231,8 @@ static int __igb_close(struct net_device *netdev, bool suspending)
 	igb_down(adapter);
 	igb_free_irq(adapter);
 
+	igb_nfc_filter_exit(adapter);
+
 	igb_free_all_tx_resources(adapter);
 	igb_free_all_rx_resources(adapter);
 
@@ -8257,4 +8277,28 @@ int igb_reinit_queues(struct igb_adapter *adapter)
 
 	return err;
 }
+
+static void igb_nfc_filter_exit(struct igb_adapter *adapter)
+{
+	struct igb_nfc_filter *rule;
+
+	spin_lock(&adapter->nfc_lock);
+
+	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node)
+		igb_erase_filter(adapter, rule);
+
+	spin_unlock(&adapter->nfc_lock);
+}
+
+static void igb_nfc_filter_restore(struct igb_adapter *adapter)
+{
+	struct igb_nfc_filter *rule;
+
+	spin_lock(&adapter->nfc_lock);
+
+	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node)
+		igb_add_filter(adapter, rule);
+
+	spin_unlock(&adapter->nfc_lock);
+}
 /* igb_main.c */
-- 
2.7.2

