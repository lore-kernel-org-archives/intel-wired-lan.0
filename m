From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Sun, 18 Oct 2020 14:14:46 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201016122046.GP2611@hirez.programming.kicks-ass.net>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
Message-ID: <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/16/20 8:20 AM, Peter Zijlstra wrote:
> On Mon, Sep 28, 2020 at 02:35:29PM -0400, Nitesh Narayan Lal wrote:
>> If we have isolated CPUs dedicated for use by real-time tasks, we try to
>> move IRQs to housekeeping CPUs from the userspace to reduce latency
>> overhead on the isolated CPUs.
>>
>> If we allocate too many IRQ vectors, moving them all to housekeeping CPUs
>> may exceed per-CPU vector limits.
>>
>> When we have isolated CPUs, limit the number of vectors allocated by
>> pci_alloc_irq_vectors() to the minimum number required by the driver, or
>> to one per housekeeping CPU if that is larger.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
>>  drivers/pci/msi.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 30ae4ffda5c1..8c156867803c 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/of_irq.h>
>> +#include <linux/sched/isolation.h>
>>  
>>  #include "pci.h"
>>  
>> @@ -1191,8 +1192,25 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>  				   struct irq_affinity *affd)
>>  {
>>  	struct irq_affinity msi_default_affd = {0};
>> +	unsigned int hk_cpus;
>>  	int nvecs = -ENOSPC;
>>  
>> +	hk_cpus = housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ);
>> +
>> +	/*
>> +	 * If we have isolated CPUs for use by real-time tasks, to keep the
>> +	 * latency overhead to a minimum, device-specific IRQ vectors are moved
>> +	 * to the housekeeping CPUs from the userspace by changing their
>> +	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
>> +	 * running out of IRQ vectors.
>> +	 */
>> +	if (hk_cpus < num_online_cpus()) {
>> +		if (hk_cpus < min_vecs)
>> +			max_vecs = min_vecs;
>> +		else if (hk_cpus < max_vecs)
>> +			max_vecs = hk_cpus;
> is that:
>
> 		max_vecs = clamp(hk_cpus, min_vecs, max_vecs);

Yes, I think this will do.

>
> Also, do we really need to have that conditional on hk_cpus <
> num_online_cpus()? That is, why can't we do this unconditionally?


FWIU most of the drivers using this API already restricts the number of
vectors based on the num_online_cpus, if we do it unconditionally we can
unnecessary duplicate the restriction for cases where we don't have any
isolated CPUs.

Also, different driver seems to take different factors into consideration
along with num_online_cpus while finding the max_vecs to request, for
example in the case of mlx5:
MLX5_CAP_GEN(dev, num_ports) * num_online_cpus() +
?????????????? MLX5_EQ_VEC_COMP_BASE

Having hk_cpus < num_online_cpus() helps us ensure that we are only
changing the behavior when we have isolated CPUs.

Does that make sense?

>
> And what are the (desired) semantics vs hotplug? Using a cpumask without
> excluding hotplug is racy.

The housekeeping_mask should still remain constant, isn't?
In any case, I can double check this.

>
>> +	}
>> +
>>  	if (flags & PCI_IRQ_AFFINITY) {
>>  		if (!affd)
>>  			affd = &msi_default_affd;
>> -- 
>> 2.18.2
>>
-- 
Thanks
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201018/0e2907a5/attachment-0001.asc>
