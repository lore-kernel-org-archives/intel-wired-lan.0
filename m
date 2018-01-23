From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 23 Jan 2018 21:02:48 +0100
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <f9f79333-e8d3-ea6f-ba04-356b1761a0b9@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <CAF=yD-JCN483_e9U7tb_4+2jGyWKfhS0TzooOui+kS4Gh7RSqw@mail.gmail.com>
 <f9f79333-e8d3-ea6f-ba04-356b1761a0b9@intel.com>
Message-ID: <CAF=yD-LZeYijHi3bJmo06B0cicqH-+eBMW_+LUs4+85ZM0KcZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>> If using ns_capable, skb->tstamp must continue to be scrubbed when traversing
>> network namespaces.
>
>
> I was planning to follow Eric's suggestion and move the tstamp scrubbing out of
> skb_scrub_packet() into ____dev_forward_skb() instead. Would that break when
> traversing namespaces?

That implies namespace traversal, so sounds perfect for this purpose.

>>
>>> @@ -2130,6 +2137,15 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>>>                 sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
>>>                 sockc->tsflags |= tsflags;
>>>                 break;
>>> +       case SO_TXTIME:
>>> +               if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
>>> +                       return -EPERM;
>>> +               if (!sock_flag(sk, SOCK_TXTIME))
>>> +                       return -EINVAL;
>>
>> No need for ns_capable check on each packet when already required to
>> toggle socket option.
>
>
> Ok. SO_MARK is doing the same so it might have "mis-inspired" me. I should
> probably fix both.

The SO_MARK cmsg does need a check on each invocation,
because it is not conditional on a sock_flag like SO_TXTIME.
