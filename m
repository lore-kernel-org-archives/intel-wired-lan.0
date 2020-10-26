From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 26 Oct 2020 14:57:50 +0100
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <9529ddd0-28f7-fa74-e56f-39de84321a22@redhat.com>
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
 <20201023085826.GP2611@hirez.programming.kicks-ass.net>
 <9ee77056-ef02-8696-5b96-46007e35ab00@redhat.com>
 <87ft6464jf.fsf@nanos.tec.linutronix.de>
 <9529ddd0-28f7-fa74-e56f-39de84321a22@redhat.com>
Message-ID: <878sbt3x9d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 26 2020 at 09:35, Nitesh Narayan Lal wrote:
> On 10/23/20 5:00 PM, Thomas Gleixner wrote:
>> An isolated setup, which I'm familiar with, has two housekeeping
>> CPUs. So far I restricted the number of network queues with a module
>> argument to two, which allocates two management interrupts for the
>> device and two interrupts (RX/TX) per queue, i.e. a total of six.
>
> Does it somehow take num_online_cpus() into consideration while deciding
> the number of interrupts to create?

No, I just tell it to create two queues :)

>> So without information from the driver which tells what the best number
>> of interrupts is with a reduced number of CPUs, this cutoff will cause
>> more problems than it solves. Regressions guaranteed.
>
> Indeed.
> I think one commonality among the drivers at the moment is the usage of
> num_online_cpus() to determine the vectors to create.
>
> So, maybe instead of doing this kind of restrictions in a generic level
> API, it will make more sense to do this on a per-device basis by replacing
> the number of online CPUs with the housekeeping CPUs?
>
> This is what I have done in the i40e patch.
> But that still sounds hackish and will impact the performance.

You want an interface which allows the driver to say:

  I need N interrupts for general management and ideally M interrupts
  per queue.

This is similar to the way drivers tell the core code about their
requirements for managed interrupts for the spreading calculation.

>> Managed interrupts base their interrupt allocation and spreading on
>> information which is handed in by the individual driver and not on crude
>> assumptions. They are not imposing restrictions on the use case.
>
> Right, FWIU it is irq_do_set_affinity that prevents the spreading of
> managed interrupts to isolated CPUs if HK_FLAG_MANAGED_IRQ is enabled,
> isn't?

No. Spreading takes possible CPUs into account. HK_FLAG_MANAGED_IRQ does
not influence spreading at all.

It only handles the case that an interrupt is affine to more than one
CPUs and the resulting affinity mask spawns both housekeeping and
isolated CPUs. It then steers the interrupt to the housekeeping CPUs (as
long as there is one online).

Thanks,

        tglx
