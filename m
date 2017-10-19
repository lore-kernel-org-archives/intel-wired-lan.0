From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Thu, 19 Oct 2017 17:07:13 -0400
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] ixgbe: Fix Tx map
	failure path
Message-ID: <20171019210700.14788.7976.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is a partial revert of "ixgbe: Don't bother clearing buffer
memory for descriptor rings". Specifically I messed up the exception
handling path a bit and this resulted in us incorrectly adding the count
back in when we didn't need to.

In order to make this simpler I am reverting most of the exception handling
path change and instead just replacing the bit that was handled by the
unmap_and_free call.

Fixes: ffed21bcee7a ("ixgbe: Don't bother clearing buffer memory for descriptor rings")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 901ab12..a408345 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8149,29 +8149,23 @@ static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 	return 0;
 dma_error:
 	dev_err(tx_ring->dev, "TX DMA map failed\n");
-	tx_buffer = &tx_ring->tx_buffer_info[i];
 
 	/* clear dma mappings for failed tx_buffer_info map */
-	while (tx_buffer != first) {
+	for (;;) {
+		tx_buffer = &tx_ring->tx_buffer_info[i];
 		if (dma_unmap_len(tx_buffer, len))
 			dma_unmap_page(tx_ring->dev,
 				       dma_unmap_addr(tx_buffer, dma),
 				       dma_unmap_len(tx_buffer, len),
 				       DMA_TO_DEVICE);
 		dma_unmap_len_set(tx_buffer, len, 0);
-
-		if (i--)
+		if (tx_buffer == first)
+			break;
+		if (i == 0)
 			i += tx_ring->count;
-		tx_buffer = &tx_ring->tx_buffer_info[i];
+		i--;
 	}
 
-	if (dma_unmap_len(tx_buffer, len))
-		dma_unmap_single(tx_ring->dev,
-				 dma_unmap_addr(tx_buffer, dma),
-				 dma_unmap_len(tx_buffer, len),
-				 DMA_TO_DEVICE);
-	dma_unmap_len_set(tx_buffer, len, 0);
-
 	dev_kfree_skb_any(first->skb);
 	first->skb = NULL;
 

