From: Vick, Matthew <matthew.vick@intel.com>
Date: Mon, 6 Apr 2015 16:39:38 +0000
Subject: [Intel-wired-lan] [net-next 20/25] fm10k: Add support for ITR
 scaling based on PCIe link speed
In-Reply-To: <55202A91.4080403@gmail.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-20-git-send-email-jeffrey.t.kirsher@intel.com>
 <55202A91.4080403@gmail.com>
Message-ID: <D147FAF6.72258%matthew.vick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/4/15, 11:16 AM, "Alexander Duyck" <alexander.duyck@gmail.com> wrote:

>On 04/03/2015 01:27 PM, Jeff Kirsher wrote:

[...]

>> 
>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h
>>b/drivers/net/ethernet/intel/fm10k/fm10k.h
>> index cc7f442e..feb53c0 100644
>> --- a/drivers/net/ethernet/intel/fm10k/fm10k.h
>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
>> @@ -131,6 +131,7 @@ struct fm10k_ring {
>>  					 * different for DCB and RSS modes
>>  					 */
>>  	u8 qos_pc;			/* priority class of queue */
>> +	u8 itr_scale;			/* throttle scaler based on PCI speed */
>>  	u16 vid;			/* default vlan ID of queue */
>>  	u16 count;			/* amount of descriptors */
>>  
>
>This shouldn't be a part of the ring.  If it is related to the ITR it
>really belongs in the ring container or the q_vector.

Fair enough--I definitely went back and forth on where to put it. I think
I'll put it in the ring container, since the ITR already gets updated
there. It's just mildly annoying during the initialization routines is all.

>> @@ -164,6 +165,9 @@ struct fm10k_ring_container {
>>  #define FM10K_ITR_10K		100	/* 100us */
>>  #define FM10K_ITR_20K		50	/* 50us */
>>  #define FM10K_ITR_ADAPTIVE	0x8000	/* adaptive interrupt moderation
>>flag */
>> +#define FM10K_ITR_SCALE_SMALL	60	/* Constant factor for small frames */
>> +#define FM10K_ITR_SCALE_MEDIUM	50	/* Constant factor for medium frames
>>*/
>> +#define FM10K_ITR_SCALE_LARGE	40	/* Constant factor for large frames */
>>  
>>  #define FM10K_ITR_ENABLE	(FM10K_ITR_AUTOMASK | FM10K_ITR_MASK_CLEAR)
>>  
>
>These values don't make any sense to me, where did they come from?

They were experimental. I'll be the first to admit they probably aren't
perfect, but they're at least a significant improvement.

Do you have some recommendations for interrupt rates at 25G/50G? Depending
on what the targets are, it'd be nice to get these scalars to something we
can shift by instead of divide by.

>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
>>b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
>> index 1e08832..cd2e86a 100644
>> --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
>> @@ -1395,11 +1395,20 @@ static void fm10k_update_itr(struct
>>fm10k_ring_container *ring_container)
>>  	if (avg_wire_size > 3000)
>>  		avg_wire_size = 3000;
>>  
>> -	/* Give a little boost to mid-size frames */
>> -	if ((avg_wire_size > 300) && (avg_wire_size < 1200))
>> -		avg_wire_size /= 3;
>> +	/* Simple throttle rate management based on average wire size,
>> +	 * providing boosts to small and medium packet loads. Divide the
>> +	 * average wire size by a constant factor to calculate the minimum
>>time
>> +	 * until the next interrupt in microseconds.
>> +	 */
>> +	if (avg_wire_size < 300)
>> +		avg_wire_size /= FM10K_ITR_SCALE_SMALL;
>> +	else if ((avg_wire_size >= 300) && (avg_wire_size < 1200))
>> +		avg_wire_size /= FM10K_ITR_SCALE_MEDIUM;
>>  	else
>> -		avg_wire_size /= 2;
>> +		avg_wire_size /= FM10K_ITR_SCALE_LARGE;
>> +
>> +	/* Scale for various PCIe link speeds */
>> +	avg_wire_size /= ring_container->ring->itr_scale;
>>  
>>  	/* write back value and retain adaptive flag */
>>  	ring_container->itr = avg_wire_size | FM10K_ITR_ADAPTIVE;
>
>This seems like all it is doing is maxing out the interrupt rate for all
>cases.  For example, a value of 1514 is reduced to 37.8.  When you use
>that as a usecs value that means the queue is capable of over 26K
>interrupts per second.
>
>The division by itr_scale is a really bad idea.  I would recommend
>replacing it with a shift and you should probably check for the value
>hitting 0.
>
>I suspect you probably aren't seeing much of a penalty because the MSI-X
>interrupt call is pretty cheap, however that is still a pretty high
>interrupt rate compared to past parts.

The interrupt rates are definitely open to suggestion. I tried to maintain
the idea of the original algorithm, which did basically the same thing
(avg_wire_size divided by some scalar), so I'm not seeing what's
significantly different here from that angle.

A shift for the itr_scale is a fair suggestion. I'll incorporate that into
a v2.

I definitely understand that I went with some high interrupt values, but
given the architecture of the device I'd be skeptical about dropping all
the way to 8000int/s.

>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>>b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> index cc527dd..c7c9832 100644
>> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> @@ -532,6 +532,9 @@ static void fm10k_configure_tx_ring(struct
>>fm10k_intfc *interface,
>>  	/* store tail pointer */
>>  	ring->tail = &interface->uc_addr[FM10K_TDT(reg_idx)];
>>  
>> +	/* store ITR scale */
>> +	ring->itr_scale = hw->mac.itr_scale;
>> +
>>  	/* reset ntu and ntc to place SW in sync with hardwdare */
>>  	ring->next_to_clean = 0;
>>  	ring->next_to_use = 0;
>> @@ -638,6 +641,9 @@ static void fm10k_configure_rx_ring(struct
>>fm10k_intfc *interface,
>>  	/* store tail pointer */
>>  	ring->tail = &interface->uc_addr[FM10K_RDT(reg_idx)];
>>  
>> +	/* store ITR scale */
>> +	ring->itr_scale = hw->mac.itr_scale;
>> +
>>  	/* reset ntu and ntc to place SW in sync with hardwdare */
>>  	ring->next_to_clean = 0;
>>  	ring->next_to_use = 0;
>> @@ -824,7 +830,8 @@ static irqreturn_t fm10k_msix_mbx_vf(int
>>__always_unused irq, void *data)
>>  
>>  	/* re-enable mailbox interrupt and indicate 20us delay */
>>  	fm10k_write_reg(hw, FM10K_VFITR(FM10K_MBX_VECTOR),
>> -			FM10K_ITR_ENABLE | FM10K_MBX_INT_DELAY);
>> +			FM10K_ITR_ENABLE | (FM10K_MBX_INT_DELAY /
>> +					    hw->mac.itr_scale));
>>  
>>  	/* service upstream mailbox */
>>  	if (fm10k_mbx_trylock(interface)) {
>> @@ -1007,7 +1014,8 @@ static irqreturn_t fm10k_msix_mbx_pf(int
>>__always_unused irq, void *data)
>>  
>>  	/* re-enable mailbox interrupt and indicate 20us delay */
>>  	fm10k_write_reg(hw, FM10K_ITR(FM10K_MBX_VECTOR),
>> -			FM10K_ITR_ENABLE | FM10K_MBX_INT_DELAY);
>> +			FM10K_ITR_ENABLE | (FM10K_MBX_INT_DELAY /
>> +					    hw->mac.itr_scale));
>>  
>>  	return IRQ_HANDLED;
>>  }
>
>You would be much better off here using the itr_scale as a multiple or a
>shift value rather than doing a divide in an interrupt handler as a
>divide can be quite expensive.

Will fix for v2.

>> @@ -56,6 +59,7 @@ static s32 fm10k_stop_hw_vf(struct fm10k_hw *hw)
>>  		fm10k_write_reg(hw, FM10K_TDBAH(i), bah);
>>  		fm10k_write_reg(hw, FM10K_RDBAL(i), bal);
>>  		fm10k_write_reg(hw, FM10K_RDBAH(i), bah);
>> +		fm10k_write_reg(hw, FM10K_TDLEN(i), tdlen);
>>  	}
>>  
>>  	return 0;
>> @@ -124,9 +128,12 @@ static s32 fm10k_init_hw_vf(struct fm10k_hw *hw)
>>  	/* record maximum queue count */
>>  	hw->mac.max_queues = i;
>>  
>> -	/* fetch default VLAN */
>> +	/* fetch default VLAN and ITR scale */
>>  	hw->mac.default_vid = (fm10k_read_reg(hw, FM10K_TXQCTL(0)) &
>>  			       FM10K_TXQCTL_VID_MASK) >> FM10K_TXQCTL_VID_SHIFT;
>> +	hw->mac.itr_scale = (fm10k_read_reg(hw, FM10K_TDLEN(0)) &
>> +			     FM10K_TDLEN_ITR_SCALE_MASK) >>
>> +			    FM10K_TDLEN_ITR_SCALE_SHIFT;
>>  
>>  	return 0;
>>  }
>> 
>
>This is a good reason to get rid of the divide in favor of a shift.  If
>a VF didn't restore the tdlen value using the stop_hw_vf function then
>you could potentially have one driver load trip up the next and cause a
>divide by 0.

Agreed, and sure enough we have a commit in the works that assumes a
default value if we read zero. I originally went with the divide for
readability's sake, but the shift is probably the better choice, so I'll
send a v2 with that.

If you have some suggestions for an interrupt range, I can look into
incorporating those as well.

Thank you for the review, Alex!

Cheers,
Matthew

