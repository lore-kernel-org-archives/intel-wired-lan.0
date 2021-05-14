From: Matteo Croce <mcroce@linux.microsoft.com>
Date: Fri, 14 May 2021 20:39:52 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/3] stmmac: use XDP helpers
In-Reply-To: <20210514183954.7129-1-mcroce@linux.microsoft.com>
References: <20210514183954.7129-1-mcroce@linux.microsoft.com>
Message-ID: <20210514183954.7129-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Matteo Croce <mcroce@microsoft.com>

Make use of the xdp_{init,prepare}_buff() helpers instead of
an open-coded version.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 345b4c6d1fd4..bf9fe25fed69 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5167,12 +5167,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 
-			xdp.data = page_address(buf->page) + buf->page_offset;
-			xdp.data_end = xdp.data + buf1_len;
-			xdp.data_hard_start = page_address(buf->page);
-			xdp_set_data_meta_invalid(&xdp);
-			xdp.frame_sz = buf_sz;
-			xdp.rxq = &rx_q->xdp_rxq;
+			xdp_init_buff(&xdp, buf_sz, &rx_q->xdp_rxq);
+			xdp_prepare_buff(&xdp, page_address(buf->page),
+					 buf->page_offset, buf1_len, false);
 
 			pre_len = xdp.data_end - xdp.data_hard_start -
 				  buf->page_offset;
-- 
2.31.1

