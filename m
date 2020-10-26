From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 26 Oct 2020 14:11:24 -0700
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <87v9ew3fzd.fsf@nanos.tec.linutronix.de>
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
Message-ID: <85b5f53e-5be2-beea-269a-f70029bea298@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 10/26/2020 1:11 PM, Thomas Gleixner wrote:
> On Mon, Oct 26 2020 at 12:21, Jacob Keller wrote:
>> On 10/26/2020 12:00 PM, Thomas Gleixner wrote:
>>> How does userspace know about the driver internals? Number of management
>>> interrupts, optimal number of interrupts per queue?
>>
>> I guess this is the problem solved in part by the queue management work
>> that would make queues a thing that userspace is aware of.
>>
>> Are there drivers which use more than one interrupt per queue? I know
>> drivers have multiple management interrupts.. and I guess some drivers
>> do combined 1 interrupt per pair of Tx/Rx..  It's also plausible to to
>> have multiple queues for one interrupt .. I'm not sure how a single
>> queue with multiple interrupts would work though.
> 
> For block there is always one interrupt per queue. Some Network drivers
> seem to have seperate RX and TX interrupts per queue.
> 
> Thanks,
> 
>         tglx
> 

That's true when thinking of Tx and Rx as a single queue. Another way to
think about it is "one rx queue" and "one tx queue" each with their own
interrupt...

Even if there are devices which force there to be exactly queue pairs,
you could still think of them as separate entities?

Hmm.
