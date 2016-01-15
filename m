From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 14 Jan 2016 20:42:03 -0800
Subject: [Intel-wired-lan] [next PATCH 2/3] i40e: Refactor Tx checksum
	offload
In-Reply-To: <20160115043921.24270.62791.stgit@localhost.localdomain>
References: <20160115043921.24270.62791.stgit@localhost.localdomain>
Message-ID: <20160115044203.24270.75723.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is meant to clean up a number of bugs in the Tx checksum offload
for the i40e driver.  The main issues all tend to be in the area of IPv6.

1.  IPv6 tunnel offloads not advertised
2.  IPv6 extension headers not skipped
3.  Use of iphdr(skb)->protocol in checksum path for IPv6
4.  Tx flags not reset when going from V6 to V4 for offloads

Specifically this driver was not offloading IPv6 under a number of
circumstances, and in some cases such as IPv4 over an IPv6 based VXLAN
tunnel it would fail outright to send any valid data.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  193 ++++++++++++++++-----------
 2 files changed, 115 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c21ad853d72f..a15ab5fd3bd7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9017,7 +9017,9 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	np->vsi = vsi;
 
 	netdev->hw_enc_features |= NETIF_F_IP_CSUM	       |
+				   NETIF_F_IPV6_CSUM	       |
 				   NETIF_F_TSO		       |
+				   NETIF_F_TSO6		       |
 				   NETIF_F_TSO_ECN	       |
 				   NETIF_F_GSO_GRE	       |
 				   NETIF_F_GSO_UDP_TUNNEL      |
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ac2fa7b02e94..60005356e65b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2337,122 +2337,152 @@ no_timestamp:
  * @tx_ring: Tx descriptor ring
  * @cd_tunneling: ptr to context desc bits
  **/
-static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
-				u32 *td_cmd, u32 *td_offset,
-				struct i40e_ring *tx_ring,
-				u32 *cd_tunneling)
+static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
+			       u32 *td_cmd, u32 *td_offset,
+			       struct i40e_ring *tx_ring,
+			       u32 *cd_tunneling)
 {
-	struct ipv6hdr *this_ipv6_hdr;
-	unsigned int this_tcp_hdrlen;
-	struct iphdr *this_ip_hdr;
-	u32 network_hdr_len;
-	u8 l4_hdr = 0;
-	struct udphdr *oudph;
-	struct iphdr *oiph;
-	u32 l4_tunnel = 0;
+	union {
+		struct iphdr *v4;
+		struct ipv6hdr *v6;
+		unsigned char *hdr;
+	} ip;
+	union {
+		struct tcphdr *tcp;
+		struct udphdr *udp;
+		unsigned char *hdr;
+	} l4;
+	unsigned char *exthdr;
+	u32 offset, cmd = 0, tunnel = 0;
+	__be16 frag_off;
+	u8 l4_proto = 0;
+
+	ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_transport_header(skb);
+
+	/* words in MACLEN + dwords in IPLEN + dwords in L4Len */
+	offset = ((ip.hdr - skb->data) / 2) <<
+		 I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
 
 	if (skb->encapsulation) {
-		switch (ip_hdr(skb)->protocol) {
+		/* define outer network header type */
+		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
+			tunnel |= (*tx_flags & I40E_TX_FLAGS_TSO) ?
+				  I40E_TX_CTX_EXT_IP_IPV4 :
+				  I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
+
+			l4_proto = ip.v4->protocol;
+		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
+			tunnel |= I40E_TX_CTX_EXT_IP_IPV6;
+
+			exthdr = ip.hdr + sizeof(*ip.v6);
+			l4_proto = ip.v6->nexthdr;
+			if (l4.hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data,
+						 &l4_proto, &frag_off);
+		}
+
+		/* compute outer L3 header size */
+		tunnel |= ((l4.hdr - ip.hdr) / 4) <<
+			  I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT;
+
+		/* switch IP header pointer from outer to inner header */
+		ip.hdr = skb_inner_network_header(skb);
+
+		/* define outer transport */
+		switch (l4_proto) {
 		case IPPROTO_UDP:
-			oudph = udp_hdr(skb);
-			oiph = ip_hdr(skb);
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
-			return;
-		}
-		network_hdr_len = skb_inner_network_header_len(skb);
-		this_ip_hdr = inner_ip_hdr(skb);
-		this_ipv6_hdr = inner_ipv6_hdr(skb);
-		this_tcp_hdrlen = inner_tcp_hdrlen(skb);
+			if (*tx_flags & I40E_TX_FLAGS_TSO)
+				return -1;
 
-		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
-			if (*tx_flags & I40E_TX_FLAGS_TSO) {
-				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
-			} else {
-				*cd_tunneling |=
-					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
-			}
-		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
+			skb_checksum_help(skb);
+			return 0;
 		}
 
-		/* Now set the ctx descriptor fields */
-		*cd_tunneling |= (skb_network_header_len(skb) >> 2) <<
-				   I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT      |
-				   l4_tunnel                             |
-				   ((skb_inner_network_offset(skb) -
-					skb_transport_offset(skb)) >> 1) <<
-				   I40E_TXD_CTX_QW0_NATLEN_SHIFT;
-		if (this_ip_hdr->version == 6) {
-			*tx_flags &= ~I40E_TX_FLAGS_IPV4;
-			*tx_flags |= I40E_TX_FLAGS_IPV6;
-		}
+		/* compute tunnel header size */
+		tunnel |= ((ip.hdr - l4.hdr) / 2) <<
+			  I40E_TXD_CTX_QW0_NATLEN_SHIFT;
+
+		/* switch L4 header pointer from outer to inner */
+		l4.hdr = skb_inner_transport_header(skb);
+
 		/* indicate if we need to offload outer UDP header */
 		if ((*tx_flags & I40E_TX_FLAGS_TSO) &&
 		    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM))
-			*cd_tunneling |= I40E_TXD_CTX_QW0_L4T_CS_MASK;
+			tunnel |= I40E_TXD_CTX_QW0_L4T_CS_MASK;
 
-	} else {
-		network_hdr_len = skb_network_header_len(skb);
-		this_ip_hdr = ip_hdr(skb);
-		this_ipv6_hdr = ipv6_hdr(skb);
-		this_tcp_hdrlen = tcp_hdrlen(skb);
+		/* reset type as we transition from outer to inner headers */
+		*tx_flags &= ~(I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6);
+		if (ip.v4->version == 4)
+			*tx_flags |= I40E_TX_FLAGS_IPV4;
+		if (ip.v6->version == 6)
+			*tx_flags |= I40E_TX_FLAGS_IPV6;
+
+		/* record tunnel offload values */
+		*cd_tunneling |= tunnel;
 	}
 
 	/* Enable IP checksum offloads */
 	if (*tx_flags & I40E_TX_FLAGS_IPV4) {
-		l4_hdr = this_ip_hdr->protocol;
 		/* the stack computes the IP header already, the only time we
 		 * need the hardware to recompute it is in the case of TSO.
 		 */
-		if (*tx_flags & I40E_TX_FLAGS_TSO) {
-			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
-		} else {
-			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
-		}
-		/* Now set the td_offset for IP header length */
-		*td_offset = (network_hdr_len >> 2) <<
-			      I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
+		cmd |= (*tx_flags & I40E_TX_FLAGS_TSO) ?
+		       I40E_TX_DESC_CMD_IIPT_IPV4_CSUM :
+		       I40E_TX_DESC_CMD_IIPT_IPV4;
+
+		l4_proto = ip.v4->protocol;
 	} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-		l4_hdr = this_ipv6_hdr->nexthdr;
-		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
-		/* Now set the td_offset for IP header length */
-		*td_offset = (network_hdr_len >> 2) <<
-			      I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
+		cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
+
+		exthdr = ip.hdr + sizeof(*ip.v6);
+		l4_proto = ip.v6->nexthdr;
+		if (l4.hdr != exthdr)
+			ipv6_skip_exthdr(skb, exthdr - skb->data,
+					 &l4_proto, &frag_off);
 	}
-	/* words in MACLEN + dwords in IPLEN + dwords in L4Len */
-	*td_offset |= (skb_network_offset(skb) >> 1) <<
-		       I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
+
+	/* Now set the td_offset for IP header length */
+	offset |= ((l4.hdr - ip.hdr) / 4) << I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
 
 	/* Enable L4 checksum offloads */
-	switch (l4_hdr) {
+	switch (l4_proto) {
 	case IPPROTO_TCP:
 		/* enable checksum offloads */
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_TCP;
-		*td_offset |= (this_tcp_hdrlen >> 2) <<
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
-		break;
+		if (*tx_flags & I40E_TX_FLAGS_TSO)
+			return -1;
+		skb_checksum_help(skb);
+		return 0;
 	}
+
+	*td_cmd |= cmd;
+	*td_offset |= offset;
+
+	return 1;
 }
 
 /**
@@ -2890,10 +2920,13 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 
 	/* Always offload the checksum, since it's in the data descriptor */
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		tx_flags |= I40E_TX_FLAGS_CSUM;
+		tso = i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
+					  tx_ring, &cd_tunneling);
+		if (tso < 0)
+			goto out_drop;
+		else if (tso)
+			tx_flags |= I40E_TX_FLAGS_CSUM;
 
-		i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
-				    tx_ring, &cd_tunneling);
 	}
 
 	i40e_create_tx_ctx(tx_ring, cd_type_cmd_tso_mss,

