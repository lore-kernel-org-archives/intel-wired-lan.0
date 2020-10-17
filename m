From: sven.auhagen@voleatech.de <sven.auhagen@voleatech.de>
Date: Sat, 17 Oct 2020 09:12:37 +0200
Subject: [Intel-wired-lan] [PATCH v2 5/6] igb: use xdp_do_flush
In-Reply-To: <20201017071238.95190-1-sven.auhagen@voleatech.de>
References: <20201017071238.95190-1-sven.auhagen@voleatech.de>
Message-ID: <20201017071238.95190-6-sven.auhagen@voleatech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sven Auhagen <sven.auhagen@voleatech.de>

Since it is a new XDP implementation change xdp_do_flush_map
to xdp_do_flush.

Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 36ff8725fdaf..55e708f75187 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8776,7 +8776,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	rx_ring->skb = skb;
 
 	if (xdp_xmit & IGB_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (xdp_xmit & IGB_XDP_TX) {
 		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
-- 
2.20.1

