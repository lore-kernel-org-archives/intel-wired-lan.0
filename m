From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Fri, 26 Oct 2018 18:27:39 +0200
Subject: [Intel-wired-lan] [RFC PATCH 1/4] ptp: add PTP_SYS_OFFSET_EXTENDED
 ioctl
In-Reply-To: <20181026162742.631-1-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
Message-ID: <20181026162742.631-2-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The PTP_SYS_OFFSET ioctl, which can be used to measure the offset
between a PHC and the system clock, includes the total time that the
gettime64 function of a driver needs to read the PHC timestamp.

This typically involves reading of multiple PCI registers (sometimes in
multiple iterations) and the register that contains the lowest bits of
the timestamp is not read in the middle between the two readings of the
system clock. This asymmetry causes the measured offset to have a
significant error.

Introduce a new ioctl, driver function, and helper functions, which
allow the reading of the lowest register to be isolated from the other
readings in order to reduce the asymmetry. The ioctl and driver function
return three timestamps for each measurement:
- system time right before reading the lowest bits of the PHC timestamp
- PHC time
- system time immediately after reading the lowest bits of the PHC
  timestamp

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 drivers/ptp/ptp_chardev.c        | 39 ++++++++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h | 26 +++++++++++++++++++++
 include/uapi/linux/ptp_clock.h   | 12 ++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 2012551d93e0..1a04c437fd4f 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -124,11 +124,13 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 	struct ptp_clock_caps caps;
 	struct ptp_clock_request req;
 	struct ptp_sys_offset *sysoff = NULL;
+	struct ptp_sys_offset_extended *sysoff_extended = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct ptp_pin_desc pd;
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 	struct ptp_clock_info *ops = ptp->info;
 	struct ptp_clock_time *pct;
+	struct ptp_system_timestamp sts;
 	struct timespec64 ts;
 	struct system_device_crosststamp xtstamp;
 	int enable, err = 0;
@@ -211,6 +213,43 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 			err = -EFAULT;
 		break;
 
+	case PTP_SYS_OFFSET_EXTENDED:
+		if (!ptp->info->gettimex64) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		sysoff_extended = memdup_user((void __user *)arg,
+					      sizeof(*sysoff_extended));
+		if (IS_ERR(sysoff_extended)) {
+			err = PTR_ERR(sysoff_extended);
+			sysoff = NULL;
+			break;
+		}
+		if (sysoff_extended->n_samples > PTP_MAX_SAMPLES) {
+			err = -EINVAL;
+			break;
+		}
+
+		pct = &sysoff_extended->ts[0];
+		for (i = 0; i < sysoff_extended->n_samples; i++) {
+			err = ptp->info->gettimex64(ptp->info, &sts);
+			if (err)
+				break;
+			pct->sec = sts.sys_ts1.tv_sec;
+			pct->nsec = sts.sys_ts1.tv_nsec;
+			pct++;
+			pct->sec = sts.phc_ts.tv_sec;
+			pct->nsec = sts.phc_ts.tv_nsec;
+			pct++;
+			pct->sec = sts.sys_ts2.tv_sec;
+			pct->nsec = sts.sys_ts2.tv_nsec;
+			pct++;
+		}
+		if (copy_to_user((void __user *)arg, sysoff_extended,
+				 sizeof(*sysoff_extended)))
+			err = -EFAULT;
+		break;
+
 	case PTP_SYS_OFFSET:
 		sysoff = memdup_user((void __user *)arg, sizeof(*sysoff));
 		if (IS_ERR(sysoff)) {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 51349d124ee5..79321d929925 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -39,6 +39,13 @@ struct ptp_clock_request {
 };
 
 struct system_device_crosststamp;
+
+struct ptp_system_timestamp {
+	struct timespec64 sys_ts1;
+	struct timespec64 phc_ts;
+	struct timespec64 sys_ts2;
+};
+
 /**
  * struct ptp_clock_info - decribes a PTP hardware clock
  *
@@ -75,6 +82,13 @@ struct system_device_crosststamp;
  * @gettime64:  Reads the current time from the hardware clock.
  *              parameter ts: Holds the result.
  *
+ * @gettimex64:  Reads the current time from the system clock, hardware clock,
+ *               and system clock again.
+ *               parameter sts:  The structure contains system time right
+ *               before reading the lowest bits of the PHC timestamp, the PHC
+ *               timestamp itself, and system time immediately after reading
+ *               the lowest bits of the PHC timestamp.
+ *
  * @getcrosststamp:  Reads the current time from the hardware clock and
  *                   system clock simultaneously.
  *                   parameter cts: Contains timestamp (device,system) pair,
@@ -124,6 +138,8 @@ struct ptp_clock_info {
 	int (*adjfreq)(struct ptp_clock_info *ptp, s32 delta);
 	int (*adjtime)(struct ptp_clock_info *ptp, s64 delta);
 	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
+	int (*gettimex64)(struct ptp_clock_info *ptp,
+			  struct ptp_system_timestamp *sts);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
@@ -227,6 +243,16 @@ int ptp_find_pin(struct ptp_clock *ptp,
 
 int ptp_schedule_worker(struct ptp_clock *ptp, unsigned long delay);
 
+static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
+{
+	ktime_get_real_ts64(&sts->sys_ts1);
+}
+
+static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
+{
+	ktime_get_real_ts64(&sts->sys_ts2);
+}
+
 #else
 static inline struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 						   struct device *parent)
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 3039bf6a742e..0cb61aed9077 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -84,6 +84,16 @@ struct ptp_sys_offset {
 	struct ptp_clock_time ts[2 * PTP_MAX_SAMPLES + 1];
 };
 
+struct ptp_sys_offset_extended {
+	unsigned int n_samples; /* Desired number of measurements. */
+	unsigned int rsv[3];    /* Reserved for future use. */
+	/*
+	 * Array of sys, phc, sys, sys, phc, sys, ... time stamps. The kernel
+	 * will provide 3*n_samples time stamps.
+	 */
+	struct ptp_clock_time ts[3 * PTP_MAX_SAMPLES];
+};
+
 struct ptp_sys_offset_precise {
 	struct ptp_clock_time device;
 	struct ptp_clock_time sys_realtime;
@@ -136,6 +146,8 @@ struct ptp_pin_desc {
 #define PTP_PIN_SETFUNC    _IOW(PTP_CLK_MAGIC, 7, struct ptp_pin_desc)
 #define PTP_SYS_OFFSET_PRECISE \
 	_IOWR(PTP_CLK_MAGIC, 8, struct ptp_sys_offset_precise)
+#define PTP_SYS_OFFSET_EXTENDED \
+	_IOW(PTP_CLK_MAGIC, 9, struct ptp_sys_offset_extended)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
-- 
2.17.2

