From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue, 23 Jan 2018 10:24:04 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <CAF=yD-JCN483_e9U7tb_4+2jGyWKfhS0TzooOui+kS4Gh7RSqw@mail.gmail.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <CAF=yD-JCN483_e9U7tb_4+2jGyWKfhS0TzooOui+kS4Gh7RSqw@mail.gmail.com>
Message-ID: <f9f79333-e8d3-ea6f-ba04-356b1761a0b9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 01/19/2018 01:15 PM, Willem de Bruijn wrote:
> On Wed, Jan 17, 2018 at 6:06 PM, Jesus Sanchez-Palencia
> <jesus.sanchez-palencia@intel.com> wrote:
>> From: Richard Cochran <rcochran@linutronix.de>
>>
>> This patch introduces SO_TXTIME.  User space enables this option in
>> order to pass a desired future transmit time in a CMSG when calling
>> sendmsg(2).
>>
>> A new field is added to struct sockcm_cookie, and the tstamp from
>> skbuffs will be used later on.
>>
>> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
>> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
>> ---
> 
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index abf4cbff99b2..37ef4b33fd92 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -1061,6 +1061,13 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>>                         sock_valbool_flag(sk, SOCK_ZEROCOPY, valbool);
>>                 break;
>>
>> +       case SO_TXTIME:
>> +               if (ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
>> +                       sock_valbool_flag(sk, SOCK_TXTIME, valbool);
>> +               else
>> +                       ret = -EPERM;
>> +               break;
>> +
>>         default:
>>                 ret = -ENOPROTOOPT;
>>                 break;
> 
> Please add getsockopt alongside setsockopt.
> 
> I would also restrict input to [0, 1] exactly to allow for future extensions.


Ok, will do.


> 
> If using ns_capable, skb->tstamp must continue to be scrubbed when traversing
> network namespaces.


I was planning to follow Eric's suggestion and move the tstamp scrubbing out of
skb_scrub_packet() into ____dev_forward_skb() instead. Would that break when
traversing namespaces?



> 
>> @@ -2130,6 +2137,15 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>>                 sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
>>                 sockc->tsflags |= tsflags;
>>                 break;
>> +       case SO_TXTIME:
>> +               if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
>> +                       return -EPERM;
>> +               if (!sock_flag(sk, SOCK_TXTIME))
>> +                       return -EINVAL;
> 
> No need for ns_capable check on each packet when already required to
> toggle socket option.


Ok. SO_MARK is doing the same so it might have "mis-inspired" me. I should
probably fix both.



> 
>> +               if (cmsg->cmsg_len != CMSG_LEN(sizeof(ktime_t)))
>> +                       return -EINVAL;
> 
> I don't see any existing reference to ktime_t in include/uapi. Just use a s64?


Sure, will fix.


Thanks,
Jesus
