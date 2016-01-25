From: Alexander Duyck <aduyck@mirantis.com>
Date: Sun, 24 Jan 2016 21:16:28 -0800
Subject: [Intel-wired-lan] [next PATCH v3 03/15] i40e/i40evf: Factor out L4
 header and checksum from L3 bits in TSO path
In-Reply-To: <20160125050602.12004.38884.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
Message-ID: <20160125051628.12004.51971.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch makes it so that the L4 header offsets and such can be ignored
when dealing with the L3 checksum and length update.  This is done making
use of two things.

First we can just use the offset from the L4 header to the start of the
packet to determine the L4 offset, and from that we can then make use of
the data offset to determine the full length of the headers.

As far as adjusting the checksum to remove the length we can simply add the
inverse of the length instead of having to recompute the entire
pseudo-header without the length.  In the case of an IPv6 header this
should be significantly cheaper since we can make use of a value we already
needed instead of having to read the source and destination address out of
the packet.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   31 +++++++++++++++----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   31 +++++++++++++++----------
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d201bedaca27..b09859e55996 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2269,9 +2269,12 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 {
 	u64 cd_cmd, cd_tso_len, cd_mss;
 	struct ipv6hdr *ipv6h;
-	struct tcphdr *tcph;
 	struct iphdr *iph;
-	u32 l4len;
+	union {
+		struct tcphdr *tcp;
+		unsigned char *hdr;
+	} l4;
+	u32 paylen, l4_offset;
 	int err;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
@@ -2286,24 +2289,26 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
 	ipv6h = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
+	l4.hdr = skb->encapsulation ? skb_inner_transport_header(skb) :
+				      skb_transport_header(skb);
 
 	if (iph->version == 4) {
-		tcph = skb->encapsulation ? inner_tcp_hdr(skb) : tcp_hdr(skb);
 		iph->tot_len = 0;
 		iph->check = 0;
-		tcph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
-						 0, IPPROTO_TCP, 0);
-	} else if (ipv6h->version == 6) {
-		tcph = skb->encapsulation ? inner_tcp_hdr(skb) : tcp_hdr(skb);
+	} else {
 		ipv6h->payload_len = 0;
-		tcph->check = ~csum_ipv6_magic(&ipv6h->saddr, &ipv6h->daddr,
-					       0, IPPROTO_TCP, 0);
 	}
 
-	l4len = skb->encapsulation ? inner_tcp_hdrlen(skb) : tcp_hdrlen(skb);
-	*hdr_len = (skb->encapsulation
-		    ? (skb_inner_transport_header(skb) - skb->data)
-		    : skb_transport_offset(skb)) + l4len;
+	/* determine offset of inner transport header */
+	l4_offset = l4.hdr - skb->data;
+
+	/* remove payload length from inner checksum */
+	paylen = (__force u16)l4.tcp->check;
+	paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
+	l4.tcp->check = ~csum_fold((__force __wsum)paylen);
+
+	/* compute length of segmentation header */
+	*hdr_len = (l4.tcp->doff * 4) + l4_offset;
 
 	/* find the field values */
 	cd_cmd = I40E_TX_CTX_DESC_TSO;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 07d6b5d5a2ae..b0dc21af3cc8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1529,9 +1529,12 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 {
 	u64 cd_cmd, cd_tso_len, cd_mss;
 	struct ipv6hdr *ipv6h;
-	struct tcphdr *tcph;
 	struct iphdr *iph;
-	u32 l4len;
+	union {
+		struct tcphdr *tcp;
+		unsigned char *hdr;
+	} l4;
+	u32 paylen, l4_offset;
 	int err;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
@@ -1546,24 +1549,26 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
 	ipv6h = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
+	l4.hdr = skb->encapsulation ? skb_inner_transport_header(skb) :
+				      skb_transport_header(skb);
 
 	if (iph->version == 4) {
-		tcph = skb->encapsulation ? inner_tcp_hdr(skb) : tcp_hdr(skb);
 		iph->tot_len = 0;
 		iph->check = 0;
-		tcph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
-						 0, IPPROTO_TCP, 0);
-	} else if (ipv6h->version == 6) {
-		tcph = skb->encapsulation ? inner_tcp_hdr(skb) : tcp_hdr(skb);
+	} else {
 		ipv6h->payload_len = 0;
-		tcph->check = ~csum_ipv6_magic(&ipv6h->saddr, &ipv6h->daddr,
-					       0, IPPROTO_TCP, 0);
 	}
 
-	l4len = skb->encapsulation ? inner_tcp_hdrlen(skb) : tcp_hdrlen(skb);
-	*hdr_len = (skb->encapsulation
-		    ? (skb_inner_transport_header(skb) - skb->data)
-		    : skb_transport_offset(skb)) + l4len;
+	/* determine offset of inner transport header */
+	l4_offset = l4.hdr - skb->data;
+
+	/* remove payload length from inner checksum */
+	paylen = (__force u16)l4.tcp->check;
+	paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
+	l4.tcp->check = ~csum_fold((__force __wsum)paylen);
+
+	/* compute length of segmentation header */
+	*hdr_len = (l4.tcp->doff * 4) + l4_offset;
 
 	/* find the field values */
 	cd_cmd = I40E_TX_CTX_DESC_TSO;

