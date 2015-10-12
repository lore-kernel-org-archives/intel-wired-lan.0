From: Christopher S. Hall <christopher.s.hall@intel.com>
Date: Mon, 12 Oct 2015 11:45:20 -0700
Subject: [Intel-wired-lan] [PATCH v4 2/4] Always running timer correlated
	clocksource
In-Reply-To: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
Message-ID: <1444675522-4198-3-git-send-email-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On modern Intel systems TSC is derived from the new Always Running Timer
(ART). In addition, ART can be captured simultaneous to the capture of
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
---
 arch/x86/include/asm/cpufeature.h |  2 +-
 arch/x86/include/asm/tsc.h        |  2 ++
 arch/x86/kernel/tsc.c             | 48 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index e6cf2ad..90868a6 100644
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
index 6d7c547..9474c9c 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -29,6 +29,8 @@ static inline cycles_t get_cycles(void)
 	return rdtsc();
 }
 
+extern struct correlated_cs art_timestamper;
+
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c3f7602..c3f098c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -820,7 +820,7 @@ int recalibrate_cpu_khz(void)
 #ifndef CONFIG_SMP
 	unsigned long cpu_khz_old = cpu_khz;
 
-	if (cpu_has_tsc) {
+	if (boot_cpu_has(X86_FEATURE_ART)) {
 		tsc_khz = x86_platform.calibrate_tsc();
 		cpu_khz = tsc_khz;
 		cpu_data(0).loops_per_jiffy =
@@ -940,10 +940,36 @@ static struct notifier_block time_cpufreq_notifier_block = {
 	.notifier_call  = time_cpufreq_notifier
 };
 
+#define ART_CPUID_LEAF (0x15)
+/* The denominator will never be less that 2 */
+#define ART_MIN_DENOMINATOR (2)
+
+static u32 art_to_tsc_numerator;
+static u32 art_to_tsc_denominator;
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
+		if (art_to_tsc_denominator >= ART_MIN_DENOMINATOR)
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
@@ -1062,6 +1088,24 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
+/*
+ * Convert ART to TSC given numerator/denominator found in detect_art()
+ */
+static u64 convert_art_to_tsc(struct correlated_cs *cs, u64 cycles)
+{
+	u64 tmp, res;
+
+	res = (cycles / art_to_tsc_denominator) * art_to_tsc_numerator;
+	tmp = (cycles % art_to_tsc_denominator) * art_to_tsc_numerator;
+	res += tmp / art_to_tsc_denominator;
+
+	return res;
+}
+
+struct correlated_cs art_timestamper = {
+	.convert	= convert_art_to_tsc,
+};
+EXPORT_SYMBOL(art_timestamper);
 
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
@@ -1133,6 +1177,8 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 		(unsigned long)tsc_khz % 1000);
 
 out:
+	if (boot_cpu_has(X86_FEATURE_ART))
+		art_timestamper.related_cs = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 }
 
-- 
2.1.4

