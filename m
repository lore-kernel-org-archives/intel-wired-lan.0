From: Patil, Kiran <kiran.patil@intel.com>
Date: Mon, 25 Jan 2016 16:16:58 -0800
Subject: [Intel-wired-lan] [next PATCH v3 12/15] i40e: Fix ATR in
 relation to tunnels
In-Reply-To: <CAKgT0UeS_wFUYqa2_6Hb3BZda+OjXeJ2hY4wwGS99TC6s28jeA@mail.gmail.com>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051736.12004.13420.stgit@localhost.localdomain>
 <56A67734.7050007@intel.com>
 <CAKgT0UeS_wFUYqa2_6Hb3BZda+OjXeJ2hY4wwGS99TC6s28jeA@mail.gmail.com>
Message-ID: <56A6BAFA.7010602@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Acked-by: Kiran Patil <kiran.patil@intel.com>


On 1/25/2016 2:21 PM, Alexander Duyck wrote:
> On Mon, Jan 25, 2016 at 11:27 AM, Patil, Kiran <kiran.patil@intel.com> wrote:
>>
>> Thanks Alex for fixing it. Please see in-line comments/suggestion.
>>
>> -- Kiran P.
>>
>>
>> On 1/24/2016 9:17 PM, Alexander Duyck wrote:
>>> This patch contains a number of fixes to make certain that we are using
>>> the correct protocols when parsing both the inner and outer headers of a
>>> frame that is mixed between IPv4 and IPv6 for inner and outer.
>>>
>>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>>> ---
>>>    drivers/net/ethernet/intel/i40e/i40e_txrx.c |   28
>>> +++++++++++----------------
>>>    1 file changed, 11 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>> index 6a76c169c07e..ed8d13637c15 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>> @@ -2030,10 +2030,9 @@ tx_only:
>>>     * @tx_ring:  ring to add programming descriptor to
>>>     * @skb:      send buffer
>>>     * @tx_flags: send tx flags
>>> - * @protocol: wire protocol
>>>     **/
>>>    static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>>> -                    u32 tx_flags, __be16 protocol)
>>> +                    u32 tx_flags)
>>>    {
>>>          struct i40e_filter_program_desc *fdir_desc;
>>>          struct i40e_pf *pf = tx_ring->vsi->back;
>>> @@ -2045,6 +2044,7 @@ static void i40e_atr(struct i40e_ring *tx_ring,
>>> struct sk_buff *skb,
>>>          struct tcphdr *th;
>>>          unsigned int hlen;
>>>          u32 flex_ptype, dtype_cmd;
>>> +       u8 l4_proto;
>>>          u16 i;
>>>          /* make sure ATR is enabled */
>>> @@ -2058,6 +2058,7 @@ static void i40e_atr(struct i40e_ring *tx_ring,
>>> struct sk_buff *skb,
>>>          if (!tx_ring->atr_sample_rate)
>>>                  return;
>>>    +     /* Currently only IPv4/IPv6 with TCP is supported */
>>>          if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
>>>                  return;
>>>    @@ -2068,26 +2069,19 @@ static void i40e_atr(struct i40e_ring *tx_ring,
>>> struct sk_buff *skb,
>>                        union {
>>                                unsigned char *transport;
>>                                struct tcphdr *th; /* if needed */
>>                                struct udphdr *uh; /* if needed */
>>                       } l4_hdr;
> I'm not sure what the point of this is.  See the comment above which I
> moved from a few lines below about "Currently only IPv4/IPv6 with TCP
> is supported".  There is only TCP header, the transport header is okay
> to have but that is essentially what we compute via network + hlen
> anyway.
Agree. For now, looks like we support IPv4/IPv6 with TCP, hence it is 
not needed.
>>                      /* Obtain start of transport */
>>                       if ((tx_flags & I40E_TX_FLAGS_TUNNEL))
>>                                  l4_hdr.transport =
>> skb_inner_transport_header(skb);
>>                      else
>>                                  l4_hdr.transport =
>> skb_transport_header(skb);
> If an offload is not requested there is no guarantee that the
> transport header will be populated.  For example if someone is pumping
> out raw frames with no offloads the only header offsets that will be
> set are for network(L3) and MAC(L2).
Thanks for good info. I didn't knew about it.
>
>>>                  /* snag network header to get L4 type and address */
>>>                  hdr.network = skb_network_header(skb);
>>>    -             /* Currently only IPv4/IPv6 with TCP is supported
>>> -                * access ihl as u8 to avoid unaligned access on ia64
>>> -                */
>>> +               /* access ihl as u8 to avoid unaligned access on ia64 */
>>>                  if (tx_flags & I40E_TX_FLAGS_IPV4)
>>>                          hlen = (hdr.network[0] & 0x0F) << 2;
>>> -               else if (protocol == htons(ETH_P_IPV6))
>>> -                       hlen = sizeof(struct ipv6hdr);
>>>                  else
>>> -                       return;
>>> +                       hlen = sizeof(struct ipv6hdr);
>>>          }
>>>    -     /* Currently only IPv4/IPv6 with TCP is supported
>>> -        * Note: tx_flags gets modified to reflect inner protocols in
>>> +       /* Note: tx_flags gets modified to reflect inner protocols in
>>>           * tx_enable_csum function if encap is enabled.
>>>           */
>>> -       if ((tx_flags & I40E_TX_FLAGS_IPV4) &&
>>> -           (hdr.ipv4->protocol != IPPROTO_TCP))
>>> -               return;
>>> -       else if ((tx_flags & I40E_TX_FLAGS_IPV6) &&
>>> -                (hdr.ipv6->nexthdr != IPPROTO_TCP))
>>> +       l4_proto = (tx_flags & I40E_TX_FLAGS_IPV4) ? hdr.ipv4->protocol :
>>> +                                                    hdr.ipv6->nexthdr;
>>                      We need to skip extended IPV6 header as well and obtain
>> correct value for
>>                      l4_proto & hlen (may be something like this):
>>
>>                      {
>>                              __be16 frag_off;
>>                              u8 next_hdr;
>>                              l4_proto = hdr.ipv6->nexthdr;
>>                              if (unlikely((l4_hdr.transport - hdr.network) ==
>> sizeof(struct ipv6hdr))) {
>>                                      off = ipv6_skip_exthdr(skb, hdr.network
>> - skb->data + sizeof(struct ipv6hdr),
>> &l4_proto,&frag_off);
>>                                      if (unlikely(off < 0))
>>                                                      return; /* Unexpected */
>>                                      if (unlikely(frag_off))
>>                                              l4_proto= NEXTHDR_FRAGMENT;
>>
>>                                      /* Update 'hlen' for the code below to
>> work properly */
>>                                      hlen = l4_hdr.transport - hdr.network;
>>                              }
>>                      }
> Once again.  See the comment about IPv4/v6 and TCP only.  Your code as
> suggested breaks that.
>
> Also instead of using ipv6_skip_exthdr we would be better off in this
> case using ipv6_find_hdr since we know we are looking for TCP, but we
> don't know where the TCP header actually is as we aren't guaranteed
> skb_transport_header will exist.
Agree that we can use ipv6_find_hdr since we know what we are looking 
forward, that will solve the problem of what is the value for 
'next_protocol'. Certainly this patch make sense and follow-on patch can 
address extended IPv6 header support.

>
> For now I think it would be better to leave this patch as is since it
> is fixing a number of bugs that were in the code without introducing
> any new ones.  I will submit a follow-on patch that can add support
> for ATR in the case of IPv6 extension headers being present.
>
> - Alex

Thanks,
-- Kiran P.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160125/6984ba8f/attachment-0001.html>
