From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 20 Jan 2016 14:43:44 -0800
Subject: [Intel-wired-lan] [next, S23,
	06/13 v2] i40e/i40evf: tunnels can be generic
Message-ID: <1453329824-9465-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since the i40e driver now supports VxLAN, GRE, and soon
to be Geneve tunnels, the driver can just note that an skb
contains a tunneled packet generically, instead of calling
out VXLAN specifically.  The tunnel set up we do for hardware
is almost always the same for all tunnel types.

This specifically enables ATR/Flow Director on GRE packets
which increases performance/scaling.  Without this patch
GRE RX packets end up on a random RSS assigned queue.

v2: Fix code error found by Alex, by repairing if/else clause
    for tunnel.

Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ie8e205603654910d2f718592cbef8132ae0719e4

---
Testing Hints:
Test tunnelled traffic, specifically also test VxLAN and other tunnel
types to make sure that ATR counters are still counting when doing
IPv4/TCP traffic over the tunnel.
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 13 +++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 720516b..757bfb6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2005,7 +2005,10 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
 		return;
 
-	if (!(tx_flags & I40E_TX_FLAGS_UDP_TUNNEL)) {
+	if ((tx_flags & I40E_TX_FLAGS_TUNNEL)) {
+		hdr.network = skb_inner_network_header(skb);
+		hlen = skb_inner_network_header_len(skb);
+	} else {
 		/* snag network header to get L4 type and address */
 		hdr.network = skb_network_header(skb);
 
@@ -2018,9 +2021,6 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 			hlen = sizeof(struct ipv6hdr);
 		else
 			return;
-	} else {
-		hdr.network = skb_inner_network_header(skb);
-		hlen = skb_inner_network_header_len(skb);
 	}
 
 	/* Currently only IPv4/IPv6 with TCP is supported
@@ -2090,7 +2090,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		     I40E_TXD_FLTR_QW1_FD_STATUS_SHIFT;
 
 	dtype_cmd |= I40E_TXD_FLTR_QW1_CNT_ENA_MASK;
-	if (!(tx_flags & I40E_TX_FLAGS_UDP_TUNNEL))
+	if (!(tx_flags & I40E_TX_FLAGS_TUNNEL))
 		dtype_cmd |=
 			((u32)I40E_FD_ATR_STAT_IDX(pf->hw.pf_id) <<
 			I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT) &
@@ -2323,10 +2323,11 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			oudph = udp_hdr(skb);
 			oiph = ip_hdr(skb);
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
-			*tx_flags |= I40E_TX_FLAGS_UDP_TUNNEL;
+			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		case IPPROTO_GRE:
 			l4_tunnel = I40E_TXD_CTX_GRE_TUNNELING;
+			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		default:
 			return;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 3f081e2..1d167b6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -163,7 +163,7 @@ enum i40e_dyn_idx_t {
 #define I40E_TX_FLAGS_FSO		BIT(7)
 #define I40E_TX_FLAGS_TSYN		BIT(8)
 #define I40E_TX_FLAGS_FD_SB		BIT(9)
-#define I40E_TX_FLAGS_UDP_TUNNEL	BIT(10)
+#define I40E_TX_FLAGS_TUNNEL		BIT(10)
 #define I40E_TX_FLAGS_VLAN_MASK		0xffff0000
 #define I40E_TX_FLAGS_VLAN_PRIO_MASK	0xe0000000
 #define I40E_TX_FLAGS_VLAN_PRIO_SHIFT	29
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 7a00657..ed4934a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1521,7 +1521,7 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			oudph = udp_hdr(skb);
 			oiph = ip_hdr(skb);
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
-			*tx_flags |= I40E_TX_FLAGS_VXLAN_TUNNEL;
+			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		default:
 			return;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index e29bb3e..d7950b1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -162,7 +162,7 @@ enum i40e_dyn_idx_t {
 #define I40E_TX_FLAGS_FCCRC		BIT(6)
 #define I40E_TX_FLAGS_FSO		BIT(7)
 #define I40E_TX_FLAGS_FD_SB		BIT(9)
-#define I40E_TX_FLAGS_VXLAN_TUNNEL	BIT(10)
+#define I40E_TX_FLAGS_TUNNEL		BIT(10)
 #define I40E_TX_FLAGS_VLAN_MASK		0xffff0000
 #define I40E_TX_FLAGS_VLAN_PRIO_MASK	0xe0000000
 #define I40E_TX_FLAGS_VLAN_PRIO_SHIFT	29
-- 
1.8.3.1

