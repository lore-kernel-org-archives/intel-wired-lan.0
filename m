From: Ilya Maximets <i.maximets@samsung.com>
Date: Thu, 22 Aug 2019 11:05:52 +0300
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix double clean of tx
 descriptors with xdp
In-Reply-To: <CAJ+HfNjo0tpk2v_+85SuX7Jw797QwRA7uJBggPHtY=JznLC9Zg@mail.gmail.com>
References: <CGME20190820151644eucas1p179d6d1da42bb6be0aad8f58ac46624ce@eucas1p1.samsung.com>
 <20190820151611.10727-1-i.maximets@samsung.com>
 <CAKgT0Udn0D0_f=SOH2wpBRWV_u4rb1Qe2h7gguXnRNzJ_VkRzg@mail.gmail.com>
 <625791af-c656-1e42-b60e-b3a5cedcb4c4@samsung.com>
 <CAKgT0Uc27+ucd=a_sgTmv5g7_+ZTg1zK4isYJ0H7YWQj3d=Ejg@mail.gmail.com>
 <f7d0f7a5-e664-8b72-99c7-63275aff4c18@samsung.com>
 <CAKgT0UcCKiM1Ys=vWxctprN7fzWcBCk-PCuKB-8=RThM=CqLSQ@mail.gmail.com>
 <CAJ+HfNjo0tpk2v_+85SuX7Jw797QwRA7uJBggPHtY=JznLC9Zg@mail.gmail.com>
Message-ID: <54faa2f1-345d-b5b2-7e48-963876b62813@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 22.08.2019 10:12, Bj?rn T?pel wrote:
> On Wed, 21 Aug 2019 at 18:57, Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>
>> On Wed, Aug 21, 2019 at 9:22 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>>>
>>> On 21.08.2019 4:17, Alexander Duyck wrote:
>>>> On Tue, Aug 20, 2019 at 8:58 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>>>>>
>>>>> On 20.08.2019 18:35, Alexander Duyck wrote:
>>>>>> On Tue, Aug 20, 2019 at 8:18 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>>>>>>>
>>>>>>> Tx code doesn't clear the descriptor status after cleaning.
>>>>>>> So, if the budget is larger than number of used elems in a ring, some
>>>>>>> descriptors will be accounted twice and xsk_umem_complete_tx will move
>>>>>>> prod_tail far beyond the prod_head breaking the comletion queue ring.
>>>>>>>
>>>>>>> Fix that by limiting the number of descriptors to clean by the number
>>>>>>> of used descriptors in the tx ring.
>>>>>>>
>>>>>>> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
>>>>>>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>>>>>>
>>>>>> I'm not sure this is the best way to go. My preference would be to
>>>>>> have something in the ring that would prevent us from racing which I
>>>>>> don't think this really addresses. I am pretty sure this code is safe
>>>>>> on x86 but I would be worried about weak ordered systems such as
>>>>>> PowerPC.
>>>>>>
>>>>>> It might make sense to look at adding the eop_desc logic like we have
>>>>>> in the regular path with a proper barrier before we write it and after
>>>>>> we read it. So for example we could hold of on writing the bytecount
>>>>>> value until the end of an iteration and call smp_wmb before we write
>>>>>> it. Then on the cleanup we could read it and if it is non-zero we take
>>>>>> an smp_rmb before proceeding further to process the Tx descriptor and
>>>>>> clearing the value. Otherwise this code is going to just keep popping
>>>>>> up with issues.
>>>>>
>>>>> But, unlike regular case, xdp zero-copy xmit and clean for particular
>>>>> tx ring always happens in the same NAPI context and even on the same
>>>>> CPU core.
>>>>>
>>>>> I saw the 'eop_desc' manipulations in regular case and yes, we could
>>>>> use 'next_to_watch' field just as a flag of descriptor existence,
>>>>> but it seems unnecessarily complicated. Am I missing something?
>>>>>
>>>>
>>>> So is it always in the same NAPI context?. I forgot, I was thinking
>>>> that somehow the socket could possibly make use of XDP for transmit.
>>>
>>> AF_XDP socket only triggers tx interrupt on ndo_xsk_async_xmit() which
>>> is used in zero-copy mode. Real xmit happens inside
>>> ixgbe_poll()
>>>  -> ixgbe_clean_xdp_tx_irq()
>>>     -> ixgbe_xmit_zc()
>>>
>>> This should be not possible to bound another XDP socket to the same netdev
>>> queue.
>>>
>>> It also possible to xmit frames in xdp_ring while performing XDP_TX/REDIRECT
>>> actions. REDIRECT could happen from different netdev with different NAPI
>>> context, but this operation is bound to specific CPU core and each core has
>>> its own xdp_ring.
>>>
>>> However, I'm not an expert here.
>>> Bj?rn, maybe you could comment on this?
>>>
>>>>
>>>> As far as the logic to use I would be good with just using a value you
>>>> are already setting such as the bytecount value. All that would need
>>>> to happen is to guarantee that the value is cleared in the Tx path. So
>>>> if you clear the bytecount in ixgbe_clean_xdp_tx_irq you could
>>>> theoretically just use that as well to flag that a descriptor has been
>>>> populated and is ready to be cleaned. Assuming the logic about this
>>>> all being in the same NAPI context anyway you wouldn't need to mess
>>>> with the barrier stuff I mentioned before.
>>>
>>> Checking the number of used descs, i.e. next_to_use - next_to_clean,
>>> makes iteration in this function logically equal to the iteration inside
>>> 'ixgbe_xsk_clean_tx_ring()'. Do you think we need to change the later
>>> function too to follow same 'bytecount' approach? I don't like having
>>> two different ways to determine number of used descriptors in the same file.
>>>
>>> Best regards, Ilya Maximets.
>>
>> As far as ixgbe_clean_xdp_tx_irq() vs ixgbe_xsk_clean_tx_ring(), I
>> would say that if you got rid of budget and framed things more like
>> how ixgbe_xsk_clean_tx_ring was framed with the ntc != ntu being
>> obvious I would prefer to see us go that route.
>>
>> Really there is no need for budget in ixgbe_clean_xdp_tx_irq() if you
>> are going to be working with a static ntu value since you will only
>> ever process one iteration through the ring anyway. It might make more
>> sense if you just went through and got rid of budget and i, and
>> instead used ntc and ntu like what was done in
>> ixgbe_xsk_clean_tx_ring().
>>
> 
> +1. I'd prefer this as well!

Sounds good. I'll look in this direction.
But I'm not completely sure about 'budget' elimination. Wouldn't it cause
issues if we'll clean the whole ring at once? I mean maybe it'll be too long
to hold the CPU core for this amount of work.
We could re-work the code keeping the loop break on budget exhaustion.
What do you think?

> 
> 
> Cheers,
> Bj?rn
> 
>> Thanks.
>>
>> - Alex
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
> 
