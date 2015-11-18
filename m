From: Tom Herbert <tom@herbertland.com>
Date: Tue, 17 Nov 2015 16:20:17 -0800
Subject: [Intel-wired-lan] [PATCH V3] ixgbe: Handle extended IPv6
	headers in tx path
In-Reply-To: <CAKgT0Udx6aeEqZXD7NL+8o6TFquxABu0uhSDfoa0CWEwN3Vijw@mail.gmail.com>
References: <20151117230714.84537.25622.stgit@mdrustad-wks.jf.intel.com>
 <CAKgT0Udx6aeEqZXD7NL+8o6TFquxABu0uhSDfoa0CWEwN3Vijw@mail.gmail.com>
Message-ID: <CALx6S36AyN6E42UmoosqXnj=d5Kz_7UWijXkK=9RHmLBDKQ5TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 17, 2015 at 3:56 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Tue, Nov 17, 2015 at 3:07 PM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
>> Check for and handle IPv6 extended headers so that tx checksum
>> offload can be done. Also use skb_checksum_help for unexpected
>> cases. Thanks to Tom Herbert for noticing these problems. Thanks
>> to Alexander Duyck for recognizing problems with the first version
>> of this patch.
>>
>> Reported-by: Tom Herbert <tom@herbertland.com>
>> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
>> ---
>> Changed in V2:
>> - Use ipv6_skip_exthdr instead of ipv6_find_hdr
>> - Move code into L3 processing and avoid any possible loop
>> - Handle encapsulated IPv6 extended headers correctly
>> Changed in V3:
>> - Call skb_checksum_help for unexpected cases
>> - Move unlikely() calls to more appropriate places
>> - Reaarange terms in call to ipv6_skip_exthdr to reduce line count
>> - Combined 2 unlikely error cases into one
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 1ffbe85eab7b..c058ce616b28 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -7229,6 +7229,8 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>>                         struct tcphdr *tcphdr;
>>                         u8 *raw;
>>                 } transport_hdr;
>> +               __be16 frag_off;
>> +               int rc;
>>
>>                 if (skb->encapsulation) {
>>                         network_hdr.raw = skb_inner_network_header(skb);
>> @@ -7252,6 +7254,21 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>>                 case 6:
>>                         vlan_macip_lens |= transport_hdr.raw - network_hdr.raw;
>>                         l4_hdr = network_hdr.ipv6->nexthdr;
>> +                       if (likely((transport_hdr.raw - network_hdr.raw) ==
>> +                                  sizeof(struct ipv6hdr)))
>> +                               break;
>> +                       rc = ipv6_skip_exthdr(skb, network_hdr.raw - skb->data +
>> +                                                  sizeof(struct ipv6hdr),
>> +                                             &l4_hdr, &frag_off);
>> +                       if (unlikely(rc < 0 || frag_off)) {
>> +                               if (net_ratelimit()) {
>> +                                       dev_warn(tx_ring->dev,
>> +                                                "ipv6_skip_exthdr returns %d\n",
>> +                                                rc);
>
> Now that I am seeing this it seems like this is getting kind of
> clunky.  Perhaps we should look at coalescing all of these warning
> messages into one message at the end of the l4_hdr section.
>
TBH, almost all of this complexity would go away if the device
implemented NETIF_F_HW_CSUM. Since the NIC already seems capable of
taking a variable value for the L4 hdr offset, it seems like this is
already close to being able to that. Probably, we just need to disable
the pseudo header calculation being done in the NIC. I suspect the
offset still must either be 16 or 6 (corresponding to TCP or UDP
checksum offsets), but even with this limitation NETIF_F_HW_CSUM is a
win.

Tom
