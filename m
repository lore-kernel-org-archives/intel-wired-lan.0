From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Thu, 27 May 2021 18:03:29 +0800
Subject: [Intel-wired-lan] [PATCH] genirq: Provide new interfaces for
 affinity hints
In-Reply-To: <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
References: <20210504092340.00006c61@intel.com>
 <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de>
 <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
 <87zgwo9u79.ffs@nanos.tec.linutronix.de>
 <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
Message-ID: <YK9ucRrjq+eck/G7@syu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

On Fri, May 21, 2021 at 02:03:06PM +0200, Thomas Gleixner wrote:
> The discussion about removing the side effect of irq_set_affinity_hint() of
> actually applying the cpumask (if not NULL) as affinity to the interrupt,
> unearthed a few unpleasantries:
> 
>   1) The modular perf drivers rely on the current behaviour for the very
>      wrong reasons.
> 
>   2) While none of the other drivers prevents user space from changing
>      the affinity, a cursorily inspection shows that there are at least
>      expectations in some drivers.
> 
> #1 needs to be cleaned up anyway, so that's not a problem
> 
> #2 might result in subtle regressions especially when irqbalanced (which
>    nowadays ignores the affinity hint) is disabled.
> 
> Provide new interfaces:
> 
>   irq_update_affinity_hint() - Only sets the affinity hint pointer
>   irq_apply_affinity_hint()  - Set the pointer and apply the affinity to
>   			       the interrupt
> 
> Make irq_set_affinity_hint() a wrapper around irq_apply_affinity_hint() and
> document it to be phased out.

Is there recommended way to retrieve the CPU number that the interrupt has
affinity?

Previously a driver (I'm looking at drivers/net/ethernet/amazon/ena) that
uses irq_set_affinity_hint() to spread out IRQ knows the corresponding CPU
number since they're using their own spreading scheme. Now, phasing out
irq_set_affinity_hint(), and thus relying on request_irq() to spread the
load instead, there don't seem to be a easy way to get the CPU number.

In theory the following could work, but including irq.h does not look like a
good idea given that the comment in its explicitly ask not to be included in
generic code.

    #include <linux/irq.h>
    int irq = request_irq(...);
    struct irq_data *data = irq_get_irq_data(irq);
    struct cpumask *mask = irq_data_get_effective_affinity_mask(data);
    int cpu = cpumask_first(mask);

Any suggestions?


Thanks,
Shung-Hsi

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20210501021832.743094-1-jesse.brandeburg at intel.com
> ---
> Applies on:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> ---
>  include/linux/interrupt.h |   41 ++++++++++++++++++++++++++++++++++++++++-
>  kernel/irq/manage.c       |    8 ++++----
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -328,7 +328,46 @@ extern int irq_force_affinity(unsigned i
>  extern int irq_can_set_affinity(unsigned int irq);
>  extern int irq_select_affinity(unsigned int irq);
>  
> -extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
> +extern int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> +				     bool setaffinity);
> +
> +/**
> + * irq_update_affinity_hint - Update the affinity hint
> + * @irq:	Interrupt to update
> + * @cpumask:	cpumask pointer (NULL to clear the hint)
> + *
> + * Updates the affinity hint, but does not change the affinity of the interrupt.
> + */
> +static inline int
> +irq_update_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +	return __irq_apply_affinity_hint(irq, m, true);
> +}
> +
> +/**
> + * irq_apply_affinity_hint - Update the affinity hint and apply the provided
> + *			     cpumask to the interrupt
> + * @irq:	Interrupt to update
> + * @cpumask:	cpumask pointer (NULL to clear the hint)
> + *
> + * Updates the affinity hint and if @cpumask is not NULL it applies it as
> + * the affinity of that interrupt.
> + */
> +static inline int
> +irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +	return __irq_apply_affinity_hint(irq, m, true);
> +}
> +
> +/*
> + * Deprecated. Use irq_update_affinity_hint() or irq_apply_affinity_hint()
> + * instead.
> + */
> +static inline int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +	return irq_apply_affinity_hint(irq, cpumask);
> +}
> +
>  extern int irq_update_affinity_desc(unsigned int irq,
>  				    struct irq_affinity_desc *affinity);
>  
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -487,7 +487,8 @@ int irq_force_affinity(unsigned int irq,
>  }
>  EXPORT_SYMBOL_GPL(irq_force_affinity);
>  
> -int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
> +int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> +			      bool setaffinity)
>  {
>  	unsigned long flags;
>  	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
> @@ -496,12 +497,11 @@ int irq_set_affinity_hint(unsigned int i
>  		return -EINVAL;
>  	desc->affinity_hint = m;
>  	irq_put_desc_unlock(desc, flags);
> -	/* set the initial affinity to prevent every interrupt being on CPU0 */
> -	if (m)
> +	if (m && setaffinity)
>  		__irq_set_affinity(irq, m, false);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
> +EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>  
>  static void irq_affinity_notify(struct work_struct *work)
>  {

