From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Jul 2021 17:34:03 -0700
Subject: [Intel-wired-lan] [PATCH net-queue v1] igc: Use num_tx_queues when
 iterating over tx_ring queue
Message-ID: <20210722003403.69289-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Nishioka, Toshiki" <toshiki.nishioka@intel.com>

Use num_tx_queues rather than the IGC_MAX_TX_QUEUES fixed number 4 when
iterating over tx_ring queue since instantiated queue count could be
less than 4 where on-line cpu count is less than 4.

Fixes: ec50a9d437f0 ("igc: Add support for taprio offloading")
Signed-off-by: Toshiki Nishioka <toshiki.nishioka@intel.com>
Tested-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e29aadbc6744..2b3b741f816c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5489,7 +5489,7 @@ static bool validate_schedule(struct igc_adapter *adapter,
 		if (e->command != TC_TAPRIO_CMD_SET_GATES)
 			return false;
 
-		for (i = 0; i < IGC_MAX_TX_QUEUES; i++) {
+		for (i = 0; i < adapter->num_tx_queues; i++) {
 			if (e->gate_mask & BIT(i))
 				queue_uses[i]++;
 
@@ -5546,7 +5546,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 
 		end_time += e->interval;
 
-		for (i = 0; i < IGC_MAX_TX_QUEUES; i++) {
+		for (i = 0; i < adapter->num_tx_queues; i++) {
 			struct igc_ring *ring = adapter->tx_ring[i];
 
 			if (!(e->gate_mask & BIT(i)))
-- 
2.32.0

