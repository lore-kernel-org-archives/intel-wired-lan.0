From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 18 Jan 2021 16:13:16 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 09/11] i40e: store the result
 of i40e_rx_offset() onto i40e_ring
In-Reply-To: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
References: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
Message-ID: <20210118151318.12324-10-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Output of i40e_rx_offset() is based on ethtool's priv flag setting,
which when changed, causes PF reset (disables napi, frees irqs, loads
different Rx mem model, etc.). This means that within napi its result is
constant and there is no reason to call it per each processed frame.

Add new 'rx_offset' field to i40e_ring that is meant to hold the
i40e_rx_offset() result and use it within i40e_clean_rx_irq().
Furthermore, use it within i40e_alloc_mapped_page().

Last but not least, un-inline the function of interest so that compiler
makes the decision about inlining as it lives in .c file.

Reviewed-by: Bj?rn T?pel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 35 +++++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  1 +
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7e008dbbef97..3a6be7fa9817 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1415,6 +1415,17 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 	}
 }
 
+/**
+ * i40e_rx_offset - Return expected offset into page to access data
+ * @rx_ring: Ring we are requesting offset of
+ *
+ * Returns the offset value for ring into the data buffer.
+ */
+static unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
+{
+	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
+}
+
 /**
  * i40e_setup_rx_descriptors - Allocate Rx descriptors
  * @rx_ring: Rx descriptor ring (for a specific queue) to setup
@@ -1443,6 +1454,7 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
+	rx_ring->rx_offset = i40e_rx_offset(rx_ring);
 
 	/* XDP RX-queue info only needed for RX rings exposed to XDP */
 	if (rx_ring->vsi->type == I40E_VSI_MAIN) {
@@ -1478,17 +1490,6 @@ void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
 	writel(val, rx_ring->tail);
 }
 
-/**
- * i40e_rx_offset - Return expected offset into page to access data
- * @rx_ring: Ring we are requesting offset of
- *
- * Returns the offset value for ring into the data buffer.
- */
-static inline unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
-{
-	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
-}
-
 static unsigned int i40e_rx_frame_truesize(struct i40e_ring *rx_ring,
 					   unsigned int size)
 {
@@ -1497,8 +1498,8 @@ static unsigned int i40e_rx_frame_truesize(struct i40e_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	truesize = i40e_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
 #else
-	truesize = i40e_rx_offset(rx_ring) ?
-		SKB_DATA_ALIGN(size + i40e_rx_offset(rx_ring)) +
+	truesize = rx_ring->rx_offset ?
+		SKB_DATA_ALIGN(size + rx_ring->rx_offset) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
 		SKB_DATA_ALIGN(size);
 #endif
@@ -1549,7 +1550,7 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 
 	bi->dma = dma;
 	bi->page = page;
-	bi->page_offset = i40e_rx_offset(rx_ring);
+	bi->page_offset = rx_ring->rx_offset;
 	page_ref_add(page, USHRT_MAX - 1);
 	bi->pagecnt_bias = USHRT_MAX;
 
@@ -1916,7 +1917,7 @@ static void i40e_add_rx_frag(struct i40e_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
 #else
-	unsigned int truesize = SKB_DATA_ALIGN(size + i40e_rx_offset(rx_ring));
+	unsigned int truesize = SKB_DATA_ALIGN(size + rx_ring->rx_offset);
 #endif
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
@@ -2312,8 +2313,9 @@ static void i40e_inc_ntc(struct i40e_ring *rx_ring)
 static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0, frame_sz = 0;
-	struct sk_buff *skb = rx_ring->skb;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
+	unsigned int offset = rx_ring->rx_offset;
+	struct sk_buff *skb = rx_ring->skb;
 	unsigned int xdp_xmit = 0;
 	bool failure = false;
 	struct xdp_buff xdp;
@@ -2373,7 +2375,6 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 
 		/* retrieve a buffer from the ring */
 		if (!skb) {
-			unsigned int offset = i40e_rx_offset(rx_ring);
 			unsigned char *hard_start;
 
 			hard_start = page_address(rx_buffer->page) +
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 5f531b195959..86fed05b4f19 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -387,6 +387,7 @@ struct i40e_ring {
 					 */
 
 	struct i40e_channel *ch;
+	u16 rx_offset;
 	struct xdp_rxq_info xdp_rxq;
 	struct xsk_buff_pool *xsk_pool;
 	struct xdp_desc *xsk_descs;      /* For storing descriptors in the AF_XDP ZC path */
-- 
2.20.1

