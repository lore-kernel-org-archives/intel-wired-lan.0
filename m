From: Mitch Williams <mitch.a.williams@intel.com>
Date: Thu, 31 Mar 2016 10:35:08 -0700
Subject: [Intel-wired-lan] [next PATCH] i40evf: properly handle VLAN features
Message-ID: <1459445708-20029-1-git-send-email-mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Correctly set the VLAN feature flags after setting the rest of the
netdev flags. And don't set them in hw_features, because these can't be
controlled by the VF driver.

Testing Hints: Make sure VLAN offloads work correctly when not using
port VLANs, and make sure they're not availble when using port VLANs.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4b70aae..039bbd2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2259,6 +2259,10 @@ static int i40evf_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
+#define I40EVF_VLAN_FEATURES (NETIF_F_HW_VLAN_CTAG_TX |\
+                              NETIF_F_HW_VLAN_CTAG_RX |\
+                              NETIF_F_HW_VLAN_CTAG_FILTER)
+
 static const struct net_device_ops i40evf_netdev_ops = {
 	.ndo_open		= i40evf_open,
 	.ndo_stop		= i40evf_close,
@@ -2320,16 +2324,6 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
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
@@ -2358,6 +2352,13 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features;
 	netdev->hw_features &= ~NETIF_F_RXCSUM;
+	netdev->hw_features &= ~(I40EVF_VLAN_FEATURES);
+	netdev->features &= ~(I40EVF_VLAN_FEATURES);
+
+	if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
+		netdev->vlan_features = netdev->features;
+		netdev->features |= I40EVF_VLAN_FEATURES;
+	}
 
 	adapter->vsi.id = adapter->vsi_res->vsi_id;
 
-- 
2.5.5

