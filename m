From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 25 Jan 2016 19:32:54 -0800
Subject: [Intel-wired-lan] [next PATCH 1/3] i40e: Add support for ATR w/
	IPv6 extension headers
In-Reply-To: <20160126032616.16387.86351.stgit@localhost.localdomain>
References: <20160126032616.16387.86351.stgit@localhost.localdomain>
Message-ID: <20160126033124.16387.6402.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch updates the code for determining the L4 protocol and L3 header
length so that when IPv6 extension headers are being used we can determine
the offset and type of the L4 protocol.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Testing Hints:
Test with mix of tunnel and non-tunnel headers to verify that frames
containing IPv6 extension headers are properly triggering ATR match events.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   30 +++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ed8d13637c15..1616a85fd25a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2044,7 +2044,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int hlen;
 	u32 flex_ptype, dtype_cmd;
-	u8 l4_proto;
+	int l4_proto;
 	u16 i;
 
 	/* make sure ATR is enabled */
@@ -2062,25 +2062,23 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
 		return;
 
-	if (tx_flags & I40E_TX_FLAGS_TUNNEL) {
-		hdr.network = skb_inner_network_header(skb);
-		hlen = skb_inner_network_header_len(skb);
-	} else {
-		/* snag network header to get L4 type and address */
-		hdr.network = skb_network_header(skb);
-
-		/* access ihl as u8 to avoid unaligned access on ia64 */
-		if (tx_flags & I40E_TX_FLAGS_IPV4)
-			hlen = (hdr.network[0] & 0x0F) << 2;
-		else
-			hlen = sizeof(struct ipv6hdr);
-	}
+	/* snag network header to get L4 type and address */
+	hdr.network = (tx_flags & I40E_TX_FLAGS_TUNNEL) ?
+		      skb_inner_network_header(skb) : skb_network_header(skb);
 
 	/* Note: tx_flags gets modified to reflect inner protocols in
 	 * tx_enable_csum function if encap is enabled.
 	 */
-	l4_proto = (tx_flags & I40E_TX_FLAGS_IPV4) ? hdr.ipv4->protocol :
-						     hdr.ipv6->nexthdr;
+	if (tx_flags & I40E_TX_FLAGS_IPV4) {
+		/* access ihl as u8 to avoid unaligned access on ia64 */
+		hlen = (hdr.network[0] & 0x0F) << 2;
+		l4_proto = hdr.ipv4->protocol;
+	} else {
+		hlen = hdr.network - skb->data;
+		l4_proto = ipv6_find_hdr(skb, &hlen, IPPROTO_TCP, NULL, NULL);
+		hlen -= hdr.network - skb->data;
+	}
+
 	if (l4_proto != IPPROTO_TCP)
 		return;
 

