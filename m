From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Fri, 28 May 2021 15:20:41 +0800
Subject: [Intel-wired-lan] [PATCH] genirq: Provide new interfaces for
 affinity hints
In-Reply-To: <CAFki+LnuharcwJy=x4Z27ixCMK1u2s2cvHh9=Bcf90rO06osEw@mail.gmail.com>
References: <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de>
 <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
 <87zgwo9u79.ffs@nanos.tec.linutronix.de>
 <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
 <YK9ucRrjq+eck/G7@syu-laptop>
 <CAFki+LnuharcwJy=x4Z27ixCMK1u2s2cvHh9=Bcf90rO06osEw@mail.gmail.com>
Message-ID: <YLCZyVXiMfQshpgL@syu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 27, 2021 at 09:06:04AM -0400, Nitesh Lal wrote:
> On Thu, May 27, 2021 at 6:03 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > Hi,
> >
> > On Fri, May 21, 2021 at 02:03:06PM +0200, Thomas Gleixner wrote:
> > > The discussion about removing the side effect of irq_set_affinity_hint() of
> > > actually applying the cpumask (if not NULL) as affinity to the interrupt,
> > > unearthed a few unpleasantries:
> > >
> > >   1) The modular perf drivers rely on the current behaviour for the very
> > >      wrong reasons.
> > >
> > >   2) While none of the other drivers prevents user space from changing
> > >      the affinity, a cursorily inspection shows that there are at least
> > >      expectations in some drivers.
> > >
> > > #1 needs to be cleaned up anyway, so that's not a problem
> > >
> > > #2 might result in subtle regressions especially when irqbalanced (which
> > >    nowadays ignores the affinity hint) is disabled.
> > >
> > > Provide new interfaces:
> > >
> > >   irq_update_affinity_hint() - Only sets the affinity hint pointer
> > >   irq_apply_affinity_hint()  - Set the pointer and apply the affinity to
> > >                              the interrupt
> > >
> > > Make irq_set_affinity_hint() a wrapper around irq_apply_affinity_hint() and
> > > document it to be phased out.
> >
> > Is there recommended way to retrieve the CPU number that the interrupt has
> > affinity?
> >
> > Previously a driver (I'm looking at drivers/net/ethernet/amazon/ena) that
> > uses irq_set_affinity_hint() to spread out IRQ knows the corresponding CPU
> > number since they're using their own spreading scheme. Now, phasing out
> > irq_set_affinity_hint(), and thus relying on request_irq() to spread the
> > load instead, there don't seem to be a easy way to get the CPU number.
> >
> 
> For drivers that don't want to rely on request_irq for spreading and want
> to force their own affinity mask can use irq_set_affinity()

I *do* want the driver to rely on request_irq() for spreading.

It is retrieving effective affinity after request_irq() call that I can't
seem to figure out.


Thanks,
Shung-Hsi

> which is an exported interface now [1] and clearly indicates the purpose
> of the usage.
> 
> As Thomas suggested we are still keeping irq_set_affinity_hint() as a
> wrapper until we make appropriate changes in individual drivers that use
> this API for different reasons. Please feel free to send out a patch
> for this driver once the changes are merged.
> 
> [1] https://lkml.org/lkml/2021/5/18/271
> 
> -- 
> Thanks
> Nitesh
> 

