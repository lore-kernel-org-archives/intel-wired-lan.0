From: Alexander Duyck <aduyck@mirantis.com>
Date: Sun, 24 Jan 2016 21:16:48 -0800
Subject: [Intel-wired-lan] [next PATCH v3 06/15] i40e/i40evf: Add support
 for IPv4 encapsulated in IPv6
In-Reply-To: <20160125050602.12004.38884.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
Message-ID: <20160125051648.12004.64219.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes two issues.  First was the fact that iphdr(skb)->protocl
was being used to test for the outer transport protocol.  This completely
breaks IPv6 support.  Second was the fact that we cleared the flag for v4
going to v6, but we didn't take care of txflags going the other way.  As
such we would have the v6 flag still set even if the inner header was v4.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   38 ++++++++++++++---------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   42 ++++++++++++++++---------
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ef632fd60486..8e723125e31e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2409,7 +2409,22 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 	l4.hdr = skb_transport_header(skb);
 
 	if (skb->encapsulation) {
-		switch (ip_hdr(skb)->protocol) {
+		/* define outer network header type */
+		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
+			if (*tx_flags & I40E_TX_FLAGS_TSO) {
+				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
+			} else {
+				*cd_tunneling |=
+					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
+			}
+			l4_proto = ip.v4->protocol;
+		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
+			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
+			l4_proto = ip.v6->nexthdr;
+		}
+
+		/* define outer transport */
+		switch (l4_proto) {
 		case IPPROTO_UDP:
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
@@ -2425,17 +2440,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		/* switch L4 header pointer from outer to inner */
 		ip.hdr = skb_inner_network_header(skb);
 		l4.hdr = skb_inner_transport_header(skb);
-
-		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
-			if (*tx_flags & I40E_TX_FLAGS_TSO) {
-				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
-			} else {
-				*cd_tunneling |=
-					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
-			}
-		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
-		}
+		l4_proto = 0;
 
 		/* Now set the ctx descriptor fields */
 		*cd_tunneling |= (skb_network_header_len(skb) >> 2) <<
@@ -2444,10 +2449,13 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 				   ((skb_inner_network_offset(skb) -
 					skb_transport_offset(skb)) >> 1) <<
 				   I40E_TXD_CTX_QW0_NATLEN_SHIFT;
-		if (ip.v6->version == 6) {
-			*tx_flags &= ~I40E_TX_FLAGS_IPV4;
+
+		/* reset type as we transition from outer to inner headers */
+		*tx_flags &= ~(I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6);
+		if (ip.v4->version == 4)
+			*tx_flags |= I40E_TX_FLAGS_IPV4;
+		if (ip.v6->version == 6)
 			*tx_flags |= I40E_TX_FLAGS_IPV6;
-		}
 	}
 
 	/* Enable IP checksum offloads */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index b1c8ada663aa..34c7e3ffba1a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1626,11 +1626,30 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 	l4.hdr = skb_transport_header(skb);
 
 	if (skb->encapsulation) {
-		switch (ip_hdr(skb)->protocol) {
+		/* define outer network header type */
+		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
+			if (*tx_flags & I40E_TX_FLAGS_TSO) {
+				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
+			} else {
+				*cd_tunneling |=
+					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
+			}
+			l4_proto = ip.v4->protocol;
+		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
+			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
+			l4_proto = ip.v6->nexthdr;
+		}
+
+		/* define outer transport */
+		switch (l4_proto) {
 		case IPPROTO_UDP:
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
+		case IPPROTO_GRE:
+			l4_tunnel = I40E_TXD_CTX_GRE_TUNNELING;
+			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
+			break;
 		default:
 			return;
 		}
@@ -1638,17 +1657,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		/* switch L4 header pointer from outer to inner */
 		ip.hdr = skb_inner_network_header(skb);
 		l4.hdr = skb_inner_transport_header(skb);
-
-		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
-			if (*tx_flags & I40E_TX_FLAGS_TSO) {
-				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
-			} else {
-				*cd_tunneling |=
-					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
-			}
-		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
-		}
+		l4_proto = 0;
 
 		/* Now set the ctx descriptor fields */
 		*cd_tunneling |= (skb_network_header_len(skb) >> 2) <<
@@ -1657,10 +1666,13 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 				   ((skb_inner_network_offset(skb) -
 					skb_transport_offset(skb)) >> 1) <<
 				   I40E_TXD_CTX_QW0_NATLEN_SHIFT;
-		if (ip.v6->version == 6) {
-			*tx_flags &= ~I40E_TX_FLAGS_IPV4;
+
+		/* reset type as we transition from outer to inner headers */
+		*tx_flags &= ~(I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6);
+		if (ip.v4->version == 4)
+			*tx_flags |= I40E_TX_FLAGS_IPV4;
+		if (ip.v6->version == 6)
 			*tx_flags |= I40E_TX_FLAGS_IPV6;
-		}
 	}
 
 	/* Enable IP checksum offloads */

