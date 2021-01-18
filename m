From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 18 Jan 2021 16:13:18 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 11/11] ixgbe: store the result
 of ixgbe_rx_offset() onto ixgbe_ring
In-Reply-To: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
References: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
Message-ID: <20210118151318.12324-12-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Output of ixgbe_rx_offset() is based on ethtool's priv flag setting, which
when changed, causes PF reset (disables napi, frees irqs, loads
different Rx mem model, etc.). This means that within napi its result is
constant and there is no reason to call it per each processed frame.

Add new 'rx_offset' field to ixgbe_ring that is meant to hold the
ixgbe_rx_offset() result and use it within ixgbe_clean_rx_irq().
Furthermore, use it within ixgbe_alloc_mapped_page().

Last but not least, un-inline the function of interest as it lives in .c
file so let compiler do the decision about the inlining.

Reviewed-by: Bj?rn T?pel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index de0fc6ecf491..a604552fa634 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -349,6 +349,7 @@ struct ixgbe_ring {
 		struct ixgbe_tx_queue_stats tx_stats;
 		struct ixgbe_rx_queue_stats rx_stats;
 	};
+	u16 rx_offset;
 	struct xdp_rxq_info xdp_rxq;
 	struct xsk_buff_pool *xsk_pool;
 	u16 ring_idx;		/* {rx,tx,xdp}_ring back reference idx */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 56dca73d158e..1f518cfb1dca 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1520,7 +1520,7 @@ static inline void ixgbe_rx_checksum(struct ixgbe_ring *ring,
 	}
 }
 
-static inline unsigned int ixgbe_rx_offset(struct ixgbe_ring *rx_ring)
+static unsigned int ixgbe_rx_offset(struct ixgbe_ring *rx_ring)
 {
 	return ring_uses_build_skb(rx_ring) ? IXGBE_SKB_PAD : 0;
 }
@@ -1561,7 +1561,7 @@ static bool ixgbe_alloc_mapped_page(struct ixgbe_ring *rx_ring,
 
 	bi->dma = dma;
 	bi->page = page;
-	bi->page_offset = ixgbe_rx_offset(rx_ring);
+	bi->page_offset = rx_ring->rx_offset;
 	page_ref_add(page, USHRT_MAX - 1);
 	bi->pagecnt_bias = USHRT_MAX;
 	rx_ring->rx_stats.alloc_rx_page++;
@@ -2006,8 +2006,8 @@ static void ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = ixgbe_rx_pg_size(rx_ring) / 2;
 #else
-	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
-				SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) :
+	unsigned int truesize = rx_ring->rx_offset ?
+				SKB_DATA_ALIGN(rx_ring->rx_offset + size) :
 				SKB_DATA_ALIGN(size);
 #endif
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
@@ -2254,8 +2254,8 @@ static unsigned int ixgbe_rx_frame_truesize(struct ixgbe_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	truesize = ixgbe_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
 #else
-	truesize = ring_uses_build_skb(rx_ring) ?
-		SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) +
+	truesize = rx_ring->rx_offset ?
+		SKB_DATA_ALIGN(rx_ring->rx_offset + size) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
 		SKB_DATA_ALIGN(size);
 #endif
@@ -2298,6 +2298,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 	unsigned int mss = 0;
 #endif /* IXGBE_FCOE */
 	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
+	unsigned int offset = rx_ring->rx_offset;
 	unsigned int xdp_xmit = 0;
 	struct xdp_buff xdp;
 
@@ -2335,7 +2336,6 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 
 		/* retrieve a buffer from the ring */
 		if (!skb) {
-			unsigned int offset = ixgbe_rx_offset(rx_ring);
 			unsigned char *hard_start;
 
 			hard_start = page_address(rx_buffer->page) +
@@ -6583,6 +6583,7 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
+	rx_ring->rx_offset = ixgbe_rx_offset(rx_ring);
 
 	/* XDP RX-queue info */
 	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
-- 
2.20.1

