From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 18 Feb 2020 19:45:53 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/3] r8169: use new helper
 tcp_v6_gso_csum_prep
In-Reply-To: <CAKgT0UfaBpLxWQZO55-KE8QKJD9XgC2SCPAtzo=PA_MAwRxtuw@mail.gmail.com>
References: <76cd6cfc-f4f3-ece7-203a-0266b7f02a12@gmail.com>
 <02ea88e7-1a79-f779-d58c-bb1dced0b3b4@gmail.com>
 <CAKgT0UfaBpLxWQZO55-KE8QKJD9XgC2SCPAtzo=PA_MAwRxtuw@mail.gmail.com>
Message-ID: <5dacf5fb-873b-79d5-326f-f30feb1ac645@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 18.02.2020 19:37, Alexander Duyck wrote:
> On Mon, Feb 17, 2020 at 1:42 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Simplify the code by using new helper tcp_v6_gso_csum_prep.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 26 ++---------------------
>>  1 file changed, 2 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 5a9143b50..75ba10069 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -4108,29 +4108,6 @@ static bool rtl_test_hw_pad_bug(struct rtl8169_private *tp, struct sk_buff *skb)
>>         return skb->len < ETH_ZLEN && tp->mac_version == RTL_GIGA_MAC_VER_34;
>>  }
>>
>> -/* msdn_giant_send_check()
>> - * According to the document of microsoft, the TCP Pseudo Header excludes the
>> - * packet length for IPv6 TCP large packets.
>> - */
>> -static int msdn_giant_send_check(struct sk_buff *skb)
>> -{
>> -       const struct ipv6hdr *ipv6h;
>> -       struct tcphdr *th;
>> -       int ret;
>> -
>> -       ret = skb_cow_head(skb, 0);
>> -       if (ret)
>> -               return ret;
>> -
>> -       ipv6h = ipv6_hdr(skb);
>> -       th = tcp_hdr(skb);
>> -
>> -       th->check = 0;
>> -       th->check = ~tcp_v6_check(0, &ipv6h->saddr, &ipv6h->daddr, 0);
>> -
>> -       return ret;
>> -}
>> -
>>  static void rtl8169_tso_csum_v1(struct sk_buff *skb, u32 *opts)
>>  {
>>         u32 mss = skb_shinfo(skb)->gso_size;
>> @@ -4163,9 +4140,10 @@ static bool rtl8169_tso_csum_v2(struct rtl8169_private *tp,
>>                         break;
>>
>>                 case htons(ETH_P_IPV6):
>> -                       if (msdn_giant_send_check(skb))
>> +                       if (skb_cow_head(skb, 0))
>>                                 return false;
>>
>> +                       tcp_v6_gso_csum_prep(skb, false);
>>                         opts[0] |= TD1_GTSENV6;
>>                         break;
>>
> 
> This change looks more or less identical to the one you made in
> "drivers/net/usb/r8152.c" for patch 3. If you have to resubmit it
> might make sense to pull that change out and include it here since
> they are both essentially the same change.
> 
Right, it's the same change. I just treated r8169 separately because
I happen to be maintainer of it.
