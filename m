From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:03 +0200
Subject: [Intel-wired-lan] [patch 17/35] net: sun3lance: Remove redundant
 checks in interrupt handler
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194921.547895614@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

lance_interrupt() contains two pointless checks:

 - A check whether the 'dev_id' argument is NULL. 'dev_id' is the pointer
   which was handed in to request_irq() and the interrupt handler will
   always be invoked with that pointer as 'dev_id' argument by the core
   code.

 - A check for interrupt reentrancy. The core code already guarantees
   non-reentrancy of interrupt handlers.

Remove these check.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org
---
 drivers/net/ethernet/amd/sun3lance.c |   11 -----------
 1 file changed, 11 deletions(-)

--- a/drivers/net/ethernet/amd/sun3lance.c
+++ b/drivers/net/ethernet/amd/sun3lance.c
@@ -657,16 +657,6 @@ static irqreturn_t lance_interrupt( int
 	struct net_device *dev = dev_id;
 	struct lance_private *lp = netdev_priv(dev);
 	int csr0;
-	static int in_interrupt;
-
-	if (dev == NULL) {
-		DPRINTK( 1, ( "lance_interrupt(): invalid dev_id\n" ));
-		return IRQ_NONE;
-	}
-
-	if (in_interrupt)
-		DPRINTK( 2, ( "%s: Re-entering the interrupt handler.\n", dev->name ));
-	in_interrupt = 1;
 
  still_more:
 	flush_cache_all();
@@ -774,7 +764,6 @@ static irqreturn_t lance_interrupt( int
 
 	DPRINTK( 2, ( "%s: exiting interrupt, csr0=%#04x.\n",
 				  dev->name, DREG ));
-	in_interrupt = 0;
 	return IRQ_HANDLED;
 }
 

