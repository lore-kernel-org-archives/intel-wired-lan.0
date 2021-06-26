From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 25 Jun 2021 17:33:09 -0700
Subject: [Intel-wired-lan] [PATCH net-next v4 07/12] igc: Add support for
 TC_SETUP_PREEMPT
In-Reply-To: <20210626003314.3159402-1-vinicius.gomes@intel.com>
References: <20210626003314.3159402-1-vinicius.gomes@intel.com>
Message-ID: <20210626003314.3159402-8-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Saves which queues are marked as preemptible, activating frame
preemption is done when the user requests it enabled, via ethtool.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 9afee4712aeb..68c7262bd172 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -92,6 +92,7 @@ struct igc_ring {
 	u8 queue_index;                 /* logical index of the ring*/
 	u8 reg_idx;                     /* physical index of the ring */
 	bool launchtime_enable;         /* true if LaunchTime is enabled */
+	bool preemptible;               /* true if not express */
 
 	u32 start_time;
 	u32 end_time;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 3f6b6d4543a8..b0981ea0ae63 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5563,6 +5563,23 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	return 0;
 }
 
+static int igc_save_frame_preemption(struct igc_adapter *adapter,
+				     struct tc_preempt_qopt_offload *qopt)
+{
+	u32 preempt;
+	int i;
+
+	preempt = qopt->preemptible_queues;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
+		ring->preemptible = preempt & BIT(i);
+	}
+
+	return 0;
+}
+
 static int igc_tsn_enable_qbv_scheduling(struct igc_adapter *adapter,
 					 struct tc_taprio_qopt_offload *qopt)
 {
@@ -5591,6 +5608,9 @@ static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	case TC_SETUP_QDISC_ETF:
 		return igc_tsn_enable_launchtime(adapter, type_data);
 
+	case TC_SETUP_PREEMPT:
+		return igc_save_frame_preemption(adapter, type_data);
+
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.32.0

