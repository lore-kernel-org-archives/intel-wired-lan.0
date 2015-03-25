From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:15 -0700
Subject: [Intel-wired-lan] [next-queue S2 05/15] i40e/i40evf: fix bug when
	skb allocation fails
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-5-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

If the skb allocation fails we should not continue using the skb
pointer.  Breaking out at the point of failure means that at the next
RX interrupt the driver will try the allocation again.

Change-ID: Iefaad69856ced7418bfd92afe55322676341f82e
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 5 ++++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9b11f2e..5a1a677 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1565,8 +1565,11 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 		if (likely(!skb)) {
 			skb = netdev_alloc_skb_ip_align(rx_ring->netdev,
 							rx_ring->rx_hdr_len);
-			if (!skb)
+			if (!skb) {
 				rx_ring->rx_stats.alloc_buff_failed++;
+				break;
+			}
+
 			/* initialize queue mapping */
 			skb_record_rx_queue(skb, rx_ring->queue_index);
 			/* we are reusing so sync this buffer for CPU use */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 1b5ee46..2be50a8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1040,8 +1040,11 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 		if (likely(!skb)) {
 			skb = netdev_alloc_skb_ip_align(rx_ring->netdev,
 							rx_ring->rx_hdr_len);
-			if (!skb)
+			if (!skb) {
 				rx_ring->rx_stats.alloc_buff_failed++;
+				break;
+			}
+
 			/* initialize queue mapping */
 			skb_record_rx_queue(skb, rx_ring->queue_index);
 			/* we are reusing so sync this buffer for CPU use */
-- 
1.9.3

