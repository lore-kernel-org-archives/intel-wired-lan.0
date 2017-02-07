From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 06 Feb 2017 18:27:14 -0800
Subject: [Intel-wired-lan] [next PATCH v5 10/12] igb: Add support for
	padding packet
In-Reply-To: <20170207022339.9864.87863.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
Message-ID: <20170207022709.9864.74231.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

With the size of the frame limited we can now write to an offset within the
buffer instead of having to write at the very start of the buffer.  The
advantage to this is that it allows us to leave padding room for things
like supporting XDP in the future.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
v4: Split this code out of patch 6 of the original series.

 drivers/net/ethernet/intel/igb/igb.h      |   11 +++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c |   14 ++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index eb91c87e0c1d..dc6e2980718f 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -314,6 +314,7 @@ struct igb_q_vector {
 
 enum e1000_ring_flags_t {
 	IGB_RING_FLAG_RX_3K_BUFFER,
+	IGB_RING_FLAG_RX_BUILD_SKB_ENABLED,
 	IGB_RING_FLAG_RX_SCTP_CSUM,
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
@@ -327,11 +328,21 @@ enum e1000_ring_flags_t {
 #define clear_ring_uses_large_buffer(ring) \
 	clear_bit(IGB_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
 
+#define ring_uses_build_skb(ring) \
+	test_bit(IGB_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+#define set_ring_build_skb_enabled(ring) \
+	set_bit(IGB_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+#define clear_ring_build_skb_enabled(ring) \
+	clear_bit(IGB_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+
 static inline unsigned int igb_rx_bufsz(struct igb_ring *ring)
 {
 #if (PAGE_SIZE < 8192)
 	if (ring_uses_large_buffer(ring))
 		return IGB_RXBUFFER_3072;
+
+	if (ring_uses_build_skb(ring))
+		return IGB_MAX_FRAME_BUILD_SKB + IGB_TS_HDR_LEN;
 #endif
 	return IGB_RXBUFFER_2048;
 }
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index bdc21b00943c..2204b2f87261 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3783,11 +3783,14 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 				  struct igb_ring *rx_ring)
 {
 	/* set build_skb and buffer size flags */
+	clear_ring_build_skb_enabled(rx_ring);
 	clear_ring_uses_large_buffer(rx_ring);
 
 	if (adapter->flags & IGB_FLAG_RX_LEGACY)
 		return;
 
+	set_ring_build_skb_enabled(rx_ring);
+
 #if (PAGE_SIZE < 8192)
 	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
 		return;
@@ -6959,7 +6962,9 @@ static bool igb_add_rx_frag(struct igb_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = igb_rx_pg_size(rx_ring) / 2;
 #else
-	unsigned int truesize = SKB_DATA_ALIGN(size);
+	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
+				SKB_DATA_ALIGN(IGB_SKB_PAD + size) :
+				SKB_DATA_ALIGN(size);
 #endif
 	unsigned int pull_len;
 
@@ -7295,6 +7300,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	return total_packets;
 }
 
+static inline unsigned int igb_rx_offset(struct igb_ring *rx_ring)
+{
+	return ring_uses_build_skb(rx_ring) ? IGB_SKB_PAD : 0;
+}
+
 static bool igb_alloc_mapped_page(struct igb_ring *rx_ring,
 				  struct igb_rx_buffer *bi)
 {
@@ -7330,7 +7340,7 @@ static bool igb_alloc_mapped_page(struct igb_ring *rx_ring,
 
 	bi->dma = dma;
 	bi->page = page;
-	bi->page_offset = 0;
+	bi->page_offset = igb_rx_offset(rx_ring);
 	bi->pagecnt_bias = 1;
 
 	return true;

