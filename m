From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 13 Nov 2015 22:14:03 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle extended IPv6 headers
 in tx path
In-Reply-To: <564653B7.90100@gmail.com>
References: <20151105010227.984.84717.stgit@mdrustad-wks.jf.intel.com>
 <305E19FFAC908240AB6DEBD1E2D8C1E180C17A68@ORSMSX108.amr.corp.intel.com>
 <564653B7.90100@gmail.com>
Message-ID: <0BBBE631-C4E0-4605-82B4-424A222930C4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck <alexander.duyck@gmail.com> wrote:

> What protocol types did you test this over?  Just curious as it seems it is using ip6_find_header without taking into account if we want the inner or outer IPv6 header.

You are right. The call to ipv6_find_header here will always look at the outer header, which is not correct in an encapsulated case.

> I believe in order to get that correct there should be an offset taken into account so that the inner header could be found instead of the outer in case skb->encapsulation is set.

I'll have to work that out.

>> @@ -7277,7 +7278,23 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>>  					IXGBE_ADVTXD_L4LEN_SHIFT;
>>  			break;
>>  		default:
>> -			if (unlikely(net_ratelimit())) {
>> +			if (network_hdr.ipv4->version == 6 &&
>> +			    ipv6_ext_hdr(l4_hdr)) {
> 
> Instead of testing for ipv6_ext_hdr why not just test with
>   if ((transport_hdr.raw - network_hdr.raw) != sizeof(struct ipv6hdr))

That does seem like it would work, but see below.

>> +				unsigned int offset = 0;
>> +				int ret;
>> +
>> +				ret = ipv6_find_hdr(skb, &offset, -1, NULL,
>> +						    NULL);
>> +				if (ret > 0) {
>> +					l4_hdr = ret;
>> +					goto again;
>> +				}
>> +				if (unlikely(net_ratelimit())) {
>> +					dev_warn(tx_ring->dev,
>> +						 "ipv6_find_hdr returned %d\n",
>> +						 ret);
>> +				}
>> +			} else if (unlikely(net_ratelimit())) {
>>  				dev_warn(tx_ring->dev,
>>  				 "partial checksum but l4 proto=%x!\n",
>>  				 l4_hdr);
> 
> You could also avoid most of this loop code if you just moved all this up into the IPv6 portion of the L3 processing.


I considered that, but really did not want to add any checks at all in what would normally (the non-extended header case) be the IPv6 hot path. And of course it isn't really a loop. It looks to me like if I eliminated the ipv6_ext_hdr call above, that, in this incarnation, it could be an infinite loop!

So I think the elimination of the ipv6_ext_hdr call should only be done if the code is put into the L3 processing. Is it worth another check in that hot path for something that, apparently, has never yet been used and is very unlikely to be a common case in most environments?

I prefer the current arrangement, because it puts the overhead on the less common path and no burden on the common one. I do need to fix the offset for the ipv6_find_hdr in any case - thanks for catching that!

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151113/ad7240a2/attachment.asc>
