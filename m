From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 16 Jan 2021 14:13:38 +0800
Subject: [Intel-wired-lan] [PATCH net-next 2/6] net: igb: use
 skb_csum_is_sctp instead of protocol check
In-Reply-To: <34c9f5b8c31610687925d9db1f151d5bc87deba7.1610777159.git.lucien.xin@gmail.com>
References: <cover.1610777159.git.lucien.xin@gmail.com>
 <34c9f5b8c31610687925d9db1f151d5bc87deba7.1610777159.git.lucien.xin@gmail.com>
Message-ID: <aa69157e286b0178bf115124f4b2da254e07a291.1610777159.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Using skb_csum_is_sctp is a easier way to validate it's a SCTP
CRC checksum offload packet, and there is no need to parse the
packet to check its proto field, especially when it's a UDP or
GRE encapped packet.

So this patch also makes igb support SCTP CRC checksum offload
for UDP and GRE encapped packets.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 03f78fd..8757ad0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5959,15 +5959,6 @@ static int igb_tso(struct igb_ring *tx_ring,
 	return 1;
 }
 
-static inline bool igb_ipv6_csum_is_sctp(struct sk_buff *skb)
-{
-	unsigned int offset = 0;
-
-	ipv6_find_hdr(skb, &offset, IPPROTO_SCTP, NULL, NULL);
-
-	return offset == skb_checksum_start_offset(skb);
-}
-
 static void igb_tx_csum(struct igb_ring *tx_ring, struct igb_tx_buffer *first)
 {
 	struct sk_buff *skb = first->skb;
@@ -5990,10 +5981,7 @@ static void igb_tx_csum(struct igb_ring *tx_ring, struct igb_tx_buffer *first)
 		break;
 	case offsetof(struct sctphdr, checksum):
 		/* validate that this is actually an SCTP request */
-		if (((first->protocol == htons(ETH_P_IP)) &&
-		     (ip_hdr(skb)->protocol == IPPROTO_SCTP)) ||
-		    ((first->protocol == htons(ETH_P_IPV6)) &&
-		     igb_ipv6_csum_is_sctp(skb))) {
+		if (skb_csum_is_sctp(skb)) {
 			type_tucmd = E1000_ADVTXD_TUCMD_L4T_SCTP;
 			break;
 		}
-- 
2.1.0

