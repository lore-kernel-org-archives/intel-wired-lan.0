From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 21 Oct 2020 22:25:48 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <87lfg093fo.fsf@nanos.tec.linutronix.de>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <87v9f57zjf.fsf@nanos.tec.linutronix.de>
 <3bca9eb1-a318-1fc6-9eee-aacc0293a193@redhat.com>
 <87lfg093fo.fsf@nanos.tec.linutronix.de>
Message-ID: <877drj72cz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 20 2020 at 20:07, Thomas Gleixner wrote:
> On Tue, Oct 20 2020 at 12:18, Nitesh Narayan Lal wrote:
>> However, IMHO we would still need a logic to prevent the devices from
>> creating excess vectors.
>
> Managed interrupts are preventing exactly that by pinning the interrupts
> and queues to one or a set of CPUs, which prevents vector exhaustion on
> CPU hotplug.
>
> Non-managed, yes that is and always was a problem. One of the reasons
> why managed interrupts exist.

But why is this only a problem for isolation? The very same problem
exists vs. CPU hotplug and therefore hibernation.

On x86 we have at max. 204 vectors available for device interrupts per
CPU. So assumed the only device interrupt in use is networking then any
machine which has more than 204 network interrupts (queues, aux ...)
active will prevent the machine from hibernation.

Aside of that it's silly to have multiple queues targeted at a single
CPU in case of hotplug. And that's not a theoretical problem.  Some
power management schemes shut down sockets when the utilization of a
system is low enough, e.g. outside of working hours.

The whole point of multi-queue is to have locality so that traffic from
a CPU goes through the CPU local queue. What's the point of having two
or more queues on a CPU in case of hotplug?

The right answer to this is to utilize managed interrupts and have
according logic in your network driver to handle CPU hotplug. When a CPU
goes down, then the queue which is associated to that CPU is quiesced
and the interrupt core shuts down the relevant interrupt instead of
moving it to an online CPU (which causes the whole vector exhaustion
problem on x86). When the CPU comes online again, then the interrupt is
reenabled in the core and the driver reactivates the queue.

Thanks,

        tglx



