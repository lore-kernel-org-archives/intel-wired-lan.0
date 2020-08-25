From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 25 Aug 2020 14:13:23 +0200
Subject: [Intel-wired-lan] [PATCH net v2 3/3] ice: avoid premature Rx buffer
 reuse
In-Reply-To: <20200825121323.20239-1-bjorn.topel@gmail.com>
References: <20200825121323.20239-1-bjorn.topel@gmail.com>
Message-ID: <20200825121323.20239-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The page recycle code, incorrectly, relied on that a page fragment
could not be freed inside xdp_do_redirect(). This assumption leads to
that page fragments that are used by the stack/XDP redirect can be
reused and overwritten.

To avoid this, store the page count prior invoking xdp_do_redirect().

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reported-and-analyzed-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 27 +++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 9d0d6b0025cf..924d34ad9fa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -768,7 +768,8 @@ ice_rx_buf_adjust_pg_offset(struct ice_rx_buf *rx_buf, unsigned int size)
  * pointing to; otherwise, the DMA mapping needs to be destroyed and
  * page freed
  */
-static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
+static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf,
+				  int rx_buf_pgcnt)
 {
 	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
 	struct page *page = rx_buf->page;
@@ -779,7 +780,7 @@ static bool ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
 
 #if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
-	if (unlikely((page_count(page) - pagecnt_bias) > 1))
+	if (unlikely((rx_buf_pgcnt - pagecnt_bias) > 1))
 		return false;
 #else
 #define ICE_LAST_OFFSET \
@@ -870,11 +871,18 @@ ice_reuse_rx_page(struct ice_ring *rx_ring, struct ice_rx_buf *old_buf)
  */
 static struct ice_rx_buf *
 ice_get_rx_buf(struct ice_ring *rx_ring, struct sk_buff **skb,
-	       const unsigned int size)
+	       const unsigned int size,
+	       int *rx_buf_pgcnt)
 {
 	struct ice_rx_buf *rx_buf;
 
 	rx_buf = &rx_ring->rx_buf[rx_ring->next_to_clean];
+	*rx_buf_pgcnt =
+#if (PAGE_SIZE < 8192)
+		page_count(rx_buf->page);
+#else
+		0;
+#endif
 	prefetchw(rx_buf->page);
 	*skb = rx_buf->skb;
 
@@ -1017,7 +1025,7 @@ ice_construct_skb(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
  * of the rx_buf. It will either recycle the buffer or unmap it and free
  * the associated resources.
  */
-static void ice_put_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
+static void ice_put_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf, int rx_buf_pgcnt)
 {
 	u16 ntc = rx_ring->next_to_clean + 1;
 
@@ -1028,7 +1036,7 @@ static void ice_put_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
 	if (!rx_buf)
 		return;
 
-	if (ice_can_reuse_rx_page(rx_buf)) {
+	if (ice_can_reuse_rx_page(rx_buf, rx_buf_pgcnt)) {
 		/* hand second half of page back to the ring */
 		ice_reuse_rx_page(rx_ring, rx_buf);
 	} else {
@@ -1103,6 +1111,7 @@ int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		struct sk_buff *skb;
 		unsigned int size;
 		u16 stat_err_bits;
+		int rx_buf_pgcnt;
 		u16 vlan_tag = 0;
 		u8 rx_ptype;
 
@@ -1125,7 +1134,7 @@ int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		dma_rmb();
 
 		if (rx_desc->wb.rxdid == FDIR_DESC_RXDID || !rx_ring->netdev) {
-			ice_put_rx_buf(rx_ring, NULL);
+			ice_put_rx_buf(rx_ring, NULL, 0);
 			cleaned_count++;
 			continue;
 		}
@@ -1134,7 +1143,7 @@ int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 			ICE_RX_FLX_DESC_PKT_LEN_M;
 
 		/* retrieve a buffer from the ring */
-		rx_buf = ice_get_rx_buf(rx_ring, &skb, size);
+		rx_buf = ice_get_rx_buf(rx_ring, &skb, size, &rx_buf_pgcnt);
 
 		if (!size) {
 			xdp.data = NULL;
@@ -1174,7 +1183,7 @@ int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 		total_rx_pkts++;
 
 		cleaned_count++;
-		ice_put_rx_buf(rx_ring, rx_buf);
+		ice_put_rx_buf(rx_ring, rx_buf, rx_buf_pgcnt);
 		continue;
 construct_skb:
 		if (skb) {
@@ -1193,7 +1202,7 @@ int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 			break;
 		}
 
-		ice_put_rx_buf(rx_ring, rx_buf);
+		ice_put_rx_buf(rx_ring, rx_buf, rx_buf_pgcnt);
 		cleaned_count++;
 
 		/* skip if it is NOP desc */
-- 
2.25.1

