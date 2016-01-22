From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 21 Jan 2016 16:27:39 -0800
Subject: [Intel-wired-lan] [next PATCH v2 07/15] i40e/i40evf: Handle IPv6
 extension headers in checksum offload
In-Reply-To: <20160122002407.18278.95721.stgit@localhost.localdomain>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
Message-ID: <20160122002739.18278.88623.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support for IPv6 extension headers in setting up the Tx
checksum.  Without this patch extension headers would cause IPv6 traffic to
fail as the transport protocol could not be identified.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   14 +++++++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8e723125e31e..2e9ae018d639 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2402,7 +2402,9 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		struct udphdr *udp;
 		unsigned char *hdr;
 	} l4;
+	unsigned char *exthdr;
 	u32 l4_tunnel = 0;
+	__be16 frag_off;
 	u8 l4_proto = 0;
 
 	ip.hdr = skb_network_header(skb);
@@ -2420,7 +2422,12 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4_proto = ip.v4->protocol;
 		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
 			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
+
+			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
+			if (l4.hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data,
+						 &l4_proto, &frag_off);
 		}
 
 		/* define outer transport */
@@ -2470,8 +2477,13 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
 		}
 	} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-		l4_proto = ip.v6->nexthdr;
 		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
+
+		exthdr = ip.hdr + sizeof(*ip.v6);
+		l4_proto = ip.v6->nexthdr;
+		if (l4.hdr != exthdr)
+			ipv6_skip_exthdr(skb, exthdr - skb->data,
+					 &l4_proto, &frag_off);
 	}
 
 	/* Now set the td_offset for IP header length */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 34c7e3ffba1a..d37cba28ecfa 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1619,7 +1619,9 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		struct udphdr *udp;
 		unsigned char *hdr;
 	} l4;
+	unsigned char *exthdr;
 	u32 l4_tunnel = 0;
+	__be16 frag_off;
 	u8 l4_proto = 0;
 
 	ip.hdr = skb_network_header(skb);
@@ -1637,7 +1639,12 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4_proto = ip.v4->protocol;
 		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
 			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
+
+			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
+			if (l4.hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data,
+						 &l4_proto, &frag_off);
 		}
 
 		/* define outer transport */
@@ -1687,8 +1694,13 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
 		}
 	} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-		l4_proto = ip.v6->nexthdr;
 		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
+
+		exthdr = ip.hdr + sizeof(*ip.v6);
+		l4_proto = ip.v6->nexthdr;
+		if (l4.hdr != exthdr)
+			ipv6_skip_exthdr(skb, exthdr - skb->data,
+					 &l4_proto, &frag_off);
 	}
 
 	/* Now set the td_offset for IP header length */

