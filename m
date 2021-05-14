From: Matteo Croce <mcroce@linux.microsoft.com>
Date: Fri, 14 May 2021 20:39:53 +0200
Subject: [Intel-wired-lan] [PATCH net-next 2/3] igc: use XDP helpers
In-Reply-To: <20210514183954.7129-1-mcroce@linux.microsoft.com>
References: <20210514183954.7129-1-mcroce@linux.microsoft.com>
Message-ID: <20210514183954.7129-3-mcroce@linux.microsoft.com>
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
 drivers/net/ethernet/intel/igc/igc_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 069471b7ffb0..92c0701e2a36 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2151,12 +2151,9 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		}
 
 		if (!skb) {
-			xdp.data = pktbuf + pkt_offset;
-			xdp.data_end = xdp.data + size;
-			xdp.data_hard_start = pktbuf - igc_rx_offset(rx_ring);
-			xdp_set_data_meta_invalid(&xdp);
-			xdp.frame_sz = truesize;
-			xdp.rxq = &rx_ring->xdp_rxq;
+			xdp_init_buff(&xdp, truesize, &rx_ring->xdp_rxq);
+			xdp_prepare_buff(&xdp, pktbuf - igc_rx_offset(rx_ring),
+					 igc_rx_offset(rx_ring) + pkt_offset, size, false);
 
 			skb = igc_xdp_run_prog(adapter, &xdp);
 		}
-- 
2.31.1

