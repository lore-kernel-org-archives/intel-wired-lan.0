From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 25 Sep 2020 15:23:07 -0500
Subject: [Intel-wired-lan] [PATCH v3 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20200925182654.224004-5-nitesh@redhat.com>
Message-ID: <20200925202307.GA2456332@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 25, 2020 at 02:26:54PM -0400, Nitesh Narayan Lal wrote:
> If we have isolated CPUs dedicated for use by real-time tasks, we try to
> move IRQs to housekeeping CPUs from the userspace to reduce latency
> overhead on the isolated CPUs.
> 
> If we allocate too many IRQ vectors, moving them all to housekeeping CPUs
> may exceed per-CPU vector limits.
> 
> When we have isolated CPUs, limit the number of vectors allocated by
> pci_alloc_irq_vectors() to the minimum number required by the driver, or
> to one per housekeeping CPU if that is larger.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  include/linux/pci.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 835530605c0d..a7b10240b778 100644
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
> @@ -1797,6 +1798,22 @@ static inline int
>  pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  		      unsigned int max_vecs, unsigned int flags)
>  {
> +	unsigned int hk_cpus;
> +
> +	hk_cpus = housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ);

Add blank line here before the block comment.

> +	/*
> +	 * If we have isolated CPUs for use by real-time tasks, to keep the
> +	 * latency overhead to a minimum, device-specific IRQ vectors are moved
> +	 * to the housekeeping CPUs from the userspace by changing their
> +	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
> +	 * running out of IRQ vectors.
> +	 */
> +	if (hk_cpus < num_online_cpus()) {
> +		if (hk_cpus < min_vecs)
> +			max_vecs = min_vecs;
> +		else if (hk_cpus < max_vecs)
> +			max_vecs = hk_cpus;
> +	}

It seems like you'd want to do this inside
pci_alloc_irq_vectors_affinity() since that's an exported interface,
and drivers that use it will bypass the limiting you're doing here.

>  	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
>  					      NULL);
>  }
> -- 
> 2.18.2
> 
