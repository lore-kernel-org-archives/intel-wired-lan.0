From: Andre Guedes <andre.guedes@intel.com>
Date: Mon, 10 Aug 2020 14:08:31 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] igc: Check descriptor's DD bit in
 igc_clean_rx_irq()
In-Reply-To: <20200810210832.34699-1-andre.guedes@intel.com>
References: <20200810210832.34699-1-andre.guedes@intel.com>
Message-ID: <20200810210832.34699-2-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I225 advanced receive descriptor provides the Descriptor Done (DD) bit
which indicates hardware is done with that receive descriptor and
software should handle it.

This patch fixes igc_clean_rx_irq() so we check that bit to determine if
we are done handling incoming packets instead of checking the packet
length information. It also gets rid of rx_desc->wb.upper.length
assignments spread through the code required to make the previous
approach to work.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 21695476b8a5..43a7c7944804 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -316,6 +316,7 @@
 #define IGC_SRRCTL_TIMER0SEL(timer)	(((timer) & 0x3) << 17)
 
 /* Receive Descriptor bit definitions */
+#define IGC_RXD_STAT_DD		0x01	/* Descriptor Done */
 #define IGC_RXD_STAT_EOP	0x02	/* End of Packet */
 #define IGC_RXD_STAT_IXSM	0x04	/* Ignore checksum */
 #define IGC_RXD_STAT_UDPCS	0x10	/* UDP xsum calculated */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 298f408519f4..0c481dc906ad 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -551,7 +551,6 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 
 	/* initialize Rx descriptor 0 */
 	rx_desc = IGC_RX_DESC(ring, 0);
-	rx_desc->wb.upper.length = 0;
 
 	/* enable receive descriptor fetching */
 	rxdctl |= IGC_RXDCTL_QUEUE_ENABLE;
@@ -1880,9 +1879,6 @@ static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
 			i -= rx_ring->count;
 		}
 
-		/* clear the length for the next_to_use descriptor */
-		rx_desc->wb.upper.length = 0;
-
 		cleaned_count--;
 	} while (cleaned_count);
 
@@ -1924,8 +1920,12 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		}
 
 		rx_desc = IGC_RX_DESC(rx_ring, rx_ring->next_to_clean);
-		size = le16_to_cpu(rx_desc->wb.upper.length);
-		if (!size)
+
+		/* If we reached a descriptor with 'Descriptor Done' bit not
+		 * set, it means we have handled all descriptors owned by
+		 * software already so we should prematurely break the loop.
+		 */
+		if (!igc_test_staterr(rx_desc, IGC_RXD_STAT_DD))
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -1934,6 +1934,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		 */
 		dma_rmb();
 
+		size = le16_to_cpu(rx_desc->wb.upper.length);
+
 		rx_buffer = igc_get_rx_buffer(rx_ring, size);
 
 		/* retrieve a buffer from the ring */
-- 
2.26.2

