From: Marcelo Tosatti <mtosatti@redhat.com>
Date: Mon, 26 Oct 2020 16:11:07 -0300
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <875z6w4xt4.fsf@nanos.tec.linutronix.de>
References: <20201020073055.GY2611@hirez.programming.kicks-ass.net>
 <078e659e-d151-5bc2-a7dd-fe0070267cb3@redhat.com>
 <20201020134128.GT2628@hirez.programming.kicks-ass.net>
 <6736e643-d4ae-9919-9ae1-a73d5f31463e@redhat.com>
 <260f4191-5b9f-6dc1-9f11-085533ac4f55@redhat.com>
 <20201023085826.GP2611@hirez.programming.kicks-ass.net>
 <9ee77056-ef02-8696-5b96-46007e35ab00@redhat.com>
 <87ft6464jf.fsf@nanos.tec.linutronix.de>
 <20201026173012.GA377978@fuller.cnet>
 <875z6w4xt4.fsf@nanos.tec.linutronix.de>
Message-ID: <20201026191107.GA407524@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 26, 2020 at 08:00:39PM +0100, Thomas Gleixner wrote:
> On Mon, Oct 26 2020 at 14:30, Marcelo Tosatti wrote:
> > On Fri, Oct 23, 2020 at 11:00:52PM +0200, Thomas Gleixner wrote:
> >> So without information from the driver which tells what the best number
> >> of interrupts is with a reduced number of CPUs, this cutoff will cause
> >> more problems than it solves. Regressions guaranteed.
> >
> > One might want to move from one interrupt per isolated app core
> > to zero, or vice versa. It seems that "best number of interrupts 
> > is with reduced number of CPUs" information, is therefore in userspace, 
> > not in driver...
> 
> How does userspace know about the driver internals? Number of management
> interrupts, optimal number of interrupts per queue?
> 
> >> Managed interrupts base their interrupt allocation and spreading on
> >> information which is handed in by the individual driver and not on crude
> >> assumptions. They are not imposing restrictions on the use case.
> >> 
> >> It's perfectly fine for isolated work to save a data set to disk after
> >> computation has finished and that just works with the per-cpu I/O queue
> >> which is otherwise completely silent. 
> >
> > Userspace could only change the mask of interrupts which are not 
> > triggered by requests from the local CPU (admin, error, mgmt, etc),
> > to avoid the vector exhaustion problem.
> >
> > However, there is no explicit way for userspace to know that, as far as
> > i know.
> >
> >  130:      34845          0          0          0          0          0          0          0  IR-PCI-MSI 33554433-edge      nvme0q1
> >  131:          0      27062          0          0          0          0          0          0  IR-PCI-MSI 33554434-edge      nvme0q2
> >  132:          0          0      24393          0          0          0          0          0  IR-PCI-MSI 33554435-edge      nvme0q3
> >  133:          0          0          0      24313          0          0          0          0  IR-PCI-MSI 33554436-edge      nvme0q4
> >  134:          0          0          0          0      20608          0          0          0  IR-PCI-MSI 33554437-edge      nvme0q5
> >  135:          0          0          0          0          0      22163          0          0  IR-PCI-MSI 33554438-edge      nvme0q6
> >  136:          0          0          0          0          0          0      23020          0  IR-PCI-MSI 33554439-edge      nvme0q7
> >  137:          0          0          0          0          0          0          0      24285  IR-PCI-MSI 33554440-edge      nvme0q8
> >
> > Can that be retrieved from PCI-MSI information, or drivers
> > have to inform this?
> 
> The driver should use a different name for the admin queues.

Works for me.

Sounds more like a heuristic which can break, so documenting this 
as an "interface" seems appropriate.

