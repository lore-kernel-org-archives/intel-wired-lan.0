From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Mon, 16 Nov 2015 18:42:26 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle extended IPv6 headers
 in tx path
In-Reply-To: <56468D47.3000608@gmail.com>
References: <20151105010227.984.84717.stgit@mdrustad-wks.jf.intel.com>
 <305E19FFAC908240AB6DEBD1E2D8C1E180C17A68@ORSMSX108.amr.corp.intel.com>
 <564653B7.90100@gmail.com> <0BBBE631-C4E0-4605-82B4-424A222930C4@intel.com>
 <56468D47.3000608@gmail.com>
Message-ID: <692E1BEC-5797-4874-9D36-A64C90B29DF5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On 11/13/2015 02:14 PM, Rustad, Mark D wrote:
>> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>> 
>>> What protocol types did you test this over?  Just curious as it seems it is using ip6_find_header without taking into account if we want the inner or outer IPv6 header.
>> You are right. The call to ipv6_find_header here will always look at the outer header, which is not correct in an encapsulated case.
>> 
>>> I believe in order to get that correct there should be an offset taken into account so that the inner header could be found instead of the outer in case skb->encapsulation is set.
>> I'll have to work that out.
> 
> If nothing else I think the offset is pretty easy to calculate since it should be network_hdr.raw - skb->data.

> I was doing some further looking into this and is there a reason for using ipv6_find_hdr instead of ipv6_skip_hdr?  It seems like the way you are using ipv6_find_hdr you aren't doing fragment verification and as a result you could end up trying to do a checksum on a fragment.  With ipv6_skip_hdr you would at least be forced to return the fragment pointer offset which you could test for to verify if this is a fragmented IPv6 frame.

You are absolutely right about this.

> My thought was if you were to compare the offset, which if I am not mistaken you already have to compute for ip header length in the Tx descriptor above, then you could do an if/else where you either use the old approach which just returns the value or ipv6_find_hdr in the else case.  The total cost added to the IPv6 hot path should consist of a comparison and an unused jump for the case without extended headers.

Yes, it is an inexpensive check, I was just trying to avoid even that, but see below.

> Also if I am not mistaken this does have the potential for an infinite loop as well, as all it would take is a malformed skb with an IPv6 extension header ending with NEXTHDR_NONE requesting a checksum offload wouldn't it?  From what I can tell ipv6_find_hdr can return that as a value if you are using the -1 target value, and it would result in you looping forever.  It isn't the kind of thing you would find with standard testing, but a fuzzer might be able to trigger it on a raw socket.

And you are absolutely right about this too. I was sure that I had looked at the case, but you know, I think I was looking at the wrong (right) function.

I will make a new version in line with what you are suggesting. Thanks for all of your thought and effort on this. I'll be sure to add a tunneled IPv6 session in my test.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151116/a2ef512d/attachment.asc>
