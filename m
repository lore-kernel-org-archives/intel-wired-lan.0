From: sven.auhagen@voleatech.de <sven.auhagen@voleatech.de>
Date: Mon, 19 Oct 2020 10:05:53 +0200
Subject: [Intel-wired-lan] [PATCH net v3 6/6] igb: avoid transmit queue
 timeout in xdp path
In-Reply-To: <20201019080553.24353-1-sven.auhagen@voleatech.de>
References: <20201019080553.24353-1-sven.auhagen@voleatech.de>
Message-ID: <20201019080553.24353-7-sven.auhagen@voleatech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sven Auhagen <sven.auhagen@voleatech.de>

Since we share the transmit queue with the network stack,
it is possible that we run into a transmit queue timeout.
This will reset the queue.
This happens under high load when XDP is using the
transmit queue pretty much exclusively.

netdev_start_xmit() sets the trans_start variable of the
transmit queue to jiffies which is later utilized by dev_watchdog(),
so to avoid timeout, let stack know that XDP xmit happened by
bumping the trans_start within XDP Tx routines to jiffies.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 55e708f75187..4a082c06f48d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2916,6 +2916,8 @@ static int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
 
 	nq = txring_txq(tx_ring);
 	__netif_tx_lock(nq, cpu);
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	nq->trans_start = jiffies;
 	ret = igb_xmit_xdp_ring(adapter, tx_ring, xdpf);
 	__netif_tx_unlock(nq);
 
@@ -2948,6 +2950,9 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 	nq = txring_txq(tx_ring);
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid transmit queue timeout since we share it with the slow path */
+	nq->trans_start = jiffies;
+
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
 		int err;
-- 
2.20.1

