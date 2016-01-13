From: Christopher S. Hall <christopher.s.hall@intel.com>
Date: Wed, 13 Jan 2016 04:12:24 -0800
Subject: [Intel-wired-lan] [PATCH v6 4/9] Always Running Timer (ART)
	correlated clocksource
In-Reply-To: <1452687149-11281-1-git-send-email-christopher.s.hall@intel.com>
References: <1452687149-11281-1-git-send-email-christopher.s.hall@intel.com>
Message-ID: <1452687149-11281-5-git-send-email-christopher.s.hall@intel.com>
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
---
 arch/x86/include/asm/cpufeature.h |  2 +-
 arch/x86/include/asm/tsc.h        |  2 ++
 arch/x86/kernel/tsc.c             | 46 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index f7ba9fb..b940fa1 100644
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
index c7c4d9c..26dcf63 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -949,10 +949,36 @@ static struct notifier_block time_cpufreq_notifier_block = {
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
@@ -1071,6 +1097,24 @@ int unsynchronized_tsc(void)
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
@@ -1142,6 +1186,8 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 		(unsigned long)tsc_khz % 1000);
 
 out:
+	if (boot_cpu_has(X86_FEATURE_ART))
+		art_timestamper.related_cs = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 }
 
-- 
2.1.4

