From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 12 Jun 2015 14:23:42 -0700
Subject: [Intel-wired-lan] [PATCH V3 1/2] ixgbe: Add support for
 UDP-encapsulated tx checksum offload
In-Reply-To: <20150612211601.26842.30885.stgit@mdrustad-wks.jf.intel.com>
References: <20150612211601.26842.30885.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150612212342.26842.9852.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mark Rustad <mark.d.rustad@intel.com>

By using GSO for UDP-encapsulated packets, all ixgbe devices can
be directed to generate checksums for the inner headers because
the outer UDP checksum can be zero. So point the machinery at the
inner headers and have the hardware generate the checksum.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Changes in V2:
- do not set NETIF_F_GSO_UDP_TUNNEL
- allow more than VXLAN encapsulation
- check for inner header offset constraints
- clear TSO bits on encapsulated packets
Changes in V3:
- do not clear bits that were never set
- add unlikely to a header offset check
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   66 ++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7bbc5bab7bca..d95b419b7ff5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6933,31 +6933,55 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 		if (!(first->tx_flags & IXGBE_TX_FLAGS_HW_VLAN) &&
 		    !(first->tx_flags & IXGBE_TX_FLAGS_CC))
 			return;
+		vlan_macip_lens = skb_network_offset(skb) <<
+				  IXGBE_ADVTXD_MACLEN_SHIFT;
 	} else {
 		u8 l4_hdr = 0;
-		switch (first->protocol) {
-		case htons(ETH_P_IP):
-			vlan_macip_lens |= skb_network_header_len(skb);
+		union {
+			struct iphdr *ipv4;
+			struct ipv6hdr *ipv6;
+			u8 *raw;
+		} network_hdr;
+		union {
+			struct tcphdr *tcphdr;
+			u8 *raw;
+		} transport_hdr;
+
+		if (skb->encapsulation) {
+			network_hdr.raw = skb_inner_network_header(skb);
+			transport_hdr.raw = skb_inner_transport_header(skb);
+			vlan_macip_lens = skb_inner_network_offset(skb) <<
+					  IXGBE_ADVTXD_MACLEN_SHIFT;
+		} else {
+			network_hdr.raw = skb_network_header(skb);
+			transport_hdr.raw = skb_transport_header(skb);
+			vlan_macip_lens = skb_network_offset(skb) <<
+					  IXGBE_ADVTXD_MACLEN_SHIFT;
+		}
+
+		/* use first 4 bits to determine IP version */
+		switch (network_hdr.ipv4->version) {
+		case IPVERSION:
+			vlan_macip_lens |= transport_hdr.raw - network_hdr.raw;
 			type_tucmd |= IXGBE_ADVTXD_TUCMD_IPV4;
-			l4_hdr = ip_hdr(skb)->protocol;
+			l4_hdr = network_hdr.ipv4->protocol;
 			break;
-		case htons(ETH_P_IPV6):
-			vlan_macip_lens |= skb_network_header_len(skb);
-			l4_hdr = ipv6_hdr(skb)->nexthdr;
+		case 6:
+			vlan_macip_lens |= transport_hdr.raw - network_hdr.raw;
+			l4_hdr = network_hdr.ipv6->nexthdr;
 			break;
 		default:
 			if (unlikely(net_ratelimit())) {
 				dev_warn(tx_ring->dev,
-				 "partial checksum but proto=%x!\n",
-				 first->protocol);
+					 "partial checksum but version=%d\n",
+					 network_hdr.ipv4->version);
 			}
-			break;
 		}
 
 		switch (l4_hdr) {
 		case IPPROTO_TCP:
 			type_tucmd |= IXGBE_ADVTXD_TUCMD_L4T_TCP;
-			mss_l4len_idx = tcp_hdrlen(skb) <<
+			mss_l4len_idx = (transport_hdr.tcphdr->doff * 4) <<
 					IXGBE_ADVTXD_L4LEN_SHIFT;
 			break;
 		case IPPROTO_SCTP:
@@ -6983,7 +7007,6 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 	}
 
 	/* vlan_macip_lens: MACLEN, VLAN tag */
-	vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
 	vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
 
 	ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, 0,
@@ -8227,6 +8250,21 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	kfree(fwd_adapter);
 }
 
+#define IXGBE_MAX_TUNNEL_HDR_LEN 80
+static netdev_features_t
+ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
+		     netdev_features_t features)
+{
+	if (!skb->encapsulation)
+		return features;
+
+	if (unlikely(skb_inner_mac_header(skb) - skb_transport_header(skb) >
+		     IXGBE_MAX_TUNNEL_HDR_LEN))
+		return features & ~NETIF_F_ALL_CSUM;
+
+	return features;
+}
+
 static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_open		= ixgbe_open,
 	.ndo_stop		= ixgbe_close,
@@ -8275,6 +8313,7 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_dfwd_del_station	= ixgbe_fwd_del,
 	.ndo_add_vxlan_port	= ixgbe_add_vxlan_port,
 	.ndo_del_vxlan_port	= ixgbe_del_vxlan_port,
+	.ndo_features_check	= ixgbe_features_check,
 };
 
 /**
@@ -8634,6 +8673,9 @@ skip_sriov:
 	netdev->vlan_features |= NETIF_F_IPV6_CSUM;
 	netdev->vlan_features |= NETIF_F_SG;
 
+	netdev->hw_enc_features |= NETIF_F_SG | NETIF_F_IP_CSUM |
+				   NETIF_F_IPV6_CSUM;
+
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 

