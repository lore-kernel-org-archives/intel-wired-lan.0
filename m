From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 28 Oct 2019 17:37:07 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: implement VF stats NDO
Message-ID: <20191029003707.45245-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Implement the VF stats gathering via the kernel via ndo_get_vf_stats().
The driver will show per-VF stats in the output of the command:
ip -s link show dev <PF>

Testing Hints:
ip -s link show dev eth0
will return non-zero VF stats.
...
   vf 0 MAC 00:55:aa:00:55:aa, spoof checking on, link-state enable, trust off
   RX: bytes  packets  mcast   bcast
   128000     1000     104     104
   TX: bytes  packets
   128000     1000

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

---

v2: remove transmit stats from multicast and broadcast based on
feedback, add a little to commit message.
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 48 +++++++++++++++++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  2 +
 3 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a6f60e8a6026..56cf7bc8add3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12870,6 +12870,7 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_set_features	= i40e_set_features,
 	.ndo_set_vf_mac		= i40e_ndo_set_vf_mac,
 	.ndo_set_vf_vlan	= i40e_ndo_set_vf_port_vlan,
+	.ndo_get_vf_stats	= i40e_get_vf_stats,
 	.ndo_set_vf_rate	= i40e_ndo_set_vf_bw,
 	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
 	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7787766d0eb8..6d75a35acb67 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4527,3 +4527,51 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
 }
+
+/**
+ * i40e_get_vf_stats - populate some stats for the VF
+ * @netdev: the netdev of the PF
+ * @vf_id: the host OS identifier (0-127)
+ * @vf_stats: pointer to the OS memory to be initialized
+ */
+int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
+		      struct ifla_vf_stats *vf_stats)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf *pf = np->vsi->back;
+	struct i40e_eth_stats *stats;
+	struct i40e_vsi *vsi;
+	struct i40e_vf *vf;
+
+	/* validate the request */
+	if (i40e_validate_vf(pf, vf_id))
+		return -EINVAL;
+
+	vf = &pf->vf[vf_id];
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
+		dev_err(&pf->pdev->dev, "VF %d in reset. Try again.\n", vf_id);
+		return -EBUSY;
+	}
+
+	vsi = pf->vsi[vf->lan_vsi_idx];
+	if (!vsi)
+		return -EINVAL;
+
+	i40e_update_eth_stats(vsi);
+	stats = &vsi->eth_stats;
+
+	memset(vf_stats, 0, sizeof(*vf_stats));
+
+	vf_stats->rx_packets = stats->rx_unicast + stats->rx_broadcast +
+		stats->rx_multicast;
+	vf_stats->tx_packets = stats->tx_unicast + stats->tx_broadcast +
+		stats->tx_multicast;
+	vf_stats->rx_bytes   = stats->rx_bytes;
+	vf_stats->tx_bytes   = stats->tx_bytes;
+	vf_stats->broadcast  = stats->rx_broadcast;
+	vf_stats->multicast  = stats->rx_multicast;
+	vf_stats->rx_dropped = stats->rx_discards;
+	vf_stats->tx_dropped = stats->tx_discards;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 1ce06240a702..631248c0981a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -138,5 +138,7 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
+int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
+		      struct ifla_vf_stats *vf_stats);
 
 #endif /* _I40E_VIRTCHNL_PF_H_ */
-- 
2.17.2

