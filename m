From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:17:55 -0700
Subject: [Intel-wired-lan] [next PATCH S51 1/9] i40e: Be much more verbose
	about what we can and cannot offload
In-Reply-To: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
References: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477433883-3248-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This change makes it so that we are much more robust about defining what we
can and cannot offload.  Previously we were just checking for the L4 tunnel
header length, however there are other fields we should be verifying as
there are multiple scenarios in which we cannot perform hardware offloads.

In addition the device only supports GSO as long as the MSS is 64 or
greater.  We were not checking this so an MSS less than that was resulting
in Tx hangs.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I5e2fd5f3075c73601b4b36327b771c64fcb6c31b
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

 drivers/net/ethernet/intel/i40e/i40e_main.c | 52 ++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 77c6b19..3a759ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9114,10 +9114,6 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				       nlflags, 0, 0, filter_mask, NULL);
 }
 
-/* Hardware supports L4 tunnel length of 128B (=2^7) which includes
- * inner mac plus all inner ethertypes.
- */
-#define I40E_MAX_TUNNEL_HDR_LEN 128
 /**
  * i40e_features_check - Validate encapsulated packet conforms to limits
  * @skb: skb buff
@@ -9128,12 +9124,52 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
 					     struct net_device *dev,
 					     netdev_features_t features)
 {
-	if (skb->encapsulation &&
-	    ((skb_inner_network_header(skb) - skb_transport_header(skb)) >
-	     I40E_MAX_TUNNEL_HDR_LEN))
-		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
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
 
 	return features;
+out_err:
+	return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
 }
 
 static const struct net_device_ops i40e_netdev_ops = {
-- 
2.4.11

