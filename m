From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:15 +0200
Subject: [Intel-wired-lan] [patch 29/35] net: hostap: Remove in_interrupt()
 usage
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194922.722439719@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

in_interrupt() is ill defined and does not provide what the name
suggests. The usage especially in driver code is deprecated and a tree wide
effort to clean up and consolidate the (ab)usage of in_interrupt() and
related checks is happening.

hfa384x_cmd() and prism2_hw_reset() check in_interrupt() at function entry
and if true emit a printk at debug loglevel and return. This is clearly debug
code.

Both functions invoke functions which can sleep. These functions already
have appropriate debug checks which cover all invalid contexts, while
in_interrupt() fails to detect context which just has preemption or
interrupts disabled.

Remove both checks as they are incomplete, debug only and already covered
by the subsequently invoked functions properly. If called from invalid
context the resulting back trace is definitely more helpful to analyze the
problem than a printk at debug loglevel.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jouni Malinen <j@w1.fi>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless at vger.kernel.org
Cc: netdev at vger.kernel.org

---
 drivers/net/wireless/intersil/hostap/hostap_hw.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/drivers/net/wireless/intersil/hostap/hostap_hw.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_hw.c
@@ -320,12 +320,6 @@ static int hfa384x_cmd(struct net_device
 	iface = netdev_priv(dev);
 	local = iface->local;
 
-	if (in_interrupt()) {
-		printk(KERN_DEBUG "%s: hfa384x_cmd called from interrupt "
-		       "context\n", dev->name);
-		return -1;
-	}
-
 	if (local->cmd_queue_len >= HOSTAP_CMD_QUEUE_MAX_LEN) {
 		printk(KERN_DEBUG "%s: hfa384x_cmd: cmd_queue full\n",
 		       dev->name);
@@ -1560,12 +1554,6 @@ static void prism2_hw_reset(struct net_d
 	iface = netdev_priv(dev);
 	local = iface->local;
 
-	if (in_interrupt()) {
-		printk(KERN_DEBUG "%s: driver bug - prism2_hw_reset() called "
-		       "in interrupt context\n", dev->name);
-		return;
-	}
-
 	if (local->hw_downloading)
 		return;
 

