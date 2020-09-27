From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:16 +0200
Subject: [Intel-wired-lan] [patch 30/35] net: mwifiex: Use
 netif_rx_any_context().
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194922.830361303@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in non-core code is phased out. Ideally the
information of the calling context should be passed by the callers or the
functions be split as appropriate.

mwifiex uses in_interupt() to select the netif_rx*() variant which matches
the calling context. The attempt to consolidate the code by passing an
arguemnt or by distangling it failed due lack of knowledge about this
driver and because the call chains are hard to follow.

As a stop gap use netif_rx_any_context() which invokes the correct code
path depending on context and confines the in_interrupt() usage to core
code.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc: Xinming Hu <huxinming820@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless at vger.kernel.org
Cc: netdev at vger.kernel.org

---
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c |    6 +-----
 drivers/net/wireless/marvell/mwifiex/util.c     |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -350,11 +350,7 @@ int mwifiex_uap_recv_packet(struct mwifi
 		skb->truesize += (skb->len - MWIFIEX_RX_DATA_BUF_SIZE);
 
 	/* Forward multicast/broadcast packet to upper layer*/
-	if (in_interrupt())
-		netif_rx(skb);
-	else
-		netif_rx_ni(skb);
-
+	netif_rx_any_context(skb);
 	return 0;
 }
 
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -488,11 +488,7 @@ int mwifiex_recv_packet(struct mwifiex_p
 	    (skb->truesize > MWIFIEX_RX_DATA_BUF_SIZE))
 		skb->truesize += (skb->len - MWIFIEX_RX_DATA_BUF_SIZE);
 
-	if (in_interrupt())
-		netif_rx(skb);
-	else
-		netif_rx_ni(skb);
-
+	netif_rx_any_context(skb);
 	return 0;
 }
 

