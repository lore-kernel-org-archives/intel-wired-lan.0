From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Aug 2019 14:00:16 +0300
Subject: [Intel-wired-lan] [PATCH net v3] ixgbe: fix double clean of tx
 descriptors with xdp
In-Reply-To: <20190826154042.00004bfc@gmail.com>
References: <CGME20190822171243eucas1p12213f2239d6c36be515dade41ed7470b@eucas1p1.samsung.com>
 <20190822171237.20798-1-i.maximets@samsung.com>
 <20190826154042.00004bfc@gmail.com>
Message-ID: <3d93da21-0198-2fff-fbbf-3c02c5155f25@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26.08.2019 16:40, Maciej Fijalkowski wrote:
> On Thu, 22 Aug 2019 20:12:37 +0300
> Ilya Maximets <i.maximets@samsung.com> wrote:
> 
>> Tx code doesn't clear the descriptors' status after cleaning.
>> So, if the budget is larger than number of used elems in a ring, some
>> descriptors will be accounted twice and xsk_umem_complete_tx will move
>> prod_tail far beyond the prod_head breaking the completion queue ring.
>>
>> Fix that by limiting the number of descriptors to clean by the number
>> of used descriptors in the tx ring.
>>
>> 'ixgbe_clean_xdp_tx_irq()' function refactored to look more like
>> 'ixgbe_xsk_clean_tx_ring()' since we're allowed to directly use
>> 'next_to_clean' and 'next_to_use' indexes.
>>
>> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>> ---
>>
>> Version 3:
>>   * Reverted some refactoring made for v2.
>>   * Eliminated 'budget' for tx clean.
>>   * prefetch returned.
>>
>> Version 2:
>>   * 'ixgbe_clean_xdp_tx_irq()' refactored to look more like
>>     'ixgbe_xsk_clean_tx_ring()'.
>>
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 29 ++++++++------------
>>  1 file changed, 11 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>> index 6b609553329f..a3b6d8c89127 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>> @@ -633,19 +633,17 @@ static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
>>  bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
>>  			    struct ixgbe_ring *tx_ring, int napi_budget)
> 
> While you're at it, can you please as well remove the 'napi_budget' argument?
> It wasn't used at all even before your patch.

As you mentioned, this is not related to current patch and this patch doesn't
touch these particular lines of code.  So, I think it's better to make a
separate patch for this if you think it's needed.

> 
> I'm jumping late in, but I was really wondering and hesitated with taking
> part in discussion since the v1 of this patch - can you elaborate why simply
> clearing the DD bit wasn't sufficient?

Clearing the DD bit will end up driver and hardware writing to close memory
locations at the same time leading to cache trashing and poor performance.

Anyway additional write is unnecessary, because we know exactly which descriptors
we need to check.

Best regards, Ilya Maximets.

> 
> Maciej
> 
>>  {
>> +	u16 ntc = tx_ring->next_to_clean, ntu = tx_ring->next_to_use;
>>  	unsigned int total_packets = 0, total_bytes = 0;
>> -	u32 i = tx_ring->next_to_clean, xsk_frames = 0;
>> -	unsigned int budget = q_vector->tx.work_limit;
>>  	struct xdp_umem *umem = tx_ring->xsk_umem;
>>  	union ixgbe_adv_tx_desc *tx_desc;
>>  	struct ixgbe_tx_buffer *tx_bi;
>> -	bool xmit_done;
>> +	u32 xsk_frames = 0;
>>  
>> -	tx_bi = &tx_ring->tx_buffer_info[i];
>> -	tx_desc = IXGBE_TX_DESC(tx_ring, i);
>> -	i -= tx_ring->count;
>> +	tx_bi = &tx_ring->tx_buffer_info[ntc];
>> +	tx_desc = IXGBE_TX_DESC(tx_ring, ntc);
>>  
>> -	do {
>> +	while (ntc != ntu) {
>>  		if (!(tx_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
>>  			break;
>>  
>> @@ -661,22 +659,18 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
>>  
>>  		tx_bi++;
>>  		tx_desc++;
>> -		i++;
>> -		if (unlikely(!i)) {
>> -			i -= tx_ring->count;
>> +		ntc++;
>> +		if (unlikely(ntc == tx_ring->count)) {
>> +			ntc = 0;
>>  			tx_bi = tx_ring->tx_buffer_info;
>>  			tx_desc = IXGBE_TX_DESC(tx_ring, 0);
>>  		}
>>  
>>  		/* issue prefetch for next Tx descriptor */
>>  		prefetch(tx_desc);
>> +	}
>>  
>> -		/* update budget accounting */
>> -		budget--;
>> -	} while (likely(budget));
>> -
>> -	i += tx_ring->count;
>> -	tx_ring->next_to_clean = i;
>> +	tx_ring->next_to_clean = ntc;
>>  
>>  	u64_stats_update_begin(&tx_ring->syncp);
>>  	tx_ring->stats.bytes += total_bytes;
>> @@ -688,8 +682,7 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
>>  	if (xsk_frames)
>>  		xsk_umem_complete_tx(umem, xsk_frames);
>>  
>> -	xmit_done = ixgbe_xmit_zc(tx_ring, q_vector->tx.work_limit);
>> -	return budget > 0 && xmit_done;
>> +	return ixgbe_xmit_zc(tx_ring, q_vector->tx.work_limit);
>>  }
>>  
>>  int ixgbe_xsk_async_xmit(struct net_device *dev, u32 qid)
> 
> 
> 
