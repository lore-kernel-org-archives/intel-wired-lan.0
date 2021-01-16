From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 16 Jan 2021 14:13:41 +0800
Subject: [Intel-wired-lan] [PATCH net-next 5/6] net: ixgbe: use
 skb_csum_is_sctp instead of protocol check
In-Reply-To: <7b4d84fe32d588884fcd75c2f6f84eb8cd052622.1610777159.git.lucien.xin@gmail.com>
References: <cover.1610777159.git.lucien.xin@gmail.com>
 <34c9f5b8c31610687925d9db1f151d5bc87deba7.1610777159.git.lucien.xin@gmail.com>
 <aa69157e286b0178bf115124f4b2da254e07a291.1610777159.git.lucien.xin@gmail.com>
 <c1a1972ea509a7559a8900e1a33212d09f58f3c9.1610777159.git.lucien.xin@gmail.com>
 <7b4d84fe32d588884fcd75c2f6f84eb8cd052622.1610777159.git.lucien.xin@gmail.com>
Message-ID: <f58d50ef96eb1504f4a952cc75a19d21dcf85827.1610777159.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Using skb_csum_is_sctp is a easier way to validate it's a SCTP CRC
checksum offload packet, and yet it also makes ixgbe support SCTP
CRC checksum offload for UDP and GRE encapped packets, just as it
does in igb driver.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6cbbe09..2973c54 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8040,15 +8040,6 @@ static int ixgbe_tso(struct ixgbe_ring *tx_ring,
 	return 1;
 }
 
-static inline bool ixgbe_ipv6_csum_is_sctp(struct sk_buff *skb)
-{
-	unsigned int offset = 0;
-
-	ipv6_find_hdr(skb, &offset, IPPROTO_SCTP, NULL, NULL);
-
-	return offset == skb_checksum_start_offset(skb);
-}
-
 static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 			  struct ixgbe_tx_buffer *first,
 			  struct ixgbe_ipsec_tx_data *itd)
@@ -8074,10 +8065,7 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 		break;
 	case offsetof(struct sctphdr, checksum):
 		/* validate that this is actually an SCTP request */
-		if (((first->protocol == htons(ETH_P_IP)) &&
-		     (ip_hdr(skb)->protocol == IPPROTO_SCTP)) ||
-		    ((first->protocol == htons(ETH_P_IPV6)) &&
-		     ixgbe_ipv6_csum_is_sctp(skb))) {
+		if (skb_csum_is_sctp(skb)) {
 			type_tucmd = IXGBE_ADVTXD_TUCMD_L4T_SCTP;
 			break;
 		}
-- 
2.1.0

