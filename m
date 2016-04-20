From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 20 Apr 2016 18:39:13 +0000
Subject: [Intel-wired-lan] [PATCH v4] e1000e: don't modify SYSTIM
 registers during SIOCSHWTSTAMP ioctl
In-Reply-To: <20160420183642.29050-1-jacob.e.keller@intel.com>
References: <20160420183642.29050-1-jacob.e.keller@intel.com>
Message-ID: <1461177553.1546.25.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-04-20 at 11:36 -0700, Jacob Keller wrote:
> The e1000e_config_hwtstamp function was incorrectly resetting the
> SYSTIM
> registers every time the ioctl was being run. If you happened to be
> running ptp4l and lost the PTP connect (removing cable, or blocking
> the
> UDP traffic for example), then ptp4l will eventually perform a
> restart
> which involves re-requesting timestamp settings. In e1000e this has
> the
> unfortunate and incorrect result of resetting SYSTIME to the kernel
> time. Since kernel time is usually in UTC, and PTP time is in TAI,
> this
> results in the leap second being re-applied.
> 
> Fix this by extracting the SYSTIME reset out into its own function,
> e1000e_ptp_reset, which we call during reset to restore the hardware
> registers. This function will (a) restart the timecounter based on
> the
> new system time, (b) restore the previous PPB setting, and (c)
> restore
> the previous hwtstamp settings.
> 
> In order to perform (b), I had to modify the adjfreq ptp function
> pointer to store the old delta each time it is called. This also has
> the
> side effect of restoring the correct base timinca register correctly.
> The driver does not need to explicitly zero the ptp_delta variable
> since
> the entire adapter structure comes zero-initialized.
> 
> Reported-by: Brian Walsh <brian@walsh.ws>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Brian Walsh <brian@walsh.ws>
> ---
> 
> Notes:
> ????This patch conflicts with Brian's "e1000e fix ptp time reset on
> newtork
> ????interruption", and that patch MUST be removed from the queue
> before applying
> ????this one.
> ????
> ????- Changes since v1
> ????* move e1000e_init_ptp prior to reset so that PTP clock is
> created first
> ????* handle NULL ptp_clock_info gracefully.
> ????
> ????- Changes since v2
> ????* fix stupid compilation error
> ????* fix stupid null pointer check
> ????
> ????- Changes since v3
> ????* fix issue when using part that doesn't support hw timestamping
> ????* rename e1000e_ptp_reset to more apt e1000e_systim_reset
> ????* refactor code a little to reduce duplicate warning and improve
> readability
> 
> ?drivers/net/ethernet/intel/e1000e/e1000.h??|??1 +
> ?drivers/net/ethernet/intel/e1000e/netdev.c | 68
> +++++++++++++++++++++++-------
> ?drivers/net/ethernet/intel/e1000e/ptp.c????|??2 +
> ?3 files changed, 55 insertions(+), 16 deletions(-)
> 


For review purposes, here is the diff between v3 and v4

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index a272ad9f8029..02e28581dcad 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3874,7 +3874,7 @@ static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
?}
?
?/**
- * e1000e_ptp_reset - reset the timesync registers after a hardware reset
+ * e1000e_systim_reset - reset the timesync registers after a hardware reset
? * @adapter: board private structure
? *
? * When the MAC is reset, all hardware bits for timesync will be reset to the
@@ -3882,7 +3882,7 @@ static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
? * Since the clock SYSTIME registers are reset, we will simply restore the
? * cyclecounter to the kernel real clock time.
? **/
-static void e1000e_ptp_reset(struct e1000_adapter *adapter)
+static void e1000e_systim_reset(struct e1000_adapter *adapter)
?{
?	struct ptp_clock_info *info = &adapter->ptp_clock_info;
?	struct e1000_hw *hw = &adapter->hw;
@@ -3890,23 +3890,26 @@ static void e1000e_ptp_reset(struct e1000_adapter *adapter)
?	u32 timinca;
?	s32 ret_val;
?
+	if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP))
+		return;
+
?	if (info->adjfreq) {
?		/* restore the previous ptp frequency delta */
?		ret_val = info->adjfreq(info, adapter->ptp_delta);
-		if (ret_val)
-			dev_warn(&adapter->pdev->dev,
-				?"Failed to restore TIMINCA clock rate delta: %d\n",
-				?ret_val);
?	} else {
+		/* set the default base frequency if no adjustment possible */
?		ret_val = e1000e_get_base_timinca(adapter, &timinca);
-		if (ret_val)
-			dev_warn(&adapter->pdev->dev,
-				?"Failed to set default TIMINCA clock rate: %d\n",
-				?ret_val);
-		else
+		if (!ret_val)
?			ew32(TIMINCA, timinca);
?	}
?
+	if (ret_val) {
+		dev_warn(&adapter->pdev->dev,
+			?"Failed to restore TIMINCA clock rate delta: %d\n",
+			?ret_val);
+		return;
+	}
+
?	/* reset the systim ns time counter */
?	spin_lock_irqsave(&adapter->systim_lock, flags);
?	timecounter_init(&adapter->tc, &adapter->cc,
@@ -4097,7 +4100,7 @@ void e1000e_reset(struct e1000_adapter *adapter)
?	e1000e_reset_adaptive(hw);
?
?	/* restore systim and hwtstamp settings */
-	e1000e_ptp_reset(adapter);
+	e1000e_systim_reset(adapter);
?
?	/* Set EEE advertisement as appropriate */
?	if (adapter->flags2 & FLAG2_HAS_EEE) {
