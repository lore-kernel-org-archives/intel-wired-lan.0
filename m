From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 18 May 2021 02:03:57 +0200
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
References: <20210504092340.00006c61@intel.com>
 <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
Message-ID: <87im3gewlu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 17 2021 at 18:44, Nitesh Lal wrote:
> On Mon, May 17, 2021 at 4:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The hint was added so that userspace has a better understanding where it
>> should place the interrupt. So if irqbalanced ignores it anyway, then
>> what's the point of the hint? IOW, why is it still used drivers?
>>
> Took a quick look at the irqbalance repo and saw the following commit:
>
> dcc411e7bf    remove affinity_hint infrastructure
>
> The commit message mentions that "PJ is redesiging how affinity hinting
> works in the kernel, the future model will just tell us to ignore an IRQ,
> and the kernel will handle placement for us.  As such we can remove the
> affinity_hint recognition entirely".

No idea who PJ is. I really love useful commit messages. Maybe Neil can
shed some light on that.

> This does indicate that apparently, irqbalance moved away from the usage of
> affinity_hint. However, the next question is what was this future
> model?

I might have missed something in the last 5 years, but that's the first
time I hear about someone trying to cleanup that thing.

> I don't know but I can surely look into it if that helps or maybe someone
> here already knows about it?

I CC'ed Neil :)

>> Now there is another aspect to that. What happens if irqbalanced does
>> not run at all and a driver relies on the side effect of the hint
>> setting the initial affinity. Bah...
>>
>
> Right, but if they only rely on this API so that the IRQs are spread across
> all the CPUs then that issue is already resolved and these other drivers
> should not regress because of changing this behavior. Isn't it?

Is that true for all architectures?

>> While none of the drivers (except the perf muck) actually prevents
>> userspace from fiddling with the affinity (via IRQF_NOBALANCING) a
>> deeper inspection shows that they actually might rely on the current
>> behaviour if irqbalanced is disabled. Of course every driver has its own
>> convoluted way to do that and all of those functions are well
>> documented. What a mess.
>>
>> If the hint still serves a purpose then we can provide a variant which
>> solely applies the hint and does not fiddle with the actual affinity,
>> but if the hint is useless anyway then we have a way better option to
>> clean that up.
>>
>
> +1

= 1

Thanks,

        tglx
