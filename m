From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 2 Feb 2016 14:49:24 -0800
Subject: [Intel-wired-lan] [next PATCH v3 11/15] i40e/i40evf: Enable
 support for SKB_GSO_UDP_TUNNEL_CSUM
In-Reply-To: <20160125051729.12004.54009.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051729.12004.54009.stgit@localhost.localdomain>
Message-ID: <20160202144924.0000795d@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 24 Jan 2016 21:17:29 -0800
Alexander Duyck <aduyck@mirantis.com> wrote:

> The XL722 has support for providing the outer UDP tunnel checksum on

X722, not XL722

> transmits.  Make use of this feature to support segmenting UDP tunnels with
> outer checksums enabled.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---

...

> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
> +			/* determine offset of outer transport header */
> +			l4_offset = l4.hdr - skb->data;
> +
> +			/* remove payload length from outer checksum */
> +			paylen = (__force u16)l4.udp->check;
> +			paylen += ntohs(1) * (u16)~(skb->len - l4_offset);

Can we get a comment about how this is supposed to work?  Doesn't it
have endian problems?  I understand these lines are removing the payload
length from the checksum by getting the length of the payload,
inverting it and removing it from the checksum, and then below,
updating the checksum, but it is really hard to follow why you use
ntohs(1) without some explanation.

> +			l4.udp->check = ~csum_fold((__force __wsum)paylen);
> +		}
> +

