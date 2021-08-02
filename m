From: aravindhan.gunasekaran@intel.com <aravindhan.gunasekaran@intel.com>
Date: Mon,  2 Aug 2021 20:37:09 +0530
Subject: [Intel-wired-lan] [PATCH next-queue v1 1/3] igc: Use default cycle
 'start' and 'end' values for queues
In-Reply-To: <1627916831-10144-1-git-send-email-aravindhan.gunasekaran@intel.com>
References: <1627916831-10144-1-git-send-email-aravindhan.gunasekaran@intel.com>
Message-ID: <1627916831-10144-2-git-send-email-aravindhan.gunasekaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Sets default values for each queue cycle start and cycle end. This
allows some simplification in the handling of these configurations as
most TSN features in i225 require a cycle to be configured.

In i225, cycle start and end time is required to be programmed for
CBS to work properly.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 37 ++++++++++++++++++-------------
 drivers/net/ethernet/intel/igc/igc_tsn.c  |  6 -----
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4dc7c4d..5184885 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5750,7 +5750,6 @@ static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
 				      bool enable)
 {
 	struct igc_ring *ring;
-	int i;
 
 	if (queue < 0 || queue >= adapter->num_tx_queues)
 		return -EINVAL;
@@ -5758,17 +5757,6 @@ static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
 	ring = adapter->tx_ring[queue];
 	ring->launchtime_enable = enable;
 
-	if (adapter->base_time)
-		return 0;
-
-	adapter->cycle_time = NSEC_PER_SEC;
-
-	for (i = 0; i < adapter->num_tx_queues; i++) {
-		ring = adapter->tx_ring[i];
-		ring->start_time = 0;
-		ring->end_time = NSEC_PER_SEC;
-	}
-
 	return 0;
 }
 
@@ -5841,16 +5829,31 @@ static int igc_tsn_enable_launchtime(struct igc_adapter *adapter,
 	return igc_tsn_offload_apply(adapter);
 }
 
+static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
+{
+	int i;
+
+	adapter->base_time = 0;
+	adapter->cycle_time = NSEC_PER_SEC;
+
+	for (i = 0; i < IGC_MAX_TX_QUEUES; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
+		ring->start_time = 0;
+		ring->end_time = NSEC_PER_SEC;
+	}
+
+	return 0;
+}
+
 static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 				 struct tc_taprio_qopt_offload *qopt)
 {
 	u32 start_time = 0, end_time = 0;
 	size_t n;
 
-	if (!qopt->enable) {
-		adapter->base_time = 0;
-		return 0;
-	}
+	if (!qopt->enable)
+		return igc_tsn_clear_schedule(adapter);
 
 	if (adapter->base_time)
 		return -EALREADY;
@@ -6337,6 +6340,8 @@ static int igc_probe(struct pci_dev *pdev,
 
 	igc_ptp_init(adapter);
 
+	igc_tsn_clear_schedule(adapter);
+
 	/* reset the hardware with the new settings */
 	igc_reset(adapter);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 4dbbb8a..5bcdf75 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -41,12 +41,6 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_TQAVCTRL, tqavctrl);
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
-		struct igc_ring *ring = adapter->tx_ring[i];
-
-		ring->start_time = 0;
-		ring->end_time = 0;
-		ring->launchtime_enable = false;
-
 		wr32(IGC_TXQCTL(i), 0);
 		wr32(IGC_STQT(i), 0);
 		wr32(IGC_ENDQT(i), NSEC_PER_SEC);
-- 
2.7.4

