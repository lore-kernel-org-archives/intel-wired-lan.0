From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 2 Dec 2016 13:48:46 -0800
Subject: [Intel-wired-lan] Question about ixgbe RESET due to lost link
In-Reply-To: <4AF47DE6-A757-4EB0-A31F-48138E12C178@purestorage.com>
References: <8DAE8844-E419-473E-9033-8CB3CAB0D3A5@purestorage.com>
 <CAKgT0UdOoTn77DM_KHkS=tkDW19dxJGrSUv9tn=ZvGy+bR=Dcw@mail.gmail.com>
 <4AF47DE6-A757-4EB0-A31F-48138E12C178@purestorage.com>
Message-ID: <CAKgT0UeieA6wirnTwV+Wj1_jZxvAOVJeugQ-mnkCdt7fWx_Ebg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Dec 1, 2016 at 6:31 PM, Ruslan Nikolaev <ruslan@purestorage.com> wrote:
> Thank you for your response! I still have questions below.
>
>>
>>> While working with ixgbe (PF) and dpdk (VF), I have noticed that sometimes
>>> we get ?Reset adapter? message 'due to lost link with pending Tx work?.
>>>
>>> The problem is that when handling the VF reset message that arrives through
>>> a mailbox (in the corresponding dpdk handler), the link may already be down.
>>> Therefore, we are unable to properly reset the device. While looking at the
>>> ixgbe code, I have noticed that IXGBE_FLAG2_RESET_REQUESTED (in this case,
>>> set in ixgbe_watchdog_flush_tx) is checked in ixgbe_reset_subtask. The
>>> latter will only do anything if the link is not already down.
>>
>> Why can't you properly reset the device?  The PF should have already
>> taken care of resetting the queues when it did the reset itself.  All
>> that should be left to do is for the VF to reinitialize the queues so
>> that they are re-enabled after the reset.
>>
>
> I guess, the problem is that we can stop a device but we are unable to start the device properly (because some registers are unavailable?) Particularly, in the patch for DPDK:
> http://dpdk.org/dev/patchwork/patch/14009/
>
> I see error messages ?Failed to update link.? If I understand correctly, this patch introduced a delay (1000 ms) to make sure that the link is up again. It also checks one register in a busy-wait loop (see comment: "When the PF link is down? VF cannot operate its registers?). But the problem here is that there might be completely arbitrary time between link going down and up again (minutes, hours, etc), so I cannot be sitting in a busy-wait loop like this.

This doesn't sound right to me.  So DPDK is expecting the link to
always be up?  That isn't always going to be the case.  It seems like
DPDK should figure out a way to enable interrupts and wait for the
mailbox notification that the link has come back up.

>>> I guess, my question is why we are setting it when detecting that the link
>>> is down. It is going to be down anyway. Can the actual reset take place when
>>> the link is up again?
>>>
>>> Thank you!
>>
>> The short answer to this is "no".
>>
>> What it all comes down to is that we have to flush the Tx queues when
>> the link goes down to get rid of stale data.  We need to go through
>> and clean out the Tx rings so that the Tx and Rx FIFOs are cleared and
>> ready to go when the link comes back up.  We can't reset the part
>> after link up because by that point the link has already come back up
>> and the stale data is likely already moving through queues.
>
> Ok, I see. What happens if the stale data (Tx) moves through queues and is actually sent. Is that a problem? Why do we need to reset queues? (Sorry if it is a silly question but just trying to understand why we are doing it in the first place.)
>

There ends up being a few different things that could happen depending
on the hardware.  In some cases it can get as bad as Tx hangs or data
corruptions.  Generally you don't want the driver sitting on the
memory in the Tx rings.  You want it to flush the memory and just wait
until the link has come back before we start queuing packets again.
