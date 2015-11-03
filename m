From: Jonathan David <jonathan.david@ni.com>
Date: Tue, 3 Nov 2015 12:05:11 -0600
Subject: [Intel-wired-lan] [RFC] e1000e: Add delays after writing to
 registers
In-Reply-To: <5630FE57.2020901@gmail.com>
References: <1445973917-22624-1-git-send-email-jonathan.david@ni.com>
 <5630FE57.2020901@gmail.com>
Message-ID: <5638F757.9030505@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/28/2015 11:56 AM, Alexander Duyck wrote:
> On 10/27/2015 12:25 PM, Jonathan David wrote:
>> There is a noticeable impact on determinism when a large number of
>> writes are flushed. Writes to the hardware registers are sent across
>> the PCI bus and take a significant amount of time to complete after
>> a flush, which causes high priority tasks (including interrupts) to
>> be delayed. This problem stems from an issue with the PCI bus where
>> a fabric lock is held during I/O buffer drain. This process can be
>> detrimental to real-time systems and is seen whenever a large number
>> of MMIO writes are issued. In the case of the e1000 drivers, when a
>> device is reset several tables (MTA, VLAN, etc) are rewritten,
>> generating enough MMIO writes over PCI for the latency issues to be
>> seen.
>>
>> Adding a delay after long series of writes gives them time to
>> complete (drain the I/O buffer), and for higher priority tasks to
>> run unimpeded.
>>
>> Signed-off-by: Jonathan David <jonathan.david@ni.com>
>
> I don't see this being accepted upstream.  The issue is what you have
> described is a platform issue, but you are trying to fix it by modifying
> a couple NIC drivers.  The fact is you are treating the symptoms here
> rather than the cause.

This is true, unfortunately fixing the root cause of this issue does not 
seem to be possible. It stems from PCI issues that are tied to hardware, 
and I am inquiring to see if there is a better solution.

> The question I would have is if the writes are really the issue or if
> the problem is more related to the operations following the writes.  For
> x86 the MMIO writes don't cause any stall issues until we hit a locked
> transaction, memory barrier, or MMIO read.  I assume you are
> encountering something similar?

Yes, if an MMIO read follows a large amount of MMIO writes (>40), we see 
the CPU stall. We observed a correlation between the number of MMIO 
writes issued and the delay observed before the execution of the local 
timer interrupt.

What is not clear is whether or not there are architectural levers that 
can be pulled to control the IO buffering behavior. For example, being 
able to write-through the IO buffer to pay a penalty up-front rather 
than stacking writes, just to pay it off when the buffer drains.

- JD
