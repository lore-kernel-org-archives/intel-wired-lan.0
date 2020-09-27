From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:18 +0200
Subject: [Intel-wired-lan] [patch 32/35] net: libertas: Use
 netif_rx_any_context()
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194923.031899444@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in non-core code is phased out. Ideally the
information of the calling context should be passed by the callers or the
functions be split as appropriate.

libertas uses in_interupt() to select the netif_rx*() variant which matches
the calling context. The attempt to consolidate the code by passing an
arguemnt or by distangling it failed due lack of knowledge about this
driver and because the call chains are hard to follow.

As a stop gap tse netif_rx_any_context() which invokes the correct code
path depending on context and confines the in_interrupt() usage to core
code.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Pascal Terjan <pterjan@google.com>
Cc: libertas-dev at lists.infradead.org
Cc: linux-wireless at vger.kernel.org
Cc: netdev at vger.kernel.org

---
 drivers/net/wireless/marvell/libertas/rx.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/net/wireless/marvell/libertas/rx.c
+++ b/drivers/net/wireless/marvell/libertas/rx.c
@@ -147,10 +147,7 @@ int lbs_process_rxed_packet(struct lbs_p
 	dev->stats.rx_packets++;
 
 	skb->protocol = eth_type_trans(skb, dev);
-	if (in_interrupt())
-		netif_rx(skb);
-	else
-		netif_rx_ni(skb);
+	netif_rx_any_context(skb);
 
 	ret = 0;
 done:
@@ -265,11 +262,7 @@ static int process_rxed_802_11_packet(st
 	dev->stats.rx_packets++;
 
 	skb->protocol = eth_type_trans(skb, priv->dev);
-
-	if (in_interrupt())
-		netif_rx(skb);
-	else
-		netif_rx_ni(skb);
+	netif_rx_any_context(skb);
 
 	ret = 0;
 

