From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 19 Apr 2016 15:06:03 -0400
Subject: [Intel-wired-lan] [RFC PATCH 2/5] mlx5: Add support for UDP tunnel
 segmentation with outer checksum offload
In-Reply-To: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
References: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
Message-ID: <20160419190603.11723.31623.stgit@ahduyck-xeon-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch assumes that the mlx5 hardware will ignore existing IPv4/v6
header fields for length and checksum as well as the length and checksum
fields for outer UDP headers.

I have no means of testing this as I do not have any mlx5 hardware but
thought I would submit it as an RFC to see if anyone out there wants to
test this and see if this does in fact enable this functionality allowing
us to to segment UDP tunneled frames that have an outer checksum.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e0adb604f461..57d8da796d50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2390,13 +2390,18 @@ static void mlx5e_build_netdev(struct net_device *netdev)
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	if (mlx5e_vxlan_allowed(mdev)) {
-		netdev->hw_features     |= NETIF_F_GSO_UDP_TUNNEL;
+		netdev->hw_features     |= NETIF_F_GSO_UDP_TUNNEL |
+					   NETIF_F_GSO_UDP_TUNNEL_CSUM |
+					   NETIF_F_GSO_PARTIAL;
 		netdev->hw_enc_features |= NETIF_F_IP_CSUM;
 		netdev->hw_enc_features |= NETIF_F_RXCSUM;
 		netdev->hw_enc_features |= NETIF_F_TSO;
 		netdev->hw_enc_features |= NETIF_F_TSO6;
 		netdev->hw_enc_features |= NETIF_F_RXHASH;
 		netdev->hw_enc_features |= NETIF_F_GSO_UDP_TUNNEL;
+		netdev->hw_enc_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM |
+					   NETIF_F_GSO_PARTIAL;
+		netdev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM;
 	}
 
 	netdev->features          = netdev->hw_features;

