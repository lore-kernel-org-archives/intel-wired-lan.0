From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 30 Oct 2018 20:01:11 -0700
Subject: [Intel-wired-lan] [RFC PATCH 1/4] ptp: add
 PTP_SYS_OFFSET_EXTENDED ioctl
In-Reply-To: <20181031022351.24mmvf7u7bcx42rv@localhost>
References: <20181026162742.631-1-mlichvar@redhat.com>
 <20181026162742.631-2-mlichvar@redhat.com>
 <20181031022351.24mmvf7u7bcx42rv@localhost>
Message-ID: <20181031030111.2s4jsnunjrbfarix@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 30, 2018 at 07:23:51PM -0700, Richard Cochran wrote:
> This collection of automatic variables is getting ugly.  May I ask you
> to prefix a patch that puts them into reverse Christmas tree before
> your changes?  (Patch below)

Forgot the diff. Here it is...

---
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 2012551d93e0..b54b8158ff8a 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -121,18 +121,18 @@ int ptp_open(struct posix_clock *pc, fmode_t fmode)
 
 long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 {
-	struct ptp_clock_caps caps;
-	struct ptp_clock_request req;
-	struct ptp_sys_offset *sysoff = NULL;
-	struct ptp_sys_offset_precise precise_offset;
-	struct ptp_pin_desc pd;
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct ptp_sys_offset_precise precise_offset;
+	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops = ptp->info;
+	struct ptp_sys_offset *sysoff = NULL;
+	struct ptp_clock_request req;
+	struct ptp_clock_caps caps;
 	struct ptp_clock_time *pct;
+	unsigned int i, pin_index;
+	struct ptp_pin_desc pd;
 	struct timespec64 ts;
-	struct system_device_crosststamp xtstamp;
 	int enable, err = 0;
-	unsigned int i, pin_index;
 
 	switch (cmd) {
 
