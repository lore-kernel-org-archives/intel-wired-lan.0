From: Fan Du <fan.du@intel.com>
Date: Wed, 15 Apr 2015 11:12:22 +0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Set rx hash type for ingress
	packets
In-Reply-To: <87618083B2453E4A8714035B62D6799250295BAB@FMSMSX105.amr.corp.intel.com>
References: <87618083B2453E4A8714035B62D6799250295BAB@FMSMSX105.amr.corp.intel.com>
Message-ID: <1429067542-20845-1-git-send-email-fan.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set hash type for ingress packets according to NIC
advanced receive descriptors RSS type part.

also use le16_to_cpu forcing type conversion to slient
endian check warnings.

Signed-off-by: Fan Du <fan.du@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |    2 +-
 drivers/net/ethernet/intel/ixgbevf/defines.h      |   12 ++++++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   30 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8915992..1b3b5fb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1359,7 +1359,7 @@ static int __ixgbe_notify_dca(struct device *dev, void *data)
 #endif /* CONFIG_IXGBE_DCA */
 static inline enum pkt_hash_types ixgbe_get_hash_type(__le16 pkt_info)
 {
-	switch (pkt_info & cpu_to_le16(IXGBE_RXDADV_RSSTYPE_MASK)) {
+	switch (le16_to_cpu(pkt_info) & IXGBE_RXDADV_RSSTYPE_MASK) {
 	case IXGBE_RXDADV_RSSTYPE_IPV4_TCP:
 	case IXGBE_RXDADV_RSSTYPE_IPV4_UDP:
 	case IXGBE_RXDADV_RSSTYPE_IPV6_TCP:
diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 770e21a..040f7ca 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -151,7 +151,19 @@ typedef u32 ixgbe_link_speed;
 #define IXGBE_RXDADV_STAT_FCSTAT_FCPRSP	0x00000020 /* 10: Recv. FCP_RSP */
 #define IXGBE_RXDADV_STAT_FCSTAT_DDP	0x00000030 /* 11: Ctxt w/ DDP */
 
+/* RSS Hash results */
+#define IXGBE_RXDADV_RSSTYPE_NONE       0x00000000
+#define IXGBE_RXDADV_RSSTYPE_IPV4_TCP   0x00000001
+#define IXGBE_RXDADV_RSSTYPE_IPV4       0x00000002
+#define IXGBE_RXDADV_RSSTYPE_IPV6_TCP   0x00000003
+#define IXGBE_RXDADV_RSSTYPE_IPV6_EX    0x00000004
+#define IXGBE_RXDADV_RSSTYPE_IPV6       0x00000005
+#define IXGBE_RXDADV_RSSTYPE_IPV6_TCP_EX 0x00000006
+#define IXGBE_RXDADV_RSSTYPE_IPV4_UDP   0x00000007
+#define IXGBE_RXDADV_RSSTYPE_IPV6_UDP   0x00000008
+#define IXGBE_RXDADV_RSSTYPE_IPV6_UDP_EX 0x00000009
 #define IXGBE_RXDADV_RSSTYPE_MASK	0x0000000F
+
 #define IXGBE_RXDADV_PKTTYPE_MASK	0x0000FFF0
 #define IXGBE_RXDADV_PKTTYPE_MASK_EX	0x0001FFF0
 #define IXGBE_RXDADV_HDRBUFLEN_MASK	0x00007FE0
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 4ee15ad..e529744 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -492,6 +492,35 @@ static inline void ixgbevf_rx_checksum(struct ixgbevf_ring *ring,
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
+static inline enum pkt_hash_types ixgbevf_get_hash_type(__le16 pkt_info)
+{
+	switch ((le16_to_cpu(pkt_info) & IXGBE_RXDADV_RSSTYPE_MASK)) {
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
+static inline void ixgbevf_rx_hash(struct ixgbevf_ring *ring,
+				   union ixgbe_adv_rx_desc *rx_desc,
+				   struct sk_buff *skb)
+{
+	if (ring->netdev->features & NETIF_F_RXHASH) {
+		__le16 pkt_info = rx_desc->wb.lower.lo_dword.hs_rss.pkt_info;
+
+		skb_set_hash(skb,
+			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
+			     ixgbevf_get_hash_type(pkt_info));
+	}
+}
+
 /**
  * ixgbevf_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: rx descriptor ring packet is being transacted on
@@ -507,6 +536,7 @@ static void ixgbevf_process_skb_fields(struct ixgbevf_ring *rx_ring,
 				       struct sk_buff *skb)
 {
 	ixgbevf_rx_checksum(rx_ring, rx_desc, skb);
+	ixgbevf_rx_hash(rx_ring, rx_desc, skb);
 
 	if (ixgbevf_test_staterr(rx_desc, IXGBE_RXD_STAT_VP)) {
 		u16 vid = le16_to_cpu(rx_desc->wb.upper.vlan);
-- 
1.7.1

