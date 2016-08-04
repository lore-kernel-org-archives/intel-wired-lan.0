From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  4 Aug 2016 18:49:47 +0200
Subject: [Intel-wired-lan] [next PATCH 5/5] i40e: Enable ntuple filters on
	VFs via VF representor netdevs.
In-Reply-To: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
References: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1470329387-25138-5-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sample script that shows how ntuple filters can be added to VFs.
PF: enp5s0f0, VF_REP0: enp5s0f0-vf0, VF_REP1: enp5s0f0-vf1

   # devlink dev set pci/0000:05:00.0 smode switchdev
   # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
   # ethtool -N enp5s0f0 flow-type ip4 src-ip 192.168.1.1 \
       dst-ip 192.168.1.2 action -1
   # ethtool -N enp5s0f0-vf0 flow-type ip4 src-ip 192.168.10.1 \
       dst-ip 192.168.10.2 action -1
   # ethtool -N enp5s0f0-vf1 flow-type ip4 src-ip 192.168.11.1 \
       dst-ip 192.168.11.2 action -1
   # ethtool -n enp5s0f0
     72 RX rings available
     Total 1 rules

     Filter: 7679
         Rule Type: Raw IPv4
         Src IP addr: 192.168.1.1 mask: 255.255.255.255
         Dest IP addr: 192.168.1.2 mask: 255.255.255.255
         TOS: 0x0 mask: 0xff
         Protocol: 0 mask: 0xff
         L4 bytes: 0x0 mask: 0xffffffff
         Action: Drop
   # ethtool -n enp5s0f0-vf0
     4 RX rings available
     Total 1 rules

     Filter: 7679
         Rule Type: Raw IPv4
         Src IP addr: 192.168.10.1 mask: 255.255.255.255
         Dest IP addr: 192.168.10.2 mask: 255.255.255.255
         TOS: 0x0 mask: 0xff
         Protocol: 0 mask: 0xff
         L4 bytes: 0x0 mask: 0xffffffff
         Action: Drop
   # ethtool -n enp5s0f0-vf1
     4 RX rings available
     Total 1 rules

     Filter: 7679
         Rule Type: Raw IPv4
         Src IP addr: 192.168.11.1 mask: 255.255.255.255
         Dest IP addr: 192.168.11.2 mask: 255.255.255.255
         TOS: 0x0 mask: 0xff
         Protocol: 0 mask: 0xff
         L4 bytes: 0x0 mask: 0xffffffff
         Action: Drop

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9a5c807..d159a11 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2320,6 +2320,46 @@ static int i40e_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 }
 
 /**
+ * i40e_vf_netdev_get_rxnfc - command to get VF's RX flow classification rules
+ * @netdev: vf representor network interface device structure
+ * @cmd: ethtool rxnfc command
+ *
+ * Returns Success if the command is supported.
+ **/
+static int i40e_vf_netdev_get_rxnfc(struct net_device *netdev,
+				    struct ethtool_rxnfc *cmd, u32 *rule_locs)
+{
+	struct i40e_vf_netdev_priv *priv = netdev_priv(netdev);
+	struct i40e_vf *vf = priv->vf;
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
+	int ret = -EOPNOTSUPP;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = vsi->num_queue_pairs;
+		ret = 0;
+		break;
+	case ETHTOOL_GRXCLSRLCNT:
+		cmd->rule_cnt = vsi->fdir_active_filters;
+		/* report total rule count */
+		cmd->data = i40e_get_fd_cnt_all(pf);
+		ret = 0;
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		ret = i40e_get_ethtool_fdir_entry(vsi, cmd);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		ret = i40e_get_ethtool_fdir_all(vsi, cmd, rule_locs);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/**
  * i40e_set_rss_hash_opt - Enable/Disable flow types for RSS hash
  * @pf: pointer to the physical function struct
  * @cmd: ethtool rxnfc command
@@ -2697,6 +2737,36 @@ static int i40e_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 }
 
 /**
+ * i40e_vf_netdev_set_rxnfc - command to set VF's RX flow classification rules
+ * @netdev: VF representor's network interface device structure
+ * @cmd: ethtool rxnfc command
+ *
+ * Returns Success if the command is supported.
+ **/
+static int i40e_vf_netdev_set_rxnfc(struct net_device *netdev,
+				    struct ethtool_rxnfc *cmd)
+{
+	struct i40e_vf_netdev_priv *priv = netdev_priv(netdev);
+	struct i40e_vf *vf = priv->vf;
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
+	int ret = -EOPNOTSUPP;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		ret = i40e_add_fdir_ethtool(vsi, cmd);
+		break;
+	case ETHTOOL_SRXCLSRLDEL:
+		ret = i40e_del_fdir_entry(vsi, cmd);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/**
  * i40e_max_channels - get Max number of combined channels supported
  * @vsi: vsi pointer
  **/
@@ -3102,6 +3172,8 @@ static const struct ethtool_ops i40e_vf_netdev_ethtool_ops = {
 	.get_strings		= i40e_vf_netdev_ethtool_get_strings,
 	.get_ethtool_stats      = i40e_vf_netdev_ethtool_get_stats,
 	.get_sset_count         = i40e_vf_netdev_ethtool_get_sset_count,
+	.get_rxnfc		= i40e_vf_netdev_get_rxnfc,
+	.set_rxnfc		= i40e_vf_netdev_set_rxnfc,
 };
 
 void i40e_set_vf_netdev_ethtool_ops(struct net_device *netdev)
-- 
2.5.5

