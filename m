From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Wed, 7 Mar 2018 14:03:46 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 02/18] net: Clear
 skb->tstamp only on the forwarding path
In-Reply-To: <CAF=yD-JYdh=tBcjSFCV51+EAWKQ2kR0RwgkP1ZWQesMo8caqcw@mail.gmail.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-3-jesus.sanchez-palencia@intel.com>
 <CAF=yD-JYdh=tBcjSFCV51+EAWKQ2kR0RwgkP1ZWQesMo8caqcw@mail.gmail.com>
Message-ID: <151c295e-82b7-8d3a-9ae8-a5f2906c091e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 03/07/2018 08:59 AM, Willem de Bruijn wrote:
> On Tue, Mar 6, 2018 at 8:12 PM, Jesus Sanchez-Palencia
> <jesus.sanchez-palencia@intel.com> wrote:
>> This is done in preparation for the upcoming time based transmission
>> patchset. Now that skb->tstamp will be used to hold packet's txtime,
>> we must ensure that it is being cleared when traversing namespaces.
>> Also, doing that from skb_scrub_packet() would break our feature when
>> tunnels are used.
> 
> Then the right location to move to is skb_scrub_packet below the test for xnet.

Fixed, thanks.



> 
>> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
>> ---
>>  include/linux/netdevice.h | 1 +
>>  net/core/skbuff.c         | 1 -
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index dbe6344b727a..7104de2bc957 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -3379,6 +3379,7 @@ static __always_inline int ____dev_forward_skb(struct net_device *dev,
>>
>>         skb_scrub_packet(skb, true);
>>         skb->priority = 0;
>> +       skb->tstamp = 0;
>>         return 0;
>>  }
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 715c13495ba6..678fc5416ae1 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -4865,7 +4865,6 @@ EXPORT_SYMBOL(skb_try_coalesce);
>>   */
>>  void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>>  {
>> -       skb->tstamp = 0;
>>         skb->pkt_type = PACKET_HOST;
>>         skb->skb_iif = 0;
>>         skb->ignore_df = 0;
>> --
>> 2.16.2
>>
