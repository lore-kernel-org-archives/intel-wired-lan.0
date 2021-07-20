From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 20 Jul 2021 12:57:02 +0200
Subject: [Intel-wired-lan] [PATCH v4 01/14] genirq: Provide new
 interfaces for affinity hints
In-Reply-To: <20210719180746.1008665-2-nitesh@redhat.com>
References: <20210719180746.1008665-1-nitesh@redhat.com>
 <20210719180746.1008665-2-nitesh@redhat.com>
Message-ID: <20210720125702.28053dd6@cakuba>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 19 Jul 2021 14:07:33 -0400, Nitesh Narayan Lal wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
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
>   irq_update_affinity_hint()  - Only sets the affinity hint pointer
>   irq_set_affinity_and_hint() - Set the pointer and apply the affinity to
>                                 the interrupt
> 
> Make irq_set_affinity_hint() a wrapper around irq_apply_affinity_hint() and
> document it to be phased out.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> Link: https://lore.kernel.org/r/20210501021832.743094-1-jesse.brandeburg at intel.com

include/linux/interrupt.h:343: warning: Function parameter or member 'm' not described in 'irq_update_affinity_hint'
include/linux/interrupt.h:343: warning: Excess function parameter 'cpumask' description in 'irq_update_affinity_hint'
include/linux/interrupt.h:358: warning: Function parameter or member 'm' not described in 'irq_set_affinity_and_hint'
include/linux/interrupt.h:358: warning: Excess function parameter 'cpumask' description in 'irq_set_affinity_and_hint'
