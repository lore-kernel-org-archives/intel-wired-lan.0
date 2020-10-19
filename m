From: Frederic Weisbecker <frederic@kernel.org>
Date: Mon, 19 Oct 2020 16:21:06 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201019111137.GL2628@hirez.programming.kicks-ass.net>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
 <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
 <20201019111137.GL2628@hirez.programming.kicks-ass.net>
Message-ID: <20201019142106.GB34192@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 19, 2020 at 01:11:37PM +0200, Peter Zijlstra wrote:
> > > And what are the (desired) semantics vs hotplug? Using a cpumask without
> > > excluding hotplug is racy.
> > 
> > The housekeeping_mask should still remain constant, isn't?
> > In any case, I can double check this.
> 
> The goal is very much to have that dynamically configurable.

Right but unfortunately we are not there before a little while. And the
existing code in these drivers allocating vectors doesn't even take into
account hotplug as you spotted. So I agreed to let Nitesh fix this issue
on top of the existing code until he can look into providing some infrastructure
for these kind of vectors allocation. The first step would be to consolidate
similar code from other drivers, then maybe handle hotplug and later
dynamic housekeeping.
