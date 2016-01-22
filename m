From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 21 Jan 2016 16:28:11 -0800
Subject: [Intel-wired-lan] [next PATCH v2 12/15] i40e: Fix ATR in relation
	to tunnels
In-Reply-To: <20160122002407.18278.95721.stgit@localhost.localdomain>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
Message-ID: <20160122002811.18278.62265.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch contains a number of fixes to make certain that we are using
the correct protocols when parsing both the inner and outer headers of a
frame that is mixed between IPv4 and IPv6 for inner and outer.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 34dfa79e76db..5a8db8de7675 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2045,6 +2045,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int hlen;
 	u32 flex_ptype, dtype_cmd;
+	u8 l4_proto;
 	u16 i;
 
 	/* make sure ATR is enabled */
@@ -2058,6 +2059,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!tx_ring->atr_sample_rate)
 		return;
 
+	/* Currently only IPv4/IPv6 with TCP is supported */
 	if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
 		return;
 
@@ -2068,26 +2070,19 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		/* snag network header to get L4 type and address */
 		hdr.network = skb_network_header(skb);
 
-		/* Currently only IPv4/IPv6 with TCP is supported
-		 * access ihl as u8 to avoid unaligned access on ia64
-		 */
+		/* access ihl as u8 to avoid unaligned access on ia64 */
 		if (tx_flags & I40E_TX_FLAGS_IPV4)
 			hlen = (hdr.network[0] & 0x0F) << 2;
-		else if (protocol == htons(ETH_P_IPV6))
-			hlen = sizeof(struct ipv6hdr);
 		else
-			return;
+			hlen = sizeof(struct ipv6hdr);
 	}
 
-	/* Currently only IPv4/IPv6 with TCP is supported
-	 * Note: tx_flags gets modified to reflect inner protocols in
+	/* Note: tx_flags gets modified to reflect inner protocols in
 	 * tx_enable_csum function if encap is enabled.
 	 */
-	if ((tx_flags & I40E_TX_FLAGS_IPV4) &&
-	    (hdr.ipv4->protocol != IPPROTO_TCP))
-		return;
-	else if ((tx_flags & I40E_TX_FLAGS_IPV6) &&
-		 (hdr.ipv6->nexthdr != IPPROTO_TCP))
+	l4_proto = (tx_flags & I40E_TX_FLAGS_IPV4) ? hdr.ipv4->protocol :
+						     hdr.ipv6->nexthdr;
+	if (l4_proto != IPPROTO_TCP)
 		return;
 
 	th = (struct tcphdr *)(hdr.network + hlen);
@@ -2124,7 +2119,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	flex_ptype = (tx_ring->queue_index << I40E_TXD_FLTR_QW0_QINDEX_SHIFT) &
 		      I40E_TXD_FLTR_QW0_QINDEX_MASK;
-	flex_ptype |= (protocol == htons(ETH_P_IP)) ?
+	flex_ptype |= (tx_flags & I40E_TX_FLAGS_IPV4) ?
 		      (I40E_FILTER_PCTYPE_NONF_IPV4_TCP <<
 		       I40E_TXD_FLTR_QW0_PCTYPE_SHIFT) :
 		      (I40E_FILTER_PCTYPE_NONF_IPV6_TCP <<

