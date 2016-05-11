From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 11 May 2016 13:23:34 -0700
Subject: [Intel-wired-lan] [next PATCH] ixgbe: Fix VLAN features error
Message-ID: <20160511202334.6128.46021.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It looks like at some point I somehow transposed the location of setting
the VLAN features in netdev->features and the configuration of the
vlan_features.  As a result the driver is now generating a warning about
vlan_features being setup incorrectly.

This patch corrects that by placing the update of netdev->features to
include the VLAN features so that it is after the point where we write
netdev->features into netdev->vlan_features.

Fixes: b83e30104bd9 ("ixgbe/ixgbevf: Add support for GSO partial")
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7bbf9b12bf38..9f3677c7e96f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9508,15 +9508,15 @@ skip_sriov:
 	if (pci_using_dac)
 		netdev->features |= NETIF_F_HIGHDMA;
 
+	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
+	netdev->hw_enc_features |= netdev->vlan_features;
+	netdev->mpls_features |= NETIF_F_HW_CSUM;
+
 	/* set this bit last since it cannot be part of vlan_features */
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
 			    NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_TX;
 
-	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
-	netdev->hw_enc_features |= netdev->vlan_features;
-	netdev->mpls_features |= NETIF_F_HW_CSUM;
-
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 

