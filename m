From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  7 Sep 2020 17:02:15 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 2/4] i40e,
 xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
In-Reply-To: <20200907150217.30888-1-bjorn.topel@gmail.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
Message-ID: <20200907150217.30888-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Start using XSK_NAPI_WEIGHT as NAPI poll budget for the AF_XDP Rx
zero-copy path.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 2a1153d8957b..a8018736ca32 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -272,7 +272,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 	bool failure = false;
 	struct sk_buff *skb;
 
-	while (likely(total_rx_packets < (unsigned int)budget)) {
+	while (likely(total_rx_packets < XSK_NAPI_WEIGHT)) {
 		union i40e_rx_desc *rx_desc;
 		struct xdp_buff **bi;
 		unsigned int size;
-- 
2.25.1

