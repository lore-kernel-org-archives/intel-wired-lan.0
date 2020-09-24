From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 24 Sep 2020 15:45:35 -0500
Subject: [Intel-wired-lan] [PATCH v2 4/4] PCI: Limit
 pci_alloc_irq_vectors as per housekeeping CPUs
In-Reply-To: <20200923181126.223766-5-nitesh@redhat.com>
Message-ID: <20200924204535.GA2337207@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Possible subject:

  PCI: Limit pci_alloc_irq_vectors() to housekeeping CPUs

On Wed, Sep 23, 2020 at 02:11:26PM -0400, Nitesh Narayan Lal wrote:
> This patch limits the pci_alloc_irq_vectors, max_vecs argument that is
> passed on by the caller based on the housekeeping online CPUs (that are
> meant to perform managed IRQ jobs).
>
> A minimum of the max_vecs passed and housekeeping online CPUs is derived
> to ensure that we don't create excess vectors as that can be problematic
> specifically in an RT environment. In cases where the min_vecs exceeds the
> housekeeping online CPUs, max vecs is restricted based on the min_vecs
> instead. The proposed change is required because for an RT environment
> unwanted IRQs are moved to the housekeeping CPUs from isolated CPUs to
> keep the latency overhead to a minimum. If the number of housekeeping CPUs
> is significantly lower than that of the isolated CPUs we can run into
> failures while moving these IRQs to housekeeping CPUs due to per CPU
> vector limit.

Does this capture enough of the log?

  If we have isolated CPUs dedicated for use by real-time tasks, we
  try to move IRQs to housekeeping CPUs to reduce overhead on the
  isolated CPUs.

  If we allocate too many IRQ vectors, moving them all to housekeeping
  CPUs may exceed per-CPU vector limits.

  When we have isolated CPUs, limit the number of vectors allocated by
  pci_alloc_irq_vectors() to the minimum number required by the
  driver, or to one per housekeeping CPU if that is larger.

> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  include/linux/pci.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 835530605c0d..cf9ca9410213 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -38,6 +38,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/resource_ext.h>
> +#include <linux/sched/isolation.h>
>  #include <uapi/linux/pci.h>
>  
>  #include <linux/pci_ids.h>
> @@ -1797,6 +1798,20 @@ static inline int
>  pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  		      unsigned int max_vecs, unsigned int flags)
>  {
> +	unsigned int hk_cpus = hk_num_online_cpus();
> +
> +	/*
> +	 * For a real-time environment, try to be conservative and at max only
> +	 * ask for the same number of vectors as there are housekeeping online
> +	 * CPUs. In case, the min_vecs requested exceeds the housekeeping
> +	 * online CPUs, restrict the max_vecs based on the min_vecs instead.
> +	 */
> +	if (hk_cpus != num_online_cpus()) {
> +		if (min_vecs > hk_cpus)
> +			max_vecs = min_vecs;
> +		else
> +			max_vecs = min_t(int, max_vecs, hk_cpus);
> +	}

Is the below basically the same?

	/*
	 * If we have isolated CPUs for use by real-time tasks,
	 * minimize overhead on those CPUs by moving IRQs to the
	 * remaining "housekeeping" CPUs.  Limit vector usage to keep
	 * housekeeping CPUs from running out of IRQ vectors.
	 */
	if (housekeeping_cpus < num_online_cpus()) {
		if (housekeeping_cpus < min_vecs)
			max_vecs = min_vecs;
		else if (housekeeping_cpus < max_vecs)
			max_vecs = housekeeping_cpus;
	}

My comment isn't quite right because this patch only limits the number
of vectors; it doesn't actually *move* IRQs to the housekeeping CPUs.
I don't know where the move happens (or maybe you just avoid assigning
IRQs to isolated CPUs, and I don't know how that happens either).

>  	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
>  					      NULL);
>  }
> -- 
> 2.18.2
> 
