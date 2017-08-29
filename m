From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:41 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 12/13] i40evf: enable support
	for VF VLAN tag stripping control
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

A recent commit 809481484e5d ("i40e/i40evf: support for VF VLAN tag
stripping control") added support for VFs to negotiate the control of
VLAN tag stripping. This should have allowed VFs to disable the feature.
Unfortunately, the flag was set only in netdev->feature flags and not in
netdev->hw_features.

This ultimately causes the stack to assume that it cannot change the
flag, so it was unchangeable and marked as [fixed] in the ethtool -k
output.

Fix this by setting the feature in hw_features first, just as we do for
the PF code. This enables ethtool -K to disable the feature correctly,
and fully enables user control of the VLAN tag stripping feature.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 70a033c..5caa1bd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2425,10 +2425,6 @@ static netdev_features_t i40evf_features_check(struct sk_buff *skb,
 	return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
 }
 
-#define I40EVF_VLAN_FEATURES (NETIF_F_HW_VLAN_CTAG_TX |\
-			      NETIF_F_HW_VLAN_CTAG_RX |\
-			      NETIF_F_HW_VLAN_CTAG_FILTER)
-
 /**
  * i40evf_fix_features - fix up the netdev feature bits
  * @netdev: our net device
@@ -2441,9 +2437,11 @@ static netdev_features_t i40evf_fix_features(struct net_device *netdev,
 {
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
 
-	features &= ~I40EVF_VLAN_FEATURES;
-	if (adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN)
-		features |= I40EVF_VLAN_FEATURES;
+	if (!(adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
+		features &= ~(NETIF_F_HW_VLAN_CTAG_TX |
+			      NETIF_F_HW_VLAN_CTAG_RX |
+			      NETIF_F_HW_VLAN_CTAG_FILTER);
+
 	return features;
 }
 
@@ -2574,9 +2572,17 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 	 */
 	hw_features = hw_enc_features;
 
+	/* Enable VLAN features if supported */
+	if (vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN)
+		hw_features |= (NETIF_F_HW_VLAN_CTAG_TX |
+				NETIF_F_HW_VLAN_CTAG_RX);
+
 	netdev->hw_features |= hw_features;
 
-	netdev->features |= hw_features | I40EVF_VLAN_FEATURES;
+	netdev->features |= hw_features;
+
+	if (vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN)
+		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	adapter->vsi.id = adapter->vsi_res->vsi_id;
 
-- 
2.9.4

