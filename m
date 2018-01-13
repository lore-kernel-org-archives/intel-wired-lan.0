From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 12 Jan 2018 17:10:15 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: use compiler constants in Rx
 path
In-Reply-To: <1515805815-2692-1-git-send-email-shannon.nelson@oracle.com>
References: <1515805815-2692-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1515805815-2692-3-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rather than swapping runtime bytes to compare to constants, let the
compiler swap the constants and save a couple of runtuime cycles.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index c5ef09f..587fd8f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -806,9 +806,9 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 		    struct sk_buff *skb)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(rx_ring->netdev);
-	u16 pkt_info = le16_to_cpu(rx_desc->wb.lower.lo_dword.hs_rss.pkt_info);
-	u16 ipsec_pkt_types = IXGBE_RXDADV_PKTTYPE_IPSEC_AH |
-				IXGBE_RXDADV_PKTTYPE_IPSEC_ESP;
+	__le16 pkt_info = rx_desc->wb.lower.lo_dword.hs_rss.pkt_info;
+	__le16 ipsec_pkt_types = cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPSEC_AH |
+					     IXGBE_RXDADV_PKTTYPE_IPSEC_ESP);
 	struct ixgbe_ipsec *ipsec = adapter->ipsec;
 	struct xfrm_offload *xo = NULL;
 	struct xfrm_state *xs = NULL;
@@ -825,11 +825,11 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 	iph = (struct iphdr *)(skb->data + ETH_HLEN);
 	c_hdr = (u8 *)iph + iph->ihl * 4;
 	switch (pkt_info & ipsec_pkt_types) {
-	case IXGBE_RXDADV_PKTTYPE_IPSEC_AH:
+	case cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPSEC_AH):
 		spi = ((struct ip_auth_hdr *)c_hdr)->spi;
 		proto = IPPROTO_AH;
 		break;
-	case IXGBE_RXDADV_PKTTYPE_IPSEC_ESP:
+	case cpu_to_le16(IXGBE_RXDADV_PKTTYPE_IPSEC_ESP):
 		spi = ((struct ip_esp_hdr *)c_hdr)->spi;
 		proto = IPPROTO_ESP;
 		break;
-- 
2.7.4

