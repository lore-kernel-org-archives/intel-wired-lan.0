From: Bernard Zhao <zhaojunkui2008@126.com>
Date: Tue, 10 May 2022 23:54:51 -0700
Subject: [Intel-wired-lan] [PATCH] intel/i40e: delete if NULL check before
 dev_kfree_skb
Message-ID: <20220511065451.655335-1-zhaojunkui2008@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

dev_kfree_skb check if the input parameter NULL and do the right
thing, there is no need to check again.
This change is to cleanup the code a bit.

Signed-off-by: Bernard Zhao <zhaojunkui2008@126.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 0eae5858f2fe..98cfadfd0f35 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1482,10 +1482,8 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 	if (!rx_ring->rx_bi)
 		return;
 
-	if (rx_ring->skb) {
-		dev_kfree_skb(rx_ring->skb);
-		rx_ring->skb = NULL;
-	}
+	dev_kfree_skb(rx_ring->skb);
+	rx_ring->skb = NULL;
 
 	if (rx_ring->xsk_pool) {
 		i40e_xsk_clean_rx_ring(rx_ring);
-- 
2.33.1

