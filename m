From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:15 -0800
Subject: [Intel-wired-lan] [next PATCH S28 08/15] i40e/i40evf: avoid atomics
In-Reply-To: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452897202-15204-9-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In the case where we have a page fully used by receive data, we need to
release the page fully to the stack. Instead of calling get_page (which
increments the page count) followed by free_page (which decrements the
page count), just donate our reference to the stack. Although this
donation is not tax deductable, it does allow us to avoid two very
expensive atomic operations that reverse each other.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: If70739792d5748995fc175ec92ac2171ed4ad8fc
---
Testing Hints: make sure receive traffic is stable under heavy load with
packet split enabled, and that no data corruption is seen.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 21 +++++++++++++--------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 21 +++++++++++++--------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 60e993e..cd9bb7f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1663,28 +1663,33 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, const int budget)
 					rx_bi->page_offset + copysize,
 					rx_packet_len, I40E_RXBUFFER_2048);
 
-			get_page(rx_bi->page);
-			/* switch to the other half-page here; the allocation
-			 * code programs the right addr into HW. If we haven't
-			 * used this half-page, the address won't be changed,
-			 * and HW can just use it next time through.
-			 */
-			rx_bi->page_offset ^= PAGE_SIZE / 2;
 			/* If the page count is more than 2, then both halves
 			 * of the page are used and we need to free it. Do it
 			 * here instead of in the alloc code. Otherwise one
 			 * of the half-pages might be released between now and
 			 * then, and we wouldn't know which one to use.
+			 * Don't call get_page and free_page since those are
+			 * both expensive atomic operations that just change
+			 * the refcount in opposite directions. Just give the
+			 * page to the stack; he can have our refcount.
 			 */
 			if (page_count(rx_bi->page) > 2) {
 				dma_unmap_page(rx_ring->dev,
 					       rx_bi->page_dma,
 					       PAGE_SIZE,
 					       DMA_FROM_DEVICE);
-				__free_page(rx_bi->page);
 				rx_bi->page = NULL;
 				rx_bi->page_dma = 0;
 				rx_ring->rx_stats.realloc_count++;
+			} else {
+				get_page(rx_bi->page);
+				/* switch to the other half-page here; the
+				 * allocation code programs the right addr
+				 * into HW. If we haven't used this half-page,
+				 * the address won't be changed, and HW can
+				 * just use it next time through.
+				 */
+				rx_bi->page_offset ^= PAGE_SIZE / 2;
 			}
 
 		}
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index c1ea819..ecd2df2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1126,28 +1126,33 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, const int budget)
 					rx_bi->page_offset + copysize,
 					rx_packet_len, I40E_RXBUFFER_2048);
 
-			get_page(rx_bi->page);
-			/* switch to the other half-page here; the allocation
-			 * code programs the right addr into HW. If we haven't
-			 * used this half-page, the address won't be changed,
-			 * and HW can just use it next time through.
-			 */
-			rx_bi->page_offset ^= PAGE_SIZE / 2;
 			/* If the page count is more than 2, then both halves
 			 * of the page are used and we need to free it. Do it
 			 * here instead of in the alloc code. Otherwise one
 			 * of the half-pages might be released between now and
 			 * then, and we wouldn't know which one to use.
+			 * Don't call get_page and free_page since those are
+			 * both expensive atomic operations that just change
+			 * the refcount in opposite directions. Just give the
+			 * page to the stack; he can have our refcount.
 			 */
 			if (page_count(rx_bi->page) > 2) {
 				dma_unmap_page(rx_ring->dev,
 					       rx_bi->page_dma,
 					       PAGE_SIZE,
 					       DMA_FROM_DEVICE);
-				__free_page(rx_bi->page);
 				rx_bi->page = NULL;
 				rx_bi->page_dma = 0;
 				rx_ring->rx_stats.realloc_count++;
+			} else {
+				get_page(rx_bi->page);
+				/* switch to the other half-page here; the
+				 * allocation code programs the right addr
+				 * into HW. If we haven't used this half-page,
+				 * the address won't be changed, and HW can
+				 * just use it next time through.
+				 */
+				rx_bi->page_offset ^= PAGE_SIZE / 2;
 			}
 
 		}
-- 
2.1.0

