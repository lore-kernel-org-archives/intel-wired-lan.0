From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 03 May 2018 17:39:23 -0700
Subject: [Intel-wired-lan] [RFC PATCH 2/2] ixgbevf: Add support for UDP
 segmentation offload
In-Reply-To: <20180504003556.4769.11407.stgit@localhost.localdomain>
References: <20180504003556.4769.11407.stgit@localhost.localdomain>
Message-ID: <20180504003923.4769.15585.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch adds support for UDP segmentation offload. Relatively few
changes were needed to add this support as it functions much like the TCP
segmentation offload.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   25 ++++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 9a939dcaf727..c2986142c98a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3709,6 +3709,7 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 	} ip;
 	union {
 		struct tcphdr *tcp;
+		struct udphdr *udp;
 		unsigned char *hdr;
 	} l4;
 	u32 paylen, l4_offset;
@@ -3731,7 +3732,8 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 	l4.hdr = skb_checksum_start(skb);
 
 	/* ADV DTYP TUCMD MKRLOC/ISCSIHEDLEN */
-	type_tucmd = IXGBE_ADVTXD_TUCMD_L4T_TCP;
+	type_tucmd = (skb->csum_offset == offsetof(struct tcphdr, check)) ?
+		     IXGBE_ADVTXD_TUCMD_L4T_TCP : IXGBE_ADVTXD_TUCMD_L4T_UDP;
 
 	/* initialize outer IP header fields */
 	if (ip.v4->version == 4) {
@@ -3759,12 +3761,20 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 	/* determine offset of inner transport header */
 	l4_offset = l4.hdr - skb->data;
 
-	/* compute length of segmentation header */
-	*hdr_len = (l4.tcp->doff * 4) + l4_offset;
-
 	/* remove payload length from inner checksum */
 	paylen = skb->len - l4_offset;
-	csum_replace_by_diff(&l4.tcp->check, htonl(paylen));
+
+	if (type_tucmd & IXGBE_ADVTXD_TUCMD_L4T_TCP) {
+		/* compute length of segmentation header */
+		*hdr_len = (l4.tcp->doff * 4) + l4_offset;
+		csum_replace_by_diff(&l4.tcp->check,
+				     (__force __wsum)htonl(paylen));
+	} else {
+		/* compute length of segmentation header */
+		*hdr_len = sizeof(*l4.udp) + l4_offset;
+		csum_replace_by_diff(&l4.udp->check,
+				     (__force __wsum)htonl(paylen));
+	}
 
 	/* update gso size and bytecount with header size */
 	first->gso_segs = skb_shinfo(skb)->gso_segs;
@@ -4368,6 +4378,7 @@ static void ixgbevf_get_stats(struct net_device *netdev,
 	if (unlikely(mac_hdr_len > IXGBEVF_MAX_MAC_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
+				    NETIF_F_GSO_UDP_L4 |
 				    NETIF_F_HW_VLAN_CTAG_TX |
 				    NETIF_F_TSO |
 				    NETIF_F_TSO6);
@@ -4376,6 +4387,7 @@ static void ixgbevf_get_stats(struct net_device *netdev,
 	if (unlikely(network_hdr_len >  IXGBEVF_MAX_NETWORK_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
+				    NETIF_F_GSO_UDP_L4 |
 				    NETIF_F_TSO |
 				    NETIF_F_TSO6);
 
@@ -4571,7 +4583,8 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			      NETIF_F_TSO6 |
 			      NETIF_F_RXCSUM |
 			      NETIF_F_HW_CSUM |
-			      NETIF_F_SCTP_CRC;
+			      NETIF_F_SCTP_CRC |
+			      NETIF_F_GSO_UDP_L4;
 
 #define IXGBEVF_GSO_PARTIAL_FEATURES (NETIF_F_GSO_GRE | \
 				      NETIF_F_GSO_GRE_CSUM | \

