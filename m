From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Fri, 26 Mar 2021 19:43:40 +0100
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse errors in i40e_txrx.c
Message-ID: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove error handling through pointers. Instead use plain int
to return value from i40e_run_xdp(...).

Previously:
- sparse errors were produced during compilation:
i40e_txrx.c:2338 i40e_run_xdp() error: (-2147483647) too low for ERR_PTR
i40e_txrx.c:2558 i40e_clean_rx_irq() error: 'skb' dereferencing possible ERR_PTR()

- sk_buff* was used to return value, but it has never had valid
pointer to sk_buff. Returned value was always int handeled as
a pointer.

Fixes: 0c8493d90b6b ("i40e: add XDP support for pass and drop actions")
Fixes: 2e6893123830 ("i40e: split XDP_TX tail and XDP_REDIRECT map flushing")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 5747a99..4345e45 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2295,7 +2295,7 @@ int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring)
  * @rx_ring: Rx ring being processed
  * @xdp: XDP buffer containing the frame
  **/
-static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
+static int i40e_run_xdp(struct i40e_ring *rx_ring,
 				    struct xdp_buff *xdp)
 {
 	int err, result = I40E_XDP_PASS;
@@ -2335,7 +2335,7 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 	}
 xdp_out:
 	rcu_read_unlock();
-	return ERR_PTR(-result);
+	return result;
 }
 
 /**
@@ -2448,6 +2448,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	unsigned int xdp_xmit = 0;
 	bool failure = false;
 	struct xdp_buff xdp;
+	int xdp_res = 0;
 
 #if (PAGE_SIZE < 8192)
 	frame_sz = i40e_rx_frame_truesize(rx_ring, 0);
@@ -2513,12 +2514,10 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
 			xdp.frame_sz = i40e_rx_frame_truesize(rx_ring, size);
 #endif
-			skb = i40e_run_xdp(rx_ring, &xdp);
+			xdp_res = i40e_run_xdp(rx_ring, &xdp);
 		}
 
-		if (IS_ERR(skb)) {
-			unsigned int xdp_res = -PTR_ERR(skb);
-
+		if (xdp_res) {
 			if (xdp_res & (I40E_XDP_TX | I40E_XDP_REDIR)) {
 				xdp_xmit |= xdp_res;
 				i40e_rx_buffer_flip(rx_ring, rx_buffer, size);

base-commit: ca4303103f33952646218db4e0869e6f6aa1c840
-- 
2.26.0

