From: Alexander Duyck <aduyck@mirantis.com>
Date: Sat, 02 Apr 2016 00:06:56 -0700
Subject: [Intel-wired-lan] [next PATCH 2/2] i40e/i40evf: Add support for
	IPIP and SIT offloads
In-Reply-To: <20160402070114.13504.22615.stgit@localhost.localdomain>
References: <20160402070114.13504.22615.stgit@localhost.localdomain>
Message-ID: <20160402070520.13504.3716.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Looking over the documentation it turns out enabling IPIP and SIT offloads
for i40e is pretty straighforward.  As such I decided to enable them with
this patch.  In my testing I am seeing an improvement of 8 to 10 Gb/s
for IPIP and SIT tunnels with this offload enabled.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

Testing-hints:
  All that should be needed is to setup a pair of systems with a tunnel and
  pass traffic over it.  Documentation on how to setup IPIP and SIT tunnels
  can be found at:

  http://www.linuxfoundation.org/collaborate/workgroups/networking/tunneling

 drivers/net/ethernet/intel/i40e/i40e_main.c     |    2 ++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     |   24 +++++++++++++++--------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |   24 +++++++++++++++--------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |    2 ++
 4 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9100d34913a7..d5f2417c0851 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9119,6 +9119,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 				   NETIF_F_TSO_ECN		|
 				   NETIF_F_TSO6			|
 				   NETIF_F_GSO_GRE		|
+				   NETIF_F_GSO_IPIP		|
+				   NETIF_F_GSO_SIT		|
 				   NETIF_F_GSO_UDP_TUNNEL	|
 				   NETIF_F_GSO_UDP_TUNNEL_CSUM	|
 				   NETIF_F_SCTP_CRC		|
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 6bf705add321..0d2a34cec6a9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2297,7 +2297,10 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		ip.v6->payload_len = 0;
 	}
 
-	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL | SKB_GSO_GRE |
+	if (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
+					 SKB_GSO_IPIP |
+					 SKB_GSO_SIT |
+					 SKB_GSO_UDP_TUNNEL |
 					 SKB_GSO_UDP_TUNNEL_CSUM)) {
 		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
 			/* determine offset of outer transport header */
@@ -2439,13 +2442,6 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 						 &l4_proto, &frag_off);
 		}
 
-		/* compute outer L3 header size */
-		tunnel |= ((l4.hdr - ip.hdr) / 4) <<
-			  I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT;
-
-		/* switch IP header pointer from outer to inner header */
-		ip.hdr = skb_inner_network_header(skb);
-
 		/* define outer transport */
 		switch (l4_proto) {
 		case IPPROTO_UDP:
@@ -2456,6 +2452,11 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			tunnel |= I40E_TXD_CTX_GRE_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_UDP_TUNNEL;
 			break;
+		case IPPROTO_IPIP:
+		case IPPROTO_IPV6:
+			*tx_flags |= I40E_TX_FLAGS_UDP_TUNNEL;
+			l4.hdr = skb_inner_network_header(skb);
+			break;
 		default:
 			if (*tx_flags & I40E_TX_FLAGS_TSO)
 				return -1;
@@ -2464,6 +2465,13 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			return 0;
 		}
 
+		/* compute outer L3 header size */
+		tunnel |= ((l4.hdr - ip.hdr) / 4) <<
+			  I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT;
+
+		/* switch IP header pointer from outer to inner header */
+		ip.hdr = skb_inner_network_header(skb);
+
 		/* compute tunnel header size */
 		tunnel |= ((ip.hdr - l4.hdr) / 2) <<
 			  I40E_TXD_CTX_QW0_NATLEN_SHIFT;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 519256bb63e8..07ce8e4e35e0 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1564,7 +1564,10 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		ip.v6->payload_len = 0;
 	}
 
-	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL | SKB_GSO_GRE |
+	if (skb_shinfo(skb)->gso_type & (SKB_GSO_GRE |
+					 SKB_GSO_IPIP |
+					 SKB_GSO_SIT |
+					 SKB_GSO_UDP_TUNNEL |
 					 SKB_GSO_UDP_TUNNEL_CSUM)) {
 		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
 			/* determine offset of outer transport header */
@@ -1664,13 +1667,6 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 						 &l4_proto, &frag_off);
 		}
 
-		/* compute outer L3 header size */
-		tunnel |= ((l4.hdr - ip.hdr) / 4) <<
-			  I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT;
-
-		/* switch IP header pointer from outer to inner header */
-		ip.hdr = skb_inner_network_header(skb);
-
 		/* define outer transport */
 		switch (l4_proto) {
 		case IPPROTO_UDP:
@@ -1681,6 +1677,11 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			tunnel |= I40E_TXD_CTX_GRE_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_VXLAN_TUNNEL;
 			break;
+		case IPPROTO_IPIP:
+		case IPPROTO_IPV6:
+			*tx_flags |= I40E_TX_FLAGS_VXLAN_TUNNEL;
+			l4.hdr = skb_inner_network_header(skb);
+			break;
 		default:
 			if (*tx_flags & I40E_TX_FLAGS_TSO)
 				return -1;
@@ -1689,6 +1690,13 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			return 0;
 		}
 
+		/* compute outer L3 header size */
+		tunnel |= ((l4.hdr - ip.hdr) / 4) <<
+			  I40E_TXD_CTX_QW0_EXT_IPLEN_SHIFT;
+
+		/* switch IP header pointer from outer to inner header */
+		ip.hdr = skb_inner_network_header(skb);
+
 		/* compute tunnel header size */
 		tunnel |= ((ip.hdr - l4.hdr) / 2) <<
 			  I40E_TXD_CTX_QW0_NATLEN_SHIFT;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index a24966e4873a..1bb9d61ec171 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2327,6 +2327,8 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 				   NETIF_F_TSO_ECN		|
 				   NETIF_F_TSO6			|
 				   NETIF_F_GSO_GRE		|
+				   NETIF_F_GSO_IPIP		|
+				   NETIF_F_GSO_SIT		|
 				   NETIF_F_GSO_UDP_TUNNEL	|
 				   NETIF_F_GSO_UDP_TUNNEL_CSUM	|
 				   NETIF_F_SCTP_CRC		|

