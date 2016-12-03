From: Ruslan Nikolaev <ruslan@purestorage.com>
Date: Fri, 2 Dec 2016 18:03:03 -0800
Subject: [Intel-wired-lan] Question about ixgbe RESET due to lost link
In-Reply-To: <CAKgT0Uc+h_x8fHpZDP5J6kNxyNuymtcnTAzv9Q-hFhyj851+2g@mail.gmail.com>
References: <CAKgT0UeieA6wirnTwV+Wj1_jZxvAOVJeugQ-mnkCdt7fWx_Ebg@mail.gmail.com>
 <FA04B483-9533-4732-9EA5-F2EF7EC3BCDD@purestorage.com>
 <CAKgT0Uc+h_x8fHpZDP5J6kNxyNuymtcnTAzv9Q-hFhyj851+2g@mail.gmail.com>
Message-ID: <AEBBD07E-1E50-40A6-9F74-8DBF30D53589@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks! Do you rely on the mailbox reset notification at all in the ixgbevf? Or is it just resetting it when the link seems to be down? 

Also, do you mean that the reset procedure is completely postponed for VFs (including stopping the corresponding device per DPDK terminology) until after the link comes back up?


>> Thanks! I have one more question below.
>> 
>>> 
>>> 
>>>> Thank you for your response! I still have questions below.
>>>> 
>>>>> 
>>>>>> While working with ixgbe (PF) and dpdk (VF), I have noticed that sometimes
>>>>>> we get ?Reset adapter? message 'due to lost link with pending Tx work?.
>>>>>> 
>>>>>> The problem is that when handling the VF reset message that arrives through
>>>>>> a mailbox (in the corresponding dpdk handler), the link may already be down.
>>>>>> Therefore, we are unable to properly reset the device. While looking at the
>>>>>> ixgbe code, I have noticed that IXGBE_FLAG2_RESET_REQUESTED (in this case,
>>>>>> set in ixgbe_watchdog_flush_tx) is checked in ixgbe_reset_subtask. The
>>>>>> latter will only do anything if the link is not already down.
>>>>> 
>>>>> Why can't you properly reset the device?  The PF should have already
>>>>> taken care of resetting the queues when it did the reset itself.  All
>>>>> that should be left to do is for the VF to reinitialize the queues so
>>>>> that they are re-enabled after the reset.
>>>>> 
>>>> 
>>>> I guess, the problem is that we can stop a device but we are unable to start the device properly (because some registers are unavailable?) Particularly, in the patch for DPDK:
>>>> http://dpdk.org/dev/patchwork/patch/14009/
>>>> 
>>>> I see error messages ?Failed to update link.? If I understand correctly, this patch introduced a delay (1000 ms) to make sure that the link is up again. It also checks one register in a busy-wait loop (see comment: "When the PF link is down? VF cannot operate its registers?). But the problem here is that there might be completely arbitrary time between link going down and up again (minutes, hours, etc), so I cannot be sitting in a busy-wait loop like this.
>>> 
>>> This doesn't sound right to me.  So DPDK is expecting the link to
>>> always be up?  That isn't always going to be the case.  It seems like
>>> DPDK should figure out a way to enable interrupts and wait for the
>>> mailbox notification that the link has come back up.
>>> 
>> 
>> Are you proposing to split reset logic (from the patch) into 2 parts?
>> 1. Always stop the device on the reset adapter notification
>> 2. Start the device on the link up notification or if it is already up
> 
> I can't say for certain as I haven't worked in DPDK all that much.
> However all of our kernel based VF drivers basically work on that kind
> of logic.  They will receive the reset notification but they will wait
> until the link up notification is received before they decide to
> reset.  The trick is we do the reset notifcation based on the call to
> ixgbevf_check_mac_link_vf() instead of just resetting if the link goes
> down.  The PF takes care of the reset on its end if it is resetting
> things due to the link going down, then the VF should reset when the
> link comes back up.  When the link goes down though we need to make
> certain to turn off all the watchdogs and such.
> 
> - Alex

