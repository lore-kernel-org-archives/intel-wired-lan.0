From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 23 Oct 2020 10:58:26 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <260f4191-5b9f-6dc1-9f11-085533ac4f55@redhat.com>
References: <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
 <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
 <20201019111137.GL2628@hirez.programming.kicks-ass.net>
 <20201019140005.GB17287@fuller.cnet>
 <20201020073055.GY2611@hirez.programming.kicks-ass.net>
 <078e659e-d151-5bc2-a7dd-fe0070267cb3@redhat.com>
 <20201020134128.GT2628@hirez.programming.kicks-ass.net>
 <6736e643-d4ae-9919-9ae1-a73d5f31463e@redhat.com>
 <260f4191-5b9f-6dc1-9f11-085533ac4f55@redhat.com>
Message-ID: <20201023085826.GP2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 22, 2020 at 01:47:14PM -0400, Nitesh Narayan Lal wrote:

> Hi Peter,
> 
> So based on the suggestions from you and Thomas, I think something like the
> following should do the job within pci_alloc_irq_vectors_affinity():
> 
> + ? ? ? if (!pci_is_managed(dev) && (hk_cpus < num_online_cpus()))
> + ? ? ? ? ? ? ? max_vecs = clamp(hk_cpus, min_vecs, max_vecs);
> 
> I do know that you didn't like the usage of "hk_cpus < num_online_cpus()"
> and to an extent I agree that it does degrade the code clarity.

It's not just code clarity; I simply don't understand it. It feels like
a band-aid that breaks thing.

At the very least it needs a ginormous (and coherent) comment that
explains:

 - the interface
 - the usage
 - this hack

> However, since there is a certain inconsistency in the number of vectors
> that drivers request through this API IMHO we will need this, otherwise
> we could cause an impact on the drivers even in setups that doesn't
> have any isolated CPUs.

So shouldn't we then fix the drivers / interface first, to get rid of
this inconsistency?

> If you agree, I can send the next version of the patch-set.

Well, it's not just me you have to convince.
