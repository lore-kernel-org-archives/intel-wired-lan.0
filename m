From: Mitch Williams <mitch.a.williams@intel.com>
Date: Fri,  1 Apr 2016 13:34:31 -0700
Subject: [Intel-wired-lan] [next PATCH v2] i40evf: properly handle VLAN
	features
Message-ID: <1459542871-39856-1-git-send-email-mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Correctly set the VLAN feature flags after setting the rest of the
netdev flags. And don't set them in hw_features, because these can't be
controlled by the VF driver.

Testing Hints: Make sure VLAN offloads work correctly when not using
port VLANs, and make sure they're not available when using port VLANs.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 31 +++++++++++++------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4b70aae..7ef4d1a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2259,6 +2259,10 @@ static int i40evf_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
+#define I40EVF_VLAN_FEATURES (NETIF_F_HW_VLAN_CTAG_TX |\
+			      NETIF_F_HW_VLAN_CTAG_RX |\
+			      NETIF_F_HW_VLAN_CTAG_FILTER)
+
 static const struct net_device_ops i40evf_netdev_ops = {
 	.ndo_open		= i40evf_open,
 	.ndo_stop		= i40evf_close,
@@ -2307,29 +2311,20 @@ static int i40evf_check_reset_complete(struct i40e_hw *hw)
  **/
 int i40evf_process_config(struct i40evf_adapter *adapter)
 {
+	struct i40e_virtchnl_vf_resource *vfres = adapter->vf_res;
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
 	/* got VF config message back from PF, now we can parse it */
-	for (i = 0; i < adapter->vf_res->num_vsis; i++) {
-		if (adapter->vf_res->vsi_res[i].vsi_type == I40E_VSI_SRIOV)
-			adapter->vsi_res = &adapter->vf_res->vsi_res[i];
+	for (i = 0; i < vfres->num_vsis; i++) {
+		if (vfres->vsi_res[i].vsi_type == I40E_VSI_SRIOV)
+			adapter->vsi_res = &vfres->vsi_res[i];
 	}
 	if (!adapter->vsi_res) {
 		dev_err(&adapter->pdev->dev, "No LAN VSI found\n");
 		return -ENODEV;
 	}
 
-	if (adapter->vf_res->vf_offload_flags
-	    & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
-		netdev->vlan_features = netdev->features &
-					~(NETIF_F_HW_VLAN_CTAG_TX |
-					  NETIF_F_HW_VLAN_CTAG_RX |
-					  NETIF_F_HW_VLAN_CTAG_FILTER);
-		netdev->features |= NETIF_F_HW_VLAN_CTAG_TX |
-				    NETIF_F_HW_VLAN_CTAG_RX |
-				    NETIF_F_HW_VLAN_CTAG_FILTER;
-	}
 	netdev->features |= NETIF_F_HIGHDMA |
 			    NETIF_F_SG |
 			    NETIF_F_IP_CSUM |
@@ -2338,7 +2333,7 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 			    NETIF_F_TSO |
 			    NETIF_F_TSO6 |
 			    NETIF_F_TSO_ECN |
-			    NETIF_F_GSO_GRE	       |
+			    NETIF_F_GSO_GRE |
 			    NETIF_F_GSO_UDP_TUNNEL |
 			    NETIF_F_RXCSUM |
 			    NETIF_F_GRO;
@@ -2355,9 +2350,15 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 	if (adapter->flags & I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE)
 		netdev->features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
 
+	/* always clear VLAN features because they can change at every reset */
+	netdev->features &= ~(I40EVF_VLAN_FEATURES);
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features;
-	netdev->hw_features &= ~NETIF_F_RXCSUM;
+
+	if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
+		netdev->vlan_features = netdev->features;
+		netdev->features |= I40EVF_VLAN_FEATURES;
+	}
 
 	adapter->vsi.id = adapter->vsi_res->vsi_id;
 
-- 
2.5.5

