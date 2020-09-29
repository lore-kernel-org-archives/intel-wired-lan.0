From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:44 +0200
Subject: [Intel-wired-lan] [patch V2 35/36] net: rtlwifi: Remove
 in_interrupt() from debug macro
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203502.960332937@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in drivers in is phased out.

rtl_dbg() a printk based debug aid is using in_interrupt() in the
underlying C function _rtl_dbg_out() which is almost identical to
_rtl_dbg_print(). The only difference is the printout of in_interrupt().

The decoding of in_interrupt() as hexvalue is non-trivial and aside of
being phased out for driver usage the return value is just by chance the
masked preempt count value and not a boolean.

These home brewn printk debug aids are tedious to work with and provide
only minimal context.  They should be replaced by trace_printk() or a debug
tracepoint which automatically records all context information.

To make progress on the in_interrupt() cleanup, make rtl_dbg() use
_rtl_dbg_print() and remove _rtl_dbg_out().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
---
V2: Adopted to the new names of the same thing.
---
 drivers/net/wireless/realtek/rtlwifi/debug.c |   20 --------------------
 drivers/net/wireless/realtek/rtlwifi/debug.h |    8 ++------
 2 files changed, 2 insertions(+), 26 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -8,26 +8,6 @@
 #include <linux/vmalloc.h>
 
 #ifdef CONFIG_RTLWIFI_DEBUG
-void _rtl_dbg_out(struct rtl_priv *rtlpriv, u64 comp, int level,
-		  const char *fmt, ...)
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
-EXPORT_SYMBOL_GPL(_rtl_dbg_out);
-
 void _rtl_dbg_print(struct rtl_priv *rtlpriv, u64 comp, int level,
 		    const char *fmt, ...)
 {
--- a/drivers/net/wireless/realtek/rtlwifi/debug.h
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.h
@@ -149,10 +149,6 @@ enum dbgp_flag_e {
 struct rtl_priv;
 
 __printf(4, 5)
-void _rtl_dbg_out(struct rtl_priv *rtlpriv, u64 comp, int level,
-		  const char *fmt, ...);
-
-__printf(4, 5)
 void _rtl_dbg_print(struct rtl_priv *rtlpriv, u64 comp, int level,
 		    const char *fmt, ...);
 
@@ -160,8 +156,8 @@ void _rtl_dbg_print_data(struct rtl_priv
 			 const char *titlestring,
 			 const void *hexdata, int hexdatalen);
 
-#define rtl_dbg(rtlpriv, comp, level, fmt, ...)			\
-	_rtl_dbg_out(rtlpriv, comp, level,				\
+#define rtl_dbg(rtlpriv, comp, level, fmt, ...)				\
+	_rtl_dbg_print(rtlpriv, comp, level,				\
 		       fmt, ##__VA_ARGS__)
 
 #define RTPRINT(rtlpriv, dbgtype, dbgflag, fmt, ...)			\

