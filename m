From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Mon, 26 Oct 2020 18:22:29 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <87lffs3bd6.fsf@nanos.tec.linutronix.de>
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
Message-ID: <959997ee-f393-bab0-45c0-4144c37b9185@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/26/20 5:50 PM, Thomas Gleixner wrote:
> On Mon, Oct 26 2020 at 14:11, Jacob Keller wrote:
>> On 10/26/2020 1:11 PM, Thomas Gleixner wrote:
>>> On Mon, Oct 26 2020 at 12:21, Jacob Keller wrote:
>>>> Are there drivers which use more than one interrupt per queue? I know
>>>> drivers have multiple management interrupts.. and I guess some drivers
>>>> do combined 1 interrupt per pair of Tx/Rx..  It's also plausible to to
>>>> have multiple queues for one interrupt .. I'm not sure how a single
>>>> queue with multiple interrupts would work though.
>>> For block there is always one interrupt per queue. Some Network drivers
>>> seem to have seperate RX and TX interrupts per queue.
>> That's true when thinking of Tx and Rx as a single queue. Another way to
>> think about it is "one rx queue" and "one tx queue" each with their own
>> interrupt...
>>
>> Even if there are devices which force there to be exactly queue pairs,
>> you could still think of them as separate entities?
> Interesting thought.
>
> But as Jakub explained networking queues are fundamentally different
> from block queues on the RX side. For block the request issued on queue
> X will raise the complete interrupt on queue X.
>
> For networking the TX side will raise the TX interrupt on the queue on
> which the packet was queued obviously or should I say hopefully. :)

This is my impression as well.

> But incoming packets will be directed to some receive queue based on a
> hash or whatever crystallball logic the firmware decided to implement.
>
> Which makes this not really suitable for the managed interrupt and
> spreading approach which is used by block-mq. Hrm...
>
> But I still think that for curing that isolation stuff we want at least
> some information from the driver. Alternative solution would be to grant
> the allocation of interrupts and queues and have some sysfs knob to shut
> down queues at runtime. If that shutdown results in releasing the queue
> interrupt (via free_irq()) then the vector exhaustion problem goes away.

I think this is close to what I and Marcelo were discussing earlier today
privately.

I don't think there is currently a way to control the enablement/disablement of
interrupts from the userspace.

I think in terms of the idea we need something similar to what i40e does,
that is shutdown all IRQs when CPU is suspended and restores the interrupt
schema when the CPU is back online.

The two key difference will be that this API needs to be generic and also
needs to be exposed to the userspace through something like sysfs as you
have mentioned.

-- 
Thanks
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201026/25b2a722/attachment.asc>
