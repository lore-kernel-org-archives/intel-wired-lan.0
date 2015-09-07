From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon,  7 Sep 2015 20:12:41 +0200
Subject: [Intel-wired-lan] [PATCH] e1000: fix data race between
	tx_ring->next_to_clean
Message-ID: <1441649561-143084-1-git-send-email-dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

e1000_clean_tx_irq cleans buffers and sets tx_ring->next_to_clean,
then e1000_xmit_frame reuses the cleaned buffers. But there are no
memory barriers when buffers gets recycled, so the recycled buffers
can be corrupted.

Use smp_store_release to update tx_ring->next_to_clean and
smp_load_acquire to read tx_ring->next_to_clean to properly
hand off buffers from e1000_clean_tx_irq to e1000_xmit_frame.

The data race was found with KernelThreadSanitizer (KTSAN).

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 drivers/net/ethernet/intel/e1000/e1000.h      | 7 +++++--
 drivers/net/ethernet/intel/e1000/e1000_main.c | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/ethernet/intel/e1000/e1000.h
index 6970710..244c0e7 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -213,8 +213,11 @@ struct e1000_rx_ring {
 };
 
 #define E1000_DESC_UNUSED(R)						\
-	((((R)->next_to_clean > (R)->next_to_use)			\
-	  ? 0 : (R)->count) + (R)->next_to_clean - (R)->next_to_use - 1)
+({									\
+	unsigned int clean = smp_load_acquire(&(R)->next_to_clean);	\
+	unsigned int use = READ_ONCE((R)->next_to_use);			\
+	clean > use ? 0 : (R)->count + clean - use - 1;			\
+})
 
 #define E1000_RX_DESC_EXT(R, i)						\
 	(&(((union e1000_rx_desc_extended *)((R).desc))[i]))
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 74dc150..97e38ce 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3876,7 +3876,10 @@ static bool e1000_clean_tx_irq(struct e1000_adapter *adapter,
 		eop_desc = E1000_TX_DESC(*tx_ring, eop);
 	}
 
-	tx_ring->next_to_clean = i;
+	/* Synchronize with E1000_DESC_UNUSED called from e1000_xmit_frame,
+	 * which will reuse the cleaned buffers.
+	 */
+	smp_store_release(&tx_ring->next_to_clean, i);
 
 	netdev_completed_queue(netdev, pkts_compl, bytes_compl);
 
-- 
2.5.0.457.gab17608

