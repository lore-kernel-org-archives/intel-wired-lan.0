From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 19 Apr 2016 15:06:21 -0400
Subject: [Intel-wired-lan] [RFC PATCH 5/5] fm10k: Add support for UDP tunnel
 segmentation with outer checksum offload
In-Reply-To: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
References: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
Message-ID: <20160419190621.11723.85385.stgit@ahduyck-xeon-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch assumes that the fm10k hardware will ignore existing IPv4/v6
header fields for length and checksum as well as the length and checksum
fields for outer UDP headers.

I have no means of testing this as I do not have any mlx5 hardware but
thought I would submit it as an RFC to see if anyone out there wants to
test this and see if this does in fact enable this functionality allowing
us to to segment UDP tunneled frames that have an outer checksum.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2a08d3f5b6df..dc4901def72d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1417,15 +1417,21 @@ struct net_device *fm10k_alloc_netdev(const struct fm10k_info *info)
 
 	/* Only the PF can support VXLAN and NVGRE tunnel offloads */
 	if (info->mac == fm10k_mac_pf) {
-		dev->hw_enc_features = NETIF_F_IP_CSUM |
+		dev->hw_enc_features = NETIF_F_SG |
+				       NETIF_F_IP_CSUM |
+				       NETIF_F_IPV6_CSUM |
 				       NETIF_F_TSO |
 				       NETIF_F_TSO6 |
 				       NETIF_F_TSO_ECN |
 				       NETIF_F_GSO_UDP_TUNNEL |
-				       NETIF_F_IPV6_CSUM |
-				       NETIF_F_SG;
+				       NETIF_F_GSO_UDP_TUNNEL_CSUM |
+				       NETIF_F_GSO_PARTIAL;
+
+		dev->features |= NETIF_F_GSO_UDP_TUNNEL |
+				 NETIF_F_GSO_UDP_TUNNEL_CSUM |
+				 NETIF_F_GSO_PARTIAL;
 
-		dev->features |= NETIF_F_GSO_UDP_TUNNEL;
+		dev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM;
 	}
 
 	/* all features defined to this point should be changeable */

