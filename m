From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Fri, 10 Dec 2021 14:31:45 +0100
Subject: [Intel-wired-lan] [PATCH v4 net-next 1/9] i40e: don't reserve
 excessive XDP_PACKET_HEADROOM on XSK Rx to skb
In-Reply-To: <20211209173307.5003-1-alexandr.lobakin@intel.com>
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
 <20211208140702.642741-2-alexandr.lobakin@intel.com>
 <da317f39-8679-96f7-ec6f-309216b02f33@redhat.com>
 <20211209173307.5003-1-alexandr.lobakin@intel.com>
Message-ID: <ccd27f5f-31c4-603f-ea36-ad32b16325b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 09/12/2021 18.33, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Date: Thu, 9 Dec 2021 09:19:46 +0100
> 
>> On 08/12/2021 15.06, Alexander Lobakin wrote:
>>> {__,}napi_alloc_skb() allocates and reserves additional NET_SKB_PAD
>>> + NET_IP_ALIGN for any skb.
>>> OTOH, i40e_construct_skb_zc() currently allocates and reserves
>>> additional `xdp->data - xdp->data_hard_start`, which is
>>> XDP_PACKET_HEADROOM for XSK frames.
>>> There's no need for that at all as the frame is post-XDP and will
>>> go only to the networking stack core.
>>
>> I disagree with this assumption, that headroom is not needed by netstack.
>> Why "no need for that at all" for netstack?
> 
> napi_alloc_skb() in our particular case will reserve 64 bytes, it is
> sufficient for {TCP,UDP,SCTP,...}/IPv{4,6} etc.

My bad, I misunderstood you. I now see (looking at code) that (as you 
say) 64 bytes of headroom *is* reserved (in bottom of __napi_alloc_skb).
Thus, the SKB *do* have headroom, so this patch should be fine.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Do watch out that 64 bytes is not always enough. Notice the define 
LL_MAX_HEADER and MAX_HEADER in include/linux/netdevice.h (that tries to 
determine worst-case header length) which is above 64 bytes. It is also 
affected by HyperV and WiFi configs.

