From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Thu, 20 Aug 2020 20:04:03 +0200
Subject: [Intel-wired-lan] [PATCH 0/2] intel/xdp fixes for fliping rx
 buffer
In-Reply-To: <20200820165121.GA9731@ranger.igk.intel.com>
References: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
 <CAJ+HfNi2B+2KYP9A7yCfFUhfUBd=sFPeuGbNZMjhNSdq3GEpMg@mail.gmail.com>
 <CAJ+HfNjybUeN9v6N-pnupi32088PL+ZXu8CKWGWmowOaH4nmOw@mail.gmail.com>
 <20200820165121.GA9731@ranger.igk.intel.com>
Message-ID: <4a78ace0-e84e-786f-127d-a3ab7d2a7c3f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-08-20 18:51, Maciej Fijalkowski wrote:
> On Thu, Aug 20, 2020 at 05:13:16PM +0200, Bj?rn T?pel wrote:
>> On Tue, 18 Aug 2020 at 16:04, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>>>
>>> On Fri, 17 Jul 2020 at 08:24, Li RongQing <lirongqing@baidu.com> wrote:
>>>>
>>>> This fixes ice/i40e/ixgbe/ixgbevf_rx_buffer_flip in
>>>> copy mode xdp that can lead to data corruption.
>>>>
>>>> I split two patches, since i40e/xgbe/ixgbevf supports xsk
>>>> receiving from 4.18, put their fixes in a patch
>>>>
>>>
>>> Li, sorry for the looong latency. I took a looong vacation. :-P
>>>
>>> Thanks for taking a look at this, but I believe this is not a bug.
>>>
>>
>> Ok, dug a bit more into this. I had an offlist discussion with Li, and
>> there are two places (AFAIK) where Li experience a BUG() in
>> tcp_collapse():
>>
>>              BUG_ON(offset < 0);
>> and
>>                  if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
>>                      BUG();
>>
>> (Li, please correct me if I'm wrong.)
>>
>> I still claim that the page-flipping mechanism is correct, but I found
>> some weirdness in the build_skb() call.
>>
>> In drivers/net/ethernet/intel/i40e/i40e_txrx.c, build_skb() is invoked as:
>>      skb = build_skb(xdp->data_hard_start, truesize);
>>
>> For the setup Li has truesize is 2048 (half a page), but the
>> rx_buf_len is 1536. In the driver a packet is layed out as:
>>
>> | padding 192 | packet data 1536 | skb shared info 320 |
>>
>> build_skb() assumes that the second argument (frag_size) is max packet
>> size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)). In other words,
>> frag_size should not include the padding (192 above). In build_skb(),
> 
> Not sure I am buying that reasoning. It assumes the padding + packet_data
> and we use skb_reserve() to tell the skb about the padding.
> 
> __build_skb_around() subtracts sizeof(struct skb_shared_info) from size
> that we are providing, so now we are with padding + packet_data.
> Then it is used to calculate the skb->end.
> 
> Back to i40e_build_skb(), we use the skb_reserve() to advance the
> skb->data and skb->tail so that they point to packet_data. Finally
> __skb_put() will move the skb->tail to the end of packet_data.
> 
> Wouldn't your approach disallow having the headroom at all in the linear
> part of skb?
>

Mea culpa.

You're perfectly right, and I'm all wrong. Thanks for sorting that out. 
xdp->data_hard_start messed up my neurons (if any one should ask).

*climbing back into the cave*


Sorry for the mail noise,
Bj?rn
