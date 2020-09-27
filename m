From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:11 +0200
Subject: [Intel-wired-lan] [patch 25/35] net: brcmfmac: Use
 netif_rx_any_context().
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194922.339094192@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in non-core code is phased out. Ideally the
information of the calling context should be passed by the callers or the
functions be split as appropriate.

brcmfmac uses in_interupt() to select the netif_rx*() variant which matches
the calling context. The attempt to consolidate the code by passing an
arguemnt or by distangling it failed due lack of knowledge about this
driver and because the call chains are convoluted and hard to follow.

As a stop gap use netif_rx_any_context() which invokes the correct code
path depending on context which confines the usage of in_interrupt() to
core code.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless at vger.kernel.org
Cc: brcm80211-dev-list.pdl at broadcom.com
Cc: brcm80211-dev-list at cypress.com
Cc: netdev at vger.kernel.org

---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -418,14 +418,7 @@ void brcmf_netif_rx(struct brcmf_if *ifp
 	ifp->ndev->stats.rx_packets++;
 
 	brcmf_dbg(DATA, "rx proto=0x%X\n", ntohs(skb->protocol));
-	if (in_interrupt())
-		netif_rx(skb);
-	else
-		/* If the receive is not processed inside an ISR,
-		 * the softirqd must be woken explicitly to service
-		 * the NET_RX_SOFTIRQ.  This is handled by netif_rx_ni().
-		 */
-		netif_rx_ni(skb);
+	netif_rx_any_context(skb);
 }
 
 void brcmf_netif_mon_rx(struct brcmf_if *ifp, struct sk_buff *skb)

