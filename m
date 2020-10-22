From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 23 Oct 2020 00:39:25 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201022122849.GA148426@fuller.cnet>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <87v9f57zjf.fsf@nanos.tec.linutronix.de>
 <3bca9eb1-a318-1fc6-9eee-aacc0293a193@redhat.com>
 <87lfg093fo.fsf@nanos.tec.linutronix.de>
 <877drj72cz.fsf@nanos.tec.linutronix.de>
 <20201022122849.GA148426@fuller.cnet>
Message-ID: <87pn596g2q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 22 2020 at 09:28, Marcelo Tosatti wrote:
> On Wed, Oct 21, 2020 at 10:25:48PM +0200, Thomas Gleixner wrote:
>> The right answer to this is to utilize managed interrupts and have
>> according logic in your network driver to handle CPU hotplug. When a CPU
>> goes down, then the queue which is associated to that CPU is quiesced
>> and the interrupt core shuts down the relevant interrupt instead of
>> moving it to an online CPU (which causes the whole vector exhaustion
>> problem on x86). When the CPU comes online again, then the interrupt is
>> reenabled in the core and the driver reactivates the queue.
>
> Aha... But it would be necessary to do that from userspace (for runtime
> isolate/unisolate).

For anything which uses managed interrupts this is a non-problem and
userspace has absolutely no business with it.

Isolation does not shut down queues, at least not the block multi-queue
ones which are only active when I/O is issued from that isolated CPU.

So transitioning out of isolation requires no action at all.

Transitioning in or changing the housekeeping mask needs some trivial
tweak to handle the case where there is an overlap in the cpuset of a
queue (housekeeping and isolated). This is handled already for setup and
affinity changes, but of course not for runtime isolation mask changes,
but that's a trivial thing to do.

What's more interesting is how to deal with the network problem where
there is no guarantee that the "response" ends up on the same queue as
the "request" which is what the block people rely on. And that problem
is not really an interrupt affinity problem in the first place.

Thanks,

        tglx
