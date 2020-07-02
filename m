From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  2 Jul 2020 17:37:30 +0200
Subject: [Intel-wired-lan] [PATCH net-next 4/4] i40e,
 xsk: move buffer allocation out of the Rx processing loop
In-Reply-To: <20200702153730.575738-1-bjorn.topel@gmail.com>
References: <20200702153730.575738-1-bjorn.topel@gmail.com>
Message-ID: <20200702153730.575738-5-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Instead of checking in each iteration of the Rx packet processing
loop, move the allocation out of the loop and do it once for each napi
activation.

For AF_XDP the rx_drop benchmark was improved by 6%.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 99f4afdc403d..91aee16fbe72 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -279,8 +279,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
 	unsigned int xdp_res, xdp_xmit = 0;
-	bool failure = false;
 	struct sk_buff *skb;
+	bool failure;
 
 	while (likely(total_rx_packets < I40E_XSK_CLEAN_RX_BUDGET)) {
 		union i40e_rx_desc *rx_desc;
@@ -288,13 +288,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		unsigned int size;
 		u64 qword;
 
-		if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
-			failure = failure ||
-				  !i40e_alloc_rx_buffers_zc(rx_ring,
-							    cleaned_count);
-			cleaned_count = 0;
-		}
-
 		rx_desc = I40E_RX_DESC(rx_ring, rx_ring->next_to_clean);
 		qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
 
@@ -369,6 +362,9 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 	}
 
+	if (cleaned_count >= I40E_RX_BUFFER_WRITE)
+		failure = !i40e_alloc_rx_buffers_zc(rx_ring, cleaned_count);
+
 	i40e_finalize_xdp_rx(rx_ring, xdp_xmit);
 	i40e_update_rx_stats(rx_ring, total_rx_bytes, total_rx_packets);
 
-- 
2.25.1

