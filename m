From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Tue, 20 Oct 2020 12:18:23 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <87v9f57zjf.fsf@nanos.tec.linutronix.de>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <87v9f57zjf.fsf@nanos.tec.linutronix.de>
Message-ID: <3bca9eb1-a318-1fc6-9eee-aacc0293a193@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/20/20 10:16 AM, Thomas Gleixner wrote:
> On Mon, Sep 28 2020 at 14:35, Nitesh Narayan Lal wrote:
>>  
>> +	hk_cpus = housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ);
>> +
>> +	/*
>> +	 * If we have isolated CPUs for use by real-time tasks, to keep the
>> +	 * latency overhead to a minimum, device-specific IRQ vectors are moved
>> +	 * to the housekeeping CPUs from the userspace by changing their
>> +	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
>> +	 * running out of IRQ vectors.
>> +	 */
> This is not true for managed interrupts. The interrupts affinity of
> those cannot be changed by user space.

Ah Yes. Perhaps
s/IRQs/non-managed IRQ ?

>
>> +	if (hk_cpus < num_online_cpus()) {
>> +		if (hk_cpus < min_vecs)
>> +			max_vecs = min_vecs;
>> +		else if (hk_cpus < max_vecs)
>> +			max_vecs = hk_cpus;
>> +	}
> So now with that assume a 16 core machine (HT off for simplicity)
>
> 17 Requested interrupts (1 general, 16 queues)
>
> Managed interrupts will allocate
>
>    1  general interrupt which is free movable by user space
>    16 managed interrupts for queues (one per CPU)
>
> This allows the driver to have 16 queues, i.e. one queue per CPU. These
> interrupts are only used when an application on a CPU issues I/O.

Correct.

>
> With the above change this will result
>
>    1  general interrupt which is free movable by user space
>    1  managed interrupts (possible affinity to all 16 CPUs, but routed
>       to housekeeping CPU as long as there is one online)
>
> So the device is now limited to a single queue which also affects the
> housekeeping CPUs because now they have to share a single queue.
>
> With larger machines this gets even worse.

Yes, the change can impact the performance, however, if we don't do that we
may have a latency impact instead. Specifically, on larger systems where
most of the CPUs are isolated as we will definitely fail in moving all of the
IRQs away from the isolated CPUs to the housekeeping.

>
> So no. This needs way more thought for managed interrupts and you cannot
> do that at the PCI layer.

Maybe we should not be doing anything in the case of managed IRQs as they
are anyways pinned to the housekeeping CPUs as long as we have the
'managed_irq' option included in the kernel cmdline.

>  Only the affinity spreading mechanism can do
> the right thing here.

I can definitely explore this further.

However, IMHO we would still need a logic to prevent the devices from
creating excess vectors.

Do you agree?

>
> Thanks,
>
>         tglx
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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201020/c4247b8a/attachment.asc>
