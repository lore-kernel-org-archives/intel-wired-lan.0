From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:17:56 -0700
Subject: [Intel-wired-lan] [next PATCH S51 2/9] i40evf: Be much more verbose
	about what we can and cannot offload
In-Reply-To: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
References: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477433883-3248-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This change makes it so that we are much more robust about defining what we
can and cannot offload.  Previously we were performing no checks.  This
should bring us up to parity with the i40e PF driver.

In addition the device only supports GSO as long as the MSS is 64 or
greater.  We were not checking this so an MSS less than that was resulting
in Tx hangs.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: If533553ec92fc6ba694eab6ac81fdaf3004f3592
---
Testing Hints:
        This is half of the fix needed to address MSS less than 64.  This
        is the fix for upstream and kernels after 3.18.4, but we will need
        to come up with a separate fix for out-of-tree that can be stripped
        on kernels prior to 3.18.4.

        An easy test for this patch is to just set the MTU for an interface
        to a value 102.  Without this patch we should see Tx hangs with
        netperf and with we should be able to pass traffic without
        triggering Tx hangs.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 59 +++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 7008ff9..a47ca2d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2178,6 +2178,64 @@ static int i40evf_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
+/**
+ * i40evf_features_check - Validate encapsulated packet conforms to limits
+ * @skb: skb buff
+ * @netdev: This physical port's netdev
+ * @features: Offload features that the stack believes apply
+ **/
+static netdev_features_t i40evf_features_check(struct sk_buff *skb,
+					       struct net_device *dev,
+					       netdev_features_t features)
+{
+	size_t len;
+
+	/* No point in doing any of this if neither checksum nor GSO are
+	 * being requested for this frame.  We can rule out both by just
+	 * checking for CHECKSUM_PARTIAL
+	 */
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return features;
+
+	/* We cannot support GSO if the MSS is going to be less than
+	 * 64 bytes.  If it is then we need to drop support for GSO.
+	 */
+	if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_size < 64))
+		features &= ~NETIF_F_GSO_MASK;
+
+	/* MACLEN can support@most 63 words */
+	len = skb_network_header(skb) - skb->data;
+	if (len & ~(63 * 2))
+		goto out_err;
+
+	/* IPLEN and EIPLEN can support at most 127 dwords */
+	len = skb_transport_header(skb) - skb_network_header(skb);
+	if (len & ~(127 * 4))
+		goto out_err;
+
+	if (skb->encapsulation) {
+		/* L4TUNLEN can support 127 words */
+		len = skb_inner_network_header(skb) - skb_transport_header(skb);
+		if (len & ~(127 * 2))
+			goto out_err;
+
+		/* IPLEN can support at most 127 dwords */
+		len = skb_inner_transport_header(skb) -
+		      skb_inner_network_header(skb);
+		if (len & ~(127 * 4))
+			goto out_err;
+	}
+
+	/* No need to validate L4LEN as TCP is the only protocol with a
+	 * a flexible value and we support all possible values supported
+	 * by TCP, which is at most 15 dwords
+	 */
+
+	return features;
+out_err:
+	return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+}
+
 #define I40EVF_VLAN_FEATURES (NETIF_F_HW_VLAN_CTAG_TX |\
 			      NETIF_F_HW_VLAN_CTAG_RX |\
 			      NETIF_F_HW_VLAN_CTAG_FILTER)
@@ -2212,6 +2270,7 @@ static const struct net_device_ops i40evf_netdev_ops = {
 	.ndo_tx_timeout		= i40evf_tx_timeout,
 	.ndo_vlan_rx_add_vid	= i40evf_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= i40evf_vlan_rx_kill_vid,
+	.ndo_features_check	= i40evf_features_check,
 	.ndo_fix_features	= i40evf_fix_features,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= i40evf_netpoll,
-- 
2.4.11

