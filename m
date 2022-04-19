From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 19 Apr 2022 10:03:43 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] Trigger proper interrupts in
 igc_xsk_wakeup
In-Reply-To: <CY4PR16MB002318405355FB6AC87CA0919BF39@CY4PR16MB0023.namprd16.prod.outlook.com>
References: <20220415210546.11294-1-jeff.evanson@qsc.com>
 <87v8v6477g.fsf@intel.com>
 <CY4PR16MB002318405355FB6AC87CA0919BF39@CY4PR16MB0023.namprd16.prod.outlook.com>
Message-ID: <87v8v5t380.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

Jeff Evanson <Jeff.Evanson@qsc.com> writes:

> Hi Vinicius. Thank you for the reply.
>
> The scenario only happens when the transmit queue interrupt is mapped
> to a different interrupt from the receive queue. In the case where
> XDP_WAKEUP_TX is set in the flags argument, the previous code would
> only trigger the interrupt for the receive queue, causing the transmit
> queue's napi_struct to never be scheduled.

This is a good explanation, adding it to the commit message for the v2
would be a good idea.

>
> In the scenario where XDP_WAKEUP_TX and XDP_WAKEUP_RX are both set in
> flags, the receive interrupt is always triggered and the transmit
> interrupt is only triggered when the transmit q_vector differs from
> the receive q_vector.

I missed that condition when I looked at the patch. Sorry about that.
Makes more sense now.

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

>
> Regards,
> Jeff Evanson
>
> -----Original Message-----
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com> 
> Sent: Monday, April 18, 2022 11:45 AM
> To: Jeff Evanson <jeff.evanson@gmail.com>; Jesse Brandeburg <jesse.brandeburg@intel.com>; Tony Nguyen <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: Jeff Evanson <Jeff.Evanson@qsc.com>; jeff.evanson at gmail.com
> Subject: Re: [PATCH 2/2] Trigger proper interrupts in igc_xsk_wakeup
>
> -External-
>
> Jeff Evanson <jeff.evanson@gmail.com> writes:
>
>> in igc_xsk_wakeup, trigger the proper interrupt based on whether flags 
>> contains XDP_WAKEUP_RX and/or XDP_WAKEUP_TX
>>
>> Signed-off-by: Jeff Evanson <jeff.evanson@qsc.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc_main.c | 36 
>> +++++++++++++++++------
>>  1 file changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c 
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index a36a18c84aeb..d706de95dc06 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -6073,7 +6073,7 @@ static void igc_trigger_rxtxq_interrupt(struct 
>> igc_adapter *adapter,  int igc_xsk_wakeup(struct net_device *dev, u32 
>> queue_id, u32 flags)  {
>>  	struct igc_adapter *adapter = netdev_priv(dev);
>> -	struct igc_q_vector *q_vector;
>> +	struct igc_q_vector *txq_vector = 0, *rxq_vector = 0;
>>  	struct igc_ring *ring;
>>  
>>  	if (test_bit(__IGC_DOWN, &adapter->state)) @@ -6082,17 +6082,35 @@ 
>> int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
>>  	if (!igc_xdp_is_enabled(adapter))
>>  		return -ENXIO;
>>  
>> -	if (queue_id >= adapter->num_rx_queues)
>> -		return -EINVAL;
>> +	if (flags & XDP_WAKEUP_RX) {
>> +		if (queue_id >= adapter->num_rx_queues)
>> +			return -EINVAL;
>>  
>> -	ring = adapter->rx_ring[queue_id];
>> +		ring = adapter->rx_ring[queue_id];
>> +		if (!ring->xsk_pool)
>> +			return -ENXIO;
>>  
>> -	if (!ring->xsk_pool)
>> -		return -ENXIO;
>> +		rxq_vector = ring->q_vector;
>> +	}
>> +
>> +	if (flags & XDP_WAKEUP_TX) {
>> +		if (queue_id >= adapter->num_tx_queues)
>> +			return -EINVAL;
>> +
>> +		ring = adapter->tx_ring[queue_id];
>> +		if (!ring->xsk_pool)
>> +			return -ENXIO;
>> +
>> +		txq_vector = ring->q_vector;
>> +	}
>> +
>> +	if (rxq_vector &&
>> +	    !napi_if_scheduled_mark_missed(&rxq_vector->napi))
>> +		igc_trigger_rxtxq_interrupt(adapter, rxq_vector);
>>  
>> -	q_vector = adapter->q_vector[queue_id];
>> -	if (!napi_if_scheduled_mark_missed(&q_vector->napi))
>> -		igc_trigger_rxtxq_interrupt(adapter, q_vector);
>> +	if (txq_vector && txq_vector != rxq_vector &&
>> +	    !napi_if_scheduled_mark_missed(&txq_vector->napi))
>> +		igc_trigger_rxtxq_interrupt(adapter, txq_vector);
>
> Two things:
>  - My imagination was not able to produce a scenario where this commit  would solve any problems. Can you explain better the case where the  current code would cause the wrong interrupt to be generated (or miss  generating an interrupt)? (this should be in the commit message)
>  - I think that with this patch applied, there would cases (both TX and  RX flags set) that we cause two writes into the EICS register. That  could cause unnecessary wakeups.
>
>>  
>>  	return 0;
>>  }
>> --
>> 2.17.1
>>
>
> Cheers,
> -- 
> Vinicius
>

-- 
Vinicius
