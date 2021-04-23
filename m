From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 23 Apr 2021 11:59:55 +0200
Subject: [Intel-wired-lan] [PATCH intel-net] i40e: fix broken XDP support
Message-ID: <20210423095955.15207-1-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") broke
XDP support in the i40e driver. That commit was fixing a sparse error
in the code by introducing a new variable xdp_res instead of
overloading this into the skb pointer. The problem is that the code
later uses the skb pointer in if statements and these where not
extended to also test for the new xdp_res variable. Fix this by adding
the correct tests for xdp_res in these places.

Fixes: 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 06b4271219b1..46355c6bdc8f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1961,10 +1961,6 @@ static bool i40e_cleanup_headers(struct i40e_ring *rx_ring, struct sk_buff *skb,
 				 union i40e_rx_desc *rx_desc)
 
 {
-	/* XDP packets use error pointer so abort at this point */
-	if (IS_ERR(skb))
-		return true;
-
 	/* ERR_MASK will only have valid bits if EOP set, and
 	 * what we are doing here is actually checking
 	 * I40E_RX_DESC_ERROR_RXE_SHIFT, since it is the zeroth bit in
@@ -2447,7 +2443,6 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	unsigned int xdp_xmit = 0;
 	bool failure = false;
 	struct xdp_buff xdp;
-	int xdp_res = 0;
 
 #if (PAGE_SIZE < 8192)
 	frame_sz = i40e_rx_frame_truesize(rx_ring, 0);
@@ -2459,6 +2454,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		union i40e_rx_desc *rx_desc;
 		int rx_buffer_pgcnt;
 		unsigned int size;
+		int xdp_res = 0;
 		u64 qword;
 
 		/* return some buffers to hardware, one@a time is too slow */
@@ -2534,7 +2530,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		}
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb) {
+		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_buff_failed++;
 			rx_buffer->pagecnt_bias++;
 			break;
@@ -2547,7 +2543,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		if (i40e_is_non_eop(rx_ring, rx_desc))
 			continue;
 
-		if (i40e_cleanup_headers(rx_ring, skb, rx_desc)) {
+		if (xdp_res || i40e_cleanup_headers(rx_ring, skb, rx_desc)) {
 			skb = NULL;
 			continue;
 		}

base-commit: bb556de79f0a9e647e8febe15786ee68483fa67b
-- 
2.29.0

