From: Joe Damato <jdamato@fastly.com>
Date: Tue, 15 Feb 2022 13:02:06 -0800
Subject: [Intel-wired-lan] i40e and TSO with MPLS ?
Message-ID: <1644958926-51692-1-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Greetings:

Does i40e (XL710) support TSO with MPLS?

We are using firmware version: 7.10 0x80006469 1.2527.0

We've attempted to add support for TSO+MPLS to i40e, but were unable to
get it working. The patch is included below for reference, but it is almost
certainly incorrect - and I am not clear if the hardware itself would
support this even if the patch was correct.

Applying the patch below and using tcpdump shows that:

	- packet data, as seen by the pcap filter in the kernel, is large.
	  This suggests that the kernel is attempting to offload
	  segmentation to the device,

	but

	- those large packets are not ACK'd by the client

This suggests that either:

	- the device does not support TSO + MPLS, and/or
	- the patch below is incorrect

Does anyone working on i40e have any insight on this?

Thanks,
Joe

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a21833c..b7455cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12920,8 +12920,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	np->vsi = vsi;
 
 	hw_enc_features = NETIF_F_SG			|
-			  NETIF_F_IP_CSUM		|
-			  NETIF_F_IPV6_CSUM		|
+			  NETIF_F_HW_CSUM		|
 			  NETIF_F_HIGHDMA		|
 			  NETIF_F_SOFT_FEATURES		|
 			  NETIF_F_TSO			|
@@ -12952,6 +12951,23 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	/* record features VLANs can make use of */
 	netdev->vlan_features |= hw_enc_features | NETIF_F_TSO_MANGLEID;
 
+#define I40E_GSO_PARTIAL_FEATURES (NETIF_F_GSO_GRE | \
+				   NETIF_F_GSO_GRE_CSUM | \
+				   NETIF_F_GSO_IPXIP4 | \
+				   NETIF_F_GSO_IPXIP6 | \
+				   NETIF_F_GSO_UDP_TUNNEL | \
+				   NETIF_F_GSO_UDP_TUNNEL_CSUM)
+
+	netdev->gso_partial_features = I40E_GSO_PARTIAL_FEATURES;
+	netdev->features |= NETIF_F_GSO_PARTIAL |
+			    I40E_GSO_PARTIAL_FEATURES;
+
+	netdev->mpls_features    |= NETIF_F_SG;
+	netdev->mpls_features    |= NETIF_F_HW_CSUM;
+	netdev->mpls_features    |= NETIF_F_TSO;
+	netdev->mpls_features    |= NETIF_F_TSO6;
+	netdev->mpls_features |= I40E_GSO_PARTIAL_FEATURES;
+
 	/* enable macvlan offloads */
 	netdev->hw_features |= NETIF_F_HW_L2FW_DOFFLOAD;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 5ad2812..9e641a9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -9,6 +9,7 @@
 #include "i40e_prototype.h"
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
+#include <net/mpls.h>
 
 #define I40E_TXD_CMD (I40E_TX_DESC_CMD_EOP | I40E_TX_DESC_CMD_RS)
 /**
@@ -2908,6 +2909,7 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 {
 	struct sk_buff *skb = first->skb;
 	u64 cd_cmd, cd_tso_len, cd_mss;
+	__be16 protocol;
 	union {
 		struct iphdr *v4;
 		struct ipv6hdr *v6;
@@ -2932,15 +2934,24 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 	if (err < 0)
 		return err;
 
-	ip.hdr = skb_network_header(skb);
-	l4.hdr = skb_transport_header(skb);
+	protocol = vlan_get_protocol(skb);
+
+	if (eth_p_mpls(protocol))
+		ip.hdr = skb_inner_network_header(skb);
+	else
+		ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_checksum_start(skb);
 
 	/* initialize outer IP header fields */
 	if (ip.v4->version == 4) {
 		ip.v4->tot_len = 0;
 		ip.v4->check = 0;
+
+		first->tx_flags |= I40E_TX_FLAGS_TSO |
+				   I40E_TX_FLAGS_IPV4;
 	} else {
 		ip.v6->payload_len = 0;
+		first->tx_flags |= I40E_TX_FLAGS_TSO;
 	}
 
 	if (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
@@ -2962,10 +2973,6 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 					     (__force __wsum)htonl(paylen));
 		}
 
-		/* reset pointers to inner headers */
-		ip.hdr = skb_inner_network_header(skb);
-		l4.hdr = skb_inner_transport_header(skb);
-
 		/* initialize inner IP header fields */
 		if (ip.v4->version == 4) {
 			ip.v4->tot_len = 0;
