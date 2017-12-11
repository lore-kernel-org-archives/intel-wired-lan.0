From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 11 Dec 2017 10:36:59 -0800
Subject: [Intel-wired-lan] [PATCH 3/9] ixgbevf: use length to determine if
 descriptor is done
In-Reply-To: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
Message-ID: <20171211183659.21524.88045.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Based on:
commit 7ec0116c9131 ("igb: Use length to determine if descriptor is done")

This change makes it so that we use the length of the packet instead of the
DD status bit to determine if a new descriptor is ready to be processed.
The obvious advantage is that it cuts down on reads as we don't really even
need the DD bit if going from a 0 to a non-zero value on size is enough to
inform us that the packet has been completed.

In addition we only reset the Rx descriptor length for descriptor zero when
resetting a ring instead of having to do a memset with 0 over the entire
ring. By doing this we can save some time on initialization.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 0cc2688..725fe2d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -653,8 +653,8 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 			i -= rx_ring->count;
 		}
 
-		/* clear the hdr_addr for the next_to_use descriptor */
-		rx_desc->read.hdr_addr = 0;
+		/* clear the length for the next_to_use descriptor */
+		rx_desc->wb.upper.length = 0;
 
 		cleaned_count--;
 	} while (cleaned_count);
@@ -938,7 +938,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 
 		rx_desc = IXGBEVF_RX_DESC(rx_ring, rx_ring->next_to_clean);
 
-		if (!ixgbevf_test_staterr(rx_desc, IXGBE_RXD_STAT_DD))
+		if (!rx_desc->wb.upper.length)
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -1729,6 +1729,7 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 				      struct ixgbevf_ring *ring)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	union ixgbe_adv_rx_desc *rx_desc;
 	u64 rdba = ring->dma;
 	u32 rxdctl;
 	u8 reg_idx = ring->reg_idx;
@@ -1757,6 +1758,10 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_VFRDT(reg_idx), 0);
 	ring->tail = adapter->io_addr + IXGBE_VFRDT(reg_idx);
 
+	/* initialize Rx descriptor 0 */
+	rx_desc = IXGBEVF_RX_DESC(ring, 0);
+	rx_desc->wb.upper.length = 0;
+
 	/* reset ntu and ntc to place SW in sync with hardwdare */
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
@@ -2141,9 +2146,6 @@ static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
 
 	size = sizeof(struct ixgbevf_rx_buffer) * rx_ring->count;
 	memset(rx_ring->rx_buffer_info, 0, size);
-
-	/* Zero out the descriptor ring */
-	memset(rx_ring->desc, 0, rx_ring->size);
 }
 
 /**

