From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Fri, 26 Oct 2018 19:13:00 +0200
Subject: [Intel-wired-lan] [PATCH v2 net] igb: shorten maximum PHC
 timecounter update interval
Message-ID: <20181026171300.12720-1-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The timecounter needs to be updated at least once per ~550 seconds in
order to avoid a 40-bit SYSTIM timestamp to be misinterpreted as an old
timestamp.

Since commit 500462a9de65 ("timers: Switch to a non-cascading wheel"),
scheduling of delayed work seems to be less accurate and a requested
delay of 540 seconds may actually be longer than 550 seconds. Also, the
PHC may be adjusted to run up to 6% faster than real time and the system
clock up to 10% slower. Shorten the delay to 360 seconds to be sure the
timecounter is updated in time.

This fixes an issue with HW timestamps on 82580/I350/I354 being off by
~1100 seconds for few seconds every ~9 minutes.

Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 9f4d700e09df..2b95dc9c7a6a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -51,9 +51,17 @@
  *
  * The 40 bit 82580 SYSTIM overflows every
  *   2^40 * 10^-9 /  60  = 18.3 minutes.
+ *
+ * SYSTIM is converted to real time using a timecounter. As
+ * timecounter_cyc2time() allows old timestamps, the timecounter needs
+ * to be updated at least once per half of the SYSTIM interval.
+ * Scheduling of delayed work is not very accurate, and also the NIC
+ * clock can be adjusted to run up to 6% faster and the system clock
+ * up to 10% slower, so we aim for 6 minutes to be sure the actual
+ * interval in the NIC time is shorter than 9.16 minutes.
  */
 
-#define IGB_SYSTIM_OVERFLOW_PERIOD	(HZ * 60 * 9)
+#define IGB_SYSTIM_OVERFLOW_PERIOD	(HZ * 60 * 6)
 #define IGB_PTP_TX_TIMEOUT		(HZ * 15)
 #define INCPERIOD_82576			BIT(E1000_TIMINCA_16NS_SHIFT)
 #define INCVALUE_82576_MASK		GENMASK(E1000_TIMINCA_16NS_SHIFT - 1, 0)
-- 
2.17.2

