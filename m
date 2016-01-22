From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 21 Jan 2016 16:28:05 -0800
Subject: [Intel-wired-lan] [next PATCH v2 11/15] i40e/i40evf: Enable support
 for SKB_GSO_UDP_TUNNEL_CSUM
In-Reply-To: <20160122002407.18278.95721.stgit@localhost.localdomain>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
Message-ID: <20160122002805.18278.7581.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The XL722 has support for providing the outer UDP tunnel checksum on
transmits.  Make use of this feature to support segmenting UDP tunnels with
outer checksums enabled.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   19 ++++++++++++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   19 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 40a4fca627d5..34dfa79e76db 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2272,6 +2272,7 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	} ip;
 	union {
 		struct tcphdr *tcp;
+		struct udphdr *udp;
 		unsigned char *hdr;
 	} l4;
 	u32 paylen, l4_offset;
@@ -2298,7 +2299,18 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		ip.v6->payload_len = 0;
 	}
 
-	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL | SKB_GSO_GRE)) {
+	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL | SKB_GSO_GRE |
+					 SKB_GSO_UDP_TUNNEL_CSUM)) {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
+			/* determine offset of outer transport header */
+			l4_offset = l4.hdr - skb->data;
+
+			/* remove payload length from outer checksum */
+			paylen = (__force u16)l4.udp->check;
+			paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
+			l4.udp->check = ~csum_fold((__force __wsum)paylen);
+		}
+
 		/* reset pointers to inner headers */
 		ip.hdr = skb_inner_network_header(skb);
 		l4.hdr = skb_inner_transport_header(skb);
@@ -2458,6 +2470,11 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		tunnel |= ((ip.hdr - l4.hdr) / 2) <<
 			  I40E_TXD_CTX_QW0_NATLEN_SHIFT;
 
+		/* indicate if we need to offload outer UDP header */
+		if ((*tx_flags & I40E_TX_FLAGS_TSO) &&
+		    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM))
+			tunnel |= I40E_TXD_CTX_QW0_L4T_CS_MASK;
+
 		/* record tunnel offload values */
 		*cd_tunneling |= tunnel;
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index f1036845072b..ec4e008c7529 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1532,6 +1532,7 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	} ip;
 	union {
 		struct tcphdr *tcp;
+		struct udphdr *udp;
 		unsigned char *hdr;
 	} l4;
 	u32 paylen, l4_offset;
@@ -1558,7 +1559,18 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		ip.v6->payload_len = 0;
 	}
 
-	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL | SKB_GSO_GRE)) {
+	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL | SKB_GSO_GRE |
+					 SKB_GSO_UDP_TUNNEL_CSUM)) {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
+			/* determine offset of outer transport header */
+			l4_offset = l4.hdr - skb->data;
+
+			/* remove payload length from outer checksum */
+			paylen = (__force u16)l4.udp->check;
+			paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
+			l4.udp->check = ~csum_fold((__force __wsum)paylen);
+		}
+
 		/* reset pointers to inner headers */
 		ip.hdr = skb_inner_network_header(skb);
 		l4.hdr = skb_inner_transport_header(skb);
@@ -1676,6 +1688,11 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		tunnel |= ((ip.hdr - l4.hdr) / 2) <<
 			  I40E_TXD_CTX_QW0_NATLEN_SHIFT;
 
+		/* indicate if we need to offload outer UDP header */
+		if ((*tx_flags & I40E_TX_FLAGS_TSO) &&
+		    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM))
+			tunnel |= I40E_TXD_CTX_QW0_L4T_CS_MASK;
+
 		/* record tunnel offload values */
 		*cd_tunneling |= tunnel;
 

