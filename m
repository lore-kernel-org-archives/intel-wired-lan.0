From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 18 Jan 2021 16:13:10 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 03/11] i40e: adjust
 i40e_is_non_eop
In-Reply-To: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
References: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
Message-ID: <20210118151318.12324-4-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40e_is_non_eop had a leftover comment and unused skb argument which was
used for placing the skb onto rx_buf in case when current buffer was
non-eop one. This is not relevant anymore as commit e72e56597ba1
("i40e/i40evf: Moves skb from i40e_rx_buffer to i40e_ring") pulled the
non-complete skb handling out of rx_bufs up to rx_ring.  Therefore,
let's adjust the function arguments that i40e_is_non_eop takes.

Furthermore, since there is already a function responsible for bumping
the ntc, make use of that and drop that logic from i40e_is_non_eop so
that the scope of this function is limited to what the name actually
states.

Reviewed-by: Bj?rn T?pel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 23 ++++++---------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f8aa68f2a7fd..7e008dbbef97 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2130,25 +2130,13 @@ static void i40e_put_rx_buffer(struct i40e_ring *rx_ring,
  * i40e_is_non_eop - process handling of non-EOP buffers
  * @rx_ring: Rx ring being processed
  * @rx_desc: Rx descriptor for current buffer
- * @skb: Current socket buffer containing buffer in progress
  *
- * This function updates next to clean.  If the buffer is an EOP buffer
- * this function exits returning false, otherwise it will place the
- * sk_buff in the next buffer to be chained and return true indicating
- * that this is in fact a non-EOP buffer.
- **/
+ * If the buffer is an EOP buffer, this function exits returning false,
+ * otherwise return true indicating that this is in fact a non-EOP buffer.
+ */
 static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
-			    union i40e_rx_desc *rx_desc,
-			    struct sk_buff *skb)
+			    union i40e_rx_desc *rx_desc)
 {
-	u32 ntc = rx_ring->next_to_clean + 1;
-
-	/* fetch, update, and store next to clean */
-	ntc = (ntc < rx_ring->count) ? ntc : 0;
-	rx_ring->next_to_clean = ntc;
-
-	prefetch(I40E_RX_DESC(rx_ring, ntc));
-
 	/* if we are the last buffer then there is nothing else to do */
 #define I40E_RXD_EOF BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)
 	if (likely(i40e_test_staterr(rx_desc, I40E_RXD_EOF)))
@@ -2427,7 +2415,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		i40e_put_rx_buffer(rx_ring, rx_buffer, rx_buffer_pgcnt);
 		cleaned_count++;
 
-		if (i40e_is_non_eop(rx_ring, rx_desc, skb))
+		i40e_inc_ntc(rx_ring);
+		if (i40e_is_non_eop(rx_ring, rx_desc))
 			continue;
 
 		if (i40e_cleanup_headers(rx_ring, skb, rx_desc)) {
-- 
2.20.1

