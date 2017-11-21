From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 21 Nov 2017 14:30:30 -0800
Subject: [Intel-wired-lan] [PATCH net] sched/deadline: fix one-bit signed
 bitfields to be unsigned
Message-ID: <20171121223030.28051-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 799ba82de01e ("sched/deadline: Use C bitfields for the state
flags", 2017-10-10) introduced the use of C bitfields for these
variables. However, sparse complains about them:

./include/linux/sched.h:476:62: error: dubious one-bit signed bitfield
./include/linux/sched.h:477:62: error: dubious one-bit signed bitfield
./include/linux/sched.h:478:62: error: dubious one-bit signed bitfield
./include/linux/sched.h:479:62: error: dubious one-bit signed bitfield

This is because a one-bit signed bitfield can only hold the values 0 and
-1, which can cause problems if the program expects to be able to
represent the value positive 1.

In practice, this may not cause a bug since -1 would be considered
"true" in logical tests, however we should avoid the practice anyways.

Fixes: 799ba82de01e ("sched/deadline: Use C bitfields for the state flags", 2017-10-10)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: luca abeni <luca.abeni@santannapisa.it>
---
 include/linux/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a5dc7c98b0a2..21991d668d35 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -473,10 +473,10 @@ struct sched_dl_entity {
 	 * conditions between the inactive timer handler and the wakeup
 	 * code.
 	 */
-	int				dl_throttled      : 1;
-	int				dl_boosted        : 1;
-	int				dl_yielded        : 1;
-	int				dl_non_contending : 1;
+	unsigned int			dl_throttled      : 1;
+	unsigned int			dl_boosted        : 1;
+	unsigned int			dl_yielded        : 1;
+	unsigned int			dl_non_contending : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
-- 
2.15.0

