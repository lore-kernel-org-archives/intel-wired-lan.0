From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 09:32:47 -0700
Subject: [Intel-wired-lan] [next-queue v2 13/17] fm10k: Update adaptive ITR
	algorithm
In-Reply-To: <1444840371-17328-1-git-send-email-jacob.e.keller@intel.com>
References: <1444840371-17328-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1444840371-17328-13-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The existing adaptive ITR algorithm is overly restrictive. It throttles
incorrectly for various traffic rates, and does not produce good
performance. The algorithm now allows for more interrupts per second,
and does some calculation to help improve for smaller packet loads. In
addition, take into account the new itr_scale from the hardware which
indicates how much to scale due to PCIe link speed.

A single thread of receiving TCP_STREAM in netperf:
- Before: 450 Mbps
- After: 20,000 Mbps

Reported-by: Matthew Vick <matthew.vick@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h      |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 29 +++++++++++++++++++++++----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  6 ++++--
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index a2484cb88d86..bdbb804a594f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -164,6 +164,7 @@ struct fm10k_ring_container {
 	unsigned int total_packets;	/* total packets processed this int */
 	u16 work_limit;			/* total work allowed per interrupt */
 	u16 itr;			/* interrupt throttle rate value */
+	u8 itr_scale;			/* ITR adjustment scaler based on PCI speed */
 	u8 count;			/* total number of rings in vector */
 };
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 8207ee189600..7a3388fff178 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1386,11 +1386,30 @@ static void fm10k_update_itr(struct fm10k_ring_container *ring_container)
 	if (avg_wire_size > 3000)
 		avg_wire_size = 3000;
 
-	/* Give a little boost to mid-size frames */
-	if ((avg_wire_size > 300) && (avg_wire_size < 1200))
-		avg_wire_size /= 3;
+	/* Throttle rate management based on average wire size, attempting to
+	 * slightly boost small and medium packet loads. Divide the average
+	 * wire size by a small factor to calculate the minimum time until the
+	 * next interrupt in microseconds. Save some cycles by using a
+	 * multiply then a shift, which also accounts for difference due to
+	 * PCIe link speed.
+	 */
+#define FM10K_ITR_SCALE_SMALL	6
+#define FM10K_ITR_SCALE_MEDIUM	5
+#define FM10K_ITR_SCALE_LARGE	4
+
+	if (avg_wire_size < 300)
+		avg_wire_size *= FM10K_ITR_SCALE_SMALL;
+	else if ((avg_wire_size >= 300) && (avg_wire_size < 1200))
+		avg_wire_size *= FM10K_ITR_SCALE_MEDIUM;
 	else
-		avg_wire_size /= 2;
+		avg_wire_size *= FM10K_ITR_SCALE_LARGE;
+
+	/* Round up average wire size, then perform bit shift, to ensure that
+	 * the calculation will never get below 1. Account for changes in ITR
+	 * value due to PCIe link speed.
+	 */
+	avg_wire_size += (1 << (ring_container->itr_scale + 8)) - 1;
+	avg_wire_size >>= ring_container->itr_scale + 8;
 
 	/* write back value and retain adaptive flag */
 	ring_container->itr = avg_wire_size | FM10K_ITR_ADAPTIVE;
@@ -1608,6 +1627,7 @@ static int fm10k_alloc_q_vector(struct fm10k_intfc *interface,
 	q_vector->tx.ring = ring;
 	q_vector->tx.work_limit = FM10K_DEFAULT_TX_WORK;
 	q_vector->tx.itr = interface->tx_itr;
+	q_vector->tx.itr_scale = interface->hw.mac.itr_scale;
 	q_vector->tx.count = txr_count;
 
 	while (txr_count) {
@@ -1636,6 +1656,7 @@ static int fm10k_alloc_q_vector(struct fm10k_intfc *interface,
 	/* save Rx ring container info */
 	q_vector->rx.ring = ring;
 	q_vector->rx.itr = interface->rx_itr;
+	q_vector->rx.itr_scale = interface->hw.mac.itr_scale;
 	q_vector->rx.count = rxr_count;
 
 	while (rxr_count) {
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 9ad9f9164d91..cbf38da0ada7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -880,7 +880,8 @@ static irqreturn_t fm10k_msix_mbx_vf(int __always_unused irq, void *data)
 
 	/* re-enable mailbox interrupt and indicate 20us delay */
 	fm10k_write_reg(hw, FM10K_VFITR(FM10K_MBX_VECTOR),
-			FM10K_ITR_ENABLE | FM10K_MBX_INT_DELAY);
+			FM10K_ITR_ENABLE | (FM10K_MBX_INT_DELAY >>
+					    hw->mac.itr_scale));
 
 	/* service upstream mailbox */
 	if (fm10k_mbx_trylock(interface)) {
@@ -1111,7 +1112,8 @@ static irqreturn_t fm10k_msix_mbx_pf(int __always_unused irq, void *data)
 
 	/* re-enable mailbox interrupt and indicate 20us delay */
 	fm10k_write_reg(hw, FM10K_ITR(FM10K_MBX_VECTOR),
-			FM10K_ITR_ENABLE | FM10K_MBX_INT_DELAY);
+			FM10K_ITR_ENABLE | (FM10K_MBX_INT_DELAY >>
+					    hw->mac.itr_scale));
 
 	return IRQ_HANDLED;
 }
-- 
2.6.1.264.gbab76a9

