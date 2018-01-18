From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 17 Jan 2018 21:33:06 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix ipv6 support for ipsec offload
Message-ID: <1516253586-7261-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix up the Rx path to watch for and decode ipv6 headers that might be
carrying ipsec headers.  To do so, we first change the search function
to be able to take both ipv4 and ipv6 addresses from a pointer, and add
an argument that tells which we are using.  Then in the Rx handler we
add a check for ipv4 vs ipv6 and then parse the headers accordingly.
We can assume simple headers because this device won't decode packets
with vlan or with ipv4/ipv6 extensions.

We also change a flag used in the ...add_sa() function as it seems the
XFRM stack doesn't actually ever set the XFRM_OFFLOAD_IPV6 flag bit.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 39 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 587fd8f..93eacdd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -379,12 +379,13 @@ static int ixgbe_ipsec_find_empty_idx(struct ixgbe_ipsec *ipsec, bool rxtable)
  * @daddr: inbound address to match
  * @proto: protocol to match
  * @spi: SPI to match
+ * @ip4: true if using an ipv4 address
  *
  * Returns a pointer to the matching SA state information
  **/
 static struct xfrm_state *ixgbe_ipsec_find_rx_state(struct ixgbe_ipsec *ipsec,
-						    __be32 daddr, u8 proto,
-						    __be32 spi)
+						    __be32 *daddr, u8 proto,
+						    __be32 spi, bool ip4)
 {
 	struct rx_sa *rsa;
 	struct xfrm_state *ret = NULL;
@@ -392,7 +393,9 @@ static struct xfrm_state *ixgbe_ipsec_find_rx_state(struct ixgbe_ipsec *ipsec,
 	rcu_read_lock();
 	hash_for_each_possible_rcu(ipsec->rx_sa_list, rsa, hlist, spi)
 		if (spi == rsa->xs->id.spi &&
-		    daddr == rsa->xs->id.daddr.a4 &&
+		    ((ip4 && *daddr == rsa->xs->id.daddr.a4) ||
+		      (!ip4 && !memcmp(daddr, &rsa->xs->id.daddr.a6,
+				       sizeof(rsa->xs->id.daddr.a6)))) &&
 		    proto == rsa->xs->id.proto) {
 			ret = rsa->xs;
 			xfrm_state_hold(ret);
@@ -505,7 +508,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 		}
 
 		/* get ip for rx sa table */
-		if (xs->xso.flags & XFRM_OFFLOAD_IPV6)
+		if (xs->props.family == AF_INET6)
 			memcpy(rsa.ipaddr, &xs->id.daddr.a6, 16);
 		else
 			memcpy(&rsa.ipaddr[3], &xs->id.daddr.a4, 4);
@@ -570,7 +573,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 			rsa.mode |= IXGBE_RXMOD_PROTO_ESP;
 		if (rsa.decrypt)
 			rsa.mode |= IXGBE_RXMOD_DECRYPT;
-		if (rsa.xs->xso.flags & XFRM_OFFLOAD_IPV6)
+		if (rsa.xs->props.family == AF_INET6)
 			rsa.mode |= IXGBE_RXMOD_IPV6;
 
 		/* the preparations worked, so save the info */
@@ -812,18 +815,30 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 	struct ixgbe_ipsec *ipsec = adapter->ipsec;
 	struct xfrm_offload *xo = NULL;
 	struct xfrm_state *xs = NULL;
-	struct iphdr *iph;
-	u8 *c_hdr;
+	struct ipv6hdr *ip6 = NULL;
+	struct iphdr *ip4 = NULL;
+	void *daddr;
 	__be32 spi;
+	u8 *c_hdr;
 	u8 proto;
 
-	/* we can assume no vlan header in the way, b/c the
+	/* Find the ip and crypto headers in the data.
+	 * We can assume no vlan header in the way, b/c the
 	 * hw won't recognize the IPsec packet and anyway the
 	 * currently vlan device doesn't support xfrm offload.
 	 */
-	/* TODO: not supporting IPv6 yet */
-	iph = (struct iphdr *)(skb->data + ETH_HLEN);
-	c_hdr = (u8 *)iph + iph->ihl * 4;
+	if (pkt_info & cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPV4)) {
+		ip4 = (struct iphdr *)(skb->data + ETH_HLEN);
+		daddr = &ip4->daddr;
+		c_hdr = (u8 *)ip4 + ip4->ihl * 4;
+	} else if (pkt_info & cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPV6)) {
+		ip6 = (struct ipv6hdr *)(skb->data + ETH_HLEN);
+		daddr = &ip6->daddr;
+		c_hdr = (u8 *)ip6 + sizeof(struct ipv6hdr);
+	} else {
+		return;
+	}
+
 	switch (pkt_info & ipsec_pkt_types) {
 	case cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPSEC_AH):
 		spi = ((struct ip_auth_hdr *)c_hdr)->spi;
@@ -837,7 +852,7 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 		return;
 	}
 
-	xs = ixgbe_ipsec_find_rx_state(ipsec, iph->daddr, proto, spi);
+	xs = ixgbe_ipsec_find_rx_state(ipsec, daddr, proto, spi, !!ip4);
 	if (unlikely(!xs))
 		return;
 
-- 
2.7.4

