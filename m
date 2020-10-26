From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 26 Oct 2020 23:46:34 +0100
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201026151306.4af991a5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
References: <20201019111137.GL2628@hirez.programming.kicks-ass.net>
 <20201019140005.GB17287@fuller.cnet>
 <20201020073055.GY2611@hirez.programming.kicks-ass.net>
 <078e659e-d151-5bc2-a7dd-fe0070267cb3@redhat.com>
 <20201020134128.GT2628@hirez.programming.kicks-ass.net>
 <6736e643-d4ae-9919-9ae1-a73d5f31463e@redhat.com>
 <260f4191-5b9f-6dc1-9f11-085533ac4f55@redhat.com>
 <20201023085826.GP2611@hirez.programming.kicks-ass.net>
 <9ee77056-ef02-8696-5b96-46007e35ab00@redhat.com>
 <87ft6464jf.fsf@nanos.tec.linutronix.de>
 <20201026173012.GA377978@fuller.cnet>
 <875z6w4xt4.fsf@nanos.tec.linutronix.de>
 <86f8f667-bda6-59c4-91b7-6ba2ef55e3db@intel.com>
 <87v9ew3fzd.fsf@nanos.tec.linutronix.de>
 <85b5f53e-5be2-beea-269a-f70029bea298@intel.com>
 <87lffs3bd6.fsf@nanos.tec.linutronix.de>
 <20201026151306.4af991a5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Message-ID: <878sbs38s5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 26 2020 at 15:13, Jakub Kicinski wrote:
> On Mon, 26 Oct 2020 22:50:45 +0100 Thomas Gleixner wrote:
>> But I still think that for curing that isolation stuff we want at least
>> some information from the driver. Alternative solution would be to grant
>> the allocation of interrupts and queues and have some sysfs knob to shut
>> down queues at runtime. If that shutdown results in releasing the queue
>> interrupt (via free_irq()) then the vector exhaustion problem goes away.
>> 
>> Needs more thought and information (for network oblivious folks like
>> me).
>
> One piece of information that may be useful is that even tho the RX
> packets may be spread semi-randomly the user space can still control
> which queues are included in the mechanism. There is an indirection
> table in the HW which allows to weigh queues differently, or exclude
> selected queues from the spreading. Other mechanisms exist to filter
> flows onto specific queues.
>
> IOW just because a core has an queue/interrupt does not mean that
> interrupt will ever fire, provided its excluded from RSS.
>
> Another piece is that by default we suggest drivers allocate 8 RX
> queues, and online_cpus TX queues. The number of queues can be
> independently controlled via ethtool -L. Drivers which can't support
> separate queues will default to online_cpus queue pairs, and let
> ethtool -L only set the "combined" parameter.
>
> There are drivers which always allocate online_cpus interrupts, 
> and then some of them will go unused if #qs < #cpus.

Thanks for the enlightment.

> My unpopular opinion is that for networking devices all the heuristics
> we may come up with are going to be a dead end.

I agree. Heuristics suck.

> We need an explicit API to allow users placing queues on cores, and
> use managed IRQs for data queues. (I'm assuming that managed IRQs will
> let us reliably map a MSI-X vector to a core :))

Yes, they allow you to do that. That will need some tweaks to theway
they work today (coming from the strict block mq semantics). You also
need to be aware that managed irqs have also strict semantics vs. CPU
hotplug. If the last CPU in the managed affinity set goes down then the
interrupt is shut down by the irq core which means that you need to
quiesce the associated queue before that happens. When the first CPU
comes online again the interrupt is reenabled, so the queue should be
able to handle it or has ensured that the device does not raise one
before it is able to do so.

Thanks,

        tglx
