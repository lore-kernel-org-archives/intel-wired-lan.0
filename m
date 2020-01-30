From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 30 Jan 2020 13:34:55 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v1 2/2] igc: Add support for
 ETF offloading
In-Reply-To: <20200130213455.191163-1-vinicius.gomes@intel.com>
References: <20200130213455.191163-1-vinicius.gomes@intel.com>
Message-ID: <20200130213455.191163-3-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This adds support for ETF offloading for the i225 controller.

For i225, the LaunchTime feature is almost a subset of the Qbv
feature. The main change from the i210 is that the launchtime of each
packet is specified as an offset applied to the BASET register. BASET
is automatically incremented each cycle.

For i225, the approach chosen is to re-use most of the setup used for
taprio offloading. With a few changes:

 - The more or less obvious one is that when ETF is enabled, we should
 set add the expected launchtime to the (advanced) transmit
 descriptor;

 - The less obvious, is that when taprio offloading is not enabled, we
 add a dummy schedule (all queues are open all the time, with a cycle
 time of 1 second).

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 70 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 19 +++++-
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1bb663e826e9..af5dd43a4c6c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -868,6 +868,23 @@ static int igc_write_mc_addr_list(struct net_device *netdev)
 	return netdev_mc_count(netdev);
 }
 
+static __le32 igc_tx_launchtime(struct igc_adapter *adapter, ktime_t txtime)
+{
+	ktime_t cycle_time = adapter->cycle_time;
+	ktime_t base_time = adapter->base_time;
+	u32 launchtime;
+
+	/* FIXME: when using ETF together with taprio, we may have a
+	* case where 'delta' is larger than the cycle_time, this may
+	* cause problems if we don't read the current value of
+	* IGC_BASET, as the value writen into the launchtime
+	* descriptor field may be misinterpreted.
+	*/
+       div_s64_rem(ktime_sub_ns(txtime, base_time), cycle_time, &launchtime);
+
+       return cpu_to_le32(launchtime);
+}
+
 static void igc_tx_ctxtdesc(struct igc_ring *tx_ring,
 			    struct igc_tx_buffer *first,
 			    u32 vlan_macip_lens, u32 type_tucmd,
@@ -875,7 +892,6 @@ static void igc_tx_ctxtdesc(struct igc_ring *tx_ring,
 {
 	struct igc_adv_tx_context_desc *context_desc;
 	u16 i = tx_ring->next_to_use;
-	struct timespec64 ts;
 
 	context_desc = IGC_TX_CTXTDESC(tx_ring, i);
 
@@ -897,9 +913,12 @@ static void igc_tx_ctxtdesc(struct igc_ring *tx_ring,
 	 * should have been handled by the upper layers.
 	 */
 	if (tx_ring->launchtime_enable) {
-		ts = ktime_to_timespec64(first->skb->tstamp);
+		struct igc_adapter *adapter = netdev_priv(tx_ring->netdev);
+		ktime_t txtime = first->skb->tstamp;
+
 		first->skb->tstamp = ktime_set(0, 0);
-		context_desc->launch_time = cpu_to_le32(ts.tv_nsec / 32);
+		context_desc->launch_time = igc_tx_launchtime(adapter,
+							      txtime);
 	} else {
 		context_desc->launch_time = 0;
 	}
@@ -4495,6 +4514,32 @@ static int igc_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 	}
 }
 
+static int igc_save_txtime_params(struct igc_adapter *adapter, int queue,
+				  bool enable)
+{
+	struct igc_ring *ring;
+	int i;
+
+	if (queue < 0 || queue > adapter->num_tx_queues)
+		return -EINVAL;
+
+	ring = adapter->tx_ring[queue];
+	ring->launchtime_enable = enable;
+
+	if (adapter->base_time)
+		return 0;
+
+	adapter->cycle_time = NSEC_PER_SEC;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		ring = adapter->tx_ring[i];
+		ring->start_time = 0;
+		ring->end_time = NSEC_PER_SEC;
+	}
+
+	return 0;
+}
+
 static bool validate_schedule(const struct tc_taprio_qopt_offload *qopt)
 {
 	int queue_uses[IGC_MAX_TX_QUEUES] = { };
@@ -4527,6 +4572,22 @@ static bool validate_schedule(const struct tc_taprio_qopt_offload *qopt)
 	return true;
 }
 
+static int igc_tsn_enable_basic_scheduling(struct igc_adapter *adapter,
+					   struct tc_etf_qopt_offload *qopt)
+{
+	struct igc_hw *hw = &adapter->hw;
+	int err;
+
+	if (hw->mac.type != igc_i225)
+		return -EOPNOTSUPP;
+
+	err = igc_save_txtime_params(adapter, qopt->queue, qopt->enable);
+	if (err)
+		return err;
+
+	return igc_tsn_offload_apply(adapter);
+}
+
 static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 				 struct tc_taprio_qopt_offload *qopt)
 {
@@ -4598,6 +4659,9 @@ static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	case TC_SETUP_QDISC_TAPRIO:
 		return igc_tsn_enable_qbv_scheduling(adapter, type_data);
 
+	case TC_SETUP_QDISC_ETF:
+		return igc_tsn_enable_basic_scheduling(adapter, type_data);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index affffce0e870..961d73de6c92 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -3,6 +3,20 @@
 
 #include "igc.h"
 
+static bool is_any_launchtime(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
+		if (ring->launchtime_enable)
+			return true;
+	}
+
+	return false;
+}
+
 /* Returns the TSN specific registers to their default values after
  * TSN offloading is disabled.
  */
@@ -85,6 +99,9 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 				IGC_TXQCTL_STRICT_END;
 		}
 
+		if (ring->launchtime_enable)
+			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
+
 		wr32(IGC_TXQCTL(i), txqctl);
 	}
 
@@ -112,7 +129,7 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 
 int igc_tsn_offload_apply(struct igc_adapter *adapter)
 {
-	bool is_any_enabled = adapter->base_time;
+	bool is_any_enabled = adapter->base_time || is_any_launchtime(adapter);
 
 	if (!(adapter->flags & IGC_FLAG_TSN_QBV_ENABLED) && !is_any_enabled)
 		return 0;
-- 
2.25.0

