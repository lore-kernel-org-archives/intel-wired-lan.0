From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:26 +0200
Subject: [Intel-wired-lan] [patch V2 17/36] net: sunbmac: Replace
 in_interrupt() usage
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203501.174106828@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

bigmac_init_rings() has an argument signaling if it is called from the
interrupt handler. This is used to decide between GFP_KERNEL and GFP_ATOMIC
for memory allocations.

But it also checks in_interrupt() to handle invocations which come from the
timer callback bigmac_timer() via bigmac_hw_init(), which is invoked with
'in_irq = 0'. While the timer callback is clearly not in hard interrupt
context it is still not sleepable context.

Rename the argument to `non_blocking' and set it to true if invoked from
the timer callback or the interrupt handler which allows to remove the
in_interrupt() check and makes the code consistent.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 drivers/net/ethernet/sun/sunbmac.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -209,13 +209,13 @@ static void bigmac_clean_rings(struct bi
 	}
 }
 
-static void bigmac_init_rings(struct bigmac *bp, int from_irq)
+static void bigmac_init_rings(struct bigmac *bp, bool non_blocking)
 {
 	struct bmac_init_block *bb = bp->bmac_block;
 	int i;
 	gfp_t gfp_flags = GFP_KERNEL;
 
-	if (from_irq || in_interrupt())
+	if (non_blocking)
 		gfp_flags = GFP_ATOMIC;
 
 	bp->rx_new = bp->rx_old = bp->tx_new = bp->tx_old = 0;
@@ -489,7 +489,7 @@ static void bigmac_tcvr_init(struct bigm
 	}
 }
 
-static int bigmac_init_hw(struct bigmac *, int);
+static int bigmac_init_hw(struct bigmac *, bool);
 
 static int try_next_permutation(struct bigmac *bp, void __iomem *tregs)
 {
@@ -549,7 +549,7 @@ static void bigmac_timer(struct timer_li
 				if (ret == -1) {
 					printk(KERN_ERR "%s: Link down, cable problem?\n",
 					       bp->dev->name);
-					ret = bigmac_init_hw(bp, 0);
+					ret = bigmac_init_hw(bp, true);
 					if (ret) {
 						printk(KERN_ERR "%s: Error, cannot re-init the "
 						       "BigMAC.\n", bp->dev->name);
@@ -617,7 +617,7 @@ static void bigmac_begin_auto_negotiatio
 	add_timer(&bp->bigmac_timer);
 }
 
-static int bigmac_init_hw(struct bigmac *bp, int from_irq)
+static int bigmac_init_hw(struct bigmac *bp, bool non_blocking)
 {
 	void __iomem *gregs        = bp->gregs;
 	void __iomem *cregs        = bp->creg;
@@ -635,7 +635,7 @@ static int bigmac_init_hw(struct bigmac
 	qec_init(bp);
 
 	/* Alloc and reset the tx/rx descriptor chains. */
-	bigmac_init_rings(bp, from_irq);
+	bigmac_init_rings(bp, non_blocking);
 
 	/* Initialize the PHY. */
 	bigmac_tcvr_init(bp);
@@ -749,7 +749,7 @@ static void bigmac_is_medium_rare(struct
 	}
 
 	printk(" RESET\n");
-	bigmac_init_hw(bp, 1);
+	bigmac_init_hw(bp, true);
 }
 
 /* BigMAC transmit complete service routines. */
@@ -921,7 +921,7 @@ static int bigmac_open(struct net_device
 		return ret;
 	}
 	timer_setup(&bp->bigmac_timer, bigmac_timer, 0);
-	ret = bigmac_init_hw(bp, 0);
+	ret = bigmac_init_hw(bp, false);
 	if (ret)
 		free_irq(dev->irq, bp);
 	return ret;
@@ -945,7 +945,7 @@ static void bigmac_tx_timeout(struct net
 {
 	struct bigmac *bp = netdev_priv(dev);
 
-	bigmac_init_hw(bp, 0);
+	bigmac_init_hw(bp, true);
 	netif_wake_queue(dev);
 }
 


