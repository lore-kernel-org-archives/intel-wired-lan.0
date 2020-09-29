From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:23 +0200
Subject: [Intel-wired-lan] [patch V2 14/36] net: natsemi: Replace
 in_interrupt() usage.
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203500.870136509@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Thomas Gleixner <tglx@linutronix.de>

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be seperated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

sonic_quiesce() uses 'in_interrupt() || irqs_disabled()' to chose either
udelay() or usleep_range() in the wait loop.

In all callchains leading to it the context is well defined and known.

Add a 'may_sleep' argument and pass it through the various callchains
leading to this function.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 drivers/net/ethernet/natsemi/sonic.c |   24 ++++++++++++------------
 drivers/net/ethernet/natsemi/sonic.h |    2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -143,7 +143,7 @@ static int sonic_open(struct net_device
 	/*
 	 * Initialize the SONIC
 	 */
-	sonic_init(dev);
+	sonic_init(dev, true);
 
 	netif_start_queue(dev);
 
@@ -153,7 +153,7 @@ static int sonic_open(struct net_device
 }
 
 /* Wait for the SONIC to become idle. */
-static void sonic_quiesce(struct net_device *dev, u16 mask)
+static void sonic_quiesce(struct net_device *dev, u16 mask, bool may_sleep)
 {
 	struct sonic_local * __maybe_unused lp = netdev_priv(dev);
 	int i;
@@ -163,7 +163,7 @@ static void sonic_quiesce(struct net_dev
 		bits = SONIC_READ(SONIC_CMD) & mask;
 		if (!bits)
 			return;
-		if (irqs_disabled() || in_interrupt())
+		if (!may_sleep)
 			udelay(20);
 		else
 			usleep_range(100, 200);
@@ -187,7 +187,7 @@ static int sonic_close(struct net_device
 	 * stop the SONIC, disable interrupts
 	 */
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RXDIS);
-	sonic_quiesce(dev, SONIC_CR_ALL);
+	sonic_quiesce(dev, SONIC_CR_ALL, true);
 
 	SONIC_WRITE(SONIC_IMR, 0);
 	SONIC_WRITE(SONIC_ISR, 0x7fff);
@@ -229,7 +229,7 @@ static void sonic_tx_timeout(struct net_
 	 * disable all interrupts before releasing DMA buffers
 	 */
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RXDIS);
-	sonic_quiesce(dev, SONIC_CR_ALL);
+	sonic_quiesce(dev, SONIC_CR_ALL, false);
 
 	SONIC_WRITE(SONIC_IMR, 0);
 	SONIC_WRITE(SONIC_ISR, 0x7fff);
@@ -246,7 +246,7 @@ static void sonic_tx_timeout(struct net_
 		}
 	}
 	/* Try to restart the adaptor. */
-	sonic_init(dev);
+	sonic_init(dev, false);
 	lp->stats.tx_errors++;
 	netif_trans_update(dev); /* prevent tx timeout */
 	netif_wake_queue(dev);
@@ -692,9 +692,9 @@ static void sonic_multicast_list(struct
 
 			/* LCAM and TXP commands can't be used simultaneously */
 			spin_lock_irqsave(&lp->lock, flags);
-			sonic_quiesce(dev, SONIC_CR_TXP);
+			sonic_quiesce(dev, SONIC_CR_TXP, false);
 			SONIC_WRITE(SONIC_CMD, SONIC_CR_LCAM);
-			sonic_quiesce(dev, SONIC_CR_LCAM);
+			sonic_quiesce(dev, SONIC_CR_LCAM, false);
 			spin_unlock_irqrestore(&lp->lock, flags);
 		}
 	}
@@ -708,7 +708,7 @@ static void sonic_multicast_list(struct
 /*
  * Initialize the SONIC ethernet controller.
  */
-static int sonic_init(struct net_device *dev)
+static int sonic_init(struct net_device *dev, bool may_sleep)
 {
 	struct sonic_local *lp = netdev_priv(dev);
 	int i;
@@ -730,7 +730,7 @@ static int sonic_init(struct net_device
 	 */
 	SONIC_WRITE(SONIC_CMD, 0);
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RXDIS | SONIC_CR_STP);
-	sonic_quiesce(dev, SONIC_CR_ALL);
+	sonic_quiesce(dev, SONIC_CR_ALL, may_sleep);
 
 	/*
 	 * initialize the receive resource area
@@ -759,7 +759,7 @@ static int sonic_init(struct net_device
 	netif_dbg(lp, ifup, dev, "%s: issuing RRRA command\n", __func__);
 
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RRRA);
-	sonic_quiesce(dev, SONIC_CR_RRRA);
+	sonic_quiesce(dev, SONIC_CR_RRRA, may_sleep);
 
 	/*
 	 * Initialize the receive descriptors so that they
@@ -834,7 +834,7 @@ static int sonic_init(struct net_device
 	 * load the CAM
 	 */
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_LCAM);
-	sonic_quiesce(dev, SONIC_CR_LCAM);
+	sonic_quiesce(dev, SONIC_CR_LCAM, may_sleep);
 
 	/*
 	 * enable receiver, disable loopback
--- a/drivers/net/ethernet/natsemi/sonic.h
+++ b/drivers/net/ethernet/natsemi/sonic.h
@@ -338,7 +338,7 @@ static void sonic_rx(struct net_device *
 static int sonic_close(struct net_device *dev);
 static struct net_device_stats *sonic_get_stats(struct net_device *dev);
 static void sonic_multicast_list(struct net_device *dev);
-static int sonic_init(struct net_device *dev);
+static int sonic_init(struct net_device *dev, bool may_sleep);
 static void sonic_tx_timeout(struct net_device *dev, unsigned int txqueue);
 static void sonic_msg_init(struct net_device *dev);
 static int sonic_alloc_descriptors(struct net_device *dev);


