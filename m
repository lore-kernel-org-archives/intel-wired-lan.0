From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 2 Feb 2016 16:06:56 -0800
Subject: [Intel-wired-lan] [next PATCH v3 11/15] i40e/i40evf: Enable
 support for SKB_GSO_UDP_TUNNEL_CSUM
In-Reply-To: <20160202144924.0000795d@unknown>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051729.12004.54009.stgit@localhost.localdomain>
 <20160202144924.0000795d@unknown>
Message-ID: <CAKgT0UfXKTyxaf35aO-eyizhsNyDVLMTLNi3KB7XpPeQ8k44KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Feb 2, 2016 at 2:49 PM, Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
> On Sun, 24 Jan 2016 21:17:29 -0800
> Alexander Duyck <aduyck@mirantis.com> wrote:
>
>> The XL722 has support for providing the outer UDP tunnel checksum on
>
> X722, not XL722
>
>> transmits.  Make use of this feature to support segmenting UDP tunnels with
>> outer checksums enabled.
>>
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> ---
>
> ...
>
>> +             if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
>> +                     /* determine offset of outer transport header */
>> +                     l4_offset = l4.hdr - skb->data;
>> +
>> +                     /* remove payload length from outer checksum */
>> +                     paylen = (__force u16)l4.udp->check;
>> +                     paylen += ntohs(1) * (u16)~(skb->len - l4_offset);
>
> Can we get a comment about how this is supposed to work?  Doesn't it
> have endian problems?  I understand these lines are removing the payload
> length from the checksum by getting the length of the payload,
> inverting it and removing it from the checksum, and then below,
> updating the checksum, but it is really hard to follow why you use
> ntohs(1) without some explanation.

The logic is actually based off of
csum_tcpudp_nofold(http://lxr.free-electrons.com/source/lib/checksum.c#L193).
The byte swapping is taken care of via a combination of the ntohs
which converts to a shift, and the csum_fold call below.  What happens
is that by shifting by 8 we push the lower byte into the upper slot,
and the upper slot into the next 16 bits.  Then when csum_fold is run
it shifts the upper 16 bits down by 16 and adds them to the lower 16
which takes care of the other half of the rotation.

>> +                     l4.udp->check = ~csum_fold((__force __wsum)paylen);
>> +             }
>> +
