From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  2 Jul 2020 17:37:29 +0200
Subject: [Intel-wired-lan] [PATCH net-next 3/4] i40e,
 xsk: increase budget for AF_XDP path
In-Reply-To: <20200702153730.575738-1-bjorn.topel@gmail.com>
References: <20200702153730.575738-1-bjorn.topel@gmail.com>
Message-ID: <20200702153730.575738-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The napi_budget, meaning the number of received packets that are
allowed to be processed for each napi invocation, takes into
consideration that each received packet is aimed for the kernel
networking stack.

That is not the case for the AF_XDP receive path, where the cost of
each packet is significantly less. Therefore, this commit disregards
the napi budget and increases it to 256. Processing 256 packets
targeted for AF_XDP is still less work than 64 (napi budget) packets
going to the kernel networking stack.

The performance for the rx_drop scenario is up 7%.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 1f2dd591dbf1..99f4afdc403d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -265,6 +265,8 @@ static void i40e_inc_ntc(struct i40e_ring *rx_ring)
 	rx_ring->next_to_clean = ntc;
 }
 
+#define I40E_XSK_CLEAN_RX_BUDGET 256U
+
 /**
  * i40e_clean_rx_irq_zc - Consumes Rx packets from the hardware ring
  * @rx_ring: Rx ring
@@ -280,7 +282,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 	bool failure = false;
 	struct sk_buff *skb;
 
-	while (likely(total_rx_packets < (unsigned int)budget)) {
+	while (likely(total_rx_packets < I40E_XSK_CLEAN_RX_BUDGET)) {
 		union i40e_rx_desc *rx_desc;
 		struct xdp_buff **bi;
 		unsigned int size;
-- 
2.25.1

