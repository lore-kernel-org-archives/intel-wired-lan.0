From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 18 Nov 2015 15:37:04 -0800
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Clean up redundancy in
	hw_enc_features
Message-ID: <20151118233703.51553.20333.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Clean up minor redundancy in the setting of hw_enc_features that
makes it appears that X550 uniquely has more encapsulation features
than other devices. The driver only supports one more feature, so
make it look that way. No longer set NETIF_F_SG since that is set
by the register_netdev call. Thanks to Alex Duyck for noticing this
slight confusion.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Changes in V2:
- Leave |= in place, just in case allocating a netdev ever sets anything
- No longer set NETIF_F_SG, since that gets set by the register_netdev call
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 4ef5b63b2543..7be000573dc1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9015,8 +9015,7 @@ skip_sriov:
 	netdev->vlan_features |= NETIF_F_IPV6_CSUM;
 	netdev->vlan_features |= NETIF_F_SG;
 
-	netdev->hw_enc_features |= NETIF_F_SG | NETIF_F_IP_CSUM |
-				   NETIF_F_IPV6_CSUM;
+	netdev->hw_enc_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
@@ -9025,9 +9024,7 @@ skip_sriov:
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

