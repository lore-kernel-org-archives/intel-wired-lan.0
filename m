From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 10 Mar 2017 21:39:33 -0800
Subject: [Intel-wired-lan] [net-next PATCH v4 1/2] ixgbe: add XDP
 support for pass and drop actions
In-Reply-To: <CAKgT0UfUideLMR-8j-RUDee+fMbAsNw=7HdPTk=L3Q8Kc8gxQQ@mail.gmail.com>
References: <20170310191134.17927.55334.stgit@john-Precision-Tower-5810>
 <CAKgT0UfUideLMR-8j-RUDee+fMbAsNw=7HdPTk=L3Q8Kc8gxQQ@mail.gmail.com>
Message-ID: <58C38D95.5010000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-03-10 12:38 PM, Alexander Duyck wrote:
> On Fri, Mar 10, 2017 at 11:11 AM, John Fastabend
> <john.fastabend@gmail.com> wrote:
>> Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
>> programs instead of rcu primitives as suggested by Daniel Borkmann and
>> Alex Duyck.
>>
>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> 
> Two minor cosmetic complaints below.  However the patch looks good to
> me.  Feel free to add this to both patches for the next revision.
> 
> Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
> 


[...]

>>         /* allocate a skb to store the frags */
>> @@ -2097,7 +2108,7 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>>                         IXGBE_CB(skb)->dma = rx_buffer->dma;
>>
>>                 skb_add_rx_frag(skb, 0, rx_buffer->page,
>> -                               rx_buffer->page_offset,
>> +                               xdp->data - page_address(rx_buffer->page),
>>                                 size, truesize);
>>  #if (PAGE_SIZE < 8192)
>>                 rx_buffer->page_offset ^= truesize;
>> @@ -2105,7 +2116,8 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>>                 rx_buffer->page_offset += truesize;
>>  #endif
>>         } else {
>> -               memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
>> +               memcpy(__skb_put(skb, size),
>> +                      xdp->data, ALIGN(size, sizeof(long)));
> 
> I'm not sure what happened here.  Is this line over 80 characters?  If
> not it probably doesn't need to be wrapped.  If it is then you might
> want to fix the line wrapping up since it doesn't look right.
> 

It is over 80 lines. What is your issue with the line wrapping?

>>                 rx_buffer->pagecnt_bias++;
>>         }
>>

[...]

>>  /**
>>   * ixgbe_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>>   * @q_vector: structure containing interrupt and ring information
>> @@ -2184,6 +2230,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>                 union ixgbe_adv_rx_desc *rx_desc;
>>                 struct ixgbe_rx_buffer *rx_buffer;
>>                 struct sk_buff *skb;
>> +               struct xdp_buff xdp;
>>                 unsigned int size;
>>
>>                 /* return some buffers to hardware, one at a time is too slow */
>> @@ -2205,15 +2252,29 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>
>>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>>
>> -               /* retrieve a buffer from the ring */
> 
> You can probably leave this comment here.  That is my preference anyway.
> 

Sure.

Thanks,
John

