From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 18 Nov 2015 13:10:20 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Clean up redundancy in
	hw_enc_features
Message-ID: <20151118211020.124539.53305.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Clean up minor redundancy in the setting of hw_enc_features that
makes it appears that X550 uniquely has more encapsulation features
than other devices. The driver only supports one more feature, so
make it look that way. Also change the initial assignment to
hw_enc_features to be a simple assignment, just to be clearer about
that as well. Thanks to Alex Duyck for noticing this slight confusion.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 4ef5b63b2543..66701ec96359 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9015,8 +9015,8 @@ skip_sriov:
 	netdev->vlan_features |= NETIF_F_IPV6_CSUM;
 	netdev->vlan_features |= NETIF_F_SG;
 
-	netdev->hw_enc_features |= NETIF_F_SG | NETIF_F_IP_CSUM |
-				   NETIF_F_IPV6_CSUM;
+	netdev->hw_enc_features = NETIF_F_SG | NETIF_F_IP_CSUM |
+				  NETIF_F_IPV6_CSUM;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
@@ -9025,9 +9025,7 @@ skip_sriov:
 	switch (adapter->hw.mac.type) {
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
-		netdev->hw_enc_features |= NETIF_F_RXCSUM |
-					   NETIF_F_IP_CSUM |
-					   NETIF_F_IPV6_CSUM;
+		netdev->hw_enc_features |= NETIF_F_RXCSUM;
 		break;
 	default:
 		break;

