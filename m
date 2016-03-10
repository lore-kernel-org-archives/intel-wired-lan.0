From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:39 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 01/13] i40e/i40evf: Fix
	casting in transmit code
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-2-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

    Simple cast to fix a sparse warning.

    Testing Hints: Test with sparse compile (make
    sparse)

Fixes: commit 5453205cd097 ("i40e/i40evf: Enable support for
SKB_GSO_UDP_TUNNEL_CSUM")

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 5 +++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9af1411..f6c9602 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2300,7 +2300,8 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 			/* remove payload length from outer checksum */
 			paylen = (__force u16)l4.udp->check;
-			paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
+			paylen += ntohs((__force __be16)1) *
+					(u16)~(skb->len - l4_offset);
 			l4.udp->check = ~csum_fold((__force __wsum)paylen);
 		}
 
@@ -2322,7 +2323,7 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	/* remove payload length from inner checksum */
 	paylen = (__force u16)l4.tcp->check;
-	paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
+	paylen += ntohs((__force __be16)1) * (u16)~(skb->len - l4_offset);
 	l4.tcp->check = ~csum_fold((__force __wsum)paylen);
 
 	/* compute length of segmentation header */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 5f9c1bb..b5af865 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1567,7 +1567,8 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 			/* remove payload length from outer checksum */
 			paylen = (__force u16)l4.udp->check;
-			paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
+			paylen += ntohs((__force __be16)1) *
+					(u16)~(skb->len - l4_offset);
 			l4.udp->check = ~csum_fold((__force __wsum)paylen);
 		}
 
@@ -1589,7 +1590,7 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	/* remove payload length from inner checksum */
 	paylen = (__force u16)l4.tcp->check;
-	paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
+	paylen += ntohs((__force __be16)1) * (u16)~(skb->len - l4_offset);
 	l4.tcp->check = ~csum_fold((__force __wsum)paylen);
 
 	/* compute length of segmentation header */
-- 
2.4.3

