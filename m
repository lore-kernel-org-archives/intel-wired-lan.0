From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:41 +0200
Subject: [Intel-wired-lan] [patch V2 32/36] net: libertas libertas_tf:
 Remove in_interrupt() from debug macro.
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203502.671989314@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The debug macro prints (INT) when in_interrupt() returns true. The value of
this information is dubious as it does not distinguish between the various
contexts which are covered by in_interrupt().

As the usage of in_interrupt() in drivers is phased out and the same
information can be more precisely obtained with tracing, remove the
in_interrupt() conditional from this debug printk.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kalle Valo <kvalo@codeaurora.org>

---
 drivers/net/wireless/marvell/libertas/defs.h        |    3 +--
 drivers/net/wireless/marvell/libertas_tf/deb_defs.h |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/marvell/libertas/defs.h
+++ b/drivers/net/wireless/marvell/libertas/defs.h
@@ -50,8 +50,7 @@ extern unsigned int lbs_debug;
 #ifdef DEBUG
 #define LBS_DEB_LL(grp, grpnam, fmt, args...) \
 do { if ((lbs_debug & (grp)) == (grp)) \
-  printk(KERN_DEBUG DRV_NAME grpnam "%s: " fmt, \
-         in_interrupt() ? " (INT)" : "", ## args); } while (0)
+  printk(KERN_DEBUG DRV_NAME grpnam ": " fmt, ## args); } while (0)
 #else
 #define LBS_DEB_LL(grp, grpnam, fmt, args...) do {} while (0)
 #endif
--- a/drivers/net/wireless/marvell/libertas_tf/deb_defs.h
+++ b/drivers/net/wireless/marvell/libertas_tf/deb_defs.h
@@ -48,8 +48,7 @@ extern unsigned int lbtf_debug;
 #ifdef DEBUG
 #define LBTF_DEB_LL(grp, grpnam, fmt, args...) \
 do { if ((lbtf_debug & (grp)) == (grp)) \
-  printk(KERN_DEBUG DRV_NAME grpnam "%s: " fmt, \
-         in_interrupt() ? " (INT)" : "", ## args); } while (0)
+  printk(KERN_DEBUG DRV_NAME grpnam ": " fmt, ## args); } while (0)
 #else
 #define LBTF_DEB_LL(grp, grpnam, fmt, args...) do {} while (0)
 #endif


