From: Alexander Duyck <aduyck@mirantis.com>
Date: Sun, 24 Jan 2016 21:16:35 -0800
Subject: [Intel-wired-lan] [next PATCH v3 04/15] i40e/i40evf: Consolidate
 all header changes into TSO function
In-Reply-To: <20160125050602.12004.38884.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
Message-ID: <20160125051635.12004.43998.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch goes through and pulls all of the spots where we were updating
either the TCP or IP checksums in the TSO and checksum path into the TSO
function.  The general idea here is that we should only be updating the
header after we verify we have completed a skb_cow_head check to verify the
head is writable.

One other advantage to doing this is that it makes things much more
obvious.  For example, in the case of IPv6 there was one spot where the
offset of the IPv4 header checksum was being updated which is obviously
incorrect.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   44 +++++++++++++++----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   44 +++++++++++++++----------
 2 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b09859e55996..c84ba5d4634a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2268,8 +2268,11 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
 {
 	u64 cd_cmd, cd_tso_len, cd_mss;
-	struct ipv6hdr *ipv6h;
-	struct iphdr *iph;
+	union {
+		struct iphdr *v4;
+		struct ipv6hdr *v6;
+		unsigned char *hdr;
+	} ip;
 	union {
 		struct tcphdr *tcp;
 		unsigned char *hdr;
@@ -2287,16 +2290,29 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (err < 0)
 		return err;
 
-	iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
-	ipv6h = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
-	l4.hdr = skb->encapsulation ? skb_inner_transport_header(skb) :
-				      skb_transport_header(skb);
+	ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_transport_header(skb);
 
-	if (iph->version == 4) {
-		iph->tot_len = 0;
-		iph->check = 0;
+	/* initialize outer IP header fields */
+	if (ip.v4->version == 4) {
+		ip.v4->tot_len = 0;
+		ip.v4->check = 0;
 	} else {
-		ipv6h->payload_len = 0;
+		ip.v6->payload_len = 0;
+	}
+
+	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL | SKB_GSO_GRE)) {
+		/* reset pointers to inner headers */
+		ip.hdr = skb_inner_network_header(skb);
+		l4.hdr = skb_inner_transport_header(skb);
+
+		/* initialize inner IP header fields */
+		if (ip.v4->version == 4) {
+			ip.v4->tot_len = 0;
+			ip.v4->check = 0;
+		} else {
+			ip.v6->payload_len = 0;
+		}
 	}
 
 	/* determine offset of inner transport header */
@@ -2381,15 +2397,11 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 	struct iphdr *this_ip_hdr;
 	u32 network_hdr_len;
 	u8 l4_hdr = 0;
-	struct udphdr *oudph = NULL;
-	struct iphdr *oiph = NULL;
 	u32 l4_tunnel = 0;
 
 	if (skb->encapsulation) {
 		switch (ip_hdr(skb)->protocol) {
 		case IPPROTO_UDP:
-			oudph = udp_hdr(skb);
-			oiph = ip_hdr(skb);
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
@@ -2408,15 +2420,12 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
 			if (*tx_flags & I40E_TX_FLAGS_TSO) {
 				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
-				ip_hdr(skb)->check = 0;
 			} else {
 				*cd_tunneling |=
 					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
 			}
 		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
 			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
-			if (*tx_flags & I40E_TX_FLAGS_TSO)
-				ip_hdr(skb)->check = 0;
 		}
 
 		/* Now set the ctx descriptor fields */
@@ -2445,7 +2454,6 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		 */
 		if (*tx_flags & I40E_TX_FLAGS_TSO) {
 			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
-			this_ip_hdr->check = 0;
 		} else {
 			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
 		}
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index b0dc21af3cc8..1b2788093425 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1528,8 +1528,11 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
 {
 	u64 cd_cmd, cd_tso_len, cd_mss;
-	struct ipv6hdr *ipv6h;
-	struct iphdr *iph;
+	union {
+		struct iphdr *v4;
+		struct ipv6hdr *v6;
+		unsigned char *hdr;
+	} ip;
 	union {
 		struct tcphdr *tcp;
 		unsigned char *hdr;
@@ -1547,16 +1550,29 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (err < 0)
 		return err;
 
-	iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
-	ipv6h = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
-	l4.hdr = skb->encapsulation ? skb_inner_transport_header(skb) :
-				      skb_transport_header(skb);
+	ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_transport_header(skb);
 
-	if (iph->version == 4) {
-		iph->tot_len = 0;
-		iph->check = 0;
+	/* initialize outer IP header fields */
+	if (ip.v4->version == 4) {
+		ip.v4->tot_len = 0;
+		ip.v4->check = 0;
 	} else {
-		ipv6h->payload_len = 0;
+		ip.v6->payload_len = 0;
+	}
+
+	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL | SKB_GSO_GRE)) {
+		/* reset pointers to inner headers */
+		ip.hdr = skb_inner_network_header(skb);
+		l4.hdr = skb_inner_transport_header(skb);
+
+		/* initialize inner IP header fields */
+		if (ip.v4->version == 4) {
+			ip.v4->tot_len = 0;
+			ip.v4->check = 0;
+		} else {
+			ip.v6->payload_len = 0;
+		}
 	}
 
 	/* determine offset of inner transport header */
@@ -1598,15 +1614,11 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 	struct iphdr *this_ip_hdr;
 	u32 network_hdr_len;
 	u8 l4_hdr = 0;
-	struct udphdr *oudph;
-	struct iphdr *oiph;
 	u32 l4_tunnel = 0;
 
 	if (skb->encapsulation) {
 		switch (ip_hdr(skb)->protocol) {
 		case IPPROTO_UDP:
-			oudph = udp_hdr(skb);
-			oiph = ip_hdr(skb);
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
@@ -1621,15 +1633,12 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
 			if (*tx_flags & I40E_TX_FLAGS_TSO) {
 				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
-				ip_hdr(skb)->check = 0;
 			} else {
 				*cd_tunneling |=
 					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
 			}
 		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
 			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
-			if (*tx_flags & I40E_TX_FLAGS_TSO)
-				ip_hdr(skb)->check = 0;
 		}
 
 		/* Now set the ctx descriptor fields */
@@ -1659,7 +1668,6 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		 */
 		if (*tx_flags & I40E_TX_FLAGS_TSO) {
 			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
-			this_ip_hdr->check = 0;
 		} else {
 			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
 		}

