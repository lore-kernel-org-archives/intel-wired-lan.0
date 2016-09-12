From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Sep 2016 14:18:39 -0700
Subject: [Intel-wired-lan] [next PATCH S46 3/8] i40e: Fix Flow Director
	raw_buf cleanup
In-Reply-To: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473715124-31296-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The Tx cleanup flow was incorrectly assuming it could check for the flow
director bits after it had unmapped the buffer.  However in this case it
results in us trying to free a raw_buf as though it is an sk_buff.

To fix this I am moving up the flag test for the FD_SB bit so that when
find a non-NULL skb or raw_buf value we then check the flag and use the
appropriate call to free the buffer.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I6284034ba1ea87c9922e56f6eb3181f7f09bddde
---
Testing Hints:
        The issue fixed here would present itself as a memory leak or data
        corruption.  The trick would be to find a way to cause the Tx ring
        for the Flow Director sideband to have buffers on it when the queue
        is disabled.  This would likely require ifconfig up/down on the
        interface in a loop while also adding filters.

        1.  ifconfig <iface> up
        2.  disable interrupts for FD SB queue. (via setpci or pciraw)
        3.  dump a number of filters on the ring via ethtool -N <iface>
        4.  shut down interface via ifconfig <iface> down

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 8 ++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7ada05e..a2077be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -532,7 +532,10 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 					    struct i40e_tx_buffer *tx_buffer)
 {
 	if (tx_buffer->skb) {
-		dev_kfree_skb_any(tx_buffer->skb);
+		if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
+			kfree(tx_buffer->raw_buf);
+		else
+			dev_kfree_skb_any(tx_buffer->skb);
 		if (dma_unmap_len(tx_buffer, len))
 			dma_unmap_single(ring->dev,
 					 dma_unmap_addr(tx_buffer, dma),
@@ -545,9 +548,6 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 			       DMA_TO_DEVICE);
 	}
 
-	if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
-		kfree(tx_buffer->raw_buf);
-
 	tx_buffer->next_to_watch = NULL;
 	tx_buffer->skb = NULL;
 	dma_unmap_len_set(tx_buffer, len, 0);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index e3427eb..cb6b130 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -51,7 +51,10 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 					    struct i40e_tx_buffer *tx_buffer)
 {
 	if (tx_buffer->skb) {
-		dev_kfree_skb_any(tx_buffer->skb);
+		if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
+			kfree(tx_buffer->raw_buf);
+		else
+			dev_kfree_skb_any(tx_buffer->skb);
 		if (dma_unmap_len(tx_buffer, len))
 			dma_unmap_single(ring->dev,
 					 dma_unmap_addr(tx_buffer, dma),
@@ -64,9 +67,6 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
 			       DMA_TO_DEVICE);
 	}
 
-	if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
-		kfree(tx_buffer->raw_buf);
-
 	tx_buffer->next_to_watch = NULL;
 	tx_buffer->skb = NULL;
 	dma_unmap_len_set(tx_buffer, len, 0);
-- 
2.4.11

