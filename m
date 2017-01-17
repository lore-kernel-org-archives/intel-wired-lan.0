From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Jan 2017 08:32:01 -0800
Subject: [Intel-wired-lan] [next PATCH v2 3/9] igb: Clear Rx buffer_info in
 configure instead of clean
In-Reply-To: <20170117163010.5184.65449.stgit@localhost.localdomain>
References: <20170117163010.5184.65449.stgit@localhost.localdomain>
Message-ID: <20170117163154.5184.41138.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This change makes it so that instead of going through the entire ring on Rx
cleanup we only go through the region that was designated to be cleaned up
and stop when we reach the region where new allocations should start.

In addition we can avoid having to perform a memset on the Rx buffer_info
structures until we are about to start using the ring again.  By deferring
this we can avoid dirtying the cache any more than we have to which can
help to improve the time needed to bring the interface down and then back
up again in a reset or suspend/resume cycle.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 91a524b155ce..79a8f3a3356e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3435,7 +3435,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
 
 	size = sizeof(struct igb_rx_buffer) * rx_ring->count;
 
-	rx_ring->rx_buffer_info = vzalloc(size);
+	rx_ring->rx_buffer_info = vmalloc(size);
 	if (!rx_ring->rx_buffer_info)
 		goto err;
 
@@ -3759,6 +3759,10 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	rxdctl |= IGB_RX_HTHRESH << 8;
 	rxdctl |= IGB_RX_WTHRESH << 16;
 
+	/* initialize rx_buffer_info */
+	memset(ring->rx_buffer_info, 0,
+	       sizeof(struct igb_rx_buffer) * ring->count);
+
 	/* initialize Rx descriptor 0 */
 	rx_desc = IGB_RX_DESC(ring, 0);
 	rx_desc->wb.upper.length = 0;
@@ -3937,23 +3941,16 @@ static void igb_free_all_rx_resources(struct igb_adapter *adapter)
  **/
 static void igb_clean_rx_ring(struct igb_ring *rx_ring)
 {
-	unsigned long size;
-	u16 i;
+	u16 i = rx_ring->next_to_clean;
 
 	if (rx_ring->skb)
 		dev_kfree_skb(rx_ring->skb);
 	rx_ring->skb = NULL;
 
-	if (!rx_ring->rx_buffer_info)
-		return;
-
 	/* Free all the Rx ring sk_buffs */
-	for (i = 0; i < rx_ring->count; i++) {
+	while (i != rx_ring->next_to_alloc) {
 		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
 
-		if (!buffer_info->page)
-			continue;
-
 		/* Invalidate cache lines that may have been written to by
 		 * device so that we avoid corrupting memory.
 		 */
@@ -3972,12 +3969,11 @@ static void igb_clean_rx_ring(struct igb_ring *rx_ring)
 		__page_frag_cache_drain(buffer_info->page,
 					buffer_info->pagecnt_bias);
 
-		buffer_info->page = NULL;
+		i++;
+		if (i == rx_ring->count)
+			i = 0;
 	}
 
-	size = sizeof(struct igb_rx_buffer) * rx_ring->count;
-	memset(rx_ring->rx_buffer_info, 0, size);
-
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;

