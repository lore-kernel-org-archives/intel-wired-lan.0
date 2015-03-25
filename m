From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:11 -0700
Subject: [Intel-wired-lan] [next-queue S2 01/15] i40evf: Fix Outer UDP RX
	checksum code
Message-ID: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Inner protocol being UDP should not stop us from verifying Outer UDP
checksum correctness.

If the Outer protocol is not UDP (NVGRE) we should not be doing a UDP
checksum check. If the packet has zero checksum, skip checksum check.

Change-ID: Ie7f153feb276a59f66a54a0938901b2c0a8100fa
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index f41da5d..1b5ee46 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -915,9 +915,7 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 	 * so the total length of IPv4 header is IHL*4 bytes
 	 * The UDP_0 bit *may* bet set if the *inner* header is UDP
 	 */
-	if (ipv4_tunnel &&
-	    (decoded.inner_prot != I40E_RX_PTYPE_INNER_PROT_UDP) &&
-	    !(rx_status & (1 << I40E_RX_DESC_STATUS_UDP_0_SHIFT))) {
+	if (ipv4_tunnel) {
 		skb->transport_header = skb->mac_header +
 					sizeof(struct ethhdr) +
 					(ip_hdr(skb)->ihl * 4);
@@ -927,15 +925,19 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 					  skb->protocol == htons(ETH_P_8021AD))
 					  ? VLAN_HLEN : 0;
 
-		rx_udp_csum = udp_csum(skb);
-		iph = ip_hdr(skb);
-		csum = csum_tcpudp_magic(
-				iph->saddr, iph->daddr,
-				(skb->len - skb_transport_offset(skb)),
-				IPPROTO_UDP, rx_udp_csum);
+		if ((ip_hdr(skb)->protocol == IPPROTO_UDP) &&
+		    (udp_hdr(skb)->check != 0)) {
+			rx_udp_csum = udp_csum(skb);
+			iph = ip_hdr(skb);
+			csum = csum_tcpudp_magic(iph->saddr, iph->daddr,
+						 (skb->len -
+						  skb_transport_offset(skb)),
+						 IPPROTO_UDP, rx_udp_csum);
 
-		if (udp_hdr(skb)->check != csum)
-			goto checksum_fail;
+			if (udp_hdr(skb)->check != csum)
+				goto checksum_fail;
+
+		} /* else its GRE and so no outer UDP header */
 	}
 
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
1.9.3

