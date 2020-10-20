From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 20 Oct 2020 15:41:28 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <078e659e-d151-5bc2-a7dd-fe0070267cb3@redhat.com>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
 <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
 <20201019111137.GL2628@hirez.programming.kicks-ass.net>
 <20201019140005.GB17287@fuller.cnet>
 <20201020073055.GY2611@hirez.programming.kicks-ass.net>
 <078e659e-d151-5bc2-a7dd-fe0070267cb3@redhat.com>
Message-ID: <20201020134128.GT2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 20, 2020 at 09:00:01AM -0400, Nitesh Narayan Lal wrote:
> 
> On 10/20/20 3:30 AM, Peter Zijlstra wrote:
> > On Mon, Oct 19, 2020 at 11:00:05AM -0300, Marcelo Tosatti wrote:
> >>> So I think it is important to figure out what that driver really wants
> >>> in the nohz_full case. If it wants to retain N interrupts per CPU, and
> >>> only reduce the number of CPUs, the proposed interface is wrong.
> >> It wants N interrupts per non-isolated (AKA housekeeping) CPU.
> > Then the patch is wrong and the interface needs changing from @min_vecs,
> > @max_vecs to something that expresses the N*nr_cpus relation.
> 
> Reading Marcelo's comment again I think what is really expected is 1
> interrupt per non-isolated (housekeeping) CPU (not N interrupts).

Then what is the point of them asking for N*nr_cpus when there is no
isolation?

Either everybody wants 1 interrupts per CPU and we can do the clamp
unconditionally, in which case we should go fix this user, or they want
multiple per cpu and we should go fix the interface.

It cannot be both.
