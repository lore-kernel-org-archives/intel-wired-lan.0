From: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 4 May 2021 13:15:22 +0100
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <20210501021832.743094-1-jesse.brandeburg@intel.com>
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
Message-ID: <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2021-05-01 03:18, Jesse Brandeburg wrote:
> It was pointed out by Nitesh that the original work I did in 2014
> to automatically set the interrupt affinity when requesting a
> mask is no longer necessary. The kernel has moved on and no
> longer has the original problem, BUT the original patch
> introduced a subtle bug when booting a system with reserved or
> excluded CPUs. Drivers calling this function with a mask value
> that included a CPU that was currently or in the future
> unavailable would generally not update the hint.
> 
> I'm sure there are a million ways to solve this, but the simplest
> one is to just remove a little code that tries to force the
> affinity, as Nitesh has shown it fixes the bug and doesn't seem
> to introduce immediate side effects.

Unfortunately, I think there are quite a few other drivers now relying 
on this behaviour, since they are really using irq_set_affinity_hint() 
as a proxy for irq_set_affinity(). Partly since the latter isn't 
exported to modules, but also I have a vague memory of it being said 
that it's nice to update the user-visible hint to match when the 
affinity does have to be forced to something specific.

Robin.

> While I'm here, introduce a kernel-doc for the hint function.
> 
> Ref: https://lore.kernel.org/lkml/CAFki+L=_dd+JgAR12_eBPX0kZO2_6=1dGdgkwHE=u=K6chMeLQ at mail.gmail.com/
> Cc: netdev at vger.kernel.org
> Fixes: 4fe7ffb7e17c ("genirq: Fix null pointer reference in irq_set_affinity_hint()")
> Fixes: e2e64a932556 ("genirq: Set initial affinity in irq_set_affinity_hint()")
> Reported-by: Nitesh Lal <nilal@redhat.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> 
> !!! NOTE: Compile tested only, would appreciate feedback
> 
> ---
>   kernel/irq/manage.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index e976c4927b25..a31df64662d5 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -456,6 +456,16 @@ int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
>   	return ret;
>   }
>   
> +/**
> + * 	irq_set_affinity_hint - set the hint for an irq
> + *	@irq:	Interrupt for which to set the hint
> + *	@m:	Mask to indicate which CPUs to suggest for the interrupt, use
> + *		NULL here to indicate to clear the value.
> + *
> + *	Use this function to recommend which CPU should handle the
> + *	interrupt to any userspace that uses /proc/irq/nn/smp_affinity_hint
> + *	in order to align interrupts. Pass NULL as the mask to clear the hint.
> + */
>   int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
>   {
>   	unsigned long flags;
> @@ -465,9 +475,6 @@ int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
>   		return -EINVAL;
>   	desc->affinity_hint = m;
>   	irq_put_desc_unlock(desc, flags);
> -	/* set the initial affinity to prevent every interrupt being on CPU0 */
> -	if (m)
> -		__irq_set_affinity(irq, m, false);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
> 
> base-commit: 765822e1569a37aab5e69736c52d4ad4a289eba6
> 
