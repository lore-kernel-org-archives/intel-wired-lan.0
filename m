From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 18 Feb 2020 19:53:48 +0100
Subject: [Intel-wired-lan] [PATCH net-next 1/3] net: core: add helper
 tcp_v6_gso_csum_prep
In-Reply-To: <CAKgT0UeUEcoKZsRnxzftMA4tc2chasmW+sWQkP11hVLbdYTYxA@mail.gmail.com>
References: <76cd6cfc-f4f3-ece7-203a-0266b7f02a12@gmail.com>
 <9fdc5f0c-fdf0-122e-48a5-43ff029cf8d9@gmail.com>
 <CAKgT0UeUEcoKZsRnxzftMA4tc2chasmW+sWQkP11hVLbdYTYxA@mail.gmail.com>
Message-ID: <f349d932-582c-96f9-fa7a-b76c615adb96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 18.02.2020 19:25, Alexander Duyck wrote:
> On Mon, Feb 17, 2020 at 1:41 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Several network drivers for chips that support TSO6 share the same code
>> for preparing the TCP header. A difference is that some reset the
>> payload_len whilst others don't do this. Let's factor out this common
>> code to a new helper.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  include/net/ip6_checksum.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/net/ip6_checksum.h b/include/net/ip6_checksum.h
>> index 7bec95df4..ef0130023 100644
>> --- a/include/net/ip6_checksum.h
>> +++ b/include/net/ip6_checksum.h
>> @@ -76,6 +76,18 @@ static inline void __tcp_v6_send_check(struct sk_buff *skb,
>>         }
>>  }
>>
>> +static inline void tcp_v6_gso_csum_prep(struct sk_buff *skb,
>> +                                       bool clear_payload_len)
>> +{
>> +       struct ipv6hdr *ipv6h = ipv6_hdr(skb);
>> +       struct tcphdr *th = tcp_hdr(skb);
>> +
>> +       if (clear_payload_len)
>> +               ipv6h->payload_len = 0;
>> +
>> +       th->check = ~tcp_v6_check(0, &ipv6h->saddr, &ipv6h->daddr, 0);
>> +}
>> +
>>  #if IS_ENABLED(CONFIG_IPV6)
>>  static inline void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb)
>>  {
> 
> So functionally I believe this is correct. The only piece I have a
> question about is if we should just force the clear_payload_len as
> always being the case since the value should either be
> ignored/overwritten in any GSO case anyway.
> 
I also thought about this and just wasn't sure whether this functional
change may break any driver. But yes, then let's change it this way.
Breaking down the series into smaller patches makes it easier to
revert an individual patch in case of a problem.

> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
Thanks for the review.
