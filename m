From: Venkatesh Srinivas <venkateshs@google.com>
Date: Fri, 25 May 2018 00:13:21 -0400
Subject: [Intel-wired-lan] [PATCH] igb: Use dma_wmb() instead of wmb()
 before doorbell writes
Message-ID: <20180525041321.140516-1-venkateshs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igb writes to doorbells to post transmit and receive descriptors;
after writing descriptors to memory but before writing to doorbells,
use dma_wmb() rather than wmb(). wmb() is more heavyweight than
necessary before doorbell writes.

On x86, this avoids SFENCEs before doorbell writes in both the
tx and rx refill paths.

Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index cce7ada89255..8aea50867a5d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5674,7 +5674,7 @@ static int igb_tx_map(struct igb_ring *tx_ring,
 	 * We also need this memory barrier to make certain all of the
 	 * status bits have been updated before next_to_watch is written.
 	 */
-	wmb();
+	dma_wmb();
 
 	/* set next_to_watch value indicating a packet is present */
 	first->next_to_watch = tx_desc;
@@ -8093,7 +8093,7 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
 		 * applicable for weak-ordered memory model archs,
 		 * such as IA-64).
 		 */
-		wmb();
+		dma_wmb();
 		writel(i, rx_ring->tail);
 	}
 }
-- 
2.17.0.921.gf22659ad46-goog

