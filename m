From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:00 -0700
Subject: [Intel-wired-lan] [PATCH S41 02/15] ice: Don't reset and rebuild
 for Tx timeout on PFC enabled queue
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash JD <avinash.dayanand@intel.com>

When there's a Tx timeout for a queue which belongs to a PFC enabled TC,
then it's not because the queue is hung but because PFC is in action.

In PFC, peer sends a pause frame for a specified period of time when its
buffer threshold is exceeded (due to congestion). Netdev on the other
hand checks if ACK is received within a specified time for a TX packet, if
not, it'll invoke the tx_timeout routine.

Signed-off-by: Avinash JD <avinash.dayanand@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 58 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h | 23 ++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 10 ++++
 drivers/net/ethernet/intel/ice/ice_type.h    |  2 +
 4 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index c4f8be0c0b24..d91bd72eebdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -62,6 +62,64 @@ u8 ice_dcb_get_ena_tc(struct ice_dcbx_cfg *dcbcfg)
 	return ena_tc;
 }
 
+/**
+ * ice_is_pfc_causing_hung_q
+ * @pf: pointer to PF structure
+ * @txqueue: Tx queue which is supposedly hung queue
+ *
+ * find if PFC is causing the hung queue, if yes return true else false
+ */
+bool ice_is_pfc_causing_hung_q(struct ice_pf *pf, unsigned int txqueue)
+{
+	u8 num_tcs = 0, i, tc, up_mapped_tc, up_in_tc = 0;
+	u64 ref_prio_xoff[ICE_MAX_UP];
+	struct ice_vsi *vsi;
+	u32 up2tc;
+
+	vsi = ice_get_main_vsi(pf);
+	if (!vsi)
+		return false;
+
+	ice_for_each_traffic_class(i)
+		if (vsi->tc_cfg.ena_tc & BIT(i))
+			num_tcs++;
+
+	/* first find out the TC to which the hung queue belongs to */
+	for (tc = 0; tc < num_tcs - 1; tc++)
+		if (ice_find_q_in_range(vsi->tc_cfg.tc_info[tc].qoffset,
+					vsi->tc_cfg.tc_info[tc + 1].qoffset,
+					txqueue))
+			break;
+
+	/* Build a bit map of all UPs associated to the suspect hung queue TC,
+	 * so that we check for its counter increment.
+	 */
+	up2tc = rd32(&pf->hw, PRTDCB_TUP2TC);
+	for (i = 0; i < ICE_MAX_UP; i++) {
+		up_mapped_tc = (up2tc >> (i * 3)) & 0x7;
+		if (up_mapped_tc == tc)
+			up_in_tc |= BIT(i);
+	}
+
+	/* Now that we figured out that hung queue is PFC enabled, still the
+	 * Tx timeout can be legitimate. So to make sure Tx timeout is
+	 * absolutely caused by PFC storm, check if the counters are
+	 * incrementing.
+	 */
+	for (i = 0; i < ICE_MAX_UP; i++)
+		if (up_in_tc & BIT(i))
+			ref_prio_xoff[i] = pf->stats.priority_xoff_rx[i];
+
+	ice_update_dcb_stats(pf);
+
+	for (i = 0; i < ICE_MAX_UP; i++)
+		if (up_in_tc & BIT(i))
+			if (pf->stats.priority_xoff_rx[i] > ref_prio_xoff[i])
+				return true;
+
+	return false;
+}
+
 /**
  * ice_dcb_get_mode - gets the DCB mode
  * @port_info: pointer to port info structure
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index 11457b6ba145..a7a5d9833a93 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -17,6 +17,8 @@
 void ice_dcb_rebuild(struct ice_pf *pf);
 u8 ice_dcb_get_ena_tc(struct ice_dcbx_cfg *dcbcfg);
 u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
+void ice_vsi_set_dcb_tc_cfg(struct ice_vsi *vsi);
+bool ice_is_pfc_causing_hung_q(struct ice_pf *pf, unsigned int txqueue);
 u8 ice_dcb_get_tc(struct ice_vsi *vsi, int queue_index);
 int
 ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked);
@@ -34,6 +36,20 @@ void
 ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 				    struct ice_rq_event_info *event);
 void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
+
+/**
+ * ice_find_q_in_range
+ * @low: start of queue range for a TC i.e. offset of TC
+ * @high: start of queue for next TC
+ * @tx_q: hung_queue/tx_queue
+ *
+ * finds if queue 'tx_q' falls between the two offsets of any given TC
+ */
+static inline bool ice_find_q_in_range(u16 low, u16 high, unsigned int tx_q)
+{
+	return (tx_q >= low) && (tx_q < high);
+}
+
 static inline void
 ice_set_cgd_num(struct ice_tlan_ctx *tlan_ctx, struct ice_ring *ring)
 {
@@ -81,6 +97,13 @@ ice_tx_prepare_vlan_flags_dcb(struct ice_ring __always_unused *tx_ring,
 	return 0;
 }
 
+static inline bool
+ice_is_pfc_causing_hung_q(struct ice_pf __always_unused *pf,
+			  unsigned int __always_unused txqueue)
+{
+	return false;
+}
+
 #define ice_update_dcb_stats(pf) do {} while (0)
 #define ice_pf_dcb_recfg(pf) do {} while (0)
 #define ice_vsi_cfg_dcb_rings(vsi) do {} while (0)
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3d143e8c5112..2128238a0f6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5201,6 +5201,16 @@ static void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 
 	pf->tx_timeout_count++;
 
+	/* Check if PFC is enabled for the TC to which the queue belongs
+	 * to. If yes then Tx timeout is not caused by a hung queue, no
+	 * need to reset and rebuild
+	 */
+	if (ice_is_pfc_causing_hung_q(pf, txqueue)) {
+		dev_info(ice_pf_to_dev(pf), "Fake Tx hang detected on queue %u, timeout caused by PFC storm\n",
+			 txqueue);
+		return;
+	}
+
 	/* now that we have an index, find the tx_ring struct */
 	for (i = 0; i < vsi->num_txq; i++)
 		if (vsi->tx_rings[i] && vsi->tx_rings[i]->desc)
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 40ac93d24e97..5abfd01113ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -611,6 +611,8 @@ struct ice_eth_stats {
 	u64 tx_errors;			/* tepc */
 };
 
+#define ICE_MAX_UP	8
+
 /* Statistics collected by the MAC */
 struct ice_hw_port_stats {
 	/* eth stats collected by the port */
-- 
2.20.1

