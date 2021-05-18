From: Nitesh Lal <nilal@redhat.com>
Date: Mon, 17 May 2021 20:23:05 -0400
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <87im3gewlu.ffs@nanos.tec.linutronix.de>
References: <20210504092340.00006c61@intel.com>
 <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de>
Message-ID: <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 17, 2021 at 8:04 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, May 17 2021 at 18:44, Nitesh Lal wrote:
> > On Mon, May 17, 2021 at 4:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> The hint was added so that userspace has a better understanding where it
> >> should place the interrupt. So if irqbalanced ignores it anyway, then
> >> what's the point of the hint? IOW, why is it still used drivers?
> >>
> > Took a quick look at the irqbalance repo and saw the following commit:
> >
> > dcc411e7bf    remove affinity_hint infrastructure
> >
> > The commit message mentions that "PJ is redesiging how affinity hinting
> > works in the kernel, the future model will just tell us to ignore an IRQ,
> > and the kernel will handle placement for us.  As such we can remove the
> > affinity_hint recognition entirely".
>
> No idea who PJ is. I really love useful commit messages. Maybe Neil can
> shed some light on that.
>
> > This does indicate that apparently, irqbalance moved away from the usage of
> > affinity_hint. However, the next question is what was this future
> > model?
>
> I might have missed something in the last 5 years, but that's the first
> time I hear about someone trying to cleanup that thing.
>
> > I don't know but I can surely look into it if that helps or maybe someone
> > here already knows about it?
>
> I CC'ed Neil :)

Thanks, I have added PJ Waskiewicz as well who I think was referred in
that commit message as PJ.

>
> >> Now there is another aspect to that. What happens if irqbalanced does
> >> not run at all and a driver relies on the side effect of the hint
> >> setting the initial affinity. Bah...
> >>
> >
> > Right, but if they only rely on this API so that the IRQs are spread across
> > all the CPUs then that issue is already resolved and these other drivers
> > should not regress because of changing this behavior. Isn't it?
>
> Is that true for all architectures?

Unfortunately, I don't know and that's probably why we have to be careful.

--
Nitesh

