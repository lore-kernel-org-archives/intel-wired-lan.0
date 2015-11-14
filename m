From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 13 Nov 2015 17:24:23 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle extended IPv6 headers
 in tx path
In-Reply-To: <0BBBE631-C4E0-4605-82B4-424A222930C4@intel.com>
References: <20151105010227.984.84717.stgit@mdrustad-wks.jf.intel.com>
 <305E19FFAC908240AB6DEBD1E2D8C1E180C17A68@ORSMSX108.amr.corp.intel.com>
 <564653B7.90100@gmail.com> <0BBBE631-C4E0-4605-82B4-424A222930C4@intel.com>
Message-ID: <56468D47.3000608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/13/2015 02:14 PM, Rustad, Mark D wrote:
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> What protocol types did you test this over?  Just curious as it seems it is using ip6_find_header without taking into account if we want the inner or outer IPv6 header.
> You are right. The call to ipv6_find_header here will always look at the outer header, which is not correct in an encapsulated case.
>
>> I believe in order to get that correct there should be an offset taken into account so that the inner header could be found instead of the outer in case skb->encapsulation is set.
> I'll have to work that out.

If nothing else I think the offset is pretty easy to calculate since it 
should be network_hdr.raw - skb->data.

>>> @@ -7277,7 +7278,23 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>>>   					IXGBE_ADVTXD_L4LEN_SHIFT;
>>>   			break;
>>>   		default:
>>> -			if (unlikely(net_ratelimit())) {
>>> +			if (network_hdr.ipv4->version == 6 &&
>>> +			    ipv6_ext_hdr(l4_hdr)) {
>> Instead of testing for ipv6_ext_hdr why not just test with
>>    if ((transport_hdr.raw - network_hdr.raw) != sizeof(struct ipv6hdr))
> That does seem like it would work, but see below.
>
>>> +				unsigned int offset = 0;
>>> +				int ret;
>>> +
>>> +				ret = ipv6_find_hdr(skb, &offset, -1, NULL,
>>> +						    NULL);

I was doing some further looking into this and is there a reason for 
using ipv6_find_hdr instead of ipv6_skip_hdr?  It seems like the way you 
are using ipv6_find_hdr you aren't doing fragment verification and as a 
result you could end up trying to do a checksum on a fragment.  With 
ipv6_skip_hdr you would at least be forced to return the fragment 
pointer offset which you could test for to verify if this is a 
fragmented IPv6 frame.

>>> +				if (ret > 0) {
>>> +					l4_hdr = ret;
>>> +					goto again;
>>> +				}
>>> +				if (unlikely(net_ratelimit())) {
>>> +					dev_warn(tx_ring->dev,
>>> +						 "ipv6_find_hdr returned %d\n",
>>> +						 ret);
>>> +				}
>>> +			} else if (unlikely(net_ratelimit())) {
>>>   				dev_warn(tx_ring->dev,
>>>   				 "partial checksum but l4 proto=%x!\n",
>>>   				 l4_hdr);
>> You could also avoid most of this loop code if you just moved all this up into the IPv6 portion of the L3 processing.
>
> I considered that, but really did not want to add any checks at all in what would normally (the non-extended header case) be the IPv6 hot path. And of course it isn't really a loop. It looks to me like if I eliminated the ipv6_ext_hdr call above, that, in this incarnation, it could be an infinite loop!
>
> So I think the elimination of the ipv6_ext_hdr call should only be done if the code is put into the L3 processing. Is it worth another check in that hot path for something that, apparently, has never yet been used and is very unlikely to be a common case in most environments?
>
> I prefer the current arrangement, because it puts the overhead on the less common path and no burden on the common one. I do need to fix the offset for the ipv6_find_hdr in any case - thanks for catching that!

My thought was if you were to compare the offset, which if I am not 
mistaken you already have to compute for ip header length in the Tx 
descriptor above, then you could do an if/else where you either use the 
old approach which just returns the value or ipv6_find_hdr in the else 
case.  The total cost added to the IPv6 hot path should consist of a 
comparison and an unused jump for the case without extended headers.

Also if I am not mistaken this does have the potential for an infinite 
loop as well, as all it would take is a malformed skb with an IPv6 
extension header ending with NEXTHDR_NONE requesting a checksum offload 
wouldn't it?  From what I can tell ipv6_find_hdr can return that as a 
value if you are using the -1 target value, and it would result in you 
looping forever.  It isn't the kind of thing you would find with 
standard testing, but a fuzzer might be able to trigger it on a raw socket.

- Alex
