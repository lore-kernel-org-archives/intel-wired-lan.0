From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:20 +0200
Subject: [Intel-wired-lan] [patch 34/35] net: rtlwifi: Remove in_interrupt()
 from debug macro
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194923.249291290@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in drivers in is phased out.

rtlwifi uses in_interrupt() in the RT_TRACE() debug macro which is
sprinkled all over the driver. RT_TRACE() is almost identical to RTPRINT()
which another hideous debug printk wrapper. The only difference is the
printout of in_interrupt().

The decoding of in_interrupt() as hexvalue is non-trivial and aside of
being phased out for driver use the return value is just by chance the
masked preempt count value and not a boolean.

These home brewn printk debug aids are tedious to work with and provide
only minimal context.  They should be replaced by trace_printk() or a debug
tracepoint which automatically records all context information.

To make progress on the in_interrupt() cleanup, make RT_TRACE() use the
RTPRINT() debug function and remove _rtl_dbg_trace().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless at vger.kernel.org
Cc: netdev at vger.kernel.org

---
 drivers/net/wireless/realtek/rtlwifi/debug.c |   20 --------------------
 drivers/net/wireless/realtek/rtlwifi/debug.h |    6 +-----
 2 files changed, 1 insertion(+), 25 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -8,26 +8,6 @@
 #include <linux/vmalloc.h>
 
 #ifdef CONFIG_RTLWIFI_DEBUG
-void _rtl_dbg_trace(struct rtl_priv *rtlpriv, u64 comp, int level,
-		    const char *fmt, ...)
-{
-	if (unlikely((comp & rtlpriv->cfg->mod_params->debug_mask) &&
-		     level <= rtlpriv->cfg->mod_params->debug_level)) {
-		struct va_format vaf;
-		va_list args;
-
-		va_start(args, fmt);
-
-		vaf.fmt = fmt;
-		vaf.va = &args;
-
-		pr_info(":<%lx> %pV", in_interrupt(), &vaf);
-
-		va_end(args);
-	}
-}
-EXPORT_SYMBOL_GPL(_rtl_dbg_trace);
-
 void _rtl_dbg_print(struct rtl_priv *rtlpriv, u64 comp, int level,
 		    const char *fmt, ...)
 {
--- a/drivers/net/wireless/realtek/rtlwifi/debug.h
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.h
@@ -149,10 +149,6 @@ enum dbgp_flag_e {
 struct rtl_priv;
 
 __printf(4, 5)
-void _rtl_dbg_trace(struct rtl_priv *rtlpriv, u64 comp, int level,
-		    const char *fmt, ...);
-
-__printf(4, 5)
 void _rtl_dbg_print(struct rtl_priv *rtlpriv, u64 comp, int level,
 		    const char *fmt, ...);
 
@@ -161,7 +157,7 @@ void _rtl_dbg_print_data(struct rtl_priv
 			 const void *hexdata, int hexdatalen);
 
 #define RT_TRACE(rtlpriv, comp, level, fmt, ...)			\
-	_rtl_dbg_trace(rtlpriv, comp, level,				\
+	_rtl_dbg_print(rtlpriv, comp, level,				\
 		       fmt, ##__VA_ARGS__)
 
 #define RTPRINT(rtlpriv, dbgtype, dbgflag, fmt, ...)			\

