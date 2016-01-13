From: Christopher S. Hall <christopher.s.hall@intel.com>
Date: Wed, 13 Jan 2016 04:12:21 -0800
Subject: [Intel-wired-lan] [PATCH v6 1/9] Add cycles to nanoseconds
	translation
In-Reply-To: <1452687149-11281-1-git-send-email-christopher.s.hall@intel.com>
References: <1452687149-11281-1-git-send-email-christopher.s.hall@intel.com>
Message-ID: <1452687149-11281-2-git-send-email-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The timekeeping code does not currently provide a way to translate
externally provided clocksource cycles to system time. The cycle count
is always provided by the result clocksource read() method internal to
the timekeeping code. The added function timekeeping_cycles_to_ns()
calculated a nanosecond value from a cycle count that can be added to
tk_read_base.base value yielding the current system time. This allows
clocksource cycle values external to the timekeeping code to provide a
cycle count that can be transformed to system time.

Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
---
 kernel/time/timekeeping.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d563c19..3f127dd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -298,13 +298,11 @@ u32 (*arch_gettimeoffset)(void) = default_arch_gettimeoffset;
 static inline u32 arch_gettimeoffset(void) { return 0; }
 #endif
 
-static inline s64 timekeeping_get_ns(struct tk_read_base *tkr)
+static inline s64 timekeeping_delta_to_ns(struct tk_read_base *tkr,
+					  cycle_t delta)
 {
-	cycle_t delta;
 	s64 nsec;
 
-	delta = timekeeping_get_delta(tkr);
-
 	nsec = delta * tkr->mult + tkr->xtime_nsec;
 	nsec >>= tkr->shift;
 
@@ -312,6 +310,24 @@ static inline s64 timekeeping_get_ns(struct tk_read_base *tkr)
 	return nsec + arch_gettimeoffset();
 }
 
+static inline s64 timekeeping_get_ns(struct tk_read_base *tkr)
+{
+	cycle_t delta;
+
+	delta = timekeeping_get_delta(tkr);
+	return timekeeping_delta_to_ns(tkr, delta);
+}
+
+static inline s64 timekeeping_cycles_to_ns(struct tk_read_base *tkr,
+					    cycle_t cycles)
+{
+	cycle_t delta;
+
+	/* calculate the delta since the last update_wall_time */
+	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
+	return timekeeping_delta_to_ns(tkr, delta);
+}
+
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
  * @tkr: Timekeeping readout base from which we take the update
-- 
2.1.4

