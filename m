From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:37 +0200
Subject: [Intel-wired-lan] [patch V2 28/36] net: ipw2x00, iwlegacy,
 iwlwifi: Remove in_interrupt() from debug macros
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203502.290194412@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in non-core code is phased out.

The debugging macros in these drivers use in_interrupt() to print 'I' or
'U' depending on the return value of in_interrupt(). While 'U' is confusing
at best and 'I' is not really describing the actual context (hard interupt,
soft interrupt, bottom half disabled section) these debug macros originate
from the pre ftrace kernel era and their value today is questionable. They
probably should be removed completely.

The macros weere added initially for ipw2100 and then spreaded when the
driver was forked.

Remove the in_interrupt() usage at least..

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kalle Valo <kvalo@codeaurora.org>

---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c   |    3 +--
 drivers/net/wireless/intel/ipw2x00/ipw2200.h   |    6 ++----
 drivers/net/wireless/intel/ipw2x00/libipw.h    |    3 +--
 drivers/net/wireless/intel/iwlegacy/common.h   |    4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-debug.c |    3 +--
 5 files changed, 7 insertions(+), 12 deletions(-)

--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -201,8 +201,7 @@ static u32 ipw2100_debug_level = IPW_DL_
 #define IPW_DEBUG(level, message...) \
 do { \
 	if (ipw2100_debug_level & (level)) { \
-		printk(KERN_DEBUG "ipw2100: %c %s ", \
-                       in_interrupt() ? 'I' : 'U',  __func__); \
+		printk(KERN_DEBUG "ipw2100: %s ", __func__); \
 		printk(message); \
 	} \
 } while (0)
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -1382,14 +1382,12 @@ BIT_ARG16(x)
 
 #define IPW_DEBUG(level, fmt, args...) \
 do { if (ipw_debug_level & (level)) \
-  printk(KERN_DEBUG DRV_NAME": %c %s " fmt, \
-         in_interrupt() ? 'I' : 'U', __func__ , ## args); } while (0)
+  printk(KERN_DEBUG DRV_NAME": %s " fmt, __func__ , ## args); } while (0)
 
 #ifdef CONFIG_IPW2200_DEBUG
 #define IPW_LL_DEBUG(level, fmt, args...) \
 do { if (ipw_debug_level & (level)) \
-  printk(KERN_DEBUG DRV_NAME": %c %s " fmt, \
-         in_interrupt() ? 'I' : 'U', __func__ , ## args); } while (0)
+  printk(KERN_DEBUG DRV_NAME": %s " fmt, __func__ , ## args); } while (0)
 #else
 #define IPW_LL_DEBUG(level, fmt, args...) do {} while (0)
 #endif				/* CONFIG_IPW2200_DEBUG */
--- a/drivers/net/wireless/intel/ipw2x00/libipw.h
+++ b/drivers/net/wireless/intel/ipw2x00/libipw.h
@@ -60,8 +60,7 @@
 extern u32 libipw_debug_level;
 #define LIBIPW_DEBUG(level, fmt, args...) \
 do { if (libipw_debug_level & (level)) \
-  printk(KERN_DEBUG "libipw: %c %s " fmt, \
-         in_interrupt() ? 'I' : 'U', __func__ , ## args); } while (0)
+  printk(KERN_DEBUG "libipw: %s " fmt, __func__ , ## args); } while (0)
 #else
 #define LIBIPW_DEBUG(level, fmt, args...) do {} while (0)
 #endif				/* CONFIG_LIBIPW_DEBUG */
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -2925,8 +2925,8 @@ do {									\
 #define IL_DBG(level, fmt, args...)					\
 do {									\
 	if (il_get_debug_level(il) & level)				\
-		dev_err(&il->hw->wiphy->dev, "%c %s " fmt,		\
-			in_interrupt() ? 'I' : 'U', __func__ , ##args); \
+		dev_err(&il->hw->wiphy->dev, "%s " fmt, __func__,	\
+			 ##args);					\
 } while (0)
 
 #define il_print_hex_dump(il, level, p, len)				\
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
@@ -121,8 +121,7 @@ void __iwl_dbg(struct device *dev,
 #ifdef CONFIG_IWLWIFI_DEBUG
 	if (iwl_have_debug_level(level) &&
 	    (!limit || net_ratelimit()))
-		dev_printk(KERN_DEBUG, dev, "%c %s %pV",
-			   in_interrupt() ? 'I' : 'U', function, &vaf);
+		dev_printk(KERN_DEBUG, dev, "%s %pV", function, &vaf);
 #endif
 	trace_iwlwifi_dbg(level, in_interrupt(), function, &vaf);
 	va_end(args);


