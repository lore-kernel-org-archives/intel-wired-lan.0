From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Jan 2017 08:59:15 -0800
Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for padding
	packet
In-Reply-To: <20170123165647.13402.1254.stgit@localhost.localdomain>
References: <20170123165647.13402.1254.stgit@localhost.localdomain>
Message-ID: <20170123165906.13402.80385.stgit@localhost.localdomain>
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

One side effect of this patch is that we can end up using a larger buffer
if jumbo frames is enabled.  The impact shouldn't be too great, but it
could hurt small packet performance for UDP workloads if jumbo frames is
enabled as the truesize of frames will be larger.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v3: Fixed "unsigned char *" / "void *" mismatch on pointer arithmetic

 drivers/net/ethernet/intel/igb/igb.h         |   44 ++++++++++++-
 drivers/net/ethernet/intel/igb/igb_ethtool.c |    4 +
 drivers/net/ethernet/intel/igb/igb_main.c    |   91 +++++++++++++++++++-------
 drivers/net/ethernet/intel/igb/igb_ptp.c     |    3 -
 4 files changed, 110 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index a74928cc0e58..21f26f164445 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -142,9 +142,9 @@ struct vf_data_storage {
 /* Supported Rx Buffer Sizes */
 #define IGB_RXBUFFER_256	256
 #define IGB_RXBUFFER_2048	2048
+#define IGB_RXBUFFER_3072	3072
 #define IGB_RX_HDR_LEN		IGB_RXBUFFER_256
 #define IGB_TS_HDR_LEN		16
-#define IGB_RX_BUFSZ		IGB_RXBUFFER_2048
 
 #define IGB_SKB_PAD		(NET_SKB_PAD + NET_IP_ALIGN)
 #if (PAGE_SIZE < 8192)
@@ -313,12 +313,51 @@ struct igb_q_vector {
 };
 
 enum e1000_ring_flags_t {
+	IGB_RING_FLAG_RX_3K_BUFFER,
+	IGB_RING_FLAG_RX_BUILD_SKB_ENABLED,
 	IGB_RING_FLAG_RX_SCTP_CSUM,
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
 	IGB_RING_FLAG_TX_DETECT_HANG
 };
 
+#define ring_uses_build_skb(ring) \
+	test_bit(IGB_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+#define set_ring_build_skb_enabled(ring) \
+	set_bit(IGB_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+#define clear_ring_build_skb_enabled(ring) \
+	clear_bit(IGB_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+
+#define ring_uses_large_buffer(ring) \
+	test_bit(IGB_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
+#define set_ring_uses_large_buffer(ring) \
+	set_bit(IGB_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
+#define clear_ring_uses_large_buffer(ring) \
+	clear_bit(IGB_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
+
+static inline unsigned int igb_rx_bufsz(struct igb_ring *ring)
+{
+#if (PAGE_SIZE < 8192)
+	if (ring_uses_large_buffer(ring))
+		return IGB_RXBUFFER_3072;
+
+	if (ring_uses_build_skb(ring))
+		return IGB_MAX_FRAME_BUILD_SKB + IGB_TS_HDR_LEN;
+#endif
+	return IGB_RXBUFFER_2048;
+}
+
+static inline unsigned int igb_rx_pg_order(struct igb_ring *ring)
+{
+#if (PAGE_SIZE < 8192)
+	if (ring_uses_large_buffer(ring))
+		return 1;
+#endif
+	return 0;
+}
+
+#define igb_rx_pg_size(_ring) (PAGE_SIZE << igb_rx_pg_order(_ring))
+
 #define IGB_TXD_DCMD (E1000_ADVTXD_DCMD_EOP | E1000_ADVTXD_DCMD_RS)
 
 #define IGB_RX_DESC(R, i)	\
@@ -557,6 +596,7 @@ struct igb_adapter {
 #define IGB_FLAG_HAS_MSIX		BIT(13)
 #define IGB_FLAG_EEE			BIT(14)
 #define IGB_FLAG_VLAN_PROMISC		BIT(15)
+#define IGB_FLAG_RX_LEGACY		BIT(16)
 
 /* Media Auto Sense */
 #define IGB_MAS_ENABLE_0		0X0001
@@ -614,7 +654,7 @@ enum igb_boards {
 void igb_ptp_suspend(struct igb_adapter *adapter);
 void igb_ptp_rx_hang(struct igb_adapter *adapter);
 void igb_ptp_rx_rgtstamp(struct igb_q_vector *q_vector, struct sk_buff *skb);
-void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, unsigned char *va,
+void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			 struct sk_buff *skb);
 int igb_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
 int igb_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 612cf13b7a3a..d5966feb7b96 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1818,7 +1818,7 @@ static int igb_clean_test_rings(struct igb_ring *rx_ring,
 		/* sync Rx buffer for CPU read */
 		dma_sync_single_for_cpu(rx_ring->dev,
 					rx_buffer_info->dma,
-					IGB_RX_BUFSZ,
+					size,
 					DMA_FROM_DEVICE);
 
 		/* verify contents of skb */
@@ -1828,7 +1828,7 @@ static int igb_clean_test_rings(struct igb_ring *rx_ring,
 		/* sync Rx buffer for device write */
 		dma_sync_single_for_device(rx_ring->dev,
 					   rx_buffer_info->dma,
-					   IGB_RX_BUFSZ,
+					   size,
 					   DMA_FROM_DEVICE);
 
 		/* unmap buffer on Tx side */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d881c51ef162..126ca0e0bcc1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -554,7 +554,7 @@ static void igb_dump(struct igb_adapter *adapter)
 					  16, 1,
 					  page_address(buffer_info->page) +
 						      buffer_info->page_offset,
-					  IGB_RX_BUFSZ, true);
+					  igb_rx_bufsz(rx_ring), true);
 				}
 			}
 		}
@@ -3746,7 +3746,10 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 
 	/* set descriptor configuration */
 	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
-	srrctl |= IGB_RX_BUFSZ >> E1000_SRRCTL_BSIZEPKT_SHIFT;
+	if (ring_uses_large_buffer(ring))
+		srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
+	else
+		srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
 	srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
 	if (hw->mac.type >= e1000_82580)
 		srrctl |= E1000_SRRCTL_TIMESTAMP;
@@ -3776,6 +3779,26 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	wr32(E1000_RXDCTL(reg_idx), rxdctl);
 }
 
+static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
+				  struct igb_ring *rx_ring)
+{
+	/* set build_skb and buffer size flags */
+	clear_ring_build_skb_enabled(rx_ring);
+	clear_ring_uses_large_buffer(rx_ring);
+
+	if (adapter->flags & IGB_FLAG_RX_LEGACY)
+		return;
+
+	set_ring_build_skb_enabled(rx_ring);
+
+#if (PAGE_SIZE < 8192)
+	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
+		return;
+
+	set_ring_uses_large_buffer(rx_ring);
+#endif
+}
+
 /**
  *  igb_configure_rx - Configure receive Unit after Reset
  *  @adapter: board private structure
@@ -3793,8 +3816,12 @@ static void igb_configure_rx(struct igb_adapter *adapter)
 	/* Setup the HW Rx Head and Tail Descriptor Pointers and
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
-	for (i = 0; i < adapter->num_rx_queues; i++)
-		igb_configure_rx_ring(adapter, adapter->rx_ring[i]);
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct igb_ring *rx_ring = adapter->rx_ring[i];
+
+		igb_set_rx_buffer_len(adapter, rx_ring);
+		igb_configure_rx_ring(adapter, rx_ring);
+	}
 }
 
 /**
@@ -3969,13 +3996,13 @@ static void igb_clean_rx_ring(struct igb_ring *rx_ring)
 		dma_sync_single_range_for_cpu(rx_ring->dev,
 					      buffer_info->dma,
 					      buffer_info->page_offset,
-					      IGB_RX_BUFSZ,
+					      igb_rx_bufsz(rx_ring),
 					      DMA_FROM_DEVICE);
 
 		/* free resources associated with mapping */
 		dma_unmap_page_attrs(rx_ring->dev,
 				     buffer_info->dma,
-				     PAGE_SIZE,
+				     igb_rx_pg_size(rx_ring),
 				     DMA_FROM_DEVICE,
 				     IGB_RX_DMA_ATTR);
 		__page_frag_cache_drain(buffer_info->page,
@@ -6867,7 +6894,7 @@ static inline bool igb_page_is_reserved(struct page *page)
 
 static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
 				  struct page *page,
-				  unsigned int truesize)
+				  const unsigned int truesize)
 {
 	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias--;
 
@@ -6881,12 +6908,14 @@ static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
 		return false;
 
 	/* flip page offset to other buffer */
-	rx_buffer->page_offset ^= IGB_RX_BUFSZ;
+	rx_buffer->page_offset ^= truesize;
 #else
 	/* move offset up to the next cache line */
 	rx_buffer->page_offset += truesize;
+#define IGB_LAST_OFFSET \
+	(SKB_WITH_OVERHEAD(PAGE_SIZE) - IGB_RXBUFFER_2048)
 
-	if (rx_buffer->page_offset > (PAGE_SIZE - IGB_RX_BUFSZ))
+	if (rx_buffer->page_offset > IGB_LAST_OFFSET)
 		return false;
 #endif
 
@@ -6924,13 +6953,15 @@ static bool igb_add_rx_frag(struct igb_ring *rx_ring,
 			    struct sk_buff *skb)
 {
 	struct page *page = rx_buffer->page;
-	unsigned char *va = page_address(page) + rx_buffer->page_offset;
+	void *va = page_address(page) + rx_buffer->page_offset;
+	unsigned int pull_len;
 #if (PAGE_SIZE < 8192)
-	unsigned int truesize = IGB_RX_BUFSZ;
+	unsigned int truesize = igb_rx_pg_size(rx_ring) / 2;
 #else
-	unsigned int truesize = SKB_DATA_ALIGN(size);
+	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
+				SKB_DATA_ALIGN(IGB_SKB_PAD + size) :
+				SKB_DATA_ALIGN(size);
 #endif
-	unsigned int pull_len;
 
 	if (unlikely(skb_is_nonlinear(skb)))
 		goto add_tail_frag;
@@ -6966,7 +6997,7 @@ static bool igb_add_rx_frag(struct igb_ring *rx_ring,
 
 add_tail_frag:
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
-			(unsigned long)va & ~PAGE_MASK, size, truesize);
+			va - page_address(page), size, truesize);
 
 	return igb_can_reuse_rx_page(rx_buffer, page, truesize);
 }
@@ -6991,13 +7022,12 @@ static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
 				      DMA_FROM_DEVICE);
 
 	if (likely(!skb)) {
-		void *page_addr = page_address(page) +
-				  rx_buffer->page_offset;
+		void *va = page_address(page) + rx_buffer->page_offset;
 
 		/* prefetch first cache line of first page */
-		prefetch(page_addr);
+		prefetch(va);
 #if L1_CACHE_BYTES < 128
-		prefetch(page_addr + L1_CACHE_BYTES);
+		prefetch(va + L1_CACHE_BYTES);
 #endif
 
 		/* allocate a skb to store the frags */
@@ -7023,7 +7053,7 @@ static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
 		 * any references we are holding to it
 		 */
 		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
-				     PAGE_SIZE, DMA_FROM_DEVICE,
+				     igb_rx_pg_size(rx_ring), DMA_FROM_DEVICE,
 				     IGB_RX_DMA_ATTR);
 		__page_frag_cache_drain(page, rx_buffer->pagecnt_bias);
 	}
@@ -7265,6 +7295,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
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
@@ -7276,21 +7311,23 @@ static bool igb_alloc_mapped_page(struct igb_ring *rx_ring,
 		return true;
 
 	/* alloc new page for storage */
-	page = dev_alloc_page();
+	page = dev_alloc_pages(igb_rx_pg_order(rx_ring));
 	if (unlikely(!page)) {
 		rx_ring->rx_stats.alloc_failed++;
 		return false;
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0, PAGE_SIZE,
-				 DMA_FROM_DEVICE, IGB_RX_DMA_ATTR);
+	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
+				 igb_rx_pg_size(rx_ring),
+				 DMA_FROM_DEVICE,
+				 IGB_RX_DMA_ATTR);
 
 	/* if mapping failed free memory back to system since
 	 * there isn't much point in holding memory we can't use
 	 */
 	if (dma_mapping_error(rx_ring->dev, dma)) {
-		__free_page(page);
+		__free_pages(page, igb_rx_pg_order(rx_ring));
 
 		rx_ring->rx_stats.alloc_failed++;
 		return false;
@@ -7298,7 +7335,7 @@ static bool igb_alloc_mapped_page(struct igb_ring *rx_ring,
 
 	bi->dma = dma;
 	bi->page = page;
-	bi->page_offset = 0;
+	bi->page_offset = igb_rx_offset(rx_ring);
 	bi->pagecnt_bias = 1;
 
 	return true;
@@ -7313,6 +7350,7 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
 	union e1000_adv_rx_desc *rx_desc;
 	struct igb_rx_buffer *bi;
 	u16 i = rx_ring->next_to_use;
+	u16 bufsz;
 
 	/* nothing to do */
 	if (!cleaned_count)
@@ -7322,14 +7360,15 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
 	bi = &rx_ring->rx_buffer_info[i];
 	i -= rx_ring->count;
 
+	bufsz = igb_rx_bufsz(rx_ring);
+
 	do {
 		if (!igb_alloc_mapped_page(rx_ring, bi))
 			break;
 
 		/* sync the buffer for use by the device */
 		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
-						 bi->page_offset,
-						 IGB_RX_BUFSZ,
+						 bi->page_offset, bufsz,
 						 DMA_FROM_DEVICE);
 
 		/* Refresh the desc even if buffer_addrs didn't change
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index c4477552ce9e..7a3fd4d74592 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -764,8 +764,7 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
  * incoming frame.  The value is stored in little endian format starting on
  * byte 8.
  **/
-void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector,
-			 unsigned char *va,
+void igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			 struct sk_buff *skb)
 {
 	__le64 *regval = (__le64 *)va;

