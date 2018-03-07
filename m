From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:15 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 03/18] posix-timers: Add
 CLOCKID_INVALID mask
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-4-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

posix-timers.h states that a clockid_t value is invalid if bits 0, 1 and
2 are all set. Add a mask that can be safely used elsewhere even if this
implicit rule's implementation is changed.

This is done in preparation for the upcoming time based transmission
patchset.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 include/linux/posix-timers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index c85704fcdbd2..0ba677cc8da6 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -28,6 +28,7 @@ struct cpu_timer_list {
  *
  * A clockid is invalid if bits 2, 1, and 0 are all set.
  */
+#define CLOCKID_INVALID			GENMASK(2, 0)
 #define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
 #define CPUCLOCK_PERTHREAD(clock) \
 	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
-- 
2.16.2

