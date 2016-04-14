From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:30 -0700
Subject: [Intel-wired-lan] [next PATCH S35 10/14] i40e/i40evf: Refactor
	tunnel interpretation
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-11-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Refactor the interpretation of a tunnel.  This removes
some code and lets us start using the hardware's parsing.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Testing Hints: make sure VxLAN, Geneve, GRE tunnels all still work over
both ipv4 and ipv6 tunnel headers.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 13 ++++++-------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 13 ++++++-------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 17ee438..ce4d94b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1410,7 +1410,7 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 				    u16 rx_ptype)
 {
 	struct i40e_rx_ptype_decoded decoded = decode_rx_desc_ptype(rx_ptype);
-	bool ipv4, ipv6, ipv4_tunnel, ipv6_tunnel;
+	bool ipv4, ipv6, tunnel = false;
 
 	skb->ip_summed = CHECKSUM_NONE;
 
@@ -1459,14 +1459,13 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 	 * doesn't make it a hard requirement so if we have validated the
 	 * inner checksum report CHECKSUM_UNNECESSARY.
 	 */
-
-	ipv4_tunnel = (rx_ptype >= I40E_RX_PTYPE_GRENAT4_MAC_PAY3) &&
-		     (rx_ptype <= I40E_RX_PTYPE_GRENAT4_MACVLAN_IPV6_ICMP_PAY4);
-	ipv6_tunnel = (rx_ptype >= I40E_RX_PTYPE_GRENAT6_MAC_PAY3) &&
-		     (rx_ptype <= I40E_RX_PTYPE_GRENAT6_MACVLAN_IPV6_ICMP_PAY4);
+	if (decoded.inner_prot & (I40E_RX_PTYPE_INNER_PROT_TCP |
+				  I40E_RX_PTYPE_INNER_PROT_UDP |
+				  I40E_RX_PTYPE_INNER_PROT_SCTP))
+		tunnel = true;
 
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
-	skb->csum_level = ipv4_tunnel || ipv6_tunnel;
+	skb->csum_level = tunnel ? 1 : 0;
 
 	return;
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 4633235..cf42f16 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -864,7 +864,7 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 				    u16 rx_ptype)
 {
 	struct i40e_rx_ptype_decoded decoded = decode_rx_desc_ptype(rx_ptype);
-	bool ipv4, ipv6, ipv4_tunnel, ipv6_tunnel;
+	bool ipv4, ipv6, tunnel = false;
 
 	skb->ip_summed = CHECKSUM_NONE;
 
@@ -913,14 +913,13 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 	 * doesn't make it a hard requirement so if we have validated the
 	 * inner checksum report CHECKSUM_UNNECESSARY.
 	 */
-
-	ipv4_tunnel = (rx_ptype >= I40E_RX_PTYPE_GRENAT4_MAC_PAY3) &&
-		     (rx_ptype <= I40E_RX_PTYPE_GRENAT4_MACVLAN_IPV6_ICMP_PAY4);
-	ipv6_tunnel = (rx_ptype >= I40E_RX_PTYPE_GRENAT6_MAC_PAY3) &&
-		     (rx_ptype <= I40E_RX_PTYPE_GRENAT6_MACVLAN_IPV6_ICMP_PAY4);
+	if (decoded.inner_prot & (I40E_RX_PTYPE_INNER_PROT_TCP |
+				  I40E_RX_PTYPE_INNER_PROT_UDP |
+				  I40E_RX_PTYPE_INNER_PROT_SCTP))
+		tunnel = true;
 
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
-	skb->csum_level = ipv4_tunnel || ipv6_tunnel;
+	skb->csum_level = tunnel ? 1 : 0;
 
 	return;
 
-- 
2.4.3

