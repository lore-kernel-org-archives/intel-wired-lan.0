From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 22 Oct 2020 10:28:02 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201021170224.55aea948@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <87v9f57zjf.fsf@nanos.tec.linutronix.de>
 <3bca9eb1-a318-1fc6-9eee-aacc0293a193@redhat.com>
 <87lfg093fo.fsf@nanos.tec.linutronix.de>
 <877drj72cz.fsf@nanos.tec.linutronix.de>
 <20201021170224.55aea948@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <874kmm7jhp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 21 2020 at 17:02, Jakub Kicinski wrote:
> On Wed, 21 Oct 2020 22:25:48 +0200 Thomas Gleixner wrote:
>> The right answer to this is to utilize managed interrupts and have
>> according logic in your network driver to handle CPU hotplug. When a CPU
>> goes down, then the queue which is associated to that CPU is quiesced
>> and the interrupt core shuts down the relevant interrupt instead of
>> moving it to an online CPU (which causes the whole vector exhaustion
>> problem on x86). When the CPU comes online again, then the interrupt is
>> reenabled in the core and the driver reactivates the queue.
>
> I think Mellanox folks made some forays into managed irqs, but I don't
> remember/can't find the details now.
>
> For networking the locality / queue per core does not always work,
> since the incoming traffic is usually spread based on a hash. Many

That makes it problematic and is fundamentally different from block I/O.

> applications perform better when network processing is done on a small
> subset of CPUs, and application doesn't get interrupted every 100us. 
> So we do need extra user control here.

Ok.

> We have a bit of a uAPI problem since people had grown to depend on
> IRQ == queue == NAPI to configure their systems. "The right way" out
> would be a proper API which allows associating queues with CPUs rather
> than IRQs, then we can use managed IRQs and solve many other problems.
>
> Such new API has been in the works / discussions for a while now.

If there is anything which needs to be done/extended on the irq side
please let me know.

Thanks

        tglx
