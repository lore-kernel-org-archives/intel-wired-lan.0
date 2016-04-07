From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  7 Apr 2016 08:21:23 -0700
Subject: [Intel-wired-lan] [PATCH v1 4/4] fm10k: fix incorrect IPv6 extended
	header checksum
In-Reply-To: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
References: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460042483-16169-4-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Check for and handle IPv6 extended headers so that tx checksum offload
can be done. Also use skb_checksum_help for unexpected cases.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Notes:
    Testing-hints:
      Use the testing tool ipv6-exth program supplied by Mark Rustad to verify that
      ipv6 packets with extended headers get proper checksums. When using tcpdump,
      ensure that you only check receive traffic on the link partner, as tcpdump
      will report checksum errors for transmitted traffic if Tx checksum offloads
      are enabled.

 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index b875f4243667..0e166e9c90c8 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -820,6 +820,8 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 		struct ipv6hdr *ipv6;
 		u8 *raw;
 	} network_hdr;
+	u8 *transport_hdr;
+	__be16 frag_off;
 	__be16 protocol;
 	u8 l4_hdr = 0;
 
@@ -837,9 +839,11 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 			goto no_csum;
 		}
 		network_hdr.raw = skb_inner_network_header(skb);
+		transport_hdr = skb_inner_transport_header(skb);
 	} else {
 		protocol = vlan_get_protocol(skb);
 		network_hdr.raw = skb_network_header(skb);
+		transport_hdr = skb_transport_header(skb);
 	}
 
 	switch (protocol) {
@@ -848,15 +852,17 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 		break;
 	case htons(ETH_P_IPV6):
 		l4_hdr = network_hdr.ipv6->nexthdr;
+		if (likely((transport_hdr - network_hdr.raw) ==
+			   sizeof(struct ipv6hdr)))
+			break;
+		ipv6_skip_exthdr(skb, network_hdr.raw - skb->data +
+				      sizeof(struct ipv6hdr),
+				 &l4_hdr, &frag_off);
+		if (unlikely(frag_off))
+			l4_hdr = NEXTHDR_FRAGMENT;
 		break;
 	default:
-		if (unlikely(net_ratelimit())) {
-			dev_warn(tx_ring->dev,
-				 "partial checksum but ip version=%x!\n",
-				 protocol);
-		}
-		tx_ring->tx_stats.csum_err++;
-		goto no_csum;
+		break;
 	}
 
 	switch (l4_hdr) {
@@ -869,9 +875,10 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 	default:
 		if (unlikely(net_ratelimit())) {
 			dev_warn(tx_ring->dev,
-				 "partial checksum but l4 proto=%x!\n",
-				 l4_hdr);
+				 "partial checksum, version=%d l4 proto=%x\n",
+				 protocol, l4_hdr);
 		}
+		skb_checksum_help(skb);
 		tx_ring->tx_stats.csum_err++;
 		goto no_csum;
 	}
-- 
2.8.1.102.ga49ec4a

