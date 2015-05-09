From: John Fastabend <john.r.fastabend@intel.com>
Date: Sat, 09 May 2015 11:06:27 -0700
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Allow flow director
 to use entire queue space
In-Reply-To: <554D1794.9020409@redhat.com>
References: <20150508184720.22470.35134.stgit@jrfastab-mobl.amr.corp.intel.com>
 <554D1794.9020409@redhat.com>
Message-ID: <554E4CA3.9020101@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/08/2015 01:07 PM, Alexander Duyck wrote:
> 
> 
> On 05/08/2015 11:47 AM, John Fastabend wrote:
>> Flow director is exported to user space using the ethtool ntuple
>> support. However, currently it only supports steering traffic to a
>> subset of the queues in use by the hardware. This change allows
>> flow director to specify queues that have been assigned to virtual
>> functions or VMDQ pools.
>>
>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> 
> Comments below.  The main thing I see is that this should really be split into two patches since you are doing two very different things here.

Sure and actually I'll likely submit the first patch against the
ethtool first and then do some clarification on the second drop_en
part. As you noted its pretty fragile (ala broke) in its current state.

> 
> - Alex
> 
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   22 ++++++++-----
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   37 +++++++++++++++++++++-
>>   2 files changed, 50 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> index 0f1bff3..ccd661f 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> @@ -2595,16 +2595,18 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>>       struct ixgbe_fdir_filter *input;
>>       union ixgbe_atr_input mask;
>>       int err;
>> +    u8 queue;
>>
>>       if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
>>           return -EOPNOTSUPP;
>>
>> -    /*
>> -     * Don't allow programming if the action is a queue greater than
>> -     * the number of online Rx queues.
>> +    /* ring_cookie can not be larger than the total number of queues in use
>> +     * by the device including the queues aassigned to virtual functions and
>> +     * VMDQ pools.
>>        */
>>       if ((fsp->ring_cookie != RX_CLS_FLOW_DISC) &&
>> -        (fsp->ring_cookie >= adapter->num_rx_queues))
>> +        (fsp->ring_cookie >=
>> +        (adapter->num_rx_queues * (adapter->num_vfs + 1))))
>>           return -EINVAL;
> 
> I'm not sure if I am a fan of the literal interpretation of the
> ring_cookie. The fact is you might be better of creating a logical
> mapping. So for example just use the least significant byte to
> represent the queue, and the next one up to represent the VMDq pool
> with 0 as the default pool (aka PF). That way you can still deal with
> any funky mapping such as the DCB/VMDq combo.

I went back and forth on this. For me this shows how this ethtool
interface is broken. All the structures are embedded in the UAPI and
its just not extensible so it becomes hardware specific. Eventually
I want to propose the flow api work I did as the better alternative.
Because as you know this is going to explode shortly as the parser
becomes programmable and a put a TCAM/SRAM/etc in front of the device.

If I go with a logical mapping users have to know they are working
on an ixgbe device. If I go with the literal mapping they still need
to know its ixgbe and a bit more information to understand the mapping.

So perhaps I'm persuaded now it is slightly better to use a logical
mapping as you say. I'll code it up. 

> 
>>       /* Don't allow indexes to exist outside of available space */
>> @@ -2681,12 +2683,16 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>>       /* apply mask and compute/store hash */
>>       ixgbe_atr_compute_perfect_hash_82599(&input->filter, &mask);
>>
>> +    if (input->action < adapter->num_rx_queues)
>> +        queue = adapter->rx_ring[input->action]->reg_idx;
>> +    else if (input->action == IXGBE_FDIR_DROP_QUEUE)
>> +        queue = IXGBE_FDIR_DROP_QUEUE;
>> +    else
>> +        queue = input->action - adapter->num_rx_queues;
>> +
>>       /* program filters to filter memory */
>>       err = ixgbe_fdir_write_perfect_filter_82599(hw,
>> -                &input->filter, input->sw_idx,
>> -                (input->action == IXGBE_FDIR_DROP_QUEUE) ?
>> -                IXGBE_FDIR_DROP_QUEUE :
>> -                adapter->rx_ring[input->action]->reg_idx);
>> +                &input->filter, input->sw_idx, queue);
>>       if (err)
>>           goto err_out_w_lock;
>>
> 
> Really you should probably do the conversion sooner.  I would convert the value back up where you pull RX_CLS_FLOW_DISC out of the ring cookie.  Also breaking the ring cookie up into a logical queue would allow for the conversion to be much simpler since the lower 8 bits would give you which ring to pull the reg_idx from and the upper 8 would give you which VMDq pool you need to target.
> 
> All of the stuff below here belongs in a separate patch.
> -V-V-V-V-V-V-
> 

And also as you noted broken in all but the most basic case. Must
have been low on coffee when I wrote that block. I'll revisit this
in a follow up patch.

> 
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index ee600b2..23540dd 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -3166,8 +3166,20 @@ static void ixgbe_enable_rx_drop(struct ixgbe_adapter *adapter,
>>       u8 reg_idx = ring->reg_idx;
>>       u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
>>
>> +    pr_info("%s: enable_rx_drop on queue %d\n",
>> +        ixgbe_driver_string, reg_idx);
>>       srrctl |= IXGBE_SRRCTL_DROP_EN;
>> +    IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
>> +}
>> +
>> +static void ixgbe_enable_vf_rx_drop(struct ixgbe_adapter *adapter, u8 reg_idx)
>> +{
>> +    struct ixgbe_hw *hw = &adapter->hw;
>> +    u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
>>
>> +    pr_info("%s: enable_vf_rx_drop on queue %d\n",
>> +        ixgbe_driver_string, reg_idx);
>> +    srrctl |= IXGBE_SRRCTL_DROP_EN;
>>       IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
>>   }
>>
>> @@ -3183,13 +3195,22 @@ static void ixgbe_disable_rx_drop(struct ixgbe_adapter *adapter,
>>       IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
>>   }
>>
> 
> The VF should be using a different register to enable Rx drop, or is
> this meant to be applied to a VMDq pool? For the VF you should be
> using ixgbe_write_qde to force the queue drop enable. The same
> probably applies for VMDq if you are planning to give user space
> access to actual pools at some point.
> 

Well I would like to push VMDq pools into user space but I don't have
a good way to provide DMA protection because VMDQ pools and PF are all
in the same iommu domain. I might need to resurrect a patch I wrote
last year against af_packet that did the validation but I don't have
any free cycles at the moment to do that work. It is interesting though
to get something like this working with some of the qemu interfaces
for zero copy rx.

>> +static void ixgbe_disable_vf_rx_drop(struct ixgbe_adapter *adapter, u8 reg_idx)
>> +{
>> +    struct ixgbe_hw *hw = &adapter->hw;
>> +    u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
>> +
>> +    srrctl &= ~IXGBE_SRRCTL_DROP_EN;
>> +    IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
>> +}
>> +
> 
> The same goes for this spot as well.
> 
>>   #ifdef CONFIG_IXGBE_DCB
>>   void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
>>   #else
>>   static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
>>   #endif
>>   {
>> -    int i;
>> +    int i, j;
>>       bool pfc_en = adapter->dcb_cfg.pfc_mode_enable;
>>
>>       if (adapter->ixgbe_ieee_pfc)
>> @@ -3208,9 +3229,23 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
>>           !(adapter->hw.fc.current_mode & ixgbe_fc_tx_pause) && !pfc_en)) {
>>           for (i = 0; i < adapter->num_rx_queues; i++)
>>               ixgbe_enable_rx_drop(adapter, adapter->rx_ring[i]);
>> +        for (i = 0; i < adapter->num_vfs; i++) {
>> +            for (j = 0; j < adapter->num_rx_queues; j++) {
>> +                u8 q = i * adapter->num_rx_queues + j;
>> +
>> +                ixgbe_enable_vf_rx_drop(adapter, q);
>> +            }
>> +        }
>>       } else {
>>           for (i = 0; i < adapter->num_rx_queues; i++)
>>               ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
>> +        for (i = 0; i < adapter->num_vfs; i++) {
>> +            for (j = 0; j < adapter->num_rx_queues; j++) {
>> +                u8 q = i * adapter->num_rx_queues + j;
>> +
>> +                ixgbe_disable_vf_rx_drop(adapter, q);
>> +            }
>> +        }
>>       }
>>   }
>>
> 
> This logic is just broken.  The fact is the number of queues can be
> controlled via the "ethtool -L" option, so you might get some of the
> VFs but not all of them since there might be something like 4 queues
> per pool, but the PF only has one allocated for use so you only cover
> a quarter of the VF queues.

OK.

> 
> If this is meant to go after VMDq pools I believe the info for those
> exist in the ring_feature[RING_F_VMDQ], not in num_vfs.  Probably
> your best bet would be to review ixgbe_cache_ring_dcb_sriov and
> ixgbe_cache_ring_sriov in order to sort out how to go about getting
> ring counts per pool, and offsets of queues.
> 

At the moment just trying to get VFs, VMDq is a follow on effort.

> Also for SR-IOV we normally always leave the VFs with queue drop
> enable set in order to prevent a failed VM from causing the device to
> hang. You might need to update your code to do something similar for
> VMDq as I am not sure you want to allow user space to stop cleaning a
> queue pair and hang the whole device.
> 

Noted. Thanks for looking at this.

.John

