From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 10 Feb 2017 15:15:49 -0800
Subject: [Intel-wired-lan] [next PATCH v2 04/11] ixgbe: Update code to
 better handle incrementing page count
In-Reply-To: <589E4700.8090907@gmail.com>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163600.5423.48511.stgit@localhost.localdomain>
 <589E4700.8090907@gmail.com>
Message-ID: <CAKgT0Ue3VcXJQ3h4y-yYgJz-4c7s=XQg814HrJne6csLWH98yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Feb 10, 2017 at 3:04 PM, John Fastabend
<john.fastabend@gmail.com> wrote:
> On 17-01-17 08:36 AM, Alexander Duyck wrote:
>> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>
>> Batch the page count updates instead of doing them one at a time.  By doing
>> this we can improve the overall performance as the atomic increment
>> operations can be expensive due to the fact that on x86 they are locked
>> operations which can cause stalls.  By doing bulk updates we can
>> consolidate the stall which should help to improve the overall receive
>> performance.
>>
>
> [...]
>
>>  struct ixgbe_queue_stats {
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 8ee8fcf0fe21..34a5271a7b35 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -1602,6 +1602,7 @@ static bool ixgbe_alloc_mapped_page(struct ixgbe_ring *rx_ring,
>>       bi->dma = dma;
>>       bi->page = page;
>>       bi->page_offset = 0;
>> +     bi->pagecnt_bias = 1;
>
> I'm curious why set pagecnt_bias to '1' here but in the ixgbe_can_reuse_rx_page
> path set it to USHRT_MAX? Any reason not to just always use the USHRT_MAX
> scheme.

Because I wanted to defer having to use page_ref_add until I know I am
going to reuse the page.  The allocation can be from a memory pool
that is reserved for emergency allocations or could be from the wrong
node.  In such a case we would take a penalty if we are having to
perform an atomic add and subtract from the page count.  By setting it
to 1 we reflect that for now we hold the only reference to the page
and we are waiting to see if it is reusable.

>>
>>       return true;
>>  }
>> @@ -1960,13 +1961,15 @@ static bool ixgbe_can_reuse_rx_page(struct ixgbe_ring *rx_ring,
>>       unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
>>                                  ixgbe_rx_bufsz(rx_ring);
>>  #endif
>> +     unsigned int pagecnt_bias = rx_buffer->pagecnt_bias--;
>> +
>>       /* avoid re-using remote pages */
>>       if (unlikely(ixgbe_page_is_reserved(page)))
>>               return false;
>>
>>  #if (PAGE_SIZE < 8192)
>>       /* if we are only owner of page we can reuse it */
>> -     if (unlikely(page_count(page) != 1))
>> +     if (unlikely(page_count(page) != pagecnt_bias))
>>               return false;
>>
>>       /* flip page offset to other buffer */
>> @@ -1979,10 +1982,14 @@ static bool ixgbe_can_reuse_rx_page(struct ixgbe_ring *rx_ring,
>>               return false;
>>  #endif
>>
>> -     /* Even if we own the page, we are not allowed to use atomic_set()
>> -      * This would break get_page_unless_zero() users.
>> +     /* If we have drained the page fragment pool we need to update
>> +      * the pagecnt_bias and page count so that we fully restock the
>> +      * number of references the driver holds.
>>        */
>> -     page_ref_inc(page);
>> +     if (unlikely(pagecnt_bias == 1)) {
>> +             page_ref_add(page, USHRT_MAX);
>> +             rx_buffer->pagecnt_bias = USHRT_MAX;
>> +     }
>>
>>       return true;
>>  }
>
> Otherwise patch looks good to me. Although it took me a moment to catch the
> ref_add/pagecnt_bias usage here.

Right.  What we are doing here is dealing with the first real priming
of the pagecnt_bias.  We had set it to one when the page count was
one, now we are forking things a bit and giving the stack one instance
of the reference count and filling the pagecnt_bias to the maximum
value supported assuming a u32 system.  The value for pagecnt_bias
will always shrink from this point.  It might bounce by 1 if we are
doing a copy-break but it should never exceed USHRT_MAX.

The advantage of doing it here is that this is after the
page_is_reserved check so we are are essentially just taking this hit
in place of having to do another page allocation versus adding it onto
a page allocation if we had done this earlier.

> Acked-by: John Fastabend <john.r.fastabend@intel.com>
>
