From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 23 Oct 2020 23:00:52 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <9ee77056-ef02-8696-5b96-46007e35ab00@redhat.com>
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
Message-ID: <87ft6464jf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 23 2020 at 09:10, Nitesh Narayan Lal wrote:
> On 10/23/20 4:58 AM, Peter Zijlstra wrote:
>> On Thu, Oct 22, 2020 at 01:47:14PM -0400, Nitesh Narayan Lal wrote:
>> So shouldn't we then fix the drivers / interface first, to get rid of
>> this inconsistency?
>>
> Considering we agree that excess vector is a problem that needs to be
> solved across all the drivers and that you are comfortable with the other
> three patches in the set. If I may suggest the following:
>
> - We can pick those three patches for now, as that will atleast fix a
> ? driver that is currently impacting RT workloads. Is that a fair
> ? expectation?

No. Blindly reducing the maximum vectors to the number of housekeeping
CPUs is patently wrong. The PCI core _cannot_ just nilly willy decide
what the right number of interrupts for this situation is.

Many of these drivers need more than queue interrupts, admin, error
interrupt and some operate best with seperate RX/TX interrupts per
queue. They all can "work" with a single PCI interrupt of course, but
the price you pay is performance.

An isolated setup, which I'm familiar with, has two housekeeping
CPUs. So far I restricted the number of network queues with a module
argument to two, which allocates two management interrupts for the
device and two interrupts (RX/TX) per queue, i.e. a total of six.

Now I reduced the number of available interrupts to two according to
your hack, which makes it use one queue RX/TX combined and one
management interrupt. Guess what happens? Network performance tanks to
the points that it breaks a carefully crafted setup.

The same applies to a device which is application specific and wants one
channel including an interrupt per isolated application core. Today I
can isolate 8 out of 12 CPUs and let the device create 8 channels and
set one interrupt and channel affine to each isolated CPU. With your
hack, I get only 4 interrupts and channels. Fail!

You cannot declare that all this is perfectly fine, just because it does
not matter for your particular use case.

So without information from the driver which tells what the best number
of interrupts is with a reduced number of CPUs, this cutoff will cause
more problems than it solves. Regressions guaranteed.

Managed interrupts base their interrupt allocation and spreading on
information which is handed in by the individual driver and not on crude
assumptions. They are not imposing restrictions on the use case.

It's perfectly fine for isolated work to save a data set to disk after
computation has finished and that just works with the per-cpu I/O queue
which is otherwise completely silent. All isolated workers can do the
same in parallel without trampling on each other toes by competing for a
reduced number of queues which are affine to the housekeeper CPUs.

Unfortunately network multi-queue is substantially different from block
multi-queue (as I learned in this conversation), so the concept cannot
be applied one-to-one to networking as is. But there are certainly part
of it which can be reused.

This needs a lot more thought than just these crude hacks.

Especially under the aspect that there are talks about making isolation
runtime switchable. Are you going to rmmod/insmod the i40e network
driver to do so? That's going to work fine if you do that
reconfiguration over network...

Thanks,

        tglx
