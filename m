From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:48:50 +0200
Subject: [Intel-wired-lan] [patch 04/35] net: caif: Use
 netif_rx_any_context()
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194920.214592677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in non-core code is phased out. Ideally the
information of the calling context should be passed by the callers or the
functions be split as appropriate.

cfhsi_rx_desc() and cfhsi_rx_pld() use in_interrupt() to distinguish if
they should use netif_rx() or netif_rx_ni() for receiving packets.

The attempt to consolidate the code by passing an arguemnt or by
distangling it failed due lack of knowledge about this driver and because
the call chains are hard to follow.

As a stop gap use netif_rx_any_context() which invokes the correct code path
depending on context and confines the in_interrupt() usage to core code.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: netdev at vger.kernel.org
---
 drivers/net/caif/caif_hsi.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

--- a/drivers/net/caif/caif_hsi.c
+++ b/drivers/net/caif/caif_hsi.c
@@ -458,15 +458,7 @@ static int cfhsi_rx_desc(struct cfhsi_de
 		skb_reset_mac_header(skb);
 		skb->dev = cfhsi->ndev;
 
-		/*
-		 * We are in a callback handler and
-		 * unfortunately we don't know what context we're
-		 * running in.
-		 */
-		if (in_interrupt())
-			netif_rx(skb);
-		else
-			netif_rx_ni(skb);
+		netif_rx_any_context(skb);
 
 		/* Update network statistics. */
 		cfhsi->ndev->stats.rx_packets++;
@@ -587,14 +579,7 @@ static int cfhsi_rx_pld(struct cfhsi_des
 		skb_reset_mac_header(skb);
 		skb->dev = cfhsi->ndev;
 
-		/*
-		 * We're called in callback from HSI
-		 * and don't know the context we're running in.
-		 */
-		if (in_interrupt())
-			netif_rx(skb);
-		else
-			netif_rx_ni(skb);
+		netif_rx_any_context(skb);
 
 		/* Update network statistics. */
 		cfhsi->ndev->stats.rx_packets++;

