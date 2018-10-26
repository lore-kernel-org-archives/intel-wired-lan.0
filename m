From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Fri, 26 Oct 2018 18:27:40 +0200
Subject: [Intel-wired-lan] [RFC PATCH 2/4] e1000e: add support for extended
 PHC gettime
In-Reply-To: <20181026162742.631-1-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
Message-ID: <20181026162742.631-3-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  3 ++
 drivers/net/ethernet/intel/e1000e/netdev.c | 48 +++++++++++++++++-----
 drivers/net/ethernet/intel/e1000e/ptp.c    | 21 ++++++++++
 3 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index c760dc72c520..be13227f1697 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -505,6 +505,9 @@ extern const struct e1000_info e1000_es2_info;
 void e1000e_ptp_init(struct e1000_adapter *adapter);
 void e1000e_ptp_remove(struct e1000_adapter *adapter);
 
+u64 e1000e_read_systim(struct e1000_adapter *adapter,
+		       struct ptp_system_timestamp *sts);
+
 static inline s32 e1000_phy_hw_reset(struct e1000_hw *hw)
 {
 	return hw->phy.ops.reset(hw);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3ba0c90e7055..3bad1a1f36c3 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4319,13 +4319,16 @@ void e1000e_reinit_locked(struct e1000_adapter *adapter)
 /**
  * e1000e_sanitize_systim - sanitize raw cycle counter reads
  * @hw: pointer to the HW structure
- * @systim: time value read, sanitized and returned
+ * @systim: PHC time value read, sanitized and returned
+ * @sts: structure which will contain system time before and after reading
+ * SYSTIML, may be NULL
  *
  * Errata for 82574/82583 possible bad bits read from SYSTIMH/L:
  * check to see that the time is incrementing at a reasonable
  * rate and is a multiple of incvalue.
  **/
-static u64 e1000e_sanitize_systim(struct e1000_hw *hw, u64 systim)
+static u64 e1000e_sanitize_systim(struct e1000_hw *hw, u64 systim,
+				  struct ptp_system_timestamp *sts)
 {
 	u64 time_delta, rem, temp;
 	u64 systim_next;
@@ -4335,7 +4338,11 @@ static u64 e1000e_sanitize_systim(struct e1000_hw *hw, u64 systim)
 	incvalue = er32(TIMINCA) & E1000_TIMINCA_INCVALUE_MASK;
 	for (i = 0; i < E1000_MAX_82574_SYSTIM_REREADS; i++) {
 		/* latch SYSTIMH on read of SYSTIML */
+		if (sts)
+			ptp_read_system_prets(sts);
 		systim_next = (u64)er32(SYSTIML);
+		if (sts)
+			ptp_read_system_postts(sts);
 		systim_next |= (u64)er32(SYSTIMH) << 32;
 
 		time_delta = systim_next - systim;
@@ -4353,15 +4360,16 @@ static u64 e1000e_sanitize_systim(struct e1000_hw *hw, u64 systim)
 }
 
 /**
- * e1000e_cyclecounter_read - read raw cycle counter (used by time counter)
- * @cc: cyclecounter structure
+ * e1000e_read_systim - read SYSTIM register
+ * @adapter: board private structure
+ * @sts: structure which will contain system time before and after reading
+ * SYSTIML, may be NULL
  **/
-static u64 e1000e_cyclecounter_read(const struct cyclecounter *cc)
+u64 e1000e_read_systim(struct e1000_adapter *adapter,
+		       struct ptp_system_timestamp *sts)
 {
-	struct e1000_adapter *adapter = container_of(cc, struct e1000_adapter,
-						     cc);
 	struct e1000_hw *hw = &adapter->hw;
-	u32 systimel, systimeh;
+	u32 systimel, systimel_2, systimeh;
 	u64 systim;
 	/* SYSTIMH latching upon SYSTIML read does not work well.
 	 * This means that if SYSTIML overflows after we read it but before
@@ -4369,11 +4377,19 @@ static u64 e1000e_cyclecounter_read(const struct cyclecounter *cc)
 	 * will experience a huge non linear increment in the systime value
 	 * to fix that we test for overflow and if true, we re-read systime.
 	 */
+	if (sts)
+		ptp_read_system_prets(sts);
 	systimel = er32(SYSTIML);
+	if (sts)
+		ptp_read_system_postts(sts);
 	systimeh = er32(SYSTIMH);
 	/* Is systimel is so large that overflow is possible? */
 	if (systimel >= (u32)0xffffffff - E1000_TIMINCA_INCVALUE_MASK) {
-		u32 systimel_2 = er32(SYSTIML);
+		if (sts)
+			ptp_read_system_prets(sts);
+		systimel_2 = er32(SYSTIML);
+		if (sts)
+			ptp_read_system_postts(sts);
 		if (systimel > systimel_2) {
 			/* There was an overflow, read again SYSTIMH, and use
 			 * systimel_2
@@ -4386,11 +4402,23 @@ static u64 e1000e_cyclecounter_read(const struct cyclecounter *cc)
 	systim |= (u64)systimeh << 32;
 
 	if (adapter->flags2 & FLAG2_CHECK_SYSTIM_OVERFLOW)
-		systim = e1000e_sanitize_systim(hw, systim);
+		systim = e1000e_sanitize_systim(hw, systim, sts);
 
 	return systim;
 }
 
+/**
+ * e1000e_cyclecounter_read - read raw cycle counter (used by time counter)
+ * @cc: cyclecounter structure
+ **/
+static u64 e1000e_cyclecounter_read(const struct cyclecounter *cc)
+{
+	struct e1000_adapter *adapter = container_of(cc, struct e1000_adapter,
+						     cc);
+
+	return e1000e_read_systim(adapter, NULL);
+}
+
 /**
  * e1000_sw_init - Initialize general software structures (struct e1000_adapter)
  * @adapter: board private structure to initialize
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index e1f821edbc21..bf1ca7ba8c37 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -188,6 +188,26 @@ static int e1000e_phc_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	return 0;
 }
 
+static int e1000e_phc_gettimex(struct ptp_clock_info *ptp,
+			       struct ptp_system_timestamp *sts)
+{
+	struct e1000_adapter *adapter = container_of(ptp, struct e1000_adapter,
+						     ptp_clock_info);
+	unsigned long flags;
+	u64 cycles, ns;
+
+	spin_lock_irqsave(&adapter->systim_lock, flags);
+
+	cycles = e1000e_read_systim(adapter, sts);
+	ns = timecounter_cyc2time(&adapter->tc, cycles);
+
+	spin_unlock_irqrestore(&adapter->systim_lock, flags);
+
+	sts->phc_ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
 /**
  * e1000e_phc_settime - Set the current time on the hardware clock
  * @ptp: ptp clock structure
@@ -259,6 +279,7 @@ static const struct ptp_clock_info e1000e_ptp_clock_info = {
 	.adjfreq	= e1000e_phc_adjfreq,
 	.adjtime	= e1000e_phc_adjtime,
 	.gettime64	= e1000e_phc_gettime,
+	.gettimex64	= e1000e_phc_gettimex,
 	.settime64	= e1000e_phc_settime,
 	.enable		= e1000e_phc_enable,
 };
-- 
2.17.2

