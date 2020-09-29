From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:34 +0200
Subject: [Intel-wired-lan] [patch V2 25/36] net: brcmfmac: Replace
 in_interrupt()
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203501.990651184@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

brcmf_sdio_isr() is using in_interrupt() to distinguish if it is called
from a interrupt service routine or from a worker thread.

Passing such information from the calling context is preferred and
requested by Linus, so add an argument `in_isr' to brcmf_sdio_isr() and let
the callers pass the information about the calling context.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |    4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |    4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -73,7 +73,7 @@ static irqreturn_t brcmf_sdiod_oob_irqha
 		sdiodev->irq_en = false;
 	}
 
-	brcmf_sdio_isr(sdiodev->bus);
+	brcmf_sdio_isr(sdiodev->bus, true);
 
 	return IRQ_HANDLED;
 }
@@ -85,7 +85,7 @@ static void brcmf_sdiod_ib_irqhandler(st
 
 	brcmf_dbg(INTR, "IB intr triggered\n");
 
-	brcmf_sdio_isr(sdiodev->bus);
+	brcmf_sdio_isr(sdiodev->bus, false);
 }
 
 /* dummy handler for SDIO function 2 interrupt */
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3625,7 +3625,7 @@ void brcmf_sdio_trigger_dpc(struct brcmf
 	}
 }
 
-void brcmf_sdio_isr(struct brcmf_sdio *bus)
+void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr)
 {
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -3636,7 +3636,7 @@ void brcmf_sdio_isr(struct brcmf_sdio *b
 
 	/* Count the interrupt call */
 	bus->sdcnt.intrcount++;
-	if (in_interrupt())
+	if (in_isr)
 		atomic_set(&bus->ipend, 1);
 	else
 		if (brcmf_sdio_intr_rstatus(bus)) {
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -372,7 +372,7 @@ int brcmf_sdiod_remove(struct brcmf_sdio
 
 struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
 void brcmf_sdio_remove(struct brcmf_sdio *bus);
-void brcmf_sdio_isr(struct brcmf_sdio *bus);
+void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr);
 
 void brcmf_sdio_wd_timer(struct brcmf_sdio *bus, bool active);
 void brcmf_sdio_wowl_config(struct device *dev, bool enabled);


