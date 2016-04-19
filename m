From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 19 Apr 2016 15:06:09 -0400
Subject: [Intel-wired-lan] [RFC PATCH 3/5] bnx2x: Add support for
 segmentation of tunnels with outer checksums
In-Reply-To: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
References: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
Message-ID: <20160419190609.11723.8710.stgit@ahduyck-xeon-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch assumes that the bnx2x hardware will ignore existing IPv4/v6
header fields for length and checksum as well as the length and checksum
fields for outer UDP and GRE headers.

I have no means of testing this as I do not have any bnx2x hardware but
thought I would submit it as an RFC to see if anyone out there wants to
test this and see if this does in fact enable this functionality allowing
us to to segment tunneled frames that have an outer checksum.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index d465bd721146..e3459524fb0e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13258,14 +13258,21 @@ static int bnx2x_init_dev(struct bnx2x *bp, struct pci_dev *pdev,
 		NETIF_F_RXCSUM | NETIF_F_LRO | NETIF_F_GRO |
 		NETIF_F_RXHASH | NETIF_F_HW_VLAN_CTAG_TX;
 	if (!chip_is_e1x) {
-		dev->hw_features |= NETIF_F_GSO_GRE | NETIF_F_GSO_UDP_TUNNEL |
-				    NETIF_F_GSO_IPIP | NETIF_F_GSO_SIT;
+		dev->hw_features |= NETIF_F_GSO_GRE | NETIF_F_GSO_GRE_CSUM |
+				    NETIF_F_GSO_IPIP | NETIF_F_GSO_SIT |
+				    NETIF_F_GSO_UDP_TUNNEL |
+				    NETIF_F_GSO_UDP_TUNNEL_CSUM |
+				    NETIF_F_GSO_PARTIAL;
 		dev->hw_enc_features =
 			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SG |
 			NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6 |
 			NETIF_F_GSO_IPIP |
 			NETIF_F_GSO_SIT |
-			NETIF_F_GSO_GRE | NETIF_F_GSO_UDP_TUNNEL;
+			NETIF_F_GSO_GRE | NETIF_F_GSO_GRE_CSUM |
+			NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM |
+			NETIF_F_GSO_PARTIAL;
+		dev->gso_partial_features = NETIF_F_GSO_GRE_CSUM |
+					    NETIF_F_GSO_UDP_TUNNEL_CSUM;
 	}
 
 	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |

