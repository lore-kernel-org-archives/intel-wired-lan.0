From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:29 +0200
Subject: [Intel-wired-lan] [patch V2 20/36] net: zd1211rw: Remove
 ZD_ASSERT(in_interrupt())
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203501.493579905@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

in_interrupt() is ill defined and does not provide what the name
suggests. The usage especially in driver code is deprecated and
a tree wide effort to clean up and consolidate the (ab)usage of
in_interrupt() and related checks is happening.

handle_regs_int() is always invoked as part of URB callback which is either
invoked from hard or soft interrupt context.

Remove the magic assertion.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kalle Valo <kvalo@codeaurora.org>

---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -378,7 +378,6 @@ static inline void handle_regs_int(struc
 	int len;
 	u16 int_num;
 
-	ZD_ASSERT(in_interrupt());
 	spin_lock_irqsave(&intr->lock, flags);
 
 	int_num = le16_to_cpu(*(__le16 *)(urb->transfer_buffer+2));


