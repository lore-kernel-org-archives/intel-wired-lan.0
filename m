From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 16 Jan 2021 14:13:39 +0800
Subject: [Intel-wired-lan] [PATCH net-next 3/6] net: igbvf: use
 skb_csum_is_sctp instead of protocol check
In-Reply-To: <aa69157e286b0178bf115124f4b2da254e07a291.1610777159.git.lucien.xin@gmail.com>
References: <cover.1610777159.git.lucien.xin@gmail.com>
 <34c9f5b8c31610687925d9db1f151d5bc87deba7.1610777159.git.lucien.xin@gmail.com>
 <aa69157e286b0178bf115124f4b2da254e07a291.1610777159.git.lucien.xin@gmail.com>
Message-ID: <c1a1972ea509a7559a8900e1a33212d09f58f3c9.1610777159.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Using skb_csum_is_sctp is a easier way to validate it's a SCTP CRC
checksum offload packet, and yet it also makes igbvf support SCTP
CRC checksum offload for UDP and GRE encapped packets, just as it
does in igb driver.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 30fdea2..fb3fbcb 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2072,15 +2072,6 @@ static int igbvf_tso(struct igbvf_ring *tx_ring,
 	return 1;
 }
 
-static inline bool igbvf_ipv6_csum_is_sctp(struct sk_buff *skb)
-{
-	unsigned int offset = 0;
-
-	ipv6_find_hdr(skb, &offset, IPPROTO_SCTP, NULL, NULL);
-
-	return offset == skb_checksum_start_offset(skb);
-}
-
 static bool igbvf_tx_csum(struct igbvf_ring *tx_ring, struct sk_buff *skb,
 			  u32 tx_flags, __be16 protocol)
 {
@@ -2102,10 +2093,7 @@ static bool igbvf_tx_csum(struct igbvf_ring *tx_ring, struct sk_buff *skb,
 		break;
 	case offsetof(struct sctphdr, checksum):
 		/* validate that this is actually an SCTP request */
-		if (((protocol == htons(ETH_P_IP)) &&
-		     (ip_hdr(skb)->protocol == IPPROTO_SCTP)) ||
-		    ((protocol == htons(ETH_P_IPV6)) &&
-		     igbvf_ipv6_csum_is_sctp(skb))) {
+		if (skb_csum_is_sctp(skb)) {
 			type_tucmd = E1000_ADVTXD_TUCMD_L4T_SCTP;
 			break;
 		}
-- 
2.1.0

