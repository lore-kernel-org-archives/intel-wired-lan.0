From: jeff.evanson@gmail.com <jeff.evanson@gmail.com>
Date: Tue, 19 Apr 2022 19:26:34 -0600
Subject: [Intel-wired-lan] [PATCH v2 1/2] igc: Fix race in igc_xdp_xmit_zc
In-Reply-To: <20220420012635.13733-1-jeff.evanson@qsc.com>
References: <20220420012635.13733-1-jeff.evanson@qsc.com>
Message-ID: <20220420012635.13733-2-jeff.evanson@qsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Evanson <jeff.evanson@qsc.com>

In igc_xdp_xmit_zc, initialize next_to_use while holding the netif_tx_lock
to prevent racing with other users of the tx ring.

Fixes: 9acf59a752d4 (igc: Enable TX via AF_XDP zero-copy)
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1c00ee310c19..a36a18c84aeb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2598,7 +2598,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
+	u16 ntu;
 	struct xdp_desc xdp_desc;
 	u16 budget;
 
@@ -2607,6 +2607,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 
 	__netif_tx_lock(nq, cpu);
 
+	ntu = ring->next_to_use;
+
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
-- 
2.17.1

