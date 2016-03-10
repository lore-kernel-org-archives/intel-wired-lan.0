From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 10 Mar 2016 10:01:10 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for toggling VLAN
 filtering flag via ethtool
Message-ID: <20160310175824.12438.85762.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change makes it so that we can use the ethtool rx-vlan-filter flag to
toggle Rx VLAN filtering on and off.  This is basically just an extension
of the existing VLAN promisc work in that it just adds support for the
additional ethtool flag.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Testing-hints: The register changes can be viewed via ethregs or using a
	       traffic generator that can be configured such that you can
	       verify the VLAN traffic is filtered when the filter is
	       enabled and can be received when it is not.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1b490d1c27ce..3c5276f62805 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4451,6 +4451,7 @@ void ixgbe_set_rx_mode(struct net_device *netdev)
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 fctrl, vmolr = IXGBE_VMOLR_BAM | IXGBE_VMOLR_AUPE;
+	netdev_features_t features = netdev->features;
 	int count;
 
 	/* Check for Promiscuous and All Multicast modes */
@@ -4468,14 +4469,13 @@ void ixgbe_set_rx_mode(struct net_device *netdev)
 		hw->addr_ctrl.user_set_promisc = true;
 		fctrl |= (IXGBE_FCTRL_UPE | IXGBE_FCTRL_MPE);
 		vmolr |= IXGBE_VMOLR_MPE;
-		ixgbe_vlan_promisc_enable(adapter);
+		features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
 	} else {
 		if (netdev->flags & IFF_ALLMULTI) {
 			fctrl |= IXGBE_FCTRL_MPE;
 			vmolr |= IXGBE_VMOLR_MPE;
 		}
 		hw->addr_ctrl.user_set_promisc = false;
-		ixgbe_vlan_promisc_disable(adapter);
 	}
 
 	/*
@@ -4508,7 +4508,7 @@ void ixgbe_set_rx_mode(struct net_device *netdev)
 	}
 
 	/* This is useful for sniffing bad packets. */
-	if (adapter->netdev->features & NETIF_F_RXALL) {
+	if (features & NETIF_F_RXALL) {
 		/* UPE and MPE will be handled by normal PROMISC logic
 		 * in e1000e_set_rx_mode */
 		fctrl |= (IXGBE_FCTRL_SBP | /* Receive bad packets */
@@ -4521,10 +4521,15 @@ void ixgbe_set_rx_mode(struct net_device *netdev)
 
 	IXGBE_WRITE_REG(hw, IXGBE_FCTRL, fctrl);
 
-	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
+	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		ixgbe_vlan_strip_enable(adapter);
 	else
 		ixgbe_vlan_strip_disable(adapter);
+
+	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		ixgbe_vlan_promisc_disable(adapter);
+	else
+		ixgbe_vlan_promisc_enable(adapter);
 }
 
 static void ixgbe_napi_enable_all(struct ixgbe_adapter *adapter)
@@ -8498,11 +8503,6 @@ static int ixgbe_set_features(struct net_device *netdev,
 			adapter->flags |= IXGBE_FLAG_FDIR_HASH_CAPABLE;
 	}
 
-	if (features & NETIF_F_HW_VLAN_CTAG_RX)
-		ixgbe_vlan_strip_enable(adapter);
-	else
-		ixgbe_vlan_strip_disable(adapter);
-
 	if (changed & NETIF_F_RXALL)
 		need_reset = true;
 
@@ -8519,6 +8519,9 @@ static int ixgbe_set_features(struct net_device *netdev,
 
 	if (need_reset)
 		ixgbe_do_reset(netdev);
+	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX |
+			    NETIF_F_HW_VLAN_CTAG_FILTER))
+		ixgbe_set_rx_mode(netdev);
 
 	return 0;
 }
@@ -9190,7 +9193,8 @@ skip_sriov:
 			   NETIF_F_HW_CSUM |
 			   NETIF_F_SCTP_CRC |
 			   NETIF_F_HW_VLAN_CTAG_TX |
-			   NETIF_F_HW_VLAN_CTAG_RX;
+			   NETIF_F_HW_VLAN_CTAG_RX |
+			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	if (hw->mac.type >= ixgbe_mac_82599EB)
 		netdev->features |= NETIF_F_SCTP_CRC;
@@ -9203,9 +9207,6 @@ skip_sriov:
 	if (hw->mac.type >= ixgbe_mac_82599EB)
 		netdev->hw_features |= NETIF_F_NTUPLE;
 
-	/* set this bit last since it cannot be part of hw_features */
-	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
-
 	netdev->vlan_features |= NETIF_F_SG |
 				 NETIF_F_TSO |
 				 NETIF_F_TSO6 |

