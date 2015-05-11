From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 11 May 2015 10:09:01 -0700
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Allow flow director
 to use entire queue space
In-Reply-To: <554E6950.9030402@gmail.com>
References: <20150508184720.22470.35134.stgit@jrfastab-mobl.amr.corp.intel.com>
 <554D1794.9020409@redhat.com> <554E4CA3.9020101@intel.com>
 <554E6950.9030402@gmail.com>
Message-ID: <5550E22D.5030003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/09/2015 01:08 PM, Alexander Duyck wrote:
> On 05/09/2015 11:06 AM, John Fastabend wrote:
>> On 05/08/2015 01:07 PM, Alexander Duyck wrote:
>>>
>>> On 05/08/2015 11:47 AM, John Fastabend wrote:
>>>> Flow director is exported to user space using the ethtool ntuple
>>>> support. However, currently it only supports steering traffic to a
>>>> subset of the queues in use by the hardware. This change allows
>>>> flow director to specify queues that have been assigned to virtual
>>>> functions or VMDQ pools.
>>>>
>>>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>>> Comments below.  The main thing I see is that this should really be
>>> split into two patches since you are doing two very different things
>>> here.
>> Sure and actually I'll likely submit the first patch against the
>> ethtool first and then do some clarification on the second drop_en
>> part. As you noted its pretty fragile (ala broke) in its current state.
>>
>>> - Alex
>>>
>>>> ---
>>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   22
>>>> ++++++++-----
>>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   37
>>>> +++++++++++++++++++++-
>>>>    2 files changed, 50 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>>>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>>>> index 0f1bff3..ccd661f 100644
>>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>>>> @@ -2595,16 +2595,18 @@ static int
>>>> ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>>>>        struct ixgbe_fdir_filter *input;
>>>>        union ixgbe_atr_input mask;
>>>>        int err;
>>>> +    u8 queue;
>>>>
>>>>        if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
>>>>            return -EOPNOTSUPP;
>>>>
>>>> -    /*
>>>> -     * Don't allow programming if the action is a queue greater than
>>>> -     * the number of online Rx queues.
>>>> +    /* ring_cookie can not be larger than the total number of
>>>> queues in use
>>>> +     * by the device including the queues aassigned to virtual
>>>> functions and
>>>> +     * VMDQ pools.
>>>>         */
>>>>        if ((fsp->ring_cookie != RX_CLS_FLOW_DISC) &&
>>>> -        (fsp->ring_cookie >= adapter->num_rx_queues))
>>>> +        (fsp->ring_cookie >=
>>>> +        (adapter->num_rx_queues * (adapter->num_vfs + 1))))
>>>>            return -EINVAL;
>>> I'm not sure if I am a fan of the literal interpretation of the
>>> ring_cookie. The fact is you might be better of creating a logical
>>> mapping. So for example just use the least significant byte to
>>> represent the queue, and the next one up to represent the VMDq pool
>>> with 0 as the default pool (aka PF). That way you can still deal with
>>> any funky mapping such as the DCB/VMDq combo.
>> I went back and forth on this. For me this shows how this ethtool
>> interface is broken. All the structures are embedded in the UAPI and
>> its just not extensible so it becomes hardware specific. Eventually
>> I want to propose the flow api work I did as the better alternative.
>> Because as you know this is going to explode shortly as the parser
>> becomes programmable and a put a TCAM/SRAM/etc in front of the device.
>>
>> If I go with a logical mapping users have to know they are working
>> on an ixgbe device. If I go with the literal mapping they still need
>> to know its ixgbe and a bit more information to understand the mapping.
>>
>> So perhaps I'm persuaded now it is slightly better to use a logical
>> mapping as you say. I'll code it up.
>
> If nothing else you might look at cleaning up the definition of a
> ring_cookie.  As far as I know the value only has two meanings on most
> NICs, it is either ~0 which indicates discard or it is the ring.  The
> thing is the ring_cookie is a u64 if I recall.  I highly doubt we need
> to worry about more than 4B rings so we could probably look at making
> the ring_cookie some sort of union with the first few most significant
> bits being some sort of flag for the type of value contained in the cookie.
>

Actually in ixgbe it can't be larger than 127 which is the special
drop ring IXGBE_FDIR_DROP_QUEUE.

But really (maybe just repeating myself) we shouldn't have to think this
hard to work around the interface. And even if we manage to make it
work for this case we are quickly going to have others. I would much
rather spend my time working out an extensible interface that is usable
vs figuring out how to be clever and use the existing API. Ethtool
should only be used for provisioning @ init time using it as a runtime
interface doesn't work. My biggest gripe is its not extensible and
doesn't support multicast events. But this is off-topic.

[...]

>>>> @@ -3183,13 +3195,22 @@ static void ixgbe_disable_rx_drop(struct
>>>> ixgbe_adapter *adapter,
>>>>        IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
>>>>    }
>>>>
>>> The VF should be using a different register to enable Rx drop, or is
>>> this meant to be applied to a VMDq pool? For the VF you should be
>>> using ixgbe_write_qde to force the queue drop enable. The same
>>> probably applies for VMDq if you are planning to give user space
>>> access to actual pools at some point.
>>>
>> Well I would like to push VMDq pools into user space but I don't have
>> a good way to provide DMA protection because VMDQ pools and PF are all
>> in the same iommu domain. I might need to resurrect a patch I wrote
>> last year against af_packet that did the validation but I don't have
>> any free cycles at the moment to do that work. It is interesting though
>> to get something like this working with some of the qemu interfaces
>> for zero copy rx.
>
> The point I was trying to get at was that you may not want to toggle the
> VF or VMDq pools at all.  In the case of SR-IOV it was a design decision
> to always leave the PFQDE bits configured to force the VF rings to drop
> if no descriptors were available.  Otherwise they can cause head of line
> blocking and force the NIC to reset.
>

Yes, this is a good to remember. Perhaps spending too much time working
with trusted VMs these days.

>>
>>>> +static void ixgbe_disable_vf_rx_drop(struct ixgbe_adapter *adapter,
>>>> u8 reg_idx)
>>>> +{
>>>> +    struct ixgbe_hw *hw = &adapter->hw;
>>>> +    u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
>>>> +
>>>> +    srrctl &= ~IXGBE_SRRCTL_DROP_EN;
>>>> +    IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
>>>> +}

[...]

>>>
>> Noted. Thanks for looking at this.
>>
>> .John
>
> No problem.

I'll send out a v2 once I get it tested.

>
> - Alex
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan


-- 
John Fastabend         Intel Corporation
