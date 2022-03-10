From: Joe Damato <jdamato@fastly.com>
Date: Wed,  9 Mar 2022 17:08:52 -0800
Subject: [Intel-wired-lan] [next-queue] ice: Add mpls+tso support
Message-ID: <1646874532-90649-1-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Attempt to add mpls+tso support.

I don't have ice hardware available to test myself, but I just implemented
this feature in i40e and thought it might be useful to implement for ice
while this is fresh in my brain.

Hoping some one at intel will be able to test this on my behalf.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  4 +++-
 drivers/net/ethernet/intel/ice/ice_txrx.c | 29 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 285b0cd..3032eab 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3454,7 +3454,9 @@ static void ice_set_netdev_features(struct net_device *netdev)
 			      vlano_features | tso_features;
 
 	/* add support for HW_CSUM on packets with MPLS header */
-	netdev->mpls_features =  NETIF_F_HW_CSUM;
+	netdev->mpls_features =  NETIF_F_HW_CSUM |
+				 NETIF_F_TSO     |
+				 NETIF_F_TSO6;
 
 	/* enable features */
 	netdev->features |= netdev->hw_features;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 2dd3e1b..c410117 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_trace.h>
 #include <net/busy_poll.h>
 #include <net/dsfield.h>
+#include <net/mpls.h>
 #include <net/xdp.h>
 #include "ice_txrx_lib.h"
 #include "ice_lib.h"
@@ -1910,18 +1911,24 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		return 0;
 
-	ip.hdr = skb_network_header(skb);
-	l4.hdr = skb_transport_header(skb);
+	protocol = vlan_get_protocol(skb);
+
+	if (eth_p_mpls(protocol))
+		ip.hdr = skb_inner_network_header(skb);
+	else
+		ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_checksum_start(skb);
 
 	/* compute outer L2 header size */
 	l2_len = ip.hdr - skb->data;
 	offset = (l2_len / 2) << ICE_TX_DESC_LEN_MACLEN_S;
 
-	protocol = vlan_get_protocol(skb);
-
-	if (protocol == htons(ETH_P_IP))
+	/* set the tx_flags to indicate the IP protocol type. this is
+	 * required so that checksum header computation below is accurate.
+	 */
+	if (ip.v4->version == 4)
 		first->tx_flags |= ICE_TX_FLAGS_IPV4;
-	else if (protocol == htons(ETH_P_IPV6))
+	else
 		first->tx_flags |= ICE_TX_FLAGS_IPV6;
 
 	if (skb->encapsulation) {
@@ -2122,6 +2129,7 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	u32 paylen;
 	u8 l4_start;
 	int err;
+	__be16 protocol;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		return 0;
@@ -2134,8 +2142,13 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		return err;
 
 	/* cppcheck-suppress unreadVariable */
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
-- 
2.7.4

