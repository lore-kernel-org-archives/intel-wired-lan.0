From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 11 Dec 2017 10:37:20 -0800
Subject: [Intel-wired-lan] [PATCH 7/9] ixgbevf: clear rx_buffer_info in
 configure instead of clean
In-Reply-To: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
Message-ID: <20171211183720.21524.93082.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Based on commit d2bead576e67
("igb: Clear Rx buffer_info in configure instead of clean")

This change makes it so that instead of going through the entire ring on Rx
cleanup we only go through the region that was designated to be cleaned up
and stop when we reach the region where new allocations should start.

In addition we can avoid having to perform a memset on the Rx buffer_info
structures until we are about to start using the ring again.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   26 +++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 350afec..a793f9e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1773,6 +1773,10 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_VFRDT(reg_idx), 0);
 	ring->tail = adapter->io_addr + IXGBE_VFRDT(reg_idx);
 
+	/* initialize rx_buffer_info */
+	memset(ring->rx_buffer_info, 0,
+	       sizeof(struct ixgbevf_rx_buffer) * ring->count);
+
 	/* initialize Rx descriptor 0 */
 	rx_desc = IXGBEVF_RX_DESC(ring, 0);
 	rx_desc->wb.upper.length = 0;
@@ -2131,8 +2135,7 @@ void ixgbevf_up(struct ixgbevf_adapter *adapter)
  **/
 static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
 {
-	unsigned long size;
-	unsigned int i;
+	u16 i = rx_ring->next_to_clean;
 
 	/* Free Rx ring sk_buff */
 	if (rx_ring->skb) {
@@ -2140,17 +2143,11 @@ static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
 		rx_ring->skb = NULL;
 	}
 
-	/* ring already cleared, nothing to do */
-	if (!rx_ring->rx_buffer_info)
-		return;
-
 	/* Free all the Rx ring pages */
-	for (i = 0; i < rx_ring->count; i++) {
+	while (i != rx_ring->next_to_alloc) {
 		struct ixgbevf_rx_buffer *rx_buffer;
 
 		rx_buffer = &rx_ring->rx_buffer_info[i];
-		if (!rx_buffer->page)
-			continue;
 
 		/* Invalidate cache lines that may have been written to by
 		 * device so that we avoid corrupting memory.
@@ -2171,11 +2168,14 @@ static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
 		__page_frag_cache_drain(rx_buffer->page,
 					rx_buffer->pagecnt_bias);
 
-		rx_buffer->page = NULL;
+		i++;
+		if (i == rx_ring->count)
+			i = 0;
 	}
 
-	size = sizeof(struct ixgbevf_rx_buffer) * rx_ring->count;
-	memset(rx_ring->rx_buffer_info, 0, size);
+	rx_ring->next_to_alloc = 0;
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
 }
 
 /**
@@ -3090,7 +3090,7 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_ring *rx_ring)
 	int size;
 
 	size = sizeof(struct ixgbevf_rx_buffer) * rx_ring->count;
-	rx_ring->rx_buffer_info = vzalloc(size);
+	rx_ring->rx_buffer_info = vmalloc(size);
 	if (!rx_ring->rx_buffer_info)
 		goto err;
 

