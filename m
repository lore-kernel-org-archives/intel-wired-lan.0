From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Mon, 22 Nov 2021 14:02:13 +0100
Subject: [Intel-wired-lan] [PATCH intel-next] ice: Fix PTP reset flow
Message-ID: <20211122130213.22130-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The PF reset does not reset PHC and PHY clocks so it's unnecessary to
stop them and reinitialize after the reset.
Configuring timestamping changes the VSI fields so it needs to be
performed after VSIs are initialized, which was not done in case of a
reset.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 234 ++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp.h  |   8 +
 3 files changed, 204 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c08d2dcfa3cc..ce1cdebf6cda 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -568,7 +568,7 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	ice_pf_dis_all_vsi(pf, false);
 
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
-		ice_ptp_release(pf);
+		ice_ptp_prepare_for_reset(pf);
 
 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
 		ice_gnss_exit(pf);
@@ -6731,7 +6731,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	 * fail.
 	 */
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
-		ice_ptp_init(pf);
+		ice_ptp_reset(pf);
 
 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
 		ice_gnss_init(pf);
@@ -6748,6 +6748,8 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		dev_err(dev, "Switchdev CTRL VSI rebuild failed: %d\n", err);
 		goto err_vsi_rebuild;
 	}
+	/* configure PTP timestamping after VSI rebuild */
+	ice_ptp_cfg_timestamp(pf, false);
 
 	if (reset_type == ICE_RESET_PFR) {
 		err = ice_rebuild_channels(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index df846b66a9a7..be2c63f71452 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -320,7 +320,7 @@ static void ice_set_rx_tstamp(struct ice_pf *pf, bool on)
  * This function will configure timestamping during PTP initialization
  * and deinitialization
  */
-static void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena)
+void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena)
 {
 	ice_set_tx_tstamp(pf, ena);
 	ice_set_rx_tstamp(pf, ena);
@@ -2330,6 +2330,130 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(500));
 }
 
+/**
+ * ice_ptp_reset - Initialize PTP hardware clock support after reset
+ * @pf: Board private structure
+ */
+void ice_ptp_reset(struct ice_pf *pf)
+{
+	struct ice_ptp *ptp = &pf->ptp;
+	struct ice_hw *hw = &pf->hw;
+	struct timespec64 ts;
+	int err, itr = 1;
+	u64 time_diff;
+
+	if (test_bit(ICE_PFR_REQ, pf->state))
+		goto pfr;
+
+	if (!hw->func_caps.ts_func_info.src_tmr_owned)
+		goto reset_ts;
+
+	err = ice_ptp_init_phc(hw);
+	if (err)
+		goto err;
+
+	/* Acquire the global hardware lock */
+	if (!ice_ptp_lock(hw)) {
+		err = -EBUSY;
+		goto err;
+	}
+
+	/* Write the increment time value to PHY and LAN */
+	err = ice_ptp_write_incval(hw, ice_base_incval(pf));
+	if (err) {
+		ice_ptp_unlock(hw);
+		goto err;
+	}
+
+	/* Write the initial Time value to PHY and LAN using the cached PHC
+	 * time before the reset and time difference between stopping and
+	 * starting the clock.
+	 */
+	if (ptp->cached_phc_time) {
+		time_diff = ktime_get_real_ns() - ptp->reset_time;
+		ts = ns_to_timespec64(ptp->cached_phc_time + time_diff);
+	} else {
+		ts = ktime_to_timespec64(ktime_get_real());
+	}
+	err = ice_ptp_write_init(pf, &ts);
+	if (err) {
+		ice_ptp_unlock(hw);
+		goto err;
+	}
+
+	/* Release the global hardware lock */
+	ice_ptp_unlock(hw);
+
+	if (!ice_is_e810(hw)) {
+		/* Enable quad interrupts */
+		err = ice_ptp_tx_ena_intr(pf, true, itr);
+		if (err)
+			goto err;
+	}
+
+reset_ts:
+	/* Restart the PHY timestamping block */
+	ice_ptp_reset_phy_timestamping(pf);
+
+pfr:
+	/* Init Tx structures */
+	if (ice_is_e810(&pf->hw)) {
+		err = ice_ptp_init_tx_e810(pf, &ptp->port.tx);
+	} else {
+		kthread_init_delayed_work(&ptp->port.ov_work,
+					  ice_ptp_wait_for_offset_valid);
+		err = ice_ptp_init_tx_e822(pf, &ptp->port.tx,
+					   ptp->port.port_num);
+	}
+	if (err)
+		goto err;
+
+	set_bit(ICE_FLAG_PTP, pf->flags);
+
+	/* Start periodic work going */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
+
+	dev_info(ice_pf_to_dev(pf), "PTP reset successful\n");
+	return;
+
+err:
+	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
+}
+
+/**
+ * ice_ptp_prepare_for_reset - Prepare PTP for reset
+ * @pf: Board private structure
+ */
+void ice_ptp_prepare_for_reset(struct ice_pf *pf)
+{
+	struct ice_ptp *ptp = &pf->ptp;
+	u8 src_tmr;
+
+	clear_bit(ICE_FLAG_PTP, pf->flags);
+
+	/* Disable timestamping for both Tx and Rx */
+	ice_ptp_cfg_timestamp(pf, false);
+
+	kthread_cancel_delayed_work_sync(&ptp->work);
+	kthread_cancel_work_sync(&ptp->extts_work);
+
+	if (test_bit(ICE_PFR_REQ, pf->state))
+		return;
+
+	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
+
+	/* Disable periodic outputs */
+	ice_ptp_disable_all_clkout(pf);
+
+	src_tmr = ice_get_ptp_src_clock_index(&pf->hw);
+
+	/* Disable source clock */
+	wr32(&pf->hw, GLTSYN_ENA(src_tmr), (u32)~GLTSYN_ENA_TSYN_ENA_M);
+
+	/* Acquire PHC and system timer to restore after reset */
+	ptp->reset_time = ktime_get_real_ns();
+}
+
 /**
  * ice_ptp_init_owner - Initialize PTP_1588_CLOCK device
  * @pf: Board private structure
@@ -2396,8 +2520,57 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 err_clk:
 	pf->ptp.clock = NULL;
 err_exit:
-	dev_err(dev, "PTP failed to register clock, err %d\n", err);
+	return err;
+}
+
+/**
+ * ice_ptp_init_work - Initialize PTP work threads
+ * @pf: Board private structure
+ * @ptp: PF PTP structure
+ */
+static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
+{
+	struct kthread_worker *kworker;
+
+	/* Initialize work functions */
+	kthread_init_delayed_work(&ptp->work, ice_ptp_periodic_work);
+	kthread_init_work(&ptp->extts_work, ice_ptp_extts_work);
+
+	/* Allocate a kworker for handling work required for the ports
+	 * connected to the PTP hardware clock.
+	 */
+	kworker = kthread_create_worker(0, "ice-ptp-%s",
+					dev_name(ice_pf_to_dev(pf)));
+	if (IS_ERR(kworker))
+		return PTR_ERR(kworker);
+
+	ptp->kworker = kworker;
 
+	/* Start periodic work going */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
+
+	return 0;
+}
+
+/**
+ * ice_ptp_init_port - Initialize PTP port structure
+ * @pf: Board private structure
+ * @ptp_port: PTP port structure
+ */
+static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
+{
+	int err;
+
+	mutex_init(&ptp_port->ps_lock);
+
+	if (ice_is_e810(&pf->hw)) {
+		err = ice_ptp_init_tx_e810(pf, &ptp_port->tx);
+		return err;
+	}
+
+	kthread_init_delayed_work(&ptp_port->ov_work,
+				  ice_ptp_wait_for_offset_valid);
+	err = ice_ptp_init_tx_e822(pf, &ptp_port->tx, ptp_port->port_num);
 	return err;
 }
 
@@ -2405,7 +2578,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
  * ice_ptp_init - Initialize PTP hardware clock support
  * @pf: Board private structure
  *
- * Set up the device for interacting with the PTP hardware clock for all
+ * Setup the device for interacting with the PTP hardware clock for all
  * functions, both the function that owns the clock hardware, and the
  * functions connected to the clock hardware.
  *
@@ -2415,8 +2588,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
  */
 void ice_ptp_init(struct ice_pf *pf)
 {
-	struct device *dev = ice_pf_to_dev(pf);
-	struct kthread_worker *kworker;
+	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
@@ -2426,55 +2598,33 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (hw->func_caps.ts_func_info.src_tmr_owned) {
 		err = ice_ptp_init_owner(pf);
 		if (err)
-			return;
+			goto err;
 	}
 
-	/* Disable timestamping for both Tx and Rx */
-	ice_ptp_cfg_timestamp(pf, false);
-
-	/* Initialize PTP port structure */
-	mutex_init(&pf->ptp.port.ps_lock);
-	pf->ptp.port.port_num = pf->hw.pf_id;
-	kthread_init_delayed_work(&pf->ptp.port.ov_work,
-				  ice_ptp_wait_for_offset_valid);
-
-	if (ice_is_e810(hw))
-		ice_ptp_init_tx_e810(pf, &pf->ptp.port.tx);
-	else
-		ice_ptp_init_tx_e822(pf, &pf->ptp.port.tx, pf->hw.pf_id);
-
-	/* Initialize work functions */
-	kthread_init_delayed_work(&pf->ptp.work, ice_ptp_periodic_work);
-	kthread_init_work(&pf->ptp.extts_work, ice_ptp_extts_work);
-
-	/* Allocate a kworker for handling work required for the ports
-	 * connected to the PTP hardware clock.
-	 */
-	kworker = kthread_create_worker(0, "ice-ptp-%s", dev_name(dev));
-	if (IS_ERR(kworker)) {
-		err = PTR_ERR(kworker);
-		goto err_kworker;
-	}
-	pf->ptp.kworker = kworker;
-
-	set_bit(ICE_FLAG_PTP, pf->flags);
-
-	/* Start periodic work going */
-	kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work, 0);
+	ptp->port.port_num = hw->pf_id;
+	err = ice_ptp_init_port(pf, &ptp->port);
+	if (err)
+		goto err;
 
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
 
-	dev_info(dev, "PTP init successful\n");
+	set_bit(ICE_FLAG_PTP, pf->flags);
+	err = ice_ptp_init_work(pf, ptp);
+	if (err)
+		goto err;
+
+	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
-err_kworker:
+err:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
-		ptp_clock_unregister(pf->ptp.clock);
+		ptp_clock_unregister(ptp->clock);
 		pf->ptp.clock = NULL;
 	}
-	dev_err(dev, "PTP failed %d\n", err);
+	clear_bit(ICE_FLAG_PTP, pf->flags);
+	dev_err(ice_pf_to_dev(pf), "PTP failed %d\n", err);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index eef8ec894871..afd048d69959 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -139,6 +139,7 @@ struct ice_ptp_port {
  * @info: structure defining PTP hardware capabilities
  * @clock: pointer to registered PTP clock device
  * @tstamp_config: hardware timestamping configuration
+ * @reset_time: kernel time after clock stop on reset
  */
 struct ice_ptp {
 	struct ice_ptp_port port;
@@ -152,6 +153,7 @@ struct ice_ptp {
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct hwtstamp_config tstamp_config;
+	u64 reset_time;
 };
 
 #define __ptp_port_to_ptp(p) \
@@ -199,6 +201,7 @@ struct ice_ptp {
 struct ice_pf;
 int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr);
 int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr);
+void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena);
 int ice_get_ptp_clock_index(struct ice_pf *pf);
 
 s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
@@ -207,6 +210,8 @@ void ice_ptp_process_ts(struct ice_pf *pf);
 void
 ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
 		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb);
+void ice_ptp_reset(struct ice_pf *pf);
+void ice_ptp_prepare_for_reset(struct ice_pf *pf);
 void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
 int ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup);
@@ -221,6 +226,7 @@ static inline int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 	return -EOPNOTSUPP;
 }
 
+static inline void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena) { }
 static inline int ice_get_ptp_clock_index(struct ice_pf *pf)
 {
 	return -1;
@@ -236,6 +242,8 @@ static inline void ice_ptp_process_ts(struct ice_pf *pf) { }
 static inline void
 ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
 		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb) { }
+static inline void ice_ptp_reset(struct ice_pf *pf) { }
+static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf) { }
 static inline void ice_ptp_init(struct ice_pf *pf) { }
 static inline void ice_ptp_release(struct ice_pf *pf) { }
 static inline int ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
-- 
2.32.0

