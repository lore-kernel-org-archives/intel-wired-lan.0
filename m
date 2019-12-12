From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 Dec 2019 03:12:59 -0800
Subject: [Intel-wired-lan] [PATCH S35 07/15] ice: Return error on not
 supported ethtool -C parameters
In-Reply-To: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
Message-ID: <20191212111307.33566-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

Check for all unused parameters, if ethtool sent one of them,
print info about that and return error.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 50 ++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a421c616604c..6ecac824c31c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3587,6 +3587,53 @@ ice_set_q_coalesce(struct ice_vsi *vsi, struct ethtool_coalesce *ec, int q_num)
 	return 0;
 }
 
+/**
+ * ice_is_coalesce_param_invalid - check for unsupported coalesce parameters
+ * @netdev: pointer to the netdev associated with this query
+ * @ec: ethtool structure to fill with driver's coalesce settings
+ *
+ * Print netdev info if driver doesn't support one of the parameters
+ * and return error. When any parameters will be implemented, remove only
+ * this parameter from param array.
+ */
+static int
+ice_is_coalesce_param_invalid(struct net_device *netdev,
+			      struct ethtool_coalesce *ec)
+{
+	struct ice_ethtool_not_used {
+		u32 value;
+		const char *name;
+	} param[] = {
+		{ec->stats_block_coalesce_usecs, "stats-block-usecs"},
+		{ec->rate_sample_interval, "sample-interval"},
+		{ec->pkt_rate_low, "pkt-rate-low"},
+		{ec->pkt_rate_high, "pkt-rate-high"},
+		{ec->rx_max_coalesced_frames, "rx-frames"},
+		{ec->rx_coalesce_usecs_irq, "rx-usecs-irq"},
+		{ec->rx_max_coalesced_frames_irq, "rx-frames-irq"},
+		{ec->tx_max_coalesced_frames, "tx-frames"},
+		{ec->tx_coalesce_usecs_irq, "tx-usecs-irq"},
+		{ec->tx_max_coalesced_frames_irq, "tx-frames-irq"},
+		{ec->rx_coalesce_usecs_low, "rx-usecs-low"},
+		{ec->rx_max_coalesced_frames_low, "rx-frames-low"},
+		{ec->tx_coalesce_usecs_low, "tx-usecs-low"},
+		{ec->tx_max_coalesced_frames_low, "tx-frames-low"},
+		{ec->rx_max_coalesced_frames_high, "rx-frames-high"},
+		{ec->tx_max_coalesced_frames_high, "tx-frames-high"}
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(param); i++) {
+		if (param[i].value) {
+			netdev_info(netdev, "Setting %s not supported\n",
+				    param[i].name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * __ice_set_coalesce - set ITR/INTRL values for the device
  * @netdev: pointer to the netdev associated with this query
@@ -3603,6 +3650,9 @@ __ice_set_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 
+	if (ice_is_coalesce_param_invalid(netdev, ec))
+		return -EINVAL;
+
 	if (q_num < 0) {
 		int v_idx;
 
-- 
2.20.1

