From: Alexander Duyck <aduyck@mirantis.com>
Date: Sun, 24 Jan 2016 21:17:01 -0800
Subject: [Intel-wired-lan] [next PATCH v3 08/15] i40e/i40evf: Do not write
 to descriptor unless we complete
In-Reply-To: <20160125050602.12004.38884.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
Message-ID: <20160125051701.12004.23605.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch defers writing to the Tx descriptor bits until we know we have
successuflly completed a given operation.  So for example we defer updating
the tunnelling portion of the context descriptor until we have fully
identified the type.

The advantage to this approach is that we can assemble values as we go
instead of having to try and cludge everything together all at once.  As a
result we can significantly clean up the tunneling configuration for
instance as we can just do a pointer walk and do the math for the distance
between each set of points.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   81 +++++++++++++------------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   81 +++++++++++++------------
 2 files changed, 84 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2e9ae018d639..713b39f4f6f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2403,25 +2403,26 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		unsigned char *hdr;
 	} l4;
 	unsigned char *exthdr;
-	u32 l4_tunnel = 0;
+	u32 offset, cmd = 0, tunnel = 0;
 	__be16 frag_off;
 	u8 l4_proto = 0;
 
 	ip.hdr = skb_network_header(skb);
 	l4.hdr = skb_transport_header(skb);
 
+	/* compute outer L2 header size */
+	offset = ((ip.hdr - skb->data) / 2) << I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
+
 	if (skb->encapsulation) {
 		/* define outer network header type */
 		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
-			if (*tx_flags & I40E_TX_FLAGS_TSO) {
-				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
-			} else {
-				*cd_tunneling |=
-					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
-			}
+			tunnel |= (*tx_flags & I40E_TX_FLAGS_TSO) ?
+				  I40E_TX_CTX_EXT_IP_IPV4 :
+				  I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
+
 			l4_proto = ip.v4->protocol;
 		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
+			tunnel |= I40E_TX_CTX_EXT_IP_IPV6;
 
 			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
@@ -2430,33 +2431,38 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 						 &l4_proto, &frag_off);
 		}
 
+		/* compute outer L3 header size */
+		tunnel |= ((l4.hdr - ip.hdr) / 4) <<
+			  I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT;
+
+		/* switch IP header pointer from outer to inner header */
+		ip.hdr = skb_inner_network_header(skb);
+
 		/* define outer transport */
 		switch (l4_proto) {
 		case IPPROTO_UDP:
-			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
+			tunnel |= I40E_TXD_CTX_UDP_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		case IPPROTO_GRE:
-			l4_tunnel = I40E_TXD_CTX_GRE_TUNNELING;
+			tunnel |= I40E_TXD_CTX_GRE_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		default:
 			return;
 		}
 
+		/* compute tunnel header size */
+		tunnel |= ((ip.hdr - l4.hdr) / 2) <<
+			  I40E_TXD_CTX_QW0_NATLEN_SHIFT;
+
+		/* record tunnel offload values */
+		*cd_tunneling |= tunnel;
+
 		/* switch L4 header pointer from outer to inner */
-		ip.hdr = skb_inner_network_header(skb);
 		l4.hdr = skb_inner_transport_header(skb);
 		l4_proto = 0;
 
-		/* Now set the ctx descriptor fields */
-		*cd_tunneling |= (skb_network_header_len(skb) >> 2) <<
-				   I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT      |
-				   l4_tunnel                             |
-				   ((skb_inner_network_offset(skb) -
-					skb_transport_offset(skb)) >> 1) <<
-				   I40E_TXD_CTX_QW0_NATLEN_SHIFT;
-
 		/* reset type as we transition from outer to inner headers */
 		*tx_flags &= ~(I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6);
 		if (ip.v4->version == 4)
@@ -2471,13 +2477,11 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		/* the stack computes the IP header already, the only time we
 		 * need the hardware to recompute it is in the case of TSO.
 		 */
-		if (*tx_flags & I40E_TX_FLAGS_TSO) {
-			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
-		} else {
-			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
-		}
+		cmd |= (*tx_flags & I40E_TX_FLAGS_TSO) ?
+		       I40E_TX_DESC_CMD_IIPT_IPV4_CSUM :
+		       I40E_TX_DESC_CMD_IIPT_IPV4;
 	} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
+		cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
 
 		exthdr = ip.hdr + sizeof(*ip.v6);
 		l4_proto = ip.v6->nexthdr;
@@ -2486,35 +2490,34 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 					 &l4_proto, &frag_off);
 	}
 
-	/* Now set the td_offset for IP header length */
-	*td_offset = ((l4.hdr - ip.hdr) / 4) << I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
-	/* words in MACLEN + dwords in IPLEN + dwords in L4Len */
-	*td_offset |= (skb_network_offset(skb) >> 1) <<
-		       I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
+	/* compute inner L3 header size */
+	offset |= ((l4.hdr - ip.hdr) / 4) << I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
 
 	/* Enable L4 checksum offloads */
 	switch (l4_proto) {
 	case IPPROTO_TCP:
 		/* enable checksum offloads */
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_TCP;
-		*td_offset |= l4.tcp->doff <<
-			       I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+		cmd |= I40E_TX_DESC_CMD_L4T_EOFT_TCP;
+		offset |= l4.tcp->doff << I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	case IPPROTO_SCTP:
 		/* enable SCTP checksum offload */
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_SCTP;
-		*td_offset |= (sizeof(struct sctphdr) >> 2) <<
-			       I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+		cmd |= I40E_TX_DESC_CMD_L4T_EOFT_SCTP;
+		offset |= (sizeof(struct sctphdr) >> 2) <<
+			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	case IPPROTO_UDP:
 		/* enable UDP checksum offload */
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_UDP;
-		*td_offset |= (sizeof(struct udphdr) >> 2) <<
-			       I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+		cmd |= I40E_TX_DESC_CMD_L4T_EOFT_UDP;
+		offset |= (sizeof(struct udphdr) >> 2) <<
+			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
 		break;
 	}
+
+	*td_cmd |= cmd;
+	*td_offset |= offset;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index d37cba28ecfa..35aa07f8b9da 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1620,25 +1620,26 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		unsigned char *hdr;
 	} l4;
 	unsigned char *exthdr;
-	u32 l4_tunnel = 0;
+	u32 offset, cmd = 0, tunnel = 0;
 	__be16 frag_off;
 	u8 l4_proto = 0;
 
 	ip.hdr = skb_network_header(skb);
 	l4.hdr = skb_transport_header(skb);
 
+	/* compute outer L2 header size */
+	offset = ((ip.hdr - skb->data) / 2) << I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
+
 	if (skb->encapsulation) {
 		/* define outer network header type */
 		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
-			if (*tx_flags & I40E_TX_FLAGS_TSO) {
-				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
-			} else {
-				*cd_tunneling |=
-					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
-			}
+			tunnel |= (*tx_flags & I40E_TX_FLAGS_TSO) ?
+				  I40E_TX_CTX_EXT_IP_IPV4 :
+				  I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
+
 			l4_proto = ip.v4->protocol;
 		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
+			tunnel |= I40E_TX_CTX_EXT_IP_IPV6;
 
 			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
@@ -1647,33 +1648,38 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 						 &l4_proto, &frag_off);
 		}
 
+		/* compute outer L3 header size */
+		tunnel |= ((l4.hdr - ip.hdr) / 4) <<
+			  I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT;
+
+		/* switch IP header pointer from outer to inner header */
+		ip.hdr = skb_inner_network_header(skb);
+
 		/* define outer transport */
 		switch (l4_proto) {
 		case IPPROTO_UDP:
-			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
+			tunnel |= I40E_TXD_CTX_UDP_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		case IPPROTO_GRE:
-			l4_tunnel = I40E_TXD_CTX_GRE_TUNNELING;
+			tunnel |= I40E_TXD_CTX_GRE_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		default:
 			return;
 		}
 
+		/* compute tunnel header size */
+		tunnel |= ((ip.hdr - l4.hdr) / 2) <<
+			  I40E_TXD_CTX_QW0_NATLEN_SHIFT;
+
+		/* record tunnel offload values */
+		*cd_tunneling |= tunnel;
+
 		/* switch L4 header pointer from outer to inner */
-		ip.hdr = skb_inner_network_header(skb);
 		l4.hdr = skb_inner_transport_header(skb);
 		l4_proto = 0;
 
-		/* Now set the ctx descriptor fields */
-		*cd_tunneling |= (skb_network_header_len(skb) >> 2) <<
-				   I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT      |
-				   l4_tunnel                             |
-				   ((skb_inner_network_offset(skb) -
-					skb_transport_offset(skb)) >> 1) <<
-				   I40E_TXD_CTX_QW0_NATLEN_SHIFT;
-
 		/* reset type as we transition from outer to inner headers */
 		*tx_flags &= ~(I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6);
 		if (ip.v4->version == 4)
@@ -1688,13 +1694,11 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		/* the stack computes the IP header already, the only time we
 		 * need the hardware to recompute it is in the case of TSO.
 		 */
-		if (*tx_flags & I40E_TX_FLAGS_TSO) {
-			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
-		} else {
-			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
-		}
+		cmd |= (*tx_flags & I40E_TX_FLAGS_TSO) ?
+		       I40E_TX_DESC_CMD_IIPT_IPV4_CSUM :
+		       I40E_TX_DESC_CMD_IIPT_IPV4;
 	} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
+		cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
 
 		exthdr = ip.hdr + sizeof(*ip.v6);
 		l4_proto = ip.v6->nexthdr;
@@ -1703,35 +1707,34 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 					 &l4_proto, &frag_off);
 	}
 
-	/* Now set the td_offset for IP header length */
-	*td_offset = ((l4.hdr - ip.hdr) / 4) << I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
-	/* words in MACLEN + dwords in IPLEN + dwords in L4Len */
-	*td_offset |= (skb_network_offset(skb) >> 1) <<
-		       I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
+	/* compute inner L3 header size */
+	offset |= ((l4.hdr - ip.hdr) / 4) << I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
 
 	/* Enable L4 checksum offloads */
 	switch (l4_proto) {
 	case IPPROTO_TCP:
 		/* enable checksum offloads */
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_TCP;
-		*td_offset |= l4.tcp->doff <<
-			       I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+		cmd |= I40E_TX_DESC_CMD_L4T_EOFT_TCP;
+		offset |= l4.tcp->doff << I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	case IPPROTO_SCTP:
 		/* enable SCTP checksum offload */
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_SCTP;
-		*td_offset |= (sizeof(struct sctphdr) >> 2) <<
-			       I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+		cmd |= I40E_TX_DESC_CMD_L4T_EOFT_SCTP;
+		offset |= (sizeof(struct sctphdr) >> 2) <<
+			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	case IPPROTO_UDP:
 		/* enable UDP checksum offload */
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_UDP;
-		*td_offset |= (sizeof(struct udphdr) >> 2) <<
-			       I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+		cmd |= I40E_TX_DESC_CMD_L4T_EOFT_UDP;
+		offset |= (sizeof(struct udphdr) >> 2) <<
+			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
 		break;
 	}
+
+	*td_cmd |= cmd;
+	*td_offset |= offset;
 }
 
 /**

