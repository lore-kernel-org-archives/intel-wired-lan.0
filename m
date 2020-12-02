From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue,  1 Dec 2020 20:53:21 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 5/9] igc: Avoid TX Hangs
 because long cycles
In-Reply-To: <20201202045325.3254757-1-vinicius.gomes@intel.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
Message-ID: <20201202045325.3254757-6-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Avoid possible TX Hangs caused by using long Qbv cycles. In some
cases, using long cycles (more than 1 second) can cause transmissions
to be blocked for that time. As the TX Hang timeout is close to 1
second, we may need to reduce the cycle time to something more
reasonable: the value chosen is 1ms.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b673ac1199bb..3af54fd9cc0d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4692,12 +4692,12 @@ static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
 	if (adapter->base_time)
 		return 0;
 
-	adapter->cycle_time = NSEC_PER_SEC;
+	adapter->cycle_time = NSEC_PER_MSEC;
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		ring = adapter->tx_ring[i];
 		ring->start_time = 0;
-		ring->end_time = NSEC_PER_SEC;
+		ring->end_time = NSEC_PER_MSEC;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 38451cf05ac6..f5a5527adb21 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -54,11 +54,11 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 
 		wr32(IGC_TXQCTL(i), 0);
 		wr32(IGC_STQT(i), 0);
-		wr32(IGC_ENDQT(i), NSEC_PER_SEC);
+		wr32(IGC_ENDQT(i), NSEC_PER_MSEC);
 	}
 
-	wr32(IGC_QBVCYCLET_S, NSEC_PER_SEC);
-	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
+	wr32(IGC_QBVCYCLET_S, NSEC_PER_MSEC);
+	wr32(IGC_QBVCYCLET, NSEC_PER_MSEC);
 
 	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
 
-- 
2.29.2

