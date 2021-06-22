From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Tue, 22 Jun 2021 23:21:35 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2 12/12] ice: add port
 representor ethtool ops and stats
In-Reply-To: <20210622212134.341728-1-michal.swiatkowski@linux.intel.com>
References: <20210622212134.341728-1-michal.swiatkowski@linux.intel.com>
Message-ID: <20210622212134.341728-13-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wojciech Drewek <wojciech.drewek@intel.com>

Introduce the following ethtool operations for VF's representor:
	-get_drvinfo
	-get_strings
	-get_ethtool_stats
	-get_sset_count
	-get_link

In all cases, exsisting operations were used with minor
changes which allow us to detect if ethtool op was called for
representor. Only VF VSI stats will be available for representor.

Implement ndo_get_stats64 for port representor. This will update
VF VSI stats and read them.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 14 +++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 32 ++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_repr.c    | 29 ++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fcddec1c1849..7ea539d47ae3 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -605,6 +605,19 @@ static inline struct ice_vsi *ice_get_main_vsi(struct ice_pf *pf)
 	return NULL;
 }
 
+/**
+ * ice_get_netdev_priv_vsi - return VSI associated with netdev priv.
+ * @np: private netdev structure
+ */
+static inline struct ice_vsi *ice_get_netdev_priv_vsi(struct ice_netdev_priv *np)
+{
+	/* In case of port representor return source port VSI. */
+	if (np->repr)
+		return np->repr->src_vsi;
+	else
+		return np->vsi;
+}
+
 /**
  * ice_get_ctrl_vsi - Get the control VSI
  * @pf: PF instance
@@ -660,6 +673,7 @@ int ice_vsi_setup_rx_rings(struct ice_vsi *vsi);
 int ice_vsi_open_ctrl(struct ice_vsi *vsi);
 int ice_vsi_open(struct ice_vsi *vsi);
 void ice_set_ethtool_ops(struct net_device *netdev);
+void ice_set_ethtool_repr_ops(struct net_device *netdev);
 void ice_set_ethtool_safe_mode_ops(struct net_device *netdev);
 u16 ice_get_avail_txq_count(struct ice_pf *pf);
 u16 ice_get_avail_rxq_count(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d95a5daca114..2858805cdeea 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -173,7 +173,7 @@ static void
 ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
+	struct ice_vsi *vsi = ice_get_netdev_priv_vsi(np);
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
 	struct ice_orom_info *orom;
@@ -869,7 +869,7 @@ ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
 static void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
+	struct ice_vsi *vsi = ice_get_netdev_priv_vsi(np);
 	unsigned int i;
 	u8 *p = data;
 
@@ -879,6 +879,9 @@ static void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 			ethtool_sprintf(&p,
 					ice_gstrings_vsi_stats[i].stat_string);
 
+		if (ice_is_port_repr_netdev(netdev))
+			return;
+
 		ice_for_each_alloc_txq(vsi, i) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
@@ -1301,6 +1304,9 @@ static int ice_get_sset_count(struct net_device *netdev, int sset)
 		 * order of strings will suffer from race conditions and are
 		 * not safe.
 		 */
+		if (ice_is_port_repr_netdev(netdev))
+			return ICE_VSI_STATS_LEN;
+
 		return ICE_ALL_STATS_LEN(netdev);
 	case ETH_SS_TEST:
 		return ICE_TEST_LEN;
@@ -1316,7 +1322,7 @@ ice_get_ethtool_stats(struct net_device *netdev,
 		      struct ethtool_stats __always_unused *stats, u64 *data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
+	struct ice_vsi *vsi = ice_get_netdev_priv_vsi(np);
 	struct ice_pf *pf = vsi->back;
 	struct ice_ring *ring;
 	unsigned int j;
@@ -1332,6 +1338,9 @@ ice_get_ethtool_stats(struct net_device *netdev,
 			     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 
+	if (ice_is_port_repr_netdev(netdev))
+		return;
+
 	/* populate per queue stats */
 	rcu_read_lock();
 
@@ -4051,6 +4060,23 @@ void ice_set_ethtool_safe_mode_ops(struct net_device *netdev)
 	netdev->ethtool_ops = &ice_ethtool_safe_mode_ops;
 }
 
+static const struct ethtool_ops ice_ethtool_repr_ops = {
+	.get_drvinfo		= ice_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_strings		= ice_get_strings,
+	.get_ethtool_stats      = ice_get_ethtool_stats,
+	.get_sset_count		= ice_get_sset_count,
+};
+
+/**
+ * ice_set_ethtool_repr_ops - setup VF's port representor ethtool ops
+ * @netdev: network interface device structure
+ */
+void ice_set_ethtool_repr_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &ice_ethtool_repr_ops;
+}
+
 /**
  * ice_set_ethtool_ops - setup netdev ethtool ops
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 76d8086278c6..ababed89f25a 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -39,6 +39,33 @@ ice_repr_get_phys_port_name(struct net_device *netdev, char *buf, size_t len)
 	return 0;
 }
 
+/**
+ * ice_repr_get_stats64 - get VF stats for VFPR use
+ * @netdev: pointer to port representor netdev
+ * @stats: pointer to struct where stats can be stored
+ */
+static void
+ice_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->repr->src_vsi;
+	struct ice_eth_stats *eth_stats;
+
+	ice_update_vsi_stats(vsi);
+	eth_stats = &vsi->eth_stats;
+
+	stats->tx_packets = eth_stats->tx_unicast + eth_stats->tx_broadcast +
+			    eth_stats->tx_multicast;
+	stats->rx_packets = eth_stats->rx_unicast + eth_stats->rx_broadcast +
+			    eth_stats->rx_multicast;
+	stats->tx_bytes = eth_stats->tx_bytes;
+	stats->rx_bytes = eth_stats->rx_bytes;
+	stats->multicast = eth_stats->rx_multicast;
+	stats->tx_errors = eth_stats->tx_errors;
+	stats->tx_dropped = eth_stats->tx_discards;
+	stats->rx_dropped = eth_stats->rx_discards;
+}
+
 /**
  * ice_netdev_to_repr - Get port representor for given netdevice
  * @netdev: pointer to port representor netdev
@@ -112,6 +139,7 @@ ice_repr_get_devlink_port(struct net_device *netdev)
 
 static const struct net_device_ops ice_repr_netdev_ops = {
 	.ndo_get_phys_port_name = ice_repr_get_phys_port_name,
+	.ndo_get_stats64 = ice_repr_get_stats64,
 	.ndo_open = ice_repr_open,
 	.ndo_stop = ice_repr_stop,
 	.ndo_start_xmit = ice_eswitch_port_start_xmit,
@@ -136,6 +164,7 @@ ice_repr_reg_netdev(struct net_device *netdev)
 {
 	eth_hw_addr_random(netdev);
 	netdev->netdev_ops = &ice_repr_netdev_ops;
+	ice_set_ethtool_repr_ops(netdev);
 
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
-- 
2.30.2

