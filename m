From: sven.auhagen@voleatech.de <sven.auhagen@voleatech.de>
Date: Mon, 19 Oct 2020 10:05:48 +0200
Subject: [Intel-wired-lan] [PATCH net v3 1/6] igb: XDP xmit back fix error
 code
In-Reply-To: <20201019080553.24353-1-sven.auhagen@voleatech.de>
References: <20201019080553.24353-1-sven.auhagen@voleatech.de>
Message-ID: <20201019080553.24353-2-sven.auhagen@voleatech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sven Auhagen <sven.auhagen@voleatech.de>

The igb XDP xmit back function should only return
defined error codes.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5fc2c381da55..08cc6f59aa2e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2910,7 +2910,7 @@ static int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
 	 */
 	tx_ring = adapter->xdp_prog ? igb_xdp_tx_queue_mapping(adapter) : NULL;
 	if (unlikely(!tx_ring))
-		return -ENXIO;
+		return IGB_XDP_CONSUMED;
 
 	nq = txring_txq(tx_ring);
 	__netif_tx_lock(nq, cpu);
-- 
2.20.1

