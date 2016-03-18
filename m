From: Alexander Duyck <aduyck@mirantis.com>
Date: Fri, 18 Mar 2016 16:06:47 -0700
Subject: [Intel-wired-lan] [next PATCH 1/2] i40e/i40evf: Fix TSO checksum
 pseudo-header adjustment
In-Reply-To: <20160318230425.14801.87895.stgit@localhost.localdomain>
References: <20160318230425.14801.87895.stgit@localhost.localdomain>
Message-ID: <20160318230647.14801.24078.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With IPv4 and IPv6 now using the same format for checksums based on the
length of the frame we need to update the i40e and i40evf drivers so that
they correctly account for lengths greater than or equal to 64K.

With this patch the driver should now correctly update checksums for frames
up to 16776960 in length which should be more than large enough for all
possible TSO frames in the near future.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   11 ++++-------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   11 ++++-------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 5bef5b0f00d9..5d5fa5359a1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2304,10 +2304,8 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 			l4_offset = l4.hdr - skb->data;
 
 			/* remove payload length from outer checksum */
-			paylen = (__force u16)l4.udp->check;
-			paylen += ntohs((__force __be16)1) *
-					(u16)~(skb->len - l4_offset);
-			l4.udp->check = ~csum_fold((__force __wsum)paylen);
+			paylen = skb->len - l4_offset;
+			csum_replace_by_diff(&l4.udp->check, htonl(paylen));
 		}
 
 		/* reset pointers to inner headers */
@@ -2327,9 +2325,8 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	l4_offset = l4.hdr - skb->data;
 
 	/* remove payload length from inner checksum */
-	paylen = (__force u16)l4.tcp->check;
-	paylen += ntohs((__force __be16)1) * (u16)~(skb->len - l4_offset);
-	l4.tcp->check = ~csum_fold((__force __wsum)paylen);
+	paylen = skb->len - l4_offset;
+	csum_replace_by_diff(&l4.tcp->check, htonl(paylen));
 
 	/* compute length of segmentation header */
 	*hdr_len = (l4.tcp->doff * 4) + l4_offset;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 570348d93e5d..04aabc52ba0d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1571,10 +1571,8 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 			l4_offset = l4.hdr - skb->data;
 
 			/* remove payload length from outer checksum */
-			paylen = (__force u16)l4.udp->check;
-			paylen += ntohs((__force __be16)1) *
-					(u16)~(skb->len - l4_offset);
-			l4.udp->check = ~csum_fold((__force __wsum)paylen);
+			paylen = skb->len - l4_offset;
+			csum_replace_by_diff(&l4.udp->check, htonl(paylen));
 		}
 
 		/* reset pointers to inner headers */
@@ -1594,9 +1592,8 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	l4_offset = l4.hdr - skb->data;
 
 	/* remove payload length from inner checksum */
-	paylen = (__force u16)l4.tcp->check;
-	paylen += ntohs((__force __be16)1) * (u16)~(skb->len - l4_offset);
-	l4.tcp->check = ~csum_fold((__force __wsum)paylen);
+	paylen = skb->len - l4_offset;
+	csum_replace_by_diff(&l4.tcp->check, htonl(paylen));
 
 	/* compute length of segmentation header */
 	*hdr_len = (l4.tcp->doff * 4) + l4_offset;

