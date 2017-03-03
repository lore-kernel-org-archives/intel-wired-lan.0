From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 3 Mar 2017 08:40:02 -0800
Subject: [Intel-wired-lan] [net-next PATCH v2 2/3] ixgbe: add support
	for XDP_TX action
In-Reply-To: <CAKgT0UeaiF7U7JG=f576Nfe39Rn5+qZG4P-dSs12z5XUp+0CJw@mail.gmail.com>
References: <20170302005417.30505.14047.stgit@john-Precision-Tower-5810>
 <20170302005439.30505.65636.stgit@john-Precision-Tower-5810>
 <CAKgT0UeaiF7U7JG=f576Nfe39Rn5+qZG4P-dSs12z5XUp+0CJw@mail.gmail.com>
Message-ID: <58B99C62.80506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-03-02 08:39 AM, Alexander Duyck wrote:
> On Wed, Mar 1, 2017 at 4:54 PM, John Fastabend <john.fastabend@gmail.com> wrote:
>> Add support for XDP_TX action.
>>
>> A couple design choices were made here. First I use a new ring
>> pointer structure xdp_ring[] in the adapter struct instead of
>> pushing the newly allocated xdp TX rings into the tx_ring[]
>> structure. This means we have to duplicate loops around rings
>> in places we want to initialize both TX rings and XDP rings.
>> But by making it explicit it is obvious when we are using XDP
>> rings and when we are using TX rings. Further we don't have
>> to do ring arithmatic which is error prone. As a proof point
>> for doing this my first patches used only a single ring structure
>> and introduced bugs in FCoE code and macvlan code paths.
>>
>> Second I am aware this is not the most optimized version of
>> this code possible. I want to get baseline support in using
>> the most readable format possible and then once this series
>> is included I will optimize the TX path in another series
>> of patches.
>>
>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>> ---

[...]

>>
>> +               for (j = 0; j < adapter->num_xdp_queues; i++, j++) {
>> +                       memcpy(&temp_ring[i], adapter->xdp_ring[j],
>> +                              sizeof(struct ixgbe_ring));
>> +
>> +                       temp_ring[i].count = new_tx_count;
>> +                       err = ixgbe_setup_tx_resources(&temp_ring[i]);
>> +                       if (err) {
>> +                               while (i) {
>> +                                       i--;
>> +                                       ixgbe_free_tx_resources(&temp_ring[i]);
>> +                               }
>> +                               goto err_setup;
>> +                       }
>> +               }
>> +
> 
> It looks like this is broken.  I would say just get rid of j and just
> use i for all of this like we did for the Tx and Rx rings.  I don't
> think you need J anymore since you aren't really playing with an
> offset anyway.
> 

Yep fixed up the counter usage throughout. This was a holdout from using the
single tx_ring[] array.

[...]

>>         struct ixgbe_q_vector *q_vector;
>> @@ -909,6 +941,33 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
>>                 ring++;
>>         }
>>
>> +       while (xdp_count) {
>> +               /* assign generic ring traits */
>> +               ring->dev = &adapter->pdev->dev;
>> +               ring->netdev = adapter->netdev;
>> +
>> +               /* configure backlink on ring */
>> +               ring->q_vector = q_vector;
>> +
>> +               /* update q_vector Tx values */
>> +               ixgbe_add_ring(ring, &q_vector->tx);
> 
> We might want to just add XDP queues as a separate ring container in
> the q_vector.  Just a thought, though I am not sure what extra
> complications it would add.
> 

I'll keep it as is for now.

[...]

>> @@ -2255,8 +2299,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>
>>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>>
>> -               consumed = ixgbe_run_xdp(rx_ring, rx_buffer, size);
>> -               rcu_read_unlock();
>> +               consumed = ixgbe_run_xdp(adapter, rx_ring, rx_buffer, size);
> 
> Okay so this is where you fixed the rcu_read_unlock that you leaked from v1.
> 
>>
>>                 if (consumed) {
>>                         ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb);
> 
> So if you end up going with my suggestions to patch 1/3 you would need
> to make a slight tweak in the if (IS_ERR(skb)) path.
> 
> If you are transmitting the buffer you need to update the page_offset
> by the truesize of the buffer, otherwise you can update pagecnt_bias.
> So something along the lines of:
>     if (PTR_ERR(skb) == IXGBE_XDP_TX) {
> #if (PAGE_SIZE < 8192)
>         rx_buffer->page_offset ^= ixgbe_rx_pg_size(rx_ring) / 2;
> #else
>         rx_buffer->page_offset += ring_uses_build_skb(rx_ring) ?
>                                           SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) :
>                                           SKB_DATA_ALIGN(size);
> #endif
>     } else {
>         rx_buffer->pagecnt_bias++;
>     }
> 

Or just do it in ixgbe_run_xdp directly.


Thanks,
John
