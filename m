From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 22 Mar 2018 07:52:31 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/2] i40e: add support for
 XDP_REDIRECT
In-Reply-To: <CAJ+HfNiGWgJEE9K1rh3OrgixFaTJE4mDCBzYVGQJv3R8_rpLTQ@mail.gmail.com>
References: <20180322090307.14409-1-bjorn.topel@gmail.com>
 <20180322090307.14409-2-bjorn.topel@gmail.com>
 <20180322125811.0dcc1b28@redhat.com>
 <CAJ+HfNiGWgJEE9K1rh3OrgixFaTJE4mDCBzYVGQJv3R8_rpLTQ@mail.gmail.com>
Message-ID: <CAKgT0UcoMxQSCWzi1GKorRXNADX0yjrQBpv04cKvR5=g3+BjsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 22, 2018 at 5:20 AM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> 2018-03-22 12:58 GMT+01:00 Jesper Dangaard Brouer <brouer@redhat.com>:
>>
>> On Thu, 22 Mar 2018 10:03:07 +0100 Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>>
>>> +/**
>>> + * i40e_xdp_xmit - Implements ndo_xdp_xmit
>>> + * @dev: netdev
>>> + * @xdp: XDP buffer
>>> + *
>>> + * Returns Zero if sent, else an error code
>>> + **/
>>> +int i40e_xdp_xmit(struct net_device *dev, struct xdp_buff *xdp)
>>> +{
>>
>> The return code is used by the XDP redirect tracepoint... this is the
>> only way we have to debug/troubleshoot runtime issues with XDP. Thus,
>> these need to be consistent across drives and distinguishable.
>>
>
> Thanks for pointing this out! I'll address all your comments and do a
> respin (but I'll wait for Alex' comments, if any).
>
>
> Bj?rn
>

The patch mostly looks okay to me. Maybe a bit of reverse xmas tree
formatting needs to be addressed for the variable declarations in your
two new functions but that is about it in terms of what I see.

- Alex
