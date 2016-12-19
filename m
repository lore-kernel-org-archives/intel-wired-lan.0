From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 19 Dec 2016 12:11:04 -0800
Subject: [Intel-wired-lan] [RFC PATCH 04/20] igb: Add support for
	DMA_ATTR_WEAK_ORDERING
In-Reply-To: <20161219200456.27116.28900.stgit@localhost.localdomain>
References: <20161219200456.27116.28900.stgit@localhost.localdomain>
Message-ID: <20161219201104.27116.72125.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Since we are already using DMA attributes in igb for Rx there is no reason
why we can't also apply DMA_ATTR_WEAK_ORDERING which is needed on some
platforms to improve performance.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |    3 +++
 drivers/net/ethernet/intel/igb/igb_main.c |    6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index acbc3abe2ddd..87c9fe9d6f18 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -148,6 +148,9 @@ struct vf_data_storage {
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
 #define IGB_RX_BUFFER_WRITE	16 /* Must be power of 2 */
 
+#define IGB_RX_DMA_ATTR \
+	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
+
 #define AUTO_ALL_MODES		0
 #define IGB_EEPROM_APME		0x0400
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1515abaa5ac9..7e21cdbde948 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3961,7 +3961,7 @@ static void igb_clean_rx_ring(struct igb_ring *rx_ring)
 				     buffer_info->dma,
 				     PAGE_SIZE,
 				     DMA_FROM_DEVICE,
-				     DMA_ATTR_SKIP_CPU_SYNC);
+				     IGB_RX_DMA_ATTR);
 		__page_frag_cache_drain(buffer_info->page,
 					buffer_info->pagecnt_bias);
 
@@ -6990,7 +6990,7 @@ static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
 		 */
 		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
 				     PAGE_SIZE, DMA_FROM_DEVICE,
-				     DMA_ATTR_SKIP_CPU_SYNC);
+				     IGB_RX_DMA_ATTR);
 		__page_frag_cache_drain(page, rx_buffer->pagecnt_bias);
 	}
 
@@ -7250,7 +7250,7 @@ static bool igb_alloc_mapped_page(struct igb_ring *rx_ring,
 
 	/* map page for use */
 	dma = dma_map_page_attrs(rx_ring->dev, page, 0, PAGE_SIZE,
-				 DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+				 DMA_FROM_DEVICE, IGB_RX_DMA_ATTR);
 
 	/* if mapping failed free memory back to system since
 	 * there isn't much point in holding memory we can't use

