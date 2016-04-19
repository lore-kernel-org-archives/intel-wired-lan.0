From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 19 Apr 2016 15:06:15 -0400
Subject: [Intel-wired-lan] [RFC PATCH 4/5] bnxt: Add support for
 segmentation of tunnels with outer checksums
In-Reply-To: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
References: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
Message-ID: <20160419190615.11723.53966.stgit@ahduyck-xeon-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch assumes that the bnxt hardware will ignore existing IPv4/v6
header fields for length and checksum as well as the length and checksum
fields for outer UDP and GRE headers.

I have no means of testing this as I do not have any bnx2x hardware but
thought I would submit it as an RFC to see if anyone out there wants to
test this and see if this does in fact enable this functionality allowing
us to to segment tunneled frames that have an outer checksum.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4645c44e7c15..ae668476fff0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6194,14 +6194,19 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   NETIF_F_TSO | NETIF_F_TSO6 |
 			   NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_GRE |
 			   NETIF_F_GSO_IPIP | NETIF_F_GSO_SIT |
-			   NETIF_F_RXHASH |
+			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
+			   NETIF_F_GSO_PARTIAL | NETIF_F_RXHASH |
 			   NETIF_F_RXCSUM | NETIF_F_LRO | NETIF_F_GRO;
 
 	dev->hw_enc_features =
 			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SG |
 			NETIF_F_TSO | NETIF_F_TSO6 |
 			NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_GRE |
-			NETIF_F_GSO_IPIP | NETIF_F_GSO_SIT;
+			NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
+			NETIF_F_GSO_IPIP | NETIF_F_GSO_SIT |
+			NETIF_F_GSO_PARTIAL;
+	dev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM |
+				    NETIF_F_GSO_GRE_CSUM;
 	dev->vlan_features = dev->hw_features | NETIF_F_HIGHDMA;
 	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_STAG_RX | NETIF_F_HW_VLAN_STAG_TX;

