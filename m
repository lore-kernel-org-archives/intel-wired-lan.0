From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 11:36:13 -0800
Subject: [Intel-wired-lan] [next PATCH S2 04/13] i40e: save PTP time before
 a device reset
In-Reply-To: <20190206193622.69370-1-alice.michael@intel.com>
References: <20190206193622.69370-1-alice.michael@intel.com>
Message-ID: <20190206193622.69370-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

In the case where PTP is running on the hardware clock, but the kernel
system time is not being synced, a device reset can mess up the clock
time.

This occurs because we reset the clock time based on the kernel time
every reset. This causes us to potentially completely reset the PTP
time, and can cause unexpected behavior in programs like ptp4l.

Avoid this by saving the PTP time prior to device reset, and then
restoring using that time after the reset.

Directly restoring the PTP time we saved isn't perfect, because time
should have continued running, but the clock will essentially be stopped
during the reset. This is still better than the current solution of
assuming that the PTP hw clock is synced to the CLOCK_REALTIME.

We can do even better, by saving the ktime and calculating
a differential, using ktime_get(). This is based on CLOCK_MONOTONIC, and
allows us to get a fairly precise measure of the time difference between
saving and restoring the time.

Using this, we can update the saved PTP time, and use that as the value
to write to the hardware clock registers. This, ofcourse is not perfect.
However, it does help ensure that the PTP time is restored as close as
feasible to the time it should have been if the reset had not occurred.

During device initialization, continue using the system time as the
source for the creation of the PTP clock, since this is the best known
current time source at driver load.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  4 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c |  5 ++
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 54 +++++++++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 3bf9c50c3394..b11255c6be64 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -632,6 +632,8 @@ struct i40e_pf {
 	struct sk_buff *ptp_tx_skb;
 	unsigned long ptp_tx_start;
 	struct hwtstamp_config tstamp_config;
+	struct timespec64 ptp_prev_hw_time;
+	ktime_t ptp_reset_start;
 	struct mutex tmreg_lock; /* Used to protect the SYSTIME registers. */
 	u32 ptp_adj_mult;
 	u32 tx_hwtstamp_timeouts;
@@ -1132,6 +1134,8 @@ void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index);
 void i40e_ptp_set_increment(struct i40e_pf *pf);
 int i40e_ptp_set_ts_config(struct i40e_pf *pf, struct ifreq *ifr);
 int i40e_ptp_get_ts_config(struct i40e_pf *pf, struct ifreq *ifr);
+void i40e_ptp_save_hw_time(struct i40e_pf *pf);
+void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 55caed65284c..91796d2c6ac6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9787,6 +9787,11 @@ static void i40e_prep_for_reset(struct i40e_pf *pf, bool lock_acquired)
 			dev_warn(&pf->pdev->dev,
 				 "shutdown_lan_hmc failed: %d\n", ret);
 	}
+
+	/* Save the current PTP time so that we can restore the time after the
+	 * reset completes.
+	 */
+	i40e_ptp_save_hw_time(pf);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 5fb4353c742b..6f2a3259d417 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -724,9 +724,52 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
 	pf->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	pf->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 
+	/* Set the previous "reset" time to the current Kernel clock time */
+	pf->ptp_prev_hw_time = ktime_to_timespec64(ktime_get_real());
+	pf->ptp_reset_start = ktime_get();
+
 	return 0;
 }
 
+/**
+ * i40e_ptp_save_hw_time - Save the current PTP time as ptp_prev_hw_time
+ * @pf: Board private structure
+ *
+ * Read the current PTP time and save it into pf->ptp_prev_hw_time. This should
+ * be called at the end of preparing to reset, just before hardware reset
+ * occurs, in order to preserve the PTP time as close as possible across
+ * resets.
+ */
+void i40e_ptp_save_hw_time(struct i40e_pf *pf)
+{
+	i40e_ptp_gettimex(&pf->ptp_caps, &pf->ptp_prev_hw_time, NULL);
+	/* Get a monotonic starting time for this reset */
+	pf->ptp_reset_start = ktime_get();
+}
+
+/**
+ * i40e_ptp_restore_hw_time - Restore the ptp_prev_hw_time + delta to PTP regs
+ * @pf: Board private structure
+ *
+ * Restore the PTP hardware clock registers. We previously cached the PTP
+ * hardware time as pf->ptp_prev_hw_time. To be as accurate as possible,
+ * update this value based on the time delta since the time was saved, using
+ * CLOCK_MONOTONIC (via ktime_get()) to calculate the time difference.
+ *
+ * This ensures that the hardware clock is restored to nearly what it should
+ * have been if a reset had not occurred.
+ */
+void i40e_ptp_restore_hw_time(struct i40e_pf *pf)
+{
+	ktime_t delta = ktime_sub(ktime_get(), pf->ptp_reset_start);
+
+	/* Update the previous HW time with the ktime delta */
+	timespec64_add_ns(&pf->ptp_prev_hw_time, ktime_to_ns(delta));
+
+	/* Restore the hardware clock registers */
+	i40e_ptp_settime(&pf->ptp_caps, &pf->ptp_prev_hw_time);
+}
+
 /**
  * i40e_ptp_init - Initialize the 1588 support after device probe or reset
  * @pf: Board private structure
@@ -734,6 +777,11 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
  * This function sets device up for 1588 support. The first time it is run, it
  * will create a PHC clock device. It does not create a clock device if one
  * already exists. It also reconfigures the device after a reset.
+ *
+ * The first time a clock is created, i40e_ptp_create_clock will set
+ * pf->ptp_prev_hw_time to the current system time. During resets, it is
+ * expected that this timespec will be set to the last known PTP clock time,
+ * in order to preserve the clock time as close as possible across a reset.
  **/
 void i40e_ptp_init(struct i40e_pf *pf)
 {
@@ -765,7 +813,6 @@ void i40e_ptp_init(struct i40e_pf *pf)
 		dev_err(&pf->pdev->dev, "%s: ptp_clock_register failed\n",
 			__func__);
 	} else if (pf->ptp_clock) {
-		struct timespec64 ts;
 		u32 regval;
 
 		if (pf->hw.debug_mask & I40E_DEBUG_LAN)
@@ -786,9 +833,8 @@ void i40e_ptp_init(struct i40e_pf *pf)
 		/* reset timestamping mode */
 		i40e_ptp_set_timestamp_mode(pf, &pf->tstamp_config);
 
-		/* Set the clock value. */
-		ts = ktime_to_timespec64(ktime_get_real());
-		i40e_ptp_settime(&pf->ptp_caps, &ts);
+		/* Restore the clock time based on last known value */
+		i40e_ptp_restore_hw_time(pf);
 	}
 }
 
-- 
2.19.2

