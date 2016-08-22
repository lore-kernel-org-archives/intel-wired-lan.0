From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Tue, 23 Aug 2016 00:43:09 +0200
Subject: [Intel-wired-lan] [dev-queue PATCH v3 2/3] i40e: Enable VF specific
	ethtool statistics via VF Port representor netdevs.
In-Reply-To: <1471905790-4222-1-git-send-email-sridhar.samudrala@intel.com>
References: <1471905790-4222-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1471905790-4222-3-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sample script that shows ethtool stats on VF representor netdev
PF: enp5s0f0, VF0: enp5s2  VF_REP0: enp5s0f0-vf0

   # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
   # ip link set enp5s2 up
   # ethtool -S enp5s0f0-vf0
   NIC statistics:
     tx_bytes: 0
     tx_unicast: 0
     tx_multicast: 0
     tx_broadcast: 0
     tx_discards: 0
     tx_errors: 0
     rx_bytes: 140
     rx_unicast: 0
     rx_multicast: 2
     rx_broadcast: 0
     rx_discards: 0
     rx_unknown_protocol: 0

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h             |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 72 ++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  1 +
 3 files changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 19103a6..13b1f75 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -866,4 +866,5 @@ i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf);
 i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf);
 i40e_status i40e_commit_npar_bw_setting(struct i40e_pf *pf);
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
+void i40e_set_vf_netdev_ethtool_ops(struct net_device *netdev);
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1835186..e2d3168 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3116,3 +3116,75 @@ void i40e_set_ethtool_ops(struct net_device *netdev)
 {
 	netdev->ethtool_ops = &i40e_ethtool_ops;
 }
+
+/* As the VF Port representor(VFPR) represents the switch port corresponding
+ * to a VF, the tx_ and rx_ strings are swapped to indicate that the frames
+ * transmitted from VF are received on VFPR and the frames received on VF are
+ * transmitted from VFPR.
+ */
+static const char i40e_vf_netdev_ethtool_sset[][ETH_GSTRING_LEN] = {
+	"tx_bytes",
+	"tx_unicast",
+	"tx_multicast",
+	"tx_broadcast",
+	"tx_discards",
+	"tx_errors",
+	"rx_bytes",
+	"rx_unicast",
+	"rx_multicast",
+	"rx_broadcast",
+	"rx_discards",
+	"rx_unknown_protocol",
+};
+
+#define I40E_VF_NETDEV_ETHTOOL_STAT_COUNT \
+			ARRAY_SIZE(i40e_vf_netdev_ethtool_sset)
+
+static void i40e_vf_netdev_ethtool_get_strings(struct net_device *dev,
+					       u32 stringset,
+					       u8 *ethtool_strings)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(ethtool_strings, &i40e_vf_netdev_ethtool_sset,
+		       sizeof(i40e_vf_netdev_ethtool_sset));
+		break;
+	}
+}
+
+static int i40e_vf_netdev_ethtool_get_sset_count(struct net_device *dev,
+						 int stringset)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		return I40E_VF_NETDEV_ETHTOOL_STAT_COUNT;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void i40e_vf_netdev_ethtool_get_stats(struct net_device *dev,
+				struct ethtool_stats *target_ethtool_stats,
+				u64 *target_stat_values)
+{
+	struct i40e_vf_netdev_priv *priv = netdev_priv(dev);
+	struct i40e_vf *vf = priv->vf;
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_vsi *vsi;
+
+	vsi = pf->vsi[vf->lan_vsi_idx];
+	i40e_update_stats(vsi);
+	memcpy(target_stat_values, &vsi->eth_stats,
+	       I40E_VF_NETDEV_ETHTOOL_STAT_COUNT * 8);
+}
+
+static const struct ethtool_ops i40e_vf_netdev_ethtool_ops = {
+	.get_strings		= i40e_vf_netdev_ethtool_get_strings,
+	.get_ethtool_stats      = i40e_vf_netdev_ethtool_get_stats,
+	.get_sset_count         = i40e_vf_netdev_ethtool_get_sset_count,
+};
+
+void i40e_set_vf_netdev_ethtool_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &i40e_vf_netdev_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 6167e56..b5a716e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1049,6 +1049,7 @@ int i40e_alloc_vf_netdev(struct i40e_vf *vf, u16 vf_num)
 	priv->vf = &(pf->vf[vf_num]);
 
 	netdev->netdev_ops = &i40e_vf_netdev_ops;
+	i40e_set_vf_netdev_ethtool_ops(netdev);
 
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
-- 
2.5.5

