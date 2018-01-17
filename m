From: Corinna Vinschen <vinschen@redhat.com>
Date: Wed, 17 Jan 2018 11:53:39 +0100
Subject: [Intel-wired-lan] [PATCH] igb: add VF trust infrastructure
Message-ID: <20180117105339.9336-1-vinschen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

* Add a per-VF value to know if a VF is trusted, by default don't
  trust VFs.

* Implement netdev op to trust VFs (igb_ndo_set_vf_trust) and add
  trust status to ndo_get_vf_config output.

* Allow a trusted VF to change MAC and MAC filters even if MAC
  has been administratively set.

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 30 +++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 1c6b8d9176a8..55d6f17d5799 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -109,6 +109,7 @@ struct vf_data_storage {
 	u16 pf_qos;
 	u16 tx_rate;
 	bool spoofchk_enabled;
+	bool trusted;
 };
 
 /* Number of unicast MAC filters reserved for the PF in the RAR registers */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 749fb1f720b4..5cbec6cf2b2a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -190,6 +190,8 @@ static int igb_ndo_set_vf_vlan(struct net_device *netdev,
 static int igb_ndo_set_vf_bw(struct net_device *, int, int, int);
 static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
 				   bool setting);
+static int igb_ndo_set_vf_trust(struct net_device *netdev, int vf,
+				bool setting);
 static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
 				 struct ifla_vf_info *ivi);
 static void igb_check_vf_rate_limit(struct igb_adapter *);
@@ -2527,6 +2529,7 @@ static const struct net_device_ops igb_netdev_ops = {
 	.ndo_set_vf_vlan	= igb_ndo_set_vf_vlan,
 	.ndo_set_vf_rate	= igb_ndo_set_vf_bw,
 	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
+	.ndo_set_vf_trust	= igb_ndo_set_vf_trust,
 	.ndo_get_vf_config	= igb_ndo_get_vf_config,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= igb_netpoll,
@@ -6383,6 +6386,9 @@ static int igb_vf_configure(struct igb_adapter *adapter, int vf)
 	/* By default spoof check is enabled for all VFs */
 	adapter->vf_data[vf].spoofchk_enabled = true;
 
+	/* By default VFs are not trusted */
+	adapter->vf_data[vf].trusted = false;
+
 	return 0;
 }
 
@@ -6940,13 +6946,13 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 		}
 		break;
 	case E1000_VF_MAC_FILTER_ADD:
-		if (vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) {
+		if ((vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) &&
+		    !vf_data->trusted) {
 			dev_warn(&pdev->dev,
 				 "VF %d requested MAC filter but is administratively denied\n",
 				 vf);
 			return -EINVAL;
 		}
-
 		if (!is_valid_ether_addr(addr)) {
 			dev_warn(&pdev->dev,
 				 "VF %d attempted to set invalid MAC filter\n",
@@ -6998,7 +7004,8 @@ static int igb_set_vf_mac_addr(struct igb_adapter *adapter, u32 *msg, int vf)
 	int ret = 0;
 
 	if (!info) {
-		if (vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) {
+		if ((vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) &&
+		    !vf_data->trusted) {
 			dev_warn(&pdev->dev,
 				 "VF %d attempted to override administratively set MAC address\nReload the VF driver to resume operations\n",
 				 vf);
@@ -8934,6 +8941,22 @@ static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
 	return 0;
 }
 
+static int igb_ndo_set_vf_trust(struct net_device *netdev, int vf, bool setting)
+{
+	struct igb_adapter *adapter = netdev_priv(netdev);
+
+	if (vf >= adapter->vfs_allocated_count)
+		return -EINVAL;
+	if (adapter->vf_data[vf].trusted == setting)
+		return 0;
+
+	adapter->vf_data[vf].trusted = setting;
+
+	dev_info(&adapter->pdev->dev, "VF %u is %strusted\n",
+		 vf, setting ? "" : "not ");
+	return 0;
+}
+
 static int igb_ndo_get_vf_config(struct net_device *netdev,
 				 int vf, struct ifla_vf_info *ivi)
 {
@@ -8947,6 +8970,7 @@ static int igb_ndo_get_vf_config(struct net_device *netdev,
 	ivi->vlan = adapter->vf_data[vf].pf_vlan;
 	ivi->qos = adapter->vf_data[vf].pf_qos;
 	ivi->spoofchk = adapter->vf_data[vf].spoofchk_enabled;
+	ivi->trusted = adapter->vf_data[vf].trusted;
 	return 0;
 }
 
-- 
2.14.3

