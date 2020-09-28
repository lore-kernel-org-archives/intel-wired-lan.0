From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Sep 2020 11:19:25 +0200
Subject: [Intel-wired-lan] [patch 24/35] net: brcmfmac: Replace
 in_interrupt()
In-Reply-To: <a345ad51-4db7-5e4f-3ff9-f1673c12da99@broadcom.com>
References: <20200927194846.045411263@linutronix.de>
 <20200927194922.245750969@linutronix.de>
 <a345ad51-4db7-5e4f-3ff9-f1673c12da99@broadcom.com>
Message-ID: <CAPDyKFrC2j5S7NrtTRCBga=rttKBp-OZnsEnAEgnXj8zj11p0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 28 Sep 2020 at 09:35, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> + Uffe
>
> On 9/27/2020 9:49 PM, Thomas Gleixner wrote:
> > @@ -85,7 +85,7 @@ static void brcmf_sdiod_ib_irqhandler(st
> >
> >       brcmf_dbg(INTR, "IB intr triggered\n");
> >
> > -     brcmf_sdio_isr(sdiodev->bus);
> > +     brcmf_sdio_isr(sdiodev->bus, false);
> >   }
>
> Hi Uffe,
>
> I assume the above code is okay, but want to confirm. Is the SDIO
> interrupt guaranteed to be on a worker thread?

Correct.

As a matter of fact, the sdio irqs can be delivered through a couple
of different paths. The legacy (scheduled for removal), is from a
dedicated kthread. The more "modern" way is either from the context of
a threaded IRQ handler or via a workqueue.

However, there are also so-called out of band SDIO irqs, typically
routed via a separate GPIO line. This isn't managed by the MMC/SDIO
subsystem, but the SDIO functional driver itself.

Kind regards
Uffe
