From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 13 Dec 2016 14:40:04 +0100
Subject: [Intel-wired-lan] [PATCH v3 1/4] i40e: Sync DMA region prior skbuff
	allocation
In-Reply-To: <20161213134007.14707-1-bjorn.topel@gmail.com>
References: <20161213134007.14707-1-bjorn.topel@gmail.com>
Message-ID: <20161213134007.14707-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This patch prepares i40e_fetch_rx_buffer() for upcoming XDP support,
where there's a need to access the device buffers prior skbuff
allocation.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index e88e335c34ef..7dacde6608d1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1646,6 +1646,13 @@ struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
 	page = rx_buffer->page;
 	prefetchw(page);
 
+	/* we are reusing so sync this buffer for CPU use */
+	dma_sync_single_range_for_cpu(rx_ring->dev,
+				      rx_buffer->dma,
+				      rx_buffer->page_offset,
+				      size,
+				      DMA_FROM_DEVICE);
+
 	if (likely(!skb)) {
 		void *page_addr = page_address(page) + rx_buffer->page_offset;
 
@@ -1671,13 +1678,6 @@ struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
 		prefetchw(skb->data);
 	}
 
-	/* we are reusing so sync this buffer for CPU use */
-	dma_sync_single_range_for_cpu(rx_ring->dev,
-				      rx_buffer->dma,
-				      rx_buffer->page_offset,
-				      size,
-				      DMA_FROM_DEVICE);
-
 	/* pull page into skb */
 	if (i40e_add_rx_frag(rx_ring, rx_buffer, size, skb)) {
 		/* hand second half of page back to the ring */
-- 
2.9.3

