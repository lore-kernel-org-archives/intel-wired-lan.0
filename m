From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 14 Apr 2016 16:29:24 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: don't modify SYSTIM registers
	during SIOCSHWTSTAMP ioctl
Message-ID: <1460676564-30452-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The e1000e_config_hwtstamp function was incorrectly resetting the SYSTIM
registers every time the ioctl was being run. If you happened to be
running ptp4l and lost the PTP connect (removing cable, or blocking the
UDP traffic for example), then ptp4l will eventually perform a restart
which involves re-requesting timestamp settings. In e1000e this has the
unfortunate and incorrect result of resetting SYSTIME to the kernel
time. Since kernel time is usually in UTC, and PTP time is in TAI, this
results in the leap second being re-applied.

Fix this by extracting the SYSTIME reset out into its own function,
e1000e_ptp_reset, which we call during reset to restore the hardware
registers. This function will (a) restart the timecounter based on the
new system time, (b) restore the previous PPB setting, and (c) restore
the previous hwtstamp settings.

In order to perform (b), I had to modify the adjfreq ptp function
pointer to store the old delta each time it is called. This also has the
side effect of restoring the correct base timinca register correctly.
The driver does not need to explicitly zero the ptp_delta variable since
the entire adapter structure comes zero-initialized.

Reported-by: Brian Walsh <brian@walsh.ws>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Notes:
    This patch conflicts with Brian's "e1000e fix ptp time reset on newtork
    interruption", and that patch MUST be removed from the queue before applying
    this one.


    Jeff, this patch WILL NOT apply unless you drop Brian's 2nd patch in
    his series.

 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 42 +++++++++++++++++++++---------
 drivers/net/ethernet/intel/e1000e/ptp.c    |  2 ++
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 010e6d61c855..ef96cd11d6d2 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -347,6 +347,7 @@ struct e1000_adapter {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
 	struct pm_qos_request pm_qos_req;
+	s32 ptp_delta;
 
 	u16 eee_advert;
 };
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 50d2684ac146..4fbf424b1c33 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3580,7 +3580,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	bool is_l4 = false;
 	bool is_l2 = false;
 	u32 regval;
-	s32 ret_val;
 
 	if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP))
 		return -EINVAL;
@@ -3719,16 +3718,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	er32(RXSTMPH);
 	er32(TXSTMPH);
 
-	/* Get and set the System Time Register SYSTIM base frequency */
-	ret_val = e1000e_get_base_timinca(adapter, &regval);
-	if (ret_val)
-		return ret_val;
-	ew32(TIMINCA, regval);
-
-	/* reset the ns time counter */
-	timecounter_init(&adapter->tc, &adapter->cc,
-			 ktime_to_ns(ktime_get_real()));
-
 	return 0;
 }
 
@@ -3885,6 +3874,33 @@ static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
 }
 
 /**
+ * e1000e_ptp_reset - reset the timesync registers after a hardware reset
+ * @adapter: board private structure
+ *
+ * When the MAC is reset, all hardware bits for timesync will be reset to the
+ * default values. This function will restore the settings last in place.
+ * Since the clock SYSTIME registers are reset, we will simply restore the
+ * cyclecounter to the kernel real clock time.
+ **/
+static void e1000e_ptp_reset(struct e1000_adapter *adapter)
+{
+	unsigned long flags;
+
+	/* restore the previous ptp frequency delta */
+	adapter->ptp_clock_info.adjfreq(&adapter->ptp_clock_info,
+					adapter->ptp_delta);
+
+	/* reset the systim ns time counter */
+	spin_lock_irqsave(&adapter->systim_lock, flags);
+	timecounter_init(&adapter->tc, &adapter->cc,
+			 ktime_to_ns(ktime_get_real()));
+	spin_unlock_irqrestore(&adapter->systim_lock, flags);
+
+	/* restore the previous hwtstamp configuration settings */
+	e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config);
+}
+
+/**
  * e1000e_reset - bring the hardware into a known good state
  *
  * This function boots the hardware and enables some settings that
@@ -4063,8 +4079,8 @@ void e1000e_reset(struct e1000_adapter *adapter)
 
 	e1000e_reset_adaptive(hw);
 
-	/* initialize systim and reset the ns time counter */
-	e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config);
+	/* restore systim and hwtstamp settings */
+	e1000e_ptp_reset(adapter);
 
 	/* Set EEE advertisement as appropriate */
 	if (adapter->flags2 & FLAG2_HAS_EEE) {
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index e2ff3ef75d5d..2e1b17ad52a3 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -79,6 +79,8 @@ static int e1000e_phc_adjfreq(struct ptp_clock_info *ptp, s32 delta)
 
 	ew32(TIMINCA, timinca);
 
+	adapter->ptp_delta = delta;
+
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	return 0;
-- 
2.8.1.102.ga49ec4a

