From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:06:00 -0400
Subject: [Intel-wired-lan] [net-next S4 03/15] i40e/i40evf: Add ATR support
	for tunneled TCP/IPv4/IPv6 packets.
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Without this RSS would have done inner header load balancing. Now we can get the
benefits of ATR for tunneled packets to better align TX and RX queues with the
right core/interrupt.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I07d0e0a192faf28fdd33b2f04c32b2a82ff97ddd
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 77 +++++++++++++++------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 34 ++++++------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  1 +
 4 files changed, 62 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 4bd3a80..f188790 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1925,11 +1925,11 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
  * i40e_atr - Add a Flow Director ATR filter
  * @tx_ring:  ring to add programming descriptor to
  * @skb:      send buffer
- * @flags:    send flags
+ * @tx_flags: send tx flags
  * @protocol: wire protocol
  **/
 static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
-		     u32 flags, __be16 protocol)
+		     u32 tx_flags, __be16 protocol)
 {
 	struct i40e_filter_program_desc *fdir_desc;
 	struct i40e_pf *pf = tx_ring->vsi->back;
@@ -1954,25 +1954,38 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!tx_ring->atr_sample_rate)
 		return;
 
-	/* snag network header to get L4 type and address */
-	hdr.network = skb_network_header(skb);
+	if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
+		return;
 
-	/* Currently only IPv4/IPv6 with TCP is supported */
-	if (protocol == htons(ETH_P_IP)) {
-		if (hdr.ipv4->protocol != IPPROTO_TCP)
-			return;
+	if (!(tx_flags & I40E_TX_FLAGS_VXLAN_TUNNEL)) {
+		/* snag network header to get L4 type and address */
+		hdr.network = skb_network_header(skb);
 
-		/* access ihl as a u8 to avoid unaligned access on ia64 */
-		hlen = (hdr.network[0] & 0x0F) << 2;
-	} else if (protocol == htons(ETH_P_IPV6)) {
-		if (hdr.ipv6->nexthdr != IPPROTO_TCP)
+		/* Currently only IPv4/IPv6 with TCP is supported
+		 * access ihl as u8 to avoid unaligned access on ia64
+		 */
+		if (tx_flags & I40E_TX_FLAGS_IPV4)
+			hlen = (hdr.network[0] & 0x0F) << 2;
+		else if (protocol == htons(ETH_P_IPV6))
+			hlen = sizeof(struct ipv6hdr);
+		else
 			return;
-
-		hlen = sizeof(struct ipv6hdr);
 	} else {
-		return;
+		hdr.network = skb_inner_network_header(skb);
+		hlen = skb_inner_network_header_len(skb);
 	}
 
+	/* Currently only IPv4/IPv6 with TCP is supported
+	 * Note: tx_flags gets modified to reflect inner protocols in
+	 * tx_enable_csum function if encap is enabled.
+	 */
+	if ((tx_flags & I40E_TX_FLAGS_IPV4) &&
+	    (hdr.ipv4->protocol != IPPROTO_TCP))
+		return;
+	else if ((tx_flags & I40E_TX_FLAGS_IPV6) &&
+		 (hdr.ipv6->nexthdr != IPPROTO_TCP))
+		return;
+
 	th = (struct tcphdr *)(hdr.network + hlen);
 
 	/* Due to lack of space, no more new filters can be programmed */
@@ -2119,16 +2132,14 @@ out:
  * i40e_tso - set up the tso context descriptor
  * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
- * @tx_flags: the collected send information
- * @protocol: the send protocol
  * @hdr_len:  ptr to the size of the packet header
  * @cd_tunneling: ptr to context descriptor bits
  *
  * Returns 0 if no TSO can happen, 1 if tso is going, or error
  **/
 static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
-		    u32 tx_flags, __be16 protocol, u8 *hdr_len,
-		    u64 *cd_type_cmd_tso_mss, u32 *cd_tunneling)
+		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss,
+		    u32 *cd_tunneling)
 {
 	u32 cd_cmd, cd_tso_len, cd_mss;
 	struct ipv6hdr *ipv6h;
@@ -2220,12 +2231,12 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
 /**
  * i40e_tx_enable_csum - Enable Tx checksum offloads
  * @skb: send buffer
- * @tx_flags: Tx flags currently set
+ * @tx_flags: pointer to Tx flags currently set
  * @td_cmd: Tx descriptor command bits to set
  * @td_offset: Tx descriptor header offsets to set
  * @cd_tunneling: ptr to context desc bits
  **/
-static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
+static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 				u32 *td_cmd, u32 *td_offset,
 				struct i40e_ring *tx_ring,
 				u32 *cd_tunneling)
@@ -2241,6 +2252,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 		switch (ip_hdr(skb)->protocol) {
 		case IPPROTO_UDP:
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
+			*tx_flags |= I40E_TX_FLAGS_VXLAN_TUNNEL;
 			break;
 		default:
 			return;
@@ -2250,18 +2262,17 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 		this_ipv6_hdr = inner_ipv6_hdr(skb);
 		this_tcp_hdrlen = inner_tcp_hdrlen(skb);
 
-		if (tx_flags & I40E_TX_FLAGS_IPV4) {
-
-			if (tx_flags & I40E_TX_FLAGS_TSO) {
+		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
+			if (*tx_flags & I40E_TX_FLAGS_TSO) {
 				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
 				ip_hdr(skb)->check = 0;
 			} else {
 				*cd_tunneling |=
 					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
 			}
-		} else if (tx_flags & I40E_TX_FLAGS_IPV6) {
+		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
 			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
-			if (tx_flags & I40E_TX_FLAGS_TSO)
+			if (*tx_flags & I40E_TX_FLAGS_TSO)
 				ip_hdr(skb)->check = 0;
 		}
 
@@ -2273,8 +2284,8 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 					skb_transport_offset(skb)) >> 1) <<
 				   I40E_TXD_CTX_QW0_NATLEN_SHIFT;
 		if (this_ip_hdr->version == 6) {
-			tx_flags &= ~I40E_TX_FLAGS_IPV4;
-			tx_flags |= I40E_TX_FLAGS_IPV6;
+			*tx_flags &= ~I40E_TX_FLAGS_IPV4;
+			*tx_flags |= I40E_TX_FLAGS_IPV6;
 		}
 	} else {
 		network_hdr_len = skb_network_header_len(skb);
@@ -2284,12 +2295,12 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 	}
 
 	/* Enable IP checksum offloads */
-	if (tx_flags & I40E_TX_FLAGS_IPV4) {
+	if (*tx_flags & I40E_TX_FLAGS_IPV4) {
 		l4_hdr = this_ip_hdr->protocol;
 		/* the stack computes the IP header already, the only time we
 		 * need the hardware to recompute it is in the case of TSO.
 		 */
-		if (tx_flags & I40E_TX_FLAGS_TSO) {
+		if (*tx_flags & I40E_TX_FLAGS_TSO) {
 			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
 			this_ip_hdr->check = 0;
 		} else {
@@ -2298,7 +2309,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 		/* Now set the td_offset for IP header length */
 		*td_offset = (network_hdr_len >> 2) <<
 			      I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
-	} else if (tx_flags & I40E_TX_FLAGS_IPV6) {
+	} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
 		l4_hdr = this_ipv6_hdr->nexthdr;
 		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
 		/* Now set the td_offset for IP header length */
@@ -2711,7 +2722,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (protocol == htons(ETH_P_IPV6))
 		tx_flags |= I40E_TX_FLAGS_IPV6;
 
-	tso = i40e_tso(tx_ring, skb, tx_flags, protocol, &hdr_len,
+	tso = i40e_tso(tx_ring, skb, &hdr_len,
 		       &cd_type_cmd_tso_mss, &cd_tunneling);
 
 	if (tso < 0)
@@ -2737,7 +2748,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		tx_flags |= I40E_TX_FLAGS_CSUM;
 
-		i40e_tx_enable_csum(skb, tx_flags, &td_cmd, &td_offset,
+		i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
 				    tx_ring, &cd_tunneling);
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 4b0b810..ea1df3b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -139,6 +139,7 @@ enum i40e_dyn_idx_t {
 #define I40E_TX_FLAGS_FSO		(u32)(1 << 7)
 #define I40E_TX_FLAGS_TSYN		(u32)(1 << 8)
 #define I40E_TX_FLAGS_FD_SB		(u32)(1 << 9)
+#define I40E_TX_FLAGS_VXLAN_TUNNEL	(u32)(1 << 10)
 #define I40E_TX_FLAGS_VLAN_MASK		0xffff0000
 #define I40E_TX_FLAGS_VLAN_PRIO_MASK	0xe0000000
 #define I40E_TX_FLAGS_VLAN_PRIO_SHIFT	29
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index b077e02..362d6e1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1408,16 +1408,14 @@ out:
  * i40e_tso - set up the tso context descriptor
  * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
- * @tx_flags: the collected send information
- * @protocol: the send protocol
  * @hdr_len:  ptr to the size of the packet header
  * @cd_tunneling: ptr to context descriptor bits
  *
  * Returns 0 if no TSO can happen, 1 if tso is going, or error
  **/
 static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
-		    u32 tx_flags, __be16 protocol, u8 *hdr_len,
-		    u64 *cd_type_cmd_tso_mss, u32 *cd_tunneling)
+		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss,
+		    u32 *cd_tunneling)
 {
 	u32 cd_cmd, cd_tso_len, cd_mss;
 	struct ipv6hdr *ipv6h;
@@ -1468,12 +1466,12 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 /**
  * i40e_tx_enable_csum - Enable Tx checksum offloads
  * @skb: send buffer
- * @tx_flags: Tx flags currently set
+ * @tx_flags: pointer to Tx flags currently set
  * @td_cmd: Tx descriptor command bits to set
  * @td_offset: Tx descriptor header offsets to set
  * @cd_tunneling: ptr to context desc bits
  **/
-static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
+static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 				u32 *td_cmd, u32 *td_offset,
 				struct i40e_ring *tx_ring,
 				u32 *cd_tunneling)
@@ -1489,6 +1487,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 		switch (ip_hdr(skb)->protocol) {
 		case IPPROTO_UDP:
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
+			*tx_flags |= I40E_TX_FLAGS_VXLAN_TUNNEL;
 			break;
 		default:
 			return;
@@ -1498,18 +1497,17 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 		this_ipv6_hdr = inner_ipv6_hdr(skb);
 		this_tcp_hdrlen = inner_tcp_hdrlen(skb);
 
-		if (tx_flags & I40E_TX_FLAGS_IPV4) {
-
-			if (tx_flags & I40E_TX_FLAGS_TSO) {
+		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
+			if (*tx_flags & I40E_TX_FLAGS_TSO) {
 				*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
 				ip_hdr(skb)->check = 0;
 			} else {
 				*cd_tunneling |=
 					 I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
 			}
-		} else if (tx_flags & I40E_TX_FLAGS_IPV6) {
+		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
 			*cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
-			if (tx_flags & I40E_TX_FLAGS_TSO)
+			if (*tx_flags & I40E_TX_FLAGS_TSO)
 				ip_hdr(skb)->check = 0;
 		}
 
@@ -1521,8 +1519,8 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 					skb_transport_offset(skb)) >> 1) <<
 				   I40E_TXD_CTX_QW0_NATLEN_SHIFT;
 		if (this_ip_hdr->version == 6) {
-			tx_flags &= ~I40E_TX_FLAGS_IPV4;
-			tx_flags |= I40E_TX_FLAGS_IPV6;
+			*tx_flags &= ~I40E_TX_FLAGS_IPV4;
+			*tx_flags |= I40E_TX_FLAGS_IPV6;
 		}
 
 
@@ -1534,12 +1532,12 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 	}
 
 	/* Enable IP checksum offloads */
-	if (tx_flags & I40E_TX_FLAGS_IPV4) {
+	if (*tx_flags & I40E_TX_FLAGS_IPV4) {
 		l4_hdr = this_ip_hdr->protocol;
 		/* the stack computes the IP header already, the only time we
 		 * need the hardware to recompute it is in the case of TSO.
 		 */
-		if (tx_flags & I40E_TX_FLAGS_TSO) {
+		if (*tx_flags & I40E_TX_FLAGS_TSO) {
 			*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
 			this_ip_hdr->check = 0;
 		} else {
@@ -1548,7 +1546,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 tx_flags,
 		/* Now set the td_offset for IP header length */
 		*td_offset = (network_hdr_len >> 2) <<
 			      I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
-	} else if (tx_flags & I40E_TX_FLAGS_IPV6) {
+	} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
 		l4_hdr = this_ipv6_hdr->nexthdr;
 		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
 		/* Now set the td_offset for IP header length */
@@ -1942,7 +1940,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (protocol == htons(ETH_P_IPV6))
 		tx_flags |= I40E_TX_FLAGS_IPV6;
 
-	tso = i40e_tso(tx_ring, skb, tx_flags, protocol, &hdr_len,
+	tso = i40e_tso(tx_ring, skb, &hdr_len,
 		       &cd_type_cmd_tso_mss, &cd_tunneling);
 
 	if (tso < 0)
@@ -1963,7 +1961,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		tx_flags |= I40E_TX_FLAGS_CSUM;
 
-		i40e_tx_enable_csum(skb, tx_flags, &td_cmd, &td_offset,
+		i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
 				    tx_ring, &cd_tunneling);
 	}
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 1e49bb1..a23f5e8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -138,6 +138,7 @@ enum i40e_dyn_idx_t {
 #define I40E_TX_FLAGS_FCCRC		(u32)(1 << 6)
 #define I40E_TX_FLAGS_FSO		(u32)(1 << 7)
 #define I40E_TX_FLAGS_FD_SB		(u32)(1 << 9)
+#define I40E_TX_FLAGS_VXLAN_TUNNEL	(u32)(1 << 10)
 #define I40E_TX_FLAGS_VLAN_MASK		0xffff0000
 #define I40E_TX_FLAGS_VLAN_PRIO_MASK	0xe0000000
 #define I40E_TX_FLAGS_VLAN_PRIO_SHIFT	29
-- 
1.9.3

