From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 14 May 2015 12:23:12 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbe: Allow flow
 director to use entire queue space
In-Reply-To: <5554E3F3.2090709@intel.com>
References: <20150514163616.14473.66892.stgit@nitbit.x32>
 <5554E1F8.1050704@gmail.com> <5554E3F3.2090709@intel.com>
Message-ID: <5554F620.4090101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/14/2015 11:05 AM, John Fastabend wrote:
> On 05/14/2015 10:57 AM, Alexander Duyck wrote:
>> On 05/14/2015 09:36 AM, John Fastabend wrote:
>>> Flow director is exported to user space using the ethtool ntuple
>>> support. However, currently it only supports steering traffic to a
>>> subset of the queues in use by the hardware. This change allows
>>> flow director to specify queues that have been assigned to virtual
>>> functions by partitioning the ring_cookie into a 8bit vf specifier
>>> followed by 32bit queue index. At the moment we don't have any
>>> ethernet drivers with more than 2^32 queues on a single function
>>> as best I can tell and nor do I expect this to happen anytime
>>> soon. This way the ring_cookie's normal use for specifying a queue
>>> on a specific PCI function continues to work as expected.
>>>
>>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   32 ++++++++++++++++------
>>>    include/uapi/linux/ethtool.h                     |   20 ++++++++++++++
>>>    2 files changed, 43 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>>> index eafa9ec..1bb8ddc 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>>> @@ -2595,18 +2595,35 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>>>        struct ixgbe_fdir_filter *input;
>>>        union ixgbe_atr_input mask;
>>>        int err;
>>> +    u8 ring, vf, queue;
>> Ring should be a u32 since that is the size you are masking it to.
> sure but we would return EINVAL before returning anything > than a u8. But
> I didn't run sparse on this which might complain about it.

How can you check that that when you are masking the value by placing it 
in the u8 before you do the comparison.  It is best just to stick to 
whatever size it is you are using.

>>>        if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
>>>            return -EOPNOTSUPP;
>>>
>>> -    /*
>>> -     * Don't allow programming if the action is a queue greater than
>>> -     * the number of online Rx queues.
>>> +    /* ring_cookie is a masked into a set of queues and ixgbe pools. */
>>> +    ring = ethtool_get_flow_spec_ring(fsp->ring_cookie);
>>> +    vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
>>> +
>>> +    /* The input is validated to ensure the pool is valid and the queue
>>> +     * selection is valid for the specified pool.
>>>         */
>>> -    if ((fsp->ring_cookie != RX_CLS_FLOW_DISC) &&
>>> -        (fsp->ring_cookie >= adapter->num_rx_queues))
>>> +    if (!vf &&
>>> +        (ring != RX_CLS_FLOW_DISC) &&
>>> +        (ring >= adapter->num_rx_queues))
>>> +        return -EINVAL;
>>> +
>> The ring is a masked value so it will never be equal to RX_CLS_FLOW_DISC.  You should probably move the if statement for RX_CLS_FLOW_DISC to somewhere before you pull out the ring and VF.
> yep. Will need to fix it.
>
>>> +    if (vf &&
>>> +        ((vf > adapter->num_vfs) ||
>>> +          ring >= adapter->num_rx_queues_per_pool))
>>>            return -EINVAL;
>>>
>> You might want to consider rearranging these if statements.  You could probably save yourself a step by just defaulting the values for dropping packets on the PF.
> sure.
>
>>> +    if (ring == IXGBE_FDIR_DROP_QUEUE)
>>> +        queue = IXGBE_FDIR_DROP_QUEUE;
>>> +    else if (!vf)
>>> +        queue = adapter->rx_ring[ring]->reg_idx;
>>> +    else
>>> +        queue = ((vf - 1) * adapter->num_rx_queues_per_pool) + ring;
>>> +
>>>        /* Don't allow indexes to exist outside of available space */
>>>        if (fsp->location >= ((1024 << adapter->fdir_pballoc) - 2)) {
>>>            e_err(drv, "Location out of range\n");
>> This will need to be tested for queues outside of what the VF is actually using to verify that the frames are just harmlessly dropped if they are not used.
> Yes of course I believe this is fine but I'll double check.
>
>>> @@ -2683,10 +2700,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>>>
>>>        /* program filters to filter memory */
>>>        err = ixgbe_fdir_write_perfect_filter_82599(hw,
>>> -                &input->filter, input->sw_idx,
>>> -                (input->action == IXGBE_FDIR_DROP_QUEUE) ?
>>> -                IXGBE_FDIR_DROP_QUEUE :
>>> -                adapter->rx_ring[input->action]->reg_idx);
>>> +                &input->filter, input->sw_idx, queue);
>>>        if (err)
>>>            goto err_out_w_lock;
>>>
>> All of the code below this point should really be a separate patch.
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> Really? I think it is likely fine to have this all in one patch.

The general idea is that you don't want to tie driver changes that 
closely to API changes.  It makes it easier for those of us that are 
stuck doing things like backporting functionality into stable kernels.  
So if for example another vendor decides to make use of the same 
functionality you don't necessarily have to backport changes to ixgbe in 
order to get the flow spec changes.

>
>>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
>>> index 2e49fc8..ecc658d 100644
>>> --- a/include/uapi/linux/ethtool.h
>>> +++ b/include/uapi/linux/ethtool.h
>>> @@ -796,6 +796,26 @@ struct ethtool_rx_flow_spec {
>>>        __u32        location;
>>>    };
>>>
>>> +/* How rings are layed out when accessing virtual functions or
>>> + * offloaded queues is device specific. To allow users to flow
>>> + * steering and specify these queues though break the ring cookie
>>> + * into a 32bit queue index with an 8 bit virtual function id.
>>> + * This also leaves the 3bytes for further specifiers.
>>> + */
>>> +#define ETHTOOL_RX_FLOW_SPEC_RING    0x00000000FFFFFFFF
>> The question I would have about this is do we really need to support 4.3 billion rings, or should we maybe look at conserving some space by cutting this down to something like 24 or 16 bits?  I guess the question comes down to how many queues do we ever expect a single function to support?
>>
> We can always find holes later. Anyways if its larger than 2^32 the net_device
> will break.

For now I would say 2^32 is fine since that is the upper limit on the 
netdev struct.  My concern is user-space lock in.  Once an API is set it 
is locked that is why I want to make sure we have covered all 
conceivable cases.

>
>>> +#define ETHTOOL_RX_FLOW_SPEC_RING_VF    0x000000FF00000000
>>> +#define ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF 32
>> I'd say 256 is probably a bit low for the upper limit on VFs.  I know PCIe w/ ARI technically allows a 16b requester ID so you should probably bump this up to 16 bits.
> Technically yes, but do you know of any ethernet devices that support this? I
> couldn't find any.

I'm not thinking necessarily about right now, but what we might be asked 
to do.  I'm also thinking about user-space lock in again.  So for now 
with most of the market at only 10Gb/s we see an upper limit of 
something like 64 VFs, however when there is 100Gb/s who is to say that 
this won't be increased to something like 256 or 512.  At a minimum we 
probably want at least 12 bits since that will cover up to 4096 
functions which would require at least 16 busses worth of requester ID 
space.


