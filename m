From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 01:55:34 -0700
Subject: [Intel-wired-lan] [PATCH S23 v4 08/15] ice: allow empty rx
 descriptors
In-Reply-To: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725085541.55104-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In some circumstances, the hardware will hand us a receive descriptor
which has no data attached, but is otherwise valid. The receive code was
improperly ignoring these descriptors, which result in an infinite loop.

To fix this, change the receive code to process all descriptors,
regardless of the size of the associated data. Add checks to the
memory-handling functions to allow for zero size.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 9a54406922f0..75b0afe02015 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -607,6 +607,8 @@ ice_add_rx_frag(struct ice_rx_buf *rx_buf, struct sk_buff *skb,
 	unsigned int truesize = ICE_RXBUF_2048;
 #endif
 
+	if (!size)
+		return;
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
 			rx_buf->page_offset, size, truesize);
 
@@ -662,6 +664,8 @@ ice_get_rx_buf(struct ice_ring *rx_ring, struct sk_buff **skb,
 	prefetchw(rx_buf->page);
 	*skb = rx_buf->skb;
 
+	if (!size)
+		return rx_buf;
 	/* we are reusing so sync this buffer for CPU use */
 	dma_sync_single_range_for_cpu(rx_ring->dev, rx_buf->dma,
 				      rx_buf->page_offset, size,
@@ -745,8 +749,11 @@ ice_construct_skb(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
  */
 static void ice_put_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
 {
-		/* hand second half of page back to the ring */
+	if (!rx_buf)
+		return;
+
 	if (ice_can_reuse_rx_page(rx_buf)) {
+		/* hand second half of page back to the ring */
 		ice_reuse_rx_page(rx_ring, rx_buf);
 		rx_ring->rx_stats.page_reuse_count++;
 	} else {
@@ -1032,8 +1039,9 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		size = le16_to_cpu(rx_desc->wb.pkt_len) &
 			ICE_RX_FLX_DESC_PKT_LEN_M;
 
+		/* retrieve a buffer from the ring */
 		rx_buf = ice_get_rx_buf(rx_ring, &skb, size);
-		/* allocate (if needed) and populate skb */
+
 		if (skb)
 			ice_add_rx_frag(rx_buf, skb, size);
 		else
@@ -1042,7 +1050,8 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_buf_failed++;
-			rx_buf->pagecnt_bias++;
+			if (rx_buf)
+				rx_buf->pagecnt_bias++;
 			break;
 		}
 
-- 
2.20.1

