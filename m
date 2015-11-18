From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 18 Nov 2015 00:19:07 +0000
Subject: [Intel-wired-lan] [PATCH V3] ixgbe: Handle extended IPv6
	headers in tx path
In-Reply-To: <CAKgT0Udx6aeEqZXD7NL+8o6TFquxABu0uhSDfoa0CWEwN3Vijw@mail.gmail.com>
References: <20151117230714.84537.25622.stgit@mdrustad-wks.jf.intel.com>
 <CAKgT0Udx6aeEqZXD7NL+8o6TFquxABu0uhSDfoa0CWEwN3Vijw@mail.gmail.com>
Message-ID: <CE2E2B48-289D-40F1-B68D-2471FDA9576E@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck <alexander.duyck@gmail.com> wrote:

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
> Also it seems like you could ignore the rc value and just focus on the
> frag_off value.

Almost. If rc < 0, then frag_off will not have been assigned to. If I initialize frag_off to 0, then rc can be completely eliminated as you suggest.

> If the function fails the l4_hdr will remain the
> extended header value and fall into the error path in the l4_hdr
> switch section below.  You could probably use NEXTHDR_FRAGMENT as the
> l4_hdr value if frag_off is non-zero.

Clever. That does get a bit of information out and coalesce the error cases nicely. I'll try that out.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151118/7776b41b/attachment-0001.asc>
