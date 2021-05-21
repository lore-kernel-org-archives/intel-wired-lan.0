From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 21 May 2021 23:45:14 +0200
Subject: [Intel-wired-lan] [PATCH] genirq: Provide new interfaces for
 affinity hints
In-Reply-To: <CAOhMmr6p2a=Dgz3Q=cbEoXJjbBjBdJm1Vwt60Si+JDCdbOEVaw@mail.gmail.com>
References: <20210504092340.00006c61@intel.com>
 <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de>
 <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
 <87zgwo9u79.ffs@nanos.tec.linutronix.de>
 <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
 <CAOhMmr6p2a=Dgz3Q=cbEoXJjbBjBdJm1Vwt60Si+JDCdbOEVaw@mail.gmail.com>
Message-ID: <87eedzahhx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 21 2021 at 10:45, Lijun Pan wrote:
> On Fri, May 21, 2021 at 7:48 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> +/**
>> + * irq_update_affinity_hint - Update the affinity hint
>> + * @irq:       Interrupt to update
>> + * @cpumask:   cpumask pointer (NULL to clear the hint)
>> + *
>> + * Updates the affinity hint, but does not change the affinity of the interrupt.
>> + */
>> +static inline int
>> +irq_update_affinity_hint(unsigned int irq, const struct cpumask *m)
>> +{
>> +       return __irq_apply_affinity_hint(irq, m, true);
>> +}
>
> Should it be:
> return __irq_apply_affinity_hint(irq, m, false);
> here?

Of course. Copy & Pasta should be forbidden.

Thanks for spotting it!

       tglx
