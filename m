From: Christopher S. Hall <christopher.s.hall@intel.com>
Date: Mon, 22 Feb 2016 03:15:24 -0800
Subject: [Intel-wired-lan] [PATCH v8 6/8] x86: tsc: Always Running Timer
	(ART) correlated clocksource
In-Reply-To: <1456139726-3327-1-git-send-email-christopher.s.hall@intel.com>
References: <1456139726-3327-1-git-send-email-christopher.s.hall@intel.com>
Message-ID: <1456139726-3327-7-git-send-email-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On modern Intel systems TSC is derived from the new Always Running Timer
(ART). ART can be captured simultaneous to the capture of
audio and network device clocks, allowing a correlation between timebases
to be constructed. Upon capture, the driver converts the captured ART
value to the appropriate system clock using the correlated clocksource
mechanism.

On systems that support ART a new CPUID leaf (0x15) returns parameters
?m? and ?n? such that:

TSC_value = (ART_value * m) / n + k [n >= 2]

[k is an offset that can adjusted by a privileged agent. The
IA32_TSC_ADJUST MSR is an example of an interface to adjust k.
See 17.14.4 of the Intel SDM for more details]

Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
[jstultz: Tweaked to fix build issue, also reworked math for
64bit division on 32bit systems]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/x86/include/asm/cpufeature.h |  2 +-
 arch/x86/include/asm/tsc.h        |  2 ++
 arch/x86/kernel/tsc.c             | 49 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 7ad8c94..ff557b4 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -85,7 +85,7 @@
 #define X86_FEATURE_P4		( 3*32+ 7) /* "" P4 */
 #define X86_FEATURE_CONSTANT_TSC ( 3*32+ 8) /* TSC ticks at a constant rate */
 #define X86_FEATURE_UP		( 3*32+ 9) /* smp kernel running on up */
-/* free, was #define X86_FEATURE_FXSAVE_LEAK ( 3*32+10) * "" FXSAVE leaks FOP/FIP/FOP */
+#define X86_FEATURE_ART		(3*32+10) /* Platform has always running timer (ART) */
 #define X86_FEATURE_ARCH_PERFMON ( 3*32+11) /* Intel Architectural PerfMon */
 #define X86_FEATURE_PEBS	( 3*32+12) /* Precise-Event Based Sampling */
 #define X86_FEATURE_BTS		( 3*32+13) /* Branch Trace Store */
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 6d7c547..174c421 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -29,6 +29,8 @@ static inline cycles_t get_cycles(void)
 	return rdtsc();
 }
 
+extern struct system_counterval_t convert_art_to_tsc(cycle_t art);
+
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3d743da..3fa0f41 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -43,6 +43,10 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
 int tsc_clocksource_reliable;
 
+static u32 art_to_tsc_numerator;
+static u32 art_to_tsc_denominator;
+struct clocksource *art_related_clocksource;
+
 /*
  * Use a ring-buffer like data structure, where a writer advances the head by
  * writing a new data entry and a reader advances the tail when it observes a
@@ -949,10 +953,34 @@ static struct notifier_block time_cpufreq_notifier_block = {
 	.notifier_call  = time_cpufreq_notifier
 };
 
+#define ART_CPUID_LEAF (0x15)
+#define ART_MIN_DENOMINATOR (1)
+
+
+/*
+ * If ART is present detect the numerator:denominator to convert to TSC
+ */
+static void detect_art(void)
+{
+	unsigned int unused[2];
+
+	if (boot_cpu_data.cpuid_level >= ART_CPUID_LEAF) {
+		cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
+		      &art_to_tsc_numerator, unused, unused+1);
+
+		if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
+		    art_to_tsc_denominator >= ART_MIN_DENOMINATOR)
+			set_cpu_cap(&boot_cpu_data, X86_FEATURE_ART);
+	}
+}
+
 static int __init cpufreq_tsc(void)
 {
 	if (!cpu_has_tsc)
 		return 0;
+
+	detect_art();
+
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		return 0;
 	cpufreq_register_notifier(&time_cpufreq_notifier_block,
@@ -1071,6 +1099,25 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
+/*
+ * Convert ART to TSC given numerator/denominator found in detect_art()
+ */
+struct system_counterval_t convert_art_to_tsc(cycle_t art)
+{
+	u64 tmp, res, rem;
+
+	rem = do_div(art, art_to_tsc_denominator);
+
+	res = art * art_to_tsc_numerator;
+	tmp = rem * art_to_tsc_numerator;
+
+	do_div(tmp, art_to_tsc_denominator);
+	res += tmp;
+
+	return (struct system_counterval_t) {.cs = art_related_clocksource,
+			.cycles = res};
+}
+EXPORT_SYMBOL(convert_art_to_tsc);
 
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
@@ -1142,6 +1189,8 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 		(unsigned long)tsc_khz % 1000);
 
 out:
+	if (boot_cpu_has(X86_FEATURE_ART))
+		art_related_clocksource = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 }
 
-- 
2.1.4

