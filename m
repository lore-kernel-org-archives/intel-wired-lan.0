From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue,  7 Dec 2021 21:55:34 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 7/9] ixgbe: pass bi->xdp to
 ixgbe_construct_skb_zc() directly
In-Reply-To: <20211207205536.563550-1-alexandr.lobakin@intel.com>
References: <20211207205536.563550-1-alexandr.lobakin@intel.com>
Message-ID: <20211207205536.563550-8-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To not dereference bi->xdp each time in ixgbe_construct_skb_zc(),
pass bi->xdp as an argument instead of bi. We can also call
xsk_buff_free() outside of the function as well as assign bi->xdp
to NULL, which seems to make it closer to its name.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index db2bc58dfcfd..1d74a7980d81 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -207,26 +207,24 @@ bool ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 count)
 }
 
 static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
-					      struct ixgbe_rx_buffer *bi)
+					      const struct xdp_buff *xdp)
 {
-	unsigned int metasize = bi->xdp->data - bi->xdp->data_meta;
-	unsigned int datasize = bi->xdp->data_end - bi->xdp->data;
+	unsigned int metasize = xdp->data - xdp->data_meta;
+	unsigned int datasize = xdp->data_end - xdp->data;
 	struct sk_buff *skb;
 
 	/* allocate a skb to store the frags */
 	skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
-			       bi->xdp->data_end - bi->xdp->data_hard_start,
+			       xdp->data_end - xdp->data_hard_start,
 			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
 		return NULL;
 
-	skb_reserve(skb, bi->xdp->data - bi->xdp->data_hard_start);
-	memcpy(__skb_put(skb, datasize), bi->xdp->data, datasize);
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
-	xsk_buff_free(bi->xdp);
-	bi->xdp = NULL;
 	return skb;
 }
 
@@ -317,12 +315,15 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 		}
 
 		/* XDP_PASS path */
-		skb = ixgbe_construct_skb_zc(rx_ring, bi);
+		skb = ixgbe_construct_skb_zc(rx_ring, bi->xdp);
 		if (!skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			break;
 		}
 
+		xsk_buff_free(bi->xdp);
+		bi->xdp = NULL;
+
 		cleaned_count++;
 		ixgbe_inc_ntc(rx_ring);
 
-- 
2.33.1

