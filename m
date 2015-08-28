From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 28 Aug 2015 17:56:00 -0400
Subject: [Intel-wired-lan] [next PATCH S13 14/15] i40e: fix ip-ip GRE
	encapulation
In-Reply-To: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440798961-17326-15-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The i40e driver will soon be capable of offloading GRE traffic
but in the meantime, don't let the driver tell the OS that
it can offload types of traffic it cannot.

This fixes a bug where if you stack a GRE MAC in IP tunnel
over i40e, all TSO packets will be sent with invalid checksums
causing really bad throughput.

NOTE: I still see some retransmits that are unexplained when
testing with vxlan or ip/mac tunnels (GRE) but the throughput
is more like what is expected with multi-gigabit on a single
flow.

Reported-by: Stefan Assman <sassman@redhat.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Ie31843b150695b2b1889e306b8c33c1d2da29a9e
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 36 ++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 469e1d5..b686450 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -30,6 +30,7 @@
 #if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
 #include <net/vxlan.h>
 #endif
+#include <net/gre.h>
 
 const char i40e_driver_name[] = "i40e";
 static const char i40e_driver_string[] =
@@ -8372,12 +8373,41 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
 					     struct net_device *dev,
 					     netdev_features_t features)
 {
-	if (skb->encapsulation &&
-	    (skb_inner_mac_header(skb) - skb_transport_header(skb) >
-	     I40E_MAX_TUNNEL_HDR_LEN))
+	u8 protocol = 0;
+	int hlen;
+
+	if (!skb->encapsulation)
+		return features;
+
+	/* prevent tunnel headers that are too long to offload from
+	 * being sent to the hardware
+	 */
+	if (skb_inner_mac_header(skb) - skb_transport_header(skb) >
+	    I40E_MAX_TUNNEL_HDR_LEN)
+		return features & ~(NETIF_F_ALL_CSUM | NETIF_F_GSO_MASK);
+
+	switch (vlan_get_protocol(skb)) {
+	case htons(ETH_P_IP):
+		protocol = ip_hdr(skb)->protocol;
+		break;
+	case htons(ETH_P_IPV6):
+		protocol = ipv6_hdr(skb)->nexthdr;
+		break;
+	}
+
+	hlen = skb_inner_mac_header(skb) - skb_transport_header(skb);
+	if ((protocol == IPPROTO_GRE) &&
+	    (skb->inner_protocol_type != ENCAP_TYPE_ETHER ||
+	     skb->inner_protocol != htons(ETH_P_TEB) ||
+	     hlen < sizeof(struct gre_base_hdr) ||
+	     hlen > (sizeof(struct gre_base_hdr) + 12)))
 		return features & ~(NETIF_F_ALL_CSUM | NETIF_F_GSO_MASK);
 
+#if IS_ENABLED(CONFIG_VXLAN)
+	return vxlan_features_check(skb, features);
+#else
 	return features;
+#endif
 }
 
 static const struct net_device_ops i40e_netdev_ops = {
-- 
1.9.3

