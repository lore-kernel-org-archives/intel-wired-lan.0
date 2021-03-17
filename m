From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Wed, 17 Mar 2021 14:04:06 -0500
Subject: [Intel-wired-lan] [PATCH][next] ixgbe: Fix out-of-bounds
 warning in ixgbe_host_interface_command()
In-Reply-To: <CAG48ez2jr_8MbY_sNXfwvs7WsF-5f9j=U4-66dTcgXd2msr39A@mail.gmail.com>
References: <20210317064148.GA55123@embeddedor>
 <CAG48ez2RDqKwx=umOHjo_1mYyNQgzvcP=KOw1HgSo4Prs_VQDw@mail.gmail.com>
 <3bd8d009-2ad2-c24d-5c34-5970c52502de@embeddedor.com>
 <CAG48ez2jr_8MbY_sNXfwvs7WsF-5f9j=U4-66dTcgXd2msr39A@mail.gmail.com>
Message-ID: <03c013b8-4ddb-8e9f-af86-3c43cd746dbb@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 3/17/21 13:57, Jann Horn wrote:

>>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>>>> index 62ddb452f862..bff3dc1af702 100644
>>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>>>> @@ -3679,7 +3679,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
>>>>         u32 hdr_size = sizeof(struct ixgbe_hic_hdr);
>>>>         union {
>>>>                 struct ixgbe_hic_hdr hdr;
>>>> -               u32 u32arr[1];
>>>> +               u32 *u32arr;
>>>>         } *bp = buffer;
>>>>         u16 buf_len, dword_len;
>>>>         s32 status;
>>>
>>> This looks bogus. An array is inline, a pointer points elsewhere -
>>> they're not interchangeable.
>>
>> Yep; but in this case these are the only places in the code where _u32arr_ is
>> being used:
>>
>> 3707         /* first pull in the header so we know the buffer length */
>> 3708         for (bi = 0; bi < dword_len; bi++) {
>> 3709                 bp->u32arr[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
>> 3710                 le32_to_cpus(&bp->u32arr[bi]);
>> 3711         }
> 
> So now line 3709 means: Read a pointer from bp->u32arr (the value
> being read from there is not actually a valid pointer), and write to
> that pointer at offset `bi`. I don't see how that line could execute
> without crashing.

Yeah; you're right. I see my confusion now. Apparently, there is no escape
from allocating heap memory to fix this issue, as I was proposing in my
last email.

I really appreciate the feedback. Thanks!
--
Gustavo
