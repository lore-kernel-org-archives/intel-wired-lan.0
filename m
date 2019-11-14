From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 14 Nov 2019 10:44:55 -0800
Subject: [Intel-wired-lan] [PATCH net 01/13] ptp: Validate requests to
 enable time stamping of external signals.
Message-ID: <20191114184507.18937-2-richardcochran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 415606588c61 ("PTP: introduce new versions of IOCTLs")
introduced a new external time stamp ioctl that validates the flags.
This patch extends the validation to ensure that at least one rising
or falling edge flag is set when enabling external time stamps.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/ptp/ptp_chardev.c      | 18 +++++++++++++-----
 include/uapi/linux/ptp_clock.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 67d0199840fd..cbbe1237ff8d 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -149,11 +149,19 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
-		if (((req.extts.flags & ~PTP_EXTTS_VALID_FLAGS) ||
-			req.extts.rsv[0] || req.extts.rsv[1]) &&
-			cmd == PTP_EXTTS_REQUEST2) {
-			err = -EINVAL;
-			break;
+		if (cmd == PTP_EXTTS_REQUEST2) {
+			/* Make sure no reserved bit is set. */
+			if ((req.extts.flags & ~PTP_EXTTS_VALID_FLAGS) ||
+			    req.extts.rsv[0] || req.extts.rsv[1]) {
+				err = -EINVAL;
+				break;
+			}
+			/* Ensure one of the rising/falling edge bits is set. */
+			if ((req.extts.flags & PTP_ENABLE_FEATURE) &&
+			    (req.extts.flags & PTP_EXTTS_EDGES) == 0) {
+				err = -EINVAL;
+				break;
+			}
 		} else if (cmd == PTP_EXTTS_REQUEST) {
 			req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;
 			req.extts.rsv[0] = 0;
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 59e89a1bc3bb..304059b1609d 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -31,6 +31,7 @@
 #define PTP_ENABLE_FEATURE (1<<0)
 #define PTP_RISING_EDGE    (1<<1)
 #define PTP_FALLING_EDGE   (1<<2)
+#define PTP_EXTTS_EDGES    (PTP_RISING_EDGE | PTP_FALLING_EDGE)
 
 /*
  * flag fields valid for the new PTP_EXTTS_REQUEST2 ioctl.
-- 
2.20.1

