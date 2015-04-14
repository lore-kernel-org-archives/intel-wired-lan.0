From: Fan Du <fan.du@intel.com>
Date: Tue, 14 Apr 2015 14:56:11 +0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Specify rx hash type wrt rx desc
	RSS type
Message-ID: <1428994571-16976-1-git-send-email-fan.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

RSS could be leveraged by taking account L4 src/dst ports
as ingredients, thus ingress skb rx hash type should honor
such the real configuration.

Signed-off-by: Fan Du <fan.du@intel.com>
---
Sorry for resending, I forgot to subscribe intel-wired-lan at lists.osuosl.org
as previous mail is being held by list moderator.

note:
1. I checked ixgbe_pci_tbl for 82598, 82599 x540 series,
   RSS type in adavanced descriptor is all supported.
   x550 is in trial version, so not checked.

2. ixgbevf looks like didn't even set rx hash type
   I'm not sure why this is left behind. IMHO it should be there.

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   23 +++++++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 395dc6b..8915992 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1357,14 +1357,33 @@ static int __ixgbe_notify_dca(struct device *dev, void *data)
 }
 
 #endif /* CONFIG_IXGBE_DCA */
+static inline enum pkt_hash_types ixgbe_get_hash_type(__le16 pkt_info)
+{
+	switch (pkt_info & cpu_to_le16(IXGBE_RXDADV_RSSTYPE_MASK)) {
+	case IXGBE_RXDADV_RSSTYPE_IPV4_TCP:
+	case IXGBE_RXDADV_RSSTYPE_IPV4_UDP:
+	case IXGBE_RXDADV_RSSTYPE_IPV6_TCP:
+	case IXGBE_RXDADV_RSSTYPE_IPV6_UDP:
+		return PKT_HASH_TYPE_L4;
+	case IXGBE_RXDADV_RSSTYPE_IPV4:
+	case IXGBE_RXDADV_RSSTYPE_IPV6:
+		return PKT_HASH_TYPE_L3;
+	default:
+		return PKT_HASH_TYPE_NONE;
+	}
+}
+
 static inline void ixgbe_rx_hash(struct ixgbe_ring *ring,
 				 union ixgbe_adv_rx_desc *rx_desc,
 				 struct sk_buff *skb)
 {
-	if (ring->netdev->features & NETIF_F_RXHASH)
+	if (ring->netdev->features & NETIF_F_RXHASH) {
+		__le16 pkt_info = rx_desc->wb.lower.lo_dword.hs_rss.pkt_info;
+
 		skb_set_hash(skb,
 			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
-			     PKT_HASH_TYPE_L3);
+			     ixgbe_get_hash_type(pkt_info));
+	}
 }
 
 #ifdef IXGBE_FCOE
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index c3ddc94..97d600e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2225,6 +2225,7 @@ enum {
 #define IXGBE_RXDADV_RSSTYPE_IPV4_UDP   0x00000007
 #define IXGBE_RXDADV_RSSTYPE_IPV6_UDP   0x00000008
 #define IXGBE_RXDADV_RSSTYPE_IPV6_UDP_EX 0x00000009
+#define IXGBE_RXDADV_RSSTYPE_MASK       0x0000000F
 
 /* RSS Packet Types as indicated in the receive descriptor. */
 #define IXGBE_RXDADV_PKTTYPE_NONE       0x00000000
-- 
1.7.1

