From: Joshua Hay <joshua.a.hay@intel.com>
Date: Mon, 11 Jan 2016 15:18:23 -0800
Subject: [Intel-wired-lan] [next PATCH S27 11/15] i40e/i40evf: use
	__GFP_NOWARN
In-Reply-To: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
References: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452554307-20937-12-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The i40e and i40evf drivers now cleanly handle allocation
failures and can avoid kernel log spew from the memory allocator
when allocations fail, so set __GFP_NOWARN on rx buffer alloc.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ic9e1b83c495e2a3ef6b069ba7fb6e52ce134cd23
---
Testing Hints: compile everywhere

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 12 ++++++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index cbedc2b..5f43237 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1292,8 +1292,10 @@ bool i40e_alloc_rx_buffers_1buf(struct i40e_ring *rx_ring, u16 cleaned_count)
 		skb = bi->skb;
 
 		if (!skb) {
-			skb = netdev_alloc_skb_ip_align(rx_ring->netdev,
-							rx_ring->rx_buf_len);
+			skb = __netdev_alloc_skb_ip_align(rx_ring->netdev,
+							  rx_ring->rx_buf_len,
+							  GFP_ATOMIC |
+							  __GFP_NOWARN);
 			if (!skb) {
 				rx_ring->rx_stats.alloc_buff_failed++;
 				goto no_buffers;
@@ -1571,8 +1573,10 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, const int budget)
 		rx_bi = &rx_ring->rx_bi[i];
 		skb = rx_bi->skb;
 		if (likely(!skb)) {
-			skb = netdev_alloc_skb_ip_align(rx_ring->netdev,
-							rx_ring->rx_hdr_len);
+			skb = __netdev_alloc_skb_ip_align(rx_ring->netdev,
+							  rx_ring->rx_hdr_len,
+							  GFP_ATOMIC |
+							  __GFP_NOWARN);
 			if (!skb) {
 				rx_ring->rx_stats.alloc_buff_failed++;
 				failure = true;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 0f9442e..d3ec3b2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -764,8 +764,10 @@ bool i40evf_alloc_rx_buffers_1buf(struct i40e_ring *rx_ring, u16 cleaned_count)
 		skb = bi->skb;
 
 		if (!skb) {
-			skb = netdev_alloc_skb_ip_align(rx_ring->netdev,
-							rx_ring->rx_buf_len);
+			skb = __netdev_alloc_skb_ip_align(rx_ring->netdev,
+							  rx_ring->rx_buf_len,
+							  GFP_ATOMIC |
+							  __GFP_NOWARN);
 			if (!skb) {
 				rx_ring->rx_stats.alloc_buff_failed++;
 				goto no_buffers;
@@ -1034,8 +1036,10 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, const int budget)
 		rx_bi = &rx_ring->rx_bi[i];
 		skb = rx_bi->skb;
 		if (likely(!skb)) {
-			skb = netdev_alloc_skb_ip_align(rx_ring->netdev,
-							rx_ring->rx_hdr_len);
+			skb = __netdev_alloc_skb_ip_align(rx_ring->netdev,
+							  rx_ring->rx_hdr_len,
+							  GFP_ATOMIC |
+							  __GFP_NOWARN);
 			if (!skb) {
 				rx_ring->rx_stats.alloc_buff_failed++;
 				failure = true;
-- 
2.1.0

