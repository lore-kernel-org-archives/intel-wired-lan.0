From: Alex Dewar <alex.dewar90@gmail.com>
Date: Wed, 16 Sep 2020 21:49:42 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: Fix use of uninitialized variable
Message-ID: <20200916204943.41017-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In i40e_clean_rx_irq_zc(), the variable failure is only set when a
condition is met, but then its value is used unconditionally. Fix this.

Addresses-Coverity: 1496986 ("Uninitialized value")
Fixes: 8cbf74149903 ("i40e, xsk: move buffer allocation out of the Rx processing loop")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 6acede0acdca..18c05d23e15e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -364,8 +364,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 	}
 
-	if (cleaned_count >= I40E_RX_BUFFER_WRITE)
-		failure = !i40e_alloc_rx_buffers_zc(rx_ring, cleaned_count);
+	failure = (cleaned_count >= I40E_RX_BUFFER_WRITE) &&
+		  !i40e_alloc_rx_buffers_zc(rx_ring, cleaned_count);
 
 	i40e_finalize_xdp_rx(rx_ring, xdp_xmit);
 	i40e_update_rx_stats(rx_ring, total_rx_bytes, total_rx_packets);
-- 
2.28.0

