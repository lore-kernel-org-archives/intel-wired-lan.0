From: Venkatesh Srinivas <venkateshs@google.com>
Date: Mon, 10 Jun 2019 14:27:50 -0700
Subject: [Intel-wired-lan] [PATCH] e1000: Use dma_wmb() instead of wmb()
 before doorbell writes
Message-ID: <20190610212750.173711-1-venkateshs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

e1000 writes to doorbells to post transmit descriptors and fill the
receive ring. After writing descriptors to memory but before
writing to doorbells, use dma_wmb() rather than wmb(). wmb() is more
heavyweight than necessary for a device to see descriptor writes.

On x86, this avoids SFENCEs before doorbell writes in both the
tx and rx paths. On ARM, this converts DSB ST -> DMB OSHST.

Tested: 82576EB / x86; QEMU (qemu emulates an 8257x)

Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 551de8c2fef2..f703fa58458e 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3019,7 +3019,7 @@ static void e1000_tx_queue(struct e1000_adapter *adapter,
 	 * applicable for weak-ordered memory model archs,
 	 * such as IA-64).
 	 */
-	wmb();
+	dma_wmb();
 
 	tx_ring->next_to_use = i;
 }
@@ -4540,7 +4540,7 @@ e1000_alloc_jumbo_rx_buffers(struct e1000_adapter *adapter,
 		 * applicable for weak-ordered memory model archs,
 		 * such as IA-64).
 		 */
-		wmb();
+		dma_wmb();
 		writel(i, adapter->hw.hw_addr + rx_ring->rdt);
 	}
 }
@@ -4655,7 +4655,7 @@ static void e1000_alloc_rx_buffers(struct e1000_adapter *adapter,
 		 * applicable for weak-ordered memory model archs,
 		 * such as IA-64).
 		 */
-		wmb();
+		dma_wmb();
 		writel(i, hw->hw_addr + rx_ring->rdt);
 	}
 }
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

