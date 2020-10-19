From: Marcelo Tosatti <mtosatti@redhat.com>
Date: Mon, 19 Oct 2020 11:00:05 -0300
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201019111137.GL2628@hirez.programming.kicks-ass.net>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
 <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
 <20201019111137.GL2628@hirez.programming.kicks-ass.net>
Message-ID: <20201019140005.GB17287@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 19, 2020 at 01:11:37PM +0200, Peter Zijlstra wrote:
> On Sun, Oct 18, 2020 at 02:14:46PM -0400, Nitesh Narayan Lal wrote:
> > >> +	hk_cpus = housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ);
> > >> +
> > >> +	/*
> > >> +	 * If we have isolated CPUs for use by real-time tasks, to keep the
> > >> +	 * latency overhead to a minimum, device-specific IRQ vectors are moved
> > >> +	 * to the housekeeping CPUs from the userspace by changing their
> > >> +	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
> > >> +	 * running out of IRQ vectors.
> > >> +	 */
> > >> +	if (hk_cpus < num_online_cpus()) {
> > >> +		if (hk_cpus < min_vecs)
> > >> +			max_vecs = min_vecs;
> > >> +		else if (hk_cpus < max_vecs)
> > >> +			max_vecs = hk_cpus;
> > > is that:
> > >
> > > 		max_vecs = clamp(hk_cpus, min_vecs, max_vecs);
> > 
> > Yes, I think this will do.
> > 
> > >
> > > Also, do we really need to have that conditional on hk_cpus <
> > > num_online_cpus()? That is, why can't we do this unconditionally?
> > 
> > FWIU most of the drivers using this API already restricts the number of
> > vectors based on the num_online_cpus, if we do it unconditionally we can
> > unnecessary duplicate the restriction for cases where we don't have any
> > isolated CPUs.
> 
> unnecessary isn't really a concern here, this is a slow path. What's
> important is code clarity.
> 
> > Also, different driver seems to take different factors into consideration
> > along with num_online_cpus while finding the max_vecs to request, for
> > example in the case of mlx5:
> > MLX5_CAP_GEN(dev, num_ports) * num_online_cpus() +
> > ?????????????? MLX5_EQ_VEC_COMP_BASE
> > 
> > Having hk_cpus < num_online_cpus() helps us ensure that we are only
> > changing the behavior when we have isolated CPUs.
> > 
> > Does that make sense?
> 
> That seems to want to allocate N interrupts per cpu (plus some random
> static amount, which seems weird, but whatever). This patch breaks that.

On purpose. For the isolated CPUs we don't want network device 
interrupts (in this context).

> So I think it is important to figure out what that driver really wants
> in the nohz_full case. If it wants to retain N interrupts per CPU, and
> only reduce the number of CPUs, the proposed interface is wrong.

It wants N interrupts per non-isolated (AKA housekeeping) CPU.
Zero interrupts for isolated interrupts.

> > > And what are the (desired) semantics vs hotplug? Using a cpumask without
> > > excluding hotplug is racy.
> > 
> > The housekeeping_mask should still remain constant, isn't?
> > In any case, I can double check this.
> 
> The goal is very much to have that dynamically configurable.

Yes, but this patch is a fix for customer bug in the old, static on-boot 
isolation CPU configuration.

---

Discussing the dynamic configuration (not this patch!) case:

Would need to enable/disable interrupts for a particular device 
on a per-CPU basis. Such interface does not exist yet.

Perhaps that is what you are looking for when writing "proposed interface
is wrong" Peter? 



