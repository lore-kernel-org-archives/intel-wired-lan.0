From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 27 Oct 2020 15:28:16 +0100
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <586e249a-1078-9fe9-22d4-b3c1ec0a3a5e@intel.com>
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
 <959997ee-f393-bab0-45c0-4144c37b9185@redhat.com>
 <875z6w38n4.fsf@nanos.tec.linutronix.de>
 <586e249a-1078-9fe9-22d4-b3c1ec0a3a5e@intel.com>
Message-ID: <87mu07216n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 26 2020 at 16:08, Jacob Keller wrote:
> On 10/26/2020 3:49 PM, Thomas Gleixner wrote:
>> On Mon, Oct 26 2020 at 18:22, Nitesh Narayan Lal wrote:
>>> I don't think there is currently a way to control the enablement/disablement of
>>> interrupts from the userspace.
>> 
>> You cannot just disable the interrupt. You need to make sure that the
>> associated queue is shutdown or quiesced _before_ the interrupt is shut
>> down.
>
> Could this be handled with a callback to the driver/hw? I know Intel HW
> should support this type of quiesce/shutdown.

We can't have a callback from the interrupt shutdown code as you have to
wait for the queue to drain packets in flight. Something like this

     mark queue as going down (no more tx queueing)
     tell hardware not to route RX packets to it
     consume pending RX
     wait for already queued TX packets to be sent

Look what the block people did. They have a common multi-instance
hotplug state and they register each context (queue) as an instance. The
hotplug core invokes the corresponding callbacks when bringing a CPU up
or when shutting it down.

Thanks,

        tglx


