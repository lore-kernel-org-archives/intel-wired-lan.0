From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:16 +0200
Subject: [Intel-wired-lan] [patch V2 07/36] net: cxbg4: Remove pointless
 in_interrupt() check
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203500.165559775@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Thomas Gleixner <tglx@linutronix.de>

t4_sge_stop() is only ever called from task context and the in_interrupt()
check is presumably a leftover from copying t3_sge_stop().

Aside of in_interrupt() being deprecated because it's not providing what it
claims to provide, this check would paper over illegitimate callers.

The functions invoked from t4_sge_stop() contain already warnings to catch
invocations from invalid contexts.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>



---
 drivers/net/ethernet/chelsio/cxgb4/sge.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -4872,9 +4872,6 @@ void t4_sge_stop(struct adapter *adap)
 	int i;
 	struct sge *s = &adap->sge;
 
-	if (in_interrupt())  /* actions below require waiting */
-		return;
-
 	if (s->rx_timer.function)
 		del_timer_sync(&s->rx_timer);
 	if (s->tx_timer.function)


