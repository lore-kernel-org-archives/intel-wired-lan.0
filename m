From: Cong Wang <cwang@twopensource.com>
Date: Thu, 23 Apr 2015 15:07:04 -0700
Subject: [Intel-wired-lan] [Patch net] igb: pass the correct maxlen for
	eth_get_headlen()
In-Reply-To: <55394BD1.5040006@redhat.com>
References: <1429724760-10075-1-git-send-email-xiyou.wangcong@gmail.com>
 <5537F9F1.1080008@gmail.com>
 <CAHA+R7PVrxJ41WSqfO4mZSpCTGdJ++Gf757f_kq5z0UeMHXbXg@mail.gmail.com>
 <553802DA.4050709@gmail.com>
 <CAHA+R7PtzNd2asXFtiqsWyzCgeE1k_iF84358cvKg6ZCU-yVkQ@mail.gmail.com>
 <553815DF.4000109@gmail.com>
 <CAHA+R7MMrrBYbQALovxuhcXrbiWjD_XpgohPXxTvNkcd3-R3WA@mail.gmail.com>
 <553821E4.5010901@gmail.com>
 <CAHA+R7MJv7tbHwU_ECbJunXVJ8uo=eQv+Xmw42oR5sKEde35RQ@mail.gmail.com>
 <CAHA+R7OhbCSjggyb_Deq_jmoDWzEcR+=hhkKjyE9Pue7bXOmHg@mail.gmail.com>
 <55394BD1.5040006@redhat.com>
Message-ID: <CAHA+R7MCyWvTN1snFiVEK9pdgF0Sr694tMUEiT1QhsOtF9t1Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 23, 2015 at 12:45 PM, Alexander Duyck
<alexander.h.duyck@redhat.com> wrote:
> On 04/23/2015 12:30 PM, Cong Wang wrote:
>>
>> (Off-topic...)
>>
>> On Wed, Apr 22, 2015 at 4:23 PM, Cong Wang <cwang@twopensource.com> wrote:
>>>
>>> The code looks correct to me now, except it is suspicious skb->len
>>> is not updated after skb_copy_to_linear_data() while skb->tail is
>>> advanced already. I need to think more before submitting a patch.
>>
>> I feel like we need the following patch, maybe skb->len is updated
>> somewhere
>> else by "skb->tail - skb->head", otherwise we are screwed?
>
>
> Maybe in skb_add_rx_frag?  You might take a look at it.

I saw that.

>
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
>> b/drivers/net/ethernet/intel/igb/igb_main.c
>> index a0a9b1f..66e6fb6 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -6843,7 +6843,6 @@ static void igb_pull_tail(struct igb_ring *rx_ring,
>>                  skb_frag_size_sub(frag, IGB_TS_HDR_LEN);
>>                  frag->page_offset += IGB_TS_HDR_LEN;
>>                  skb->data_len -= IGB_TS_HDR_LEN;
>> -               skb->len -= IGB_TS_HDR_LEN;
>>
>>                  /* move va to start of packet data */
>>                  va += IGB_TS_HDR_LEN;
>> @@ -6856,12 +6855,12 @@ static void igb_pull_tail(struct igb_ring
>> *rx_ring,
>>
>>          /* align pull length to size of long to optimize memcpy
>> performance */
>>          skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
>> +       __skb_put(skb, pull_len);
>>
>>          /* update all of the pointers */
>>          skb_frag_size_sub(frag, pull_len);
>>          frag->page_offset += pull_len;
>>          skb->data_len -= pull_len;
>> -       skb->tail += pull_len;
>>   }
>>
>>   /**
>
>
> Seriously?  Are you even reading the code?  The fragment is already a part
> of the skb, as such it is already included in skb->len. By re-adding the
> header you are adding bytes that aren't there.  All we were doing is moving
> data from a fragment to the linear portion.

Hmm, I thought frags are counted only in skb->data_len, I misunderstood
skb_headlen() and skb_pagelen().

>
> No offense but your starting to waste my time with these silly patch ideas.


You can always ignore any off-topic discussion, which I already warned you
in the beginning...

> The patches I submitted to intel-wired-lan fix the issue that you found, and
> there aren't any new issues that it creates so the issue is resolved.  And
> like I said if you need to fix this in stable just subtract IGB_TS_HDR_LEN
> from the header length scanned in eth_get_headlen and it will resolve the
> issue you reported and that way we can fix the issue and avoid pulling a
> fragment down to size 0.
>

Please keep non-off-topic discussion from off-topic ones. I will reply there.
