From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 18 Nov 2015 09:21:28 -0800
Subject: [Intel-wired-lan] [PATCH V4] ixgbe: Handle extended IPv6 headers in
	tx path
Message-ID: <20151118172128.114143.22844.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Check for and handle IPv6 extended headers so that tx checksum
offload can be done. Also use skb_checksum_help for unexpected
cases. Thanks to Tom Herbert for noticing these problems. Thanks
to Alexander Duyck for recognizing problems with the first version
of this patch and recognizing how to coalesce error conditions
into a single location.

Reported-by: Tom Herbert <tom@herbertland.com>
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Changed in V2:
- Use ipv6_skip_exthdr instead of ipv6_find_hdr
- Move code into L3 processing and avoid any possible loop
- Handle encapsulated IPv6 extended headers correctly
Changed in V3:
- Call skb_checksum_help for unexpected cases
- Move unlikely() calls to more appropriate places
- Reaarange terms in call to ipv6_skip_exthdr to reduce line count
- Combined 2 unlikely error cases into one
Changed in V4:
- Coalesce error conditions into one location
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1ffbe85eab7b..4ef5b63b2543 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7229,6 +7229,7 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 			struct tcphdr *tcphdr;
 			u8 *raw;
 		} transport_hdr;
+		__be16 frag_off;
 
 		if (skb->encapsulation) {
 			network_hdr.raw = skb_inner_network_header(skb);
@@ -7252,13 +7253,17 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 		case 6:
 			vlan_macip_lens |= transport_hdr.raw - network_hdr.raw;
 			l4_hdr = network_hdr.ipv6->nexthdr;
+			if (likely((transport_hdr.raw - network_hdr.raw) ==
+				   sizeof(struct ipv6hdr)))
+				break;
+			ipv6_skip_exthdr(skb, network_hdr.raw - skb->data +
+					      sizeof(struct ipv6hdr),
+					 &l4_hdr, &frag_off);
+			if (unlikely(frag_off))
+				l4_hdr = NEXTHDR_FRAGMENT;
 			break;
 		default:
-			if (unlikely(net_ratelimit())) {
-				dev_warn(tx_ring->dev,
-					 "partial checksum but version=%d\n",
-					 network_hdr.ipv4->version);
-			}
+			break;
 		}
 
 		switch (l4_hdr) {
@@ -7279,16 +7284,18 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 		default:
 			if (unlikely(net_ratelimit())) {
 				dev_warn(tx_ring->dev,
-				 "partial checksum but l4 proto=%x!\n",
-				 l4_hdr);
+					 "partial checksum, version=%d, l4 proto=%x\n",
+					 network_hdr.ipv4->version, l4_hdr);
 			}
-			break;
+			skb_checksum_help(skb);
+			goto no_csum;
 		}
 
 		/* update TX checksum flag */
 		first->tx_flags |= IXGBE_TX_FLAGS_CSUM;
 	}
 
+no_csum:
 	/* vlan_macip_lens: MACLEN, VLAN tag */
 	vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
 

