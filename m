From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Mon, 13 Apr 2015 18:15:11 +0900
Subject: [Intel-wired-lan] [PATCH net 2/2] igb: Fix NULL assignment to
	incorrect variable in igb_reset_q_vector
In-Reply-To: <1428916512-25559-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1428916512-25559-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Message-ID: <1428916512-25559-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

adapter->tx_ring is set to NULL where rx_ring should be.

Fixes: 5536d2102a2d ("igb: Combine q_vector and ring allocation into a single function")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 010ddcb..b664512 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1036,7 +1036,7 @@ static void igb_reset_q_vector(struct igb_adapter *adapter, int v_idx)
 		adapter->tx_ring[q_vector->tx.ring->queue_index] = NULL;
 
 	if (q_vector->rx.ring)
-		adapter->tx_ring[q_vector->rx.ring->queue_index] = NULL;
+		adapter->rx_ring[q_vector->rx.ring->queue_index] = NULL;
 
 	netif_napi_del(&q_vector->napi);
 
-- 
1.8.1.2


