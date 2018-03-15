From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 15 Mar 2018 14:23:22 -0700
Subject: [Intel-wired-lan] [next-queue 3/4] ixgbe: no need for esp trailer
 if gso
In-Reply-To: <1521149003-1433-1-git-send-email-shannon.nelson@oracle.com>
References: <1521149003-1433-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1521149003-1433-4-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is no need to calculate the trailer length if we're doing
a GSO/TSO, as there is no trailer added to the packet data.
Also, don't bother clearing the flags field as it was already
cleared earlier.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 37 +++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index f225452..5ddea43 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -774,11 +774,7 @@ int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
 
 	first->tx_flags |= IXGBE_TX_FLAGS_IPSEC | IXGBE_TX_FLAGS_CC;
 
-	itd->flags = 0;
 	if (xs->id.proto == IPPROTO_ESP) {
-		struct sk_buff *skb = first->skb;
-		int ret, authlen, trailerlen;
-		u8 padlen;
 
 		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_TYPE_ESP |
 			      IXGBE_ADVTXD_TUCMD_L4T_TCP;
@@ -790,19 +786,28 @@ int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
 		 * padlen bytes of padding.  This ends up not the same
 		 * as the static value found in xs->props.trailer_len (21).
 		 *
-		 * The "correct" way to get the auth length would be to use
-		 *    authlen = crypto_aead_authsize(xs->data);
-		 * but since we know we only have one size to worry about
-		 * we can let the compiler use the constant and save us a
-		 * few CPU cycles.
+		 * ... but if we're doing GSO, don't bother as the stack
+		 * doesn't add a trailer for those.
 		 */
-		authlen = IXGBE_IPSEC_AUTH_BITS / 8;
-
-		ret = skb_copy_bits(skb, skb->len - (authlen + 2), &padlen, 1);
-		if (unlikely(ret))
-			return 0;
-		trailerlen = authlen + 2 + padlen;
-		itd->trailer_len = trailerlen;
+		if (!skb_is_gso(first->skb)) {
+			/* The "correct" way to get the auth length would be
+			 * to use
+			 *    authlen = crypto_aead_authsize(xs->data);
+			 * but since we know we only have one size to worry
+			 * about * we can let the compiler use the constant
+			 * and save us a few CPU cycles.
+			 */
+			const int authlen = IXGBE_IPSEC_AUTH_BITS / 8;
+			struct sk_buff *skb = first->skb;
+			u8 padlen;
+			int ret;
+
+			ret = skb_copy_bits(skb, skb->len - (authlen + 2),
+					    &padlen, 1);
+			if (unlikely(ret))
+				return 0;
+			itd->trailer_len = authlen + 2 + padlen;
+		}
 	}
 	if (tsa->encrypt)
 		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN;
-- 
2.7.4

