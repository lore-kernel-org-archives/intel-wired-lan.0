From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Jan 2017 08:31:48 -0800
Subject: [Intel-wired-lan] [next PATCH v2 2/9] igb: Use length to determine
 if descriptor is done
In-Reply-To: <20170117163010.5184.65449.stgit@localhost.localdomain>
References: <20170117163010.5184.65449.stgit@localhost.localdomain>
Message-ID: <20170117163137.5184.23469.stgit@localhost.localdomain>
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

In addition I have updated the code so that we only reset the Rx descriptor
length for descriptor zero when resetting a ring instead of having to do a
memset with 0 over the entire ring.  By doing this we can save some time on
initialization.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v2: Update ethtool loopback test to use length check instead of DD check

 drivers/net/ethernet/intel/igb/igb_ethtool.c |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c    |   14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 737b664d004c..3f5f7744c90f 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1811,7 +1811,7 @@ static int igb_clean_test_rings(struct igb_ring *rx_ring,
 	tx_ntc = tx_ring->next_to_clean;
 	rx_desc = IGB_RX_DESC(rx_ring, rx_ntc);
 
-	while (igb_test_staterr(rx_desc, E1000_RXD_STAT_DD)) {
+	while (rx_desc->wb.upper.length) {
 		/* check Rx buffer */
 		rx_buffer_info = &rx_ring->rx_buffer_info[rx_ntc];
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index eede6db6037c..91a524b155ce 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3720,6 +3720,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 			   struct igb_ring *ring)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	union e1000_adv_rx_desc *rx_desc;
 	u64 rdba = ring->dma;
 	int reg_idx = ring->reg_idx;
 	u32 srrctl = 0, rxdctl = 0;
@@ -3758,6 +3759,10 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	rxdctl |= IGB_RX_HTHRESH << 8;
 	rxdctl |= IGB_RX_WTHRESH << 16;
 
+	/* initialize Rx descriptor 0 */
+	rx_desc = IGB_RX_DESC(ring, 0);
+	rx_desc->wb.upper.length = 0;
+
 	/* enable receive descriptor fetching */
 	rxdctl |= E1000_RXDCTL_QUEUE_ENABLE;
 	wr32(E1000_RXDCTL(reg_idx), rxdctl);
@@ -3973,9 +3978,6 @@ static void igb_clean_rx_ring(struct igb_ring *rx_ring)
 	size = sizeof(struct igb_rx_buffer) * rx_ring->count;
 	memset(rx_ring->rx_buffer_info, 0, size);
 
-	/* Zero out the descriptor ring */
-	memset(rx_ring->desc, 0, rx_ring->size);
-
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
@@ -7174,7 +7176,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 
 		rx_desc = IGB_RX_DESC(rx_ring, rx_ring->next_to_clean);
 
-		if (!rx_desc->wb.upper.status_error)
+		if (!rx_desc->wb.upper.length)
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -7314,8 +7316,8 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
 			i -= rx_ring->count;
 		}
 
-		/* clear the status bits for the next_to_use descriptor */
-		rx_desc->wb.upper.status_error = 0;
+		/* clear the length for the next_to_use descriptor */
+		rx_desc->wb.upper.length = 0;
 
 		cleaned_count--;
 	} while (cleaned_count);

