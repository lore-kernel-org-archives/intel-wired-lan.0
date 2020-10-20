From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 20 Oct 2020 20:07:23 +0200
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <3bca9eb1-a318-1fc6-9eee-aacc0293a193@redhat.com>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <87v9f57zjf.fsf@nanos.tec.linutronix.de>
 <3bca9eb1-a318-1fc6-9eee-aacc0293a193@redhat.com>
Message-ID: <87lfg093fo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 20 2020 at 12:18, Nitesh Narayan Lal wrote:
> On 10/20/20 10:16 AM, Thomas Gleixner wrote:
>> With the above change this will result
>>
>>    1  general interrupt which is free movable by user space
>>    1  managed interrupts (possible affinity to all 16 CPUs, but routed
>>       to housekeeping CPU as long as there is one online)
>>
>> So the device is now limited to a single queue which also affects the
>> housekeeping CPUs because now they have to share a single queue.
>>
>> With larger machines this gets even worse.
>
> Yes, the change can impact the performance, however, if we don't do that we
> may have a latency impact instead. Specifically, on larger systems where
> most of the CPUs are isolated as we will definitely fail in moving all of the
> IRQs away from the isolated CPUs to the housekeeping.

For non managed interrupts I agree.

>> So no. This needs way more thought for managed interrupts and you cannot
>> do that at the PCI layer.
>
> Maybe we should not be doing anything in the case of managed IRQs as they
> are anyways pinned to the housekeeping CPUs as long as we have the
> 'managed_irq' option included in the kernel cmdline.

Exactly. For the PCI side this vector limiting has to be restricted to
the non managed case.

>>  Only the affinity spreading mechanism can do
>> the right thing here.
>
> I can definitely explore this further.
>
> However, IMHO we would still need a logic to prevent the devices from
> creating excess vectors.

Managed interrupts are preventing exactly that by pinning the interrupts
and queues to one or a set of CPUs, which prevents vector exhaustion on
CPU hotplug.

Non-managed, yes that is and always was a problem. One of the reasons
why managed interrupts exist.

Thanks,

        tglx
