From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:48:55 +0200
Subject: [Intel-wired-lan] [patch 09/35] net: fec_mpc52xx: Replace
 in_interrupt() usage
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194920.730139599@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be seperated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

mpc52xx_fec_stop() uses in_interrupt() to check if it is safe to sleep. All
callers run in well defined contexts.

Pass an argument from the callers indicating whether it is safe to sleep.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org

---
 drivers/net/ethernet/freescale/fec_mpc52xx.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -74,7 +74,7 @@ struct mpc52xx_fec_priv {
 static irqreturn_t mpc52xx_fec_interrupt(int, void *);
 static irqreturn_t mpc52xx_fec_rx_interrupt(int, void *);
 static irqreturn_t mpc52xx_fec_tx_interrupt(int, void *);
-static void mpc52xx_fec_stop(struct net_device *dev);
+static void mpc52xx_fec_stop(struct net_device *dev, bool may_sleep);
 static void mpc52xx_fec_start(struct net_device *dev);
 static void mpc52xx_fec_reset(struct net_device *dev);
 
@@ -283,7 +283,7 @@ static int mpc52xx_fec_close(struct net_
 
 	netif_stop_queue(dev);
 
-	mpc52xx_fec_stop(dev);
+	mpc52xx_fec_stop(dev, true);
 
 	mpc52xx_fec_free_rx_buffers(dev, priv->rx_dmatsk);
 
@@ -693,7 +693,7 @@ static void mpc52xx_fec_start(struct net
  *
  * stop all activity on fec and empty dma buffers
  */
-static void mpc52xx_fec_stop(struct net_device *dev)
+static void mpc52xx_fec_stop(struct net_device *dev, bool may_sleep)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 	struct mpc52xx_fec __iomem *fec = priv->fec;
@@ -706,7 +706,7 @@ static void mpc52xx_fec_stop(struct net_
 	bcom_disable(priv->rx_dmatsk);
 
 	/* Wait for tx queue to drain, but only if we're in process context */
-	if (!in_interrupt()) {
+	if (may_sleep) {
 		timeout = jiffies + msecs_to_jiffies(2000);
 		while (time_before(jiffies, timeout) &&
 				!bcom_queue_empty(priv->tx_dmatsk))
@@ -738,7 +738,7 @@ static void mpc52xx_fec_reset(struct net
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 	struct mpc52xx_fec __iomem *fec = priv->fec;
 
-	mpc52xx_fec_stop(dev);
+	mpc52xx_fec_stop(dev, false);
 
 	out_be32(&fec->rfifo_status, in_be32(&fec->rfifo_status));
 	out_be32(&fec->reset_cntrl, FEC_RESET_CNTRL_RESET_FIFO);

