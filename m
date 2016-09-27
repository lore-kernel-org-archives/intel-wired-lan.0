From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 27 Sep 2016 11:28:50 -0700
Subject: [Intel-wired-lan] [next PATCH S48 3/7] i40e: Drop redundant Rx
	descriptor processing code
In-Reply-To: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475000934-27335-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch cleans up several pieces of redundant code in the Rx clean-up
paths.

The first bit is that hdr_addr and the status_err_len portions of the Rx
descriptor represent the same value.  As such there is no point in setting
them to 0 before setting them to 0.  I'm dropping the second spot where we
are updating the value to 0 so that we only have 1 write for this value
instead of 2.

The second piece is the checking for the DD bit in the packet.  We only
need to check for a non-zero value for the status_err_len because if the
device is done with the descriptor it will have written something back and
the DD is just one piece of it.  In addition I have moved the reading of
the Rx descriptor bits related to rx_ptype down so that they are actually
below the dma_rmb() call so that we are guaranteed that we don't have any
funky 64b on 32b calls causing any ordering issues.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I256e44a025d3c64a7224aaaec37c852bfcb1871b
---
Testing Hints:
        We should still receive packets normally.  This change could impact
        the Rx hashing, but I don't know of any tests for skb->hash.  The
        only possibility I can think of would be to add a trace point.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 18 ++++++------------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 18 ++++++------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7d5a462..54764dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1217,7 +1217,6 @@ bool i40e_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 		 * because each write-back erases this info.
 		 */
 		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
-		rx_desc->read.hdr_addr = 0;
 
 		rx_desc++;
 		bi++;
@@ -1738,7 +1737,6 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	while (likely(total_rx_packets < budget)) {
 		union i40e_rx_desc *rx_desc;
 		struct sk_buff *skb;
-		u32 rx_status;
 		u16 vlan_tag;
 		u8 rx_ptype;
 		u64 qword;
@@ -1752,21 +1750,13 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 
 		rx_desc = I40E_RX_DESC(rx_ring, rx_ring->next_to_clean);
 
-		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-		rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
-			   I40E_RXD_QW1_PTYPE_SHIFT;
-		rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
-			    I40E_RXD_QW1_STATUS_SHIFT;
-
-		if (!(rx_status & BIT(I40E_RX_DESC_STATUS_DD_SHIFT)))
-			break;
-
 		/* status_error_len will always be zero for unused descriptors
 		 * because it's cleared in cleanup, and overlaps with hdr_addr
 		 * which is always zero because packet split isn't used, if the
 		 * hardware wrote DD then it will be non-zero
 		 */
-		if (!rx_desc->wb.qword1.status_error_len)
+		if (!i40e_test_staterr(rx_desc,
+				       BIT(I40E_RX_DESC_STATUS_DD_SHIFT)))
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -1800,6 +1790,10 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
 
+		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
+		rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
+			   I40E_RXD_QW1_PTYPE_SHIFT;
+
 		/* populate checksum, VLAN, and protocol */
 		i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index dd8ad6b..e2d3622 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -705,7 +705,6 @@ bool i40evf_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 		 * because each write-back erases this info.
 		 */
 		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
-		rx_desc->read.hdr_addr = 0;
 
 		rx_desc++;
 		bi++;
@@ -1209,7 +1208,6 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	while (likely(total_rx_packets < budget)) {
 		union i40e_rx_desc *rx_desc;
 		struct sk_buff *skb;
-		u32 rx_status;
 		u16 vlan_tag;
 		u8 rx_ptype;
 		u64 qword;
@@ -1223,21 +1221,13 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 
 		rx_desc = I40E_RX_DESC(rx_ring, rx_ring->next_to_clean);
 
-		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-		rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
-			   I40E_RXD_QW1_PTYPE_SHIFT;
-		rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
-			    I40E_RXD_QW1_STATUS_SHIFT;
-
-		if (!(rx_status & BIT(I40E_RX_DESC_STATUS_DD_SHIFT)))
-			break;
-
 		/* status_error_len will always be zero for unused descriptors
 		 * because it's cleared in cleanup, and overlaps with hdr_addr
 		 * which is always zero because packet split isn't used, if the
 		 * hardware wrote DD then it will be non-zero
 		 */
-		if (!rx_desc->wb.qword1.status_error_len)
+		if (!i40e_test_staterr(rx_desc,
+				       BIT(I40E_RX_DESC_STATUS_DD_SHIFT)))
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -1271,6 +1261,10 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
 
+		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
+		rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
+			   I40E_RXD_QW1_PTYPE_SHIFT;
+
 		/* populate checksum, VLAN, and protocol */
 		i40evf_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
 
-- 
2.4.11

