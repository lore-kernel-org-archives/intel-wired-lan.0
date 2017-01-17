From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Jan 2017 08:35:54 -0800
Subject: [Intel-wired-lan] [next PATCH v2 03/11] ixgbe: Update driver to
 make use of DMA attributes in Rx path
In-Reply-To: <20170117163401.5423.37993.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
Message-ID: <20170117163550.5423.60153.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch adds support for DMA_ATTR_SKIP_CPU_SYNC and
DMA_ATTR_WEAK_ORDERING.  By enabling both of these for the Rx path we are
able to see performance improvements on architectures that implement either
one due to the fact that page mapping and unmapping only has to sync what
is actually being used instead of the entire buffer.  In addition by
enabling the weak ordering attribute enables a performance improvement for
architectures that can associate a memory ordering with a DMA buffer such
as Sparc.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   56 +++++++++++++++++--------
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 9c6ccfc34177..97e74deecae2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -107,6 +107,9 @@
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
 #define IXGBE_RX_BUFFER_WRITE	16	/* Must be power of 2 */
 
+#define IXGBE_RX_DMA_ATTR \
+	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
+
 enum ixgbe_tx_flags {
 	/* cmd_type flags */
 	IXGBE_TX_FLAGS_HW_VLAN	= 0x01,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cfc097d07661..8ee8fcf0fe21 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1583,8 +1583,10 @@ static bool ixgbe_alloc_mapped_page(struct ixgbe_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page(rx_ring->dev, page, 0,
-			   ixgbe_rx_pg_size(rx_ring), DMA_FROM_DEVICE);
+	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
+				 ixgbe_rx_pg_size(rx_ring),
+				 DMA_FROM_DEVICE,
+				 IXGBE_RX_DMA_ATTR);
 
 	/*
 	 * if mapping failed free memory back to system since
@@ -1627,6 +1629,12 @@ void ixgbe_alloc_rx_buffers(struct ixgbe_ring *rx_ring, u16 cleaned_count)
 		if (!ixgbe_alloc_mapped_page(rx_ring, bi))
 			break;
 
+		/* sync the buffer for use by the device */
+		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
+						 bi->page_offset,
+						 ixgbe_rx_bufsz(rx_ring),
+						 DMA_FROM_DEVICE);
+
 		/*
 		 * Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
@@ -1849,8 +1857,10 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
 {
 	/* if the page was released unmap it, else just sync our portion */
 	if (unlikely(IXGBE_CB(skb)->page_released)) {
-		dma_unmap_page(rx_ring->dev, IXGBE_CB(skb)->dma,
-			       ixgbe_rx_pg_size(rx_ring), DMA_FROM_DEVICE);
+		dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
+				     ixgbe_rx_pg_size(rx_ring),
+				     DMA_FROM_DEVICE,
+				     IXGBE_RX_DMA_ATTR);
 		IXGBE_CB(skb)->page_released = false;
 	} else {
 		struct skb_frag_struct *frag = &skb_shinfo(skb)->frags[0];
@@ -1934,12 +1944,6 @@ static void ixgbe_reuse_rx_page(struct ixgbe_ring *rx_ring,
 
 	/* transfer page from old buffer to new buffer */
 	*new_buff = *old_buff;
-
-	/* sync the buffer for use by the device */
-	dma_sync_single_range_for_device(rx_ring->dev, new_buff->dma,
-					 new_buff->page_offset,
-					 ixgbe_rx_bufsz(rx_ring),
-					 DMA_FROM_DEVICE);
 }
 
 static inline bool ixgbe_page_is_reserved(struct page *page)
@@ -2106,9 +2110,10 @@ static struct sk_buff *ixgbe_fetch_rx_buffer(struct ixgbe_ring *rx_ring,
 		IXGBE_CB(skb)->page_released = true;
 	} else {
 		/* we are not reusing the buffer so unmap it */
-		dma_unmap_page(rx_ring->dev, rx_buffer->dma,
-			       ixgbe_rx_pg_size(rx_ring),
-			       DMA_FROM_DEVICE);
+		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
+				     ixgbe_rx_pg_size(rx_ring),
+				     DMA_FROM_DEVICE,
+				     IXGBE_RX_DMA_ATTR);
 	}
 
 	/* clear contents of buffer_info */
@@ -4942,10 +4947,11 @@ static void ixgbe_clean_rx_ring(struct ixgbe_ring *rx_ring)
 		if (rx_buffer->skb) {
 			struct sk_buff *skb = rx_buffer->skb;
 			if (IXGBE_CB(skb)->page_released)
-				dma_unmap_page(dev,
-					       IXGBE_CB(skb)->dma,
-					       ixgbe_rx_bufsz(rx_ring),
-					       DMA_FROM_DEVICE);
+				dma_unmap_page_attrs(dev,
+						     IXGBE_CB(skb)->dma,
+						     ixgbe_rx_pg_size(rx_ring),
+						     DMA_FROM_DEVICE,
+						     IXGBE_RX_DMA_ATTR);
 			dev_kfree_skb(skb);
 			rx_buffer->skb = NULL;
 		}
@@ -4953,8 +4959,20 @@ static void ixgbe_clean_rx_ring(struct ixgbe_ring *rx_ring)
 		if (!rx_buffer->page)
 			continue;
 
-		dma_unmap_page(dev, rx_buffer->dma,
-			       ixgbe_rx_pg_size(rx_ring), DMA_FROM_DEVICE);
+		/* Invalidate cache lines that may have been written to by
+		 * device so that we avoid corrupting memory.
+		 */
+		dma_sync_single_range_for_cpu(rx_ring->dev,
+					      rx_buffer->dma,
+					      rx_buffer->page_offset,
+					      ixgbe_rx_bufsz(rx_ring),
+					      DMA_FROM_DEVICE);
+
+		/* free resources associated with mapping */
+		dma_unmap_page_attrs(dev, rx_buffer->dma,
+				     ixgbe_rx_pg_size(rx_ring),
+				     DMA_FROM_DEVICE,
+				     IXGBE_RX_DMA_ATTR);
 		__free_pages(rx_buffer->page, ixgbe_rx_pg_order(rx_ring));
 
 		rx_buffer->page = NULL;

