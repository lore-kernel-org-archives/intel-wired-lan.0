From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 23 Jul 2019 09:08:48 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: use a local variable for the frag
 pointer
Message-ID: <20190723160848.1006-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the function fm10k_xmit_frame_ring, we recently switched to using
the skb_frag_size accessor instead of directly using the size member of
the skb fragment.

This made the for loop slightly harder to read because it created a very
long line that is difficult to split up. Avoid this by using a local
variable in the for loop, so that we do not have to break the line on an
open parenthesis.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index e0a2be534b20..2be9222510e7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1073,9 +1073,11 @@ netdev_tx_t fm10k_xmit_frame_ring(struct sk_buff *skb,
 	 *       + 2 desc gap to keep tail from touching head
 	 * otherwise try next time
 	 */
-	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
-		count += TXD_USE_COUNT(skb_frag_size(
-						&skb_shinfo(skb)->frags[f]));
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[f];
+
+		count += TXD_USE_COUNT(skb_frag_size(frag));
+	}
 
 	if (fm10k_maybe_stop_tx(tx_ring, count + 3)) {
 		tx_ring->tx_stats.tx_busy++;
-- 
2.22.0.214.g8dca754b1e87

