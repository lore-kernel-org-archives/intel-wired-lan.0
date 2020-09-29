From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:38 +0200
Subject: [Intel-wired-lan] [patch V2 29/36] net: iwlwifi: Remove
 in_interrupt() from tracing macro.
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203502.385024523@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt) in driver code is phased out.

The iwlwifi_dbg tracepoint records in_interrupt() seperately, but that's
superfluous because the trace header already records all kind of state and
context information like hardirq status, softirq status, preemption count
etc.

Aside of that the recording of in_interrupt() as boolean does not allow to
distinguish between the possible contexts (hard interrupt, soft interrupt,
bottom half disabled) while the trace header gives precise information.

Remove the duplicate information from the tracepoint and fixup the caller.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Luca Coelho <luca@coelho.fi>
Acked-by: Kalle Valo <kvalo@codeaurora.org>

---
 drivers/net/wireless/intel/iwlwifi/iwl-debug.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h |    6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
@@ -123,7 +123,7 @@ void __iwl_dbg(struct device *dev,
 	    (!limit || net_ratelimit()))
 		dev_printk(KERN_DEBUG, dev, "%s %pV", function, &vaf);
 #endif
-	trace_iwlwifi_dbg(level, in_interrupt(), function, &vaf);
+	trace_iwlwifi_dbg(level, function, &vaf);
 	va_end(args);
 }
 IWL_EXPORT_SYMBOL(__iwl_dbg);
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
@@ -54,18 +54,16 @@ DEFINE_EVENT(iwlwifi_msg_event, iwlwifi_
 );
 
 TRACE_EVENT(iwlwifi_dbg,
-	TP_PROTO(u32 level, bool in_interrupt, const char *function,
+	TP_PROTO(u32 level, const char *function,
 		 struct va_format *vaf),
-	TP_ARGS(level, in_interrupt, function, vaf),
+	TP_ARGS(level, function, vaf),
 	TP_STRUCT__entry(
 		__field(u32, level)
-		__field(u8, in_interrupt)
 		__string(function, function)
 		__dynamic_array(char, msg, MAX_MSG_LEN)
 	),
 	TP_fast_assign(
 		__entry->level = level;
-		__entry->in_interrupt = in_interrupt;
 		__assign_str(function, function);
 		WARN_ON_ONCE(vsnprintf(__get_dynamic_array(msg),
 				       MAX_MSG_LEN, vaf->fmt,


