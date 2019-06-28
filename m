From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 28 Jun 2019 08:03:26 -0700
Subject: [Intel-wired-lan] [PATCH S23 v2 08/15] ice: allow empty rx
 descriptors
In-Reply-To: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
Message-ID: <20190628150332.59155-8-anthony.l.nguyen@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_txrx.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 1085ab920155..309207de1e86 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -859,6 +859,8 @@ ice_add_rx_frag(struct ice_rx_buf *rx_buf, struct sk_buff *skb,
 	unsigned int truesize = ICE_RXBUF_2048;
 #endif
 
+	if (!size)
+		return;
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
 			rx_buf->page_offset, size, truesize);
 
@@ -914,6 +916,8 @@ ice_get_rx_buf(struct ice_ring *rx_ring, struct sk_buff **skb,
 	prefetchw(rx_buf->page);
 	*skb = rx_buf->skb;
 
+	if (!size)
+		return rx_buf;
 	/* we are reusing so sync this buffer for CPU use */
 	dma_sync_single_range_for_cpu(rx_ring->dev, rx_buf->dma,
 				      rx_buf->page_offset, size,
@@ -1005,6 +1009,9 @@ static void ice_put_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
 	ntc = (ntc < rx_ring->count) ? ntc : 0;
 	rx_ring->next_to_clean = ntc;
 
+	if (!rx_buf)
+		return;
+
 	if (ice_can_reuse_rx_page(rx_buf)) {
 		/* hand second half of page back to the ring */
 		ice_reuse_rx_page(rx_ring, rx_buf);
@@ -1298,12 +1305,15 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		size = le16_to_cpu(rx_desc->wb.pkt_len) &
 			ICE_RX_FLX_DESC_PKT_LEN_M;
 
-		if (!size)
-			break;
-
 		/* retrieve a buffer from the ring */
 		rx_buf = ice_get_rx_buf(rx_ring, &skb, size);
 
+		if (!size) {
+			xdp.data = NULL;
+			xdp.data_end = NULL;
+			goto construct_skb;
+		}
+
 		xdp.data = page_address(rx_buf->page) + rx_buf->page_offset;
 		xdp.data_hard_start = xdp.data - ice_rx_offset(rx_ring);
 		xdp.data_end = xdp.data + size;
@@ -1342,7 +1352,8 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
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

