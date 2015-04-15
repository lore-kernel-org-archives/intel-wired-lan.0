From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Wed, 15 Apr 2015 00:29:19 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Specify rx hash type wrt rx
 desc	RSS type
In-Reply-To: <1428994571-16976-1-git-send-email-fan.du@intel.com>
References: <1428994571-16976-1-git-send-email-fan.du@intel.com>
Message-ID: <87618083B2453E4A8714035B62D6799250295BAB@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Fan Du
>Sent: Monday, April 13, 2015 11:56 PM
>Subject: [Intel-wired-lan] [PATCH] ixgbe: Specify rx hash type wrt rx desc RSS type
>
>RSS could be leveraged by taking account L4 src/dst ports
>as ingredients, thus ingress skb rx hash type should honor
>such the real configuration.
>
>Signed-off-by: Fan Du <fan.du@intel.com>
>---
>Sorry for resending, I forgot to subscribe intel-wired-lan at lists.osuosl.org
>as previous mail is being held by list moderator.
>
>note:
>1. I checked ixgbe_pci_tbl for 82598, 82599 x540 series,
>   RSS type in adavanced descriptor is all supported.
>   x550 is in trial version, so not checked.
>
>2. ixgbevf looks like didn't even set rx hash type
>   I'm not sure why this is left behind. IMHO it should be there.

I will look into it.

>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   23 +++++++++++++++++++++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
> 2 files changed, 22 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>index 395dc6b..8915992 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>@@ -1357,14 +1357,33 @@ static int __ixgbe_notify_dca(struct device *dev, void *data)
> }
> 
> #endif /* CONFIG_IXGBE_DCA */
>+static inline enum pkt_hash_types ixgbe_get_hash_type(__le16 pkt_info)
>+{
>+	switch (pkt_info & cpu_to_le16(IXGBE_RXDADV_RSSTYPE_MASK)) {
>+	case IXGBE_RXDADV_RSSTYPE_IPV4_TCP:
>+	case IXGBE_RXDADV_RSSTYPE_IPV4_UDP:
>+	case IXGBE_RXDADV_RSSTYPE_IPV6_TCP:
>+	case IXGBE_RXDADV_RSSTYPE_IPV6_UDP:
>+		return PKT_HASH_TYPE_L4;
>+	case IXGBE_RXDADV_RSSTYPE_IPV4:
>+	case IXGBE_RXDADV_RSSTYPE_IPV6:
>+		return PKT_HASH_TYPE_L3;
>+	default:
>+		return PKT_HASH_TYPE_NONE;
>+	}
>+}
>+
> static inline void ixgbe_rx_hash(struct ixgbe_ring *ring,
> 				 union ixgbe_adv_rx_desc *rx_desc,
> 				 struct sk_buff *skb)
> {
>-	if (ring->netdev->features & NETIF_F_RXHASH)
>+	if (ring->netdev->features & NETIF_F_RXHASH) {
>+		__le16 pkt_info = rx_desc->wb.lower.lo_dword.hs_rss.pkt_info;
>+
> 		skb_set_hash(skb,
> 			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
>-			     PKT_HASH_TYPE_L3);
>+			     ixgbe_get_hash_type(pkt_info));
>+	}
> }
> 
> #ifdef IXGBE_FCOE
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>index c3ddc94..97d600e 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>@@ -2225,6 +2225,7 @@ enum {
> #define IXGBE_RXDADV_RSSTYPE_IPV4_UDP   0x00000007
> #define IXGBE_RXDADV_RSSTYPE_IPV6_UDP   0x00000008
> #define IXGBE_RXDADV_RSSTYPE_IPV6_UDP_EX 0x00000009
+#define IXGBE_RXDADV_RSSTYPE_MASK       0x0000000F

This define already exists in ixgbe_type.h.

The out of tree driver has this already implemented. I guess we did not push it upstream:

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 66adbd0..96703de 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1357,14 +1357,33 @@ static int __ixgbe_notify_dca(struct device *dev, void *data)
 }
 
 #endif /* CONFIG_IXGBE_DCA */
+
+#define IXGBE_RSS_L4_TYPES_MASK \
+	((1ul << IXGBE_RXDADV_RSSTYPE_IPV4_TCP) | \
+	 (1ul << IXGBE_RXDADV_RSSTYPE_IPV4_UDP) | \
+	 (1ul << IXGBE_RXDADV_RSSTYPE_IPV6_TCP) | \
+	 (1ul << IXGBE_RXDADV_RSSTYPE_IPV6_UDP) | \
+	 (1ul << IXGBE_RXDADV_RSSTYPE_IPV6_TCP_EX) | \
+	 (1ul << IXGBE_RXDADV_RSSTYPE_IPV6_UDP_EX))
+
 static inline void ixgbe_rx_hash(struct ixgbe_ring *ring,
 				 union ixgbe_adv_rx_desc *rx_desc,
 				 struct sk_buff *skb)
 {
-	if (ring->netdev->features & NETIF_F_RXHASH)
-		skb_set_hash(skb,
-			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
-			     PKT_HASH_TYPE_L3);
+	u16 rss_type; 
+
+	if (!(ring->netdev->features & NETIF_F_RXHASH))
+		return;
+
+	rss_type = le16_to_cpu(rx_desc->wb.lower.lo_dword.hs_rss.pkt_info) &
+		   IXGBE_RXDADV_RSSTYPE_MASK;
+
+	if (!rss_type)
+		return;
+
+	skb_set_hash(skb, le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
+		     (IXGBE_RSS_L4_TYPES_MASK & (1ul << rss_type)) ?
+		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
 }
 
 #ifdef IXGBE_FCOE

Thanks,
Emil
