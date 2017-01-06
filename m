From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 06 Jan 2017 08:07:13 -0800
Subject: [Intel-wired-lan] [next PATCH 06/11] ixgbe: Use length to determine
 if descriptor is done
In-Reply-To: <20170106155448.1501.31298.stgit@localhost.localdomain>
References: <20170106155448.1501.31298.stgit@localhost.localdomain>
Message-ID: <20170106160711.1501.3612.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This change makes it so that we use the length of the packet instead of the
DD status bit to determine if a new descriptor is ready to be processed.
The obvious advantage is that it cuts down on reads as we don't really even
need the DD bit if going from a 0 to a non-zero value on size is enough to
inform us that the packet has been completed.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1b6f1f584044..6ce596816954 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1653,8 +1653,8 @@ void ixgbe_alloc_rx_buffers(struct ixgbe_ring *rx_ring, u16 cleaned_count)
 			i -= rx_ring->count;
 		}
 
-		/* clear the status bits for the next_to_use descriptor */
-		rx_desc->wb.upper.status_error = 0;
+		/* clear the length for the next_to_use descriptor */
+		rx_desc->wb.upper.length = 0;
 
 		cleaned_count--;
 	} while (cleaned_count);
@@ -2170,7 +2170,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 
 		rx_desc = IXGBE_RX_DESC(rx_ring, rx_ring->next_to_clean);
 
-		if (!rx_desc->wb.upper.status_error)
+		if (!rx_desc->wb.upper.length)
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -3749,6 +3749,7 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 			     struct ixgbe_ring *ring)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	union ixgbe_adv_rx_desc *rx_desc;
 	u64 rdba = ring->dma;
 	u32 rxdctl;
 	u8 reg_idx = ring->reg_idx;
@@ -3783,6 +3784,10 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 		rxdctl |=  0x080420;
 	}
 
+	/* initialize Rx descriptor 0 */
+	rx_desc = IXGBE_RX_DESC(ring, 0);
+	rx_desc->wb.upper.length = 0;
+
 	/* enable receive descriptor ring */
 	rxdctl |= IXGBE_RXDCTL_ENABLE;
 	IXGBE_WRITE_REG(hw, IXGBE_RXDCTL(reg_idx), rxdctl);
@@ -4998,9 +5003,6 @@ static void ixgbe_clean_rx_ring(struct ixgbe_ring *rx_ring)
 	size = sizeof(struct ixgbe_rx_buffer) * rx_ring->count;
 	memset(rx_ring->rx_buffer_info, 0, size);
 
-	/* Zero out the descriptor ring */
-	memset(rx_ring->desc, 0, rx_ring->size);
-
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;

