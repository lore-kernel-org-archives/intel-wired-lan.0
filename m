From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Nov 2015 09:01:00 -0800
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Handle extended IPv6
	headers in tx path
In-Reply-To: <CALx6S34KEGEJXtd2BzgnzyexAzfdF+FvaaYXUhcxAM7hiLgEdg@mail.gmail.com>
References: <20151117002647.49052.40409.stgit@mdrustad-wks.jf.intel.com>
 <CALx6S34wd9_qX7sTM=7tx3w+bfhg+rA-J42sjdCos8Jy-cNLwA@mail.gmail.com>
 <CAKgT0UdpoPF2e9cD8mS=hgPdvrZ-suVqx4bCrmjxf9BVqRfcMA@mail.gmail.com>
 <CALx6S34KEGEJXtd2BzgnzyexAzfdF+FvaaYXUhcxAM7hiLgEdg@mail.gmail.com>
Message-ID: <CAKgT0Udmcd6H_2xSirv_EDK5Bp0vrvm1d6DLx973bCHxFA-8zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 17, 2015 at 8:48 AM, Tom Herbert <tom@herbertland.com> wrote:
> On Tue, Nov 17, 2015 at 8:41 AM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>> On Mon, Nov 16, 2015 at 9:21 PM, Tom Herbert <tom@herbertland.com> wrote:
>>> On Mon, Nov 16, 2015 at 4:26 PM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
>>>> Check for and handle IPv6 extended headers so that tx checksum
>>>> offload can be done. Thanks to Tom Herbert for noticing this
>>>> problem. Thanks to Alexander Duyck for recognizing problems with
>>>> the first version of this patch.
>>>>
>>>> Reported-by: Tom Herbert <tom@herbertland.com>
>>>> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>>>> ---
>>>> Changed in V2:
>>>> - Use ipv6_skip_exthdr instead of ipv6_find_hdr
>>>> - Move code into L3 processing and avoid any possible loop
>>>> - Handle encapsulated IPv6 extended headers correctly
>>>> ---
>>>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>> index 1ffbe85eab7b..23f316a9ad5a 100644
>>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>> @@ -7229,6 +7229,8 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>>>>                         struct tcphdr *tcphdr;
>>>>                         u8 *raw;
>>>>                 } transport_hdr;
>>>> +               __be16 frag_off;
>>>> +               int rc;
>>>>
>>>>                 if (skb->encapsulation) {
>>>>                         network_hdr.raw = skb_inner_network_header(skb);
>>>> @@ -7252,6 +7254,23 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>>>>                 case 6:
>>>>                         vlan_macip_lens |= transport_hdr.raw - network_hdr.raw;
>>>>                         l4_hdr = network_hdr.ipv6->nexthdr;
>>>> +                       if (likely((transport_hdr.raw - network_hdr.raw) ==
>>>> +                                  sizeof(struct ipv6hdr)))
>>>> +                               break;
>>>> +                       rc = ipv6_skip_exthdr(skb, network_hdr.raw +
>>>> +                                                  sizeof(struct ipv6hdr) -
>>>> +                                                  skb->data,
>>>> +                                             &l4_hdr, &frag_off);
>>>> +                       if (rc < 0) {
>>>> +                               if (unlikely(net_ratelimit())) {
>>>> +                                       dev_warn(tx_ring->dev,
>>>> +                                                "ipv6_skip_exthdr returned %d\n",
>>>> +                                                rc);
>>>> +                               }
>>>> +                               break;
>>>> +                       }
>>>> +                       if (frag_off)
>>>> +                               l4_hdr = 0;
>>>>                         break;
>>>>                 default:
>>>>                         if (unlikely(net_ratelimit())) {
>>>>
>>>
>>> Failures should not result in dev_warn, just call skb_checksum_help
>>> instead. Ignoring CHECKSUM_PARTIAL is guaranteed to be sending a bad
>>> checksum!
>>
>> The problem is there are scenarios here where a checksum shouldn't be
>> computed.  If for example the frame is fragmented we should be
>> displaying some sort of error message and not computing the checksum
>> because no matter what we compute it isn't going to be valid.
>>
> If the stack is sending fragments with CHECKSUM_PARTIAL set then that
> is a bug higher in the stack-- the driver does not need to worry about
> that.

Right, but it is still something that needs to get fixed.  By
triggering the dev_warn here we at least create visibility that
something has gone horribly wrong.

- Alex
