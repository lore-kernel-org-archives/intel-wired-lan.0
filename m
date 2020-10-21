From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Wed, 21 Oct 2020 17:04:01 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <877drj72cz.fsf@nanos.tec.linutronix.de>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <87v9f57zjf.fsf@nanos.tec.linutronix.de>
 <3bca9eb1-a318-1fc6-9eee-aacc0293a193@redhat.com>
 <87lfg093fo.fsf@nanos.tec.linutronix.de>
 <877drj72cz.fsf@nanos.tec.linutronix.de>
Message-ID: <9fa39be6-45ab-01a6-86b0-b077f368f4cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/21/20 4:25 PM, Thomas Gleixner wrote:
> On Tue, Oct 20 2020 at 20:07, Thomas Gleixner wrote:
>> On Tue, Oct 20 2020 at 12:18, Nitesh Narayan Lal wrote:
>>> However, IMHO we would still need a logic to prevent the devices from
>>> creating excess vectors.
>> Managed interrupts are preventing exactly that by pinning the interrupts
>> and queues to one or a set of CPUs, which prevents vector exhaustion on
>> CPU hotplug.
>>
>> Non-managed, yes that is and always was a problem. One of the reasons
>> why managed interrupts exist.
> But why is this only a problem for isolation? The very same problem
> exists vs. CPU hotplug and therefore hibernation.
>
> On x86 we have at max. 204 vectors available for device interrupts per
> CPU. So assumed the only device interrupt in use is networking then any
> machine which has more than 204 network interrupts (queues, aux ...)
> active will prevent the machine from hibernation.

Yes, that is indeed the case.

>
> Aside of that it's silly to have multiple queues targeted at a single
> CPU in case of hotplug. And that's not a theoretical problem.  Some
> power management schemes shut down sockets when the utilization of a
> system is low enough, e.g. outside of working hours.
>
> The whole point of multi-queue is to have locality so that traffic from
> a CPU goes through the CPU local queue. What's the point of having two
> or more queues on a CPU in case of hotplug?
>
> The right answer to this is to utilize managed interrupts and have
> according logic in your network driver to handle CPU hotplug. When a CPU
> goes down, then the queue which is associated to that CPU is quiesced
> and the interrupt core shuts down the relevant interrupt instead of
> moving it to an online CPU (which causes the whole vector exhaustion
> problem on x86). When the CPU comes online again, then the interrupt is
> reenabled in the core and the driver reactivates the queue.

IIRC then i40e does have something like that where it suspends all IRQs
before hibernation and restores them when the CPU is back online.

I am not particularly sure about the other drivers.

This brings me to another discussion that Peter initiated that is to
perform the proposed restriction without any condition for all non-managed
IRQs.

Something on the lines:

+?????? if (!pci_is_managed(dev))
+?????????????? max_vecs = clamp(hk_cpus, min_vecs, max_vecs);


I am not particularly sure about this because I am not sure what kind of
performance penalty this will have on the drivers in general and if
that will be acceptable at all. Any thoughts?

However, this still doesn't solve the generic problem, and an ideal solution
will be something that you suggested.

Will it be sensible to think about having a generic API that can be
consumed by all the drivers and that can do both the things you mentioned?

>
> Thanks,
>
>         tglx
>
>
>
-- 
Thanks
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201021/23faabd1/attachment-0001.asc>
