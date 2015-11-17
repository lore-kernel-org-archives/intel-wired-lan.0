From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Nov 2015 15:56:55 -0800
Subject: [Intel-wired-lan] [PATCH V3] ixgbe: Handle extended IPv6
	headers in tx path
In-Reply-To: <20151117230714.84537.25622.stgit@mdrustad-wks.jf.intel.com>
References: <20151117230714.84537.25622.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <CAKgT0Udx6aeEqZXD7NL+8o6TFquxABu0uhSDfoa0CWEwN3Vijw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 17, 2015 at 3:07 PM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
> Check for and handle IPv6 extended headers so that tx checksum
> offload can be done. Also use skb_checksum_help for unexpected
> cases. Thanks to Tom Herbert for noticing these problems. Thanks
> to Alexander Duyck for recognizing problems with the first version
> of this patch.
>
> Reported-by: Tom Herbert <tom@herbertland.com>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changed in V2:
> - Use ipv6_skip_exthdr instead of ipv6_find_hdr
> - Move code into L3 processing and avoid any possible loop
> - Handle encapsulated IPv6 extended headers correctly
> Changed in V3:
> - Call skb_checksum_help for unexpected cases
> - Move unlikely() calls to more appropriate places
> - Reaarange terms in call to ipv6_skip_exthdr to reduce line count
> - Combined 2 unlikely error cases into one
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 1ffbe85eab7b..c058ce616b28 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7229,6 +7229,8 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>                         struct tcphdr *tcphdr;
>                         u8 *raw;
>                 } transport_hdr;
> +               __be16 frag_off;
> +               int rc;
>
>                 if (skb->encapsulation) {
>                         network_hdr.raw = skb_inner_network_header(skb);
> @@ -7252,6 +7254,21 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>                 case 6:
>                         vlan_macip_lens |= transport_hdr.raw - network_hdr.raw;
>                         l4_hdr = network_hdr.ipv6->nexthdr;
> +                       if (likely((transport_hdr.raw - network_hdr.raw) ==
> +                                  sizeof(struct ipv6hdr)))
> +                               break;
> +                       rc = ipv6_skip_exthdr(skb, network_hdr.raw - skb->data +
> +                                                  sizeof(struct ipv6hdr),
> +                                             &l4_hdr, &frag_off);
> +                       if (unlikely(rc < 0 || frag_off)) {
> +                               if (net_ratelimit()) {
> +                                       dev_warn(tx_ring->dev,
> +                                                "ipv6_skip_exthdr returns %d\n",
> +                                                rc);

Now that I am seeing this it seems like this is getting kind of
clunky.  Perhaps we should look at coalescing all of these warning
messages into one message at the end of the l4_hdr section.

Also it seems like you could ignore the rc value and just focus on the
frag_off value.  If the function fails the l4_hdr will remain the
extended header value and fall into the error path in the l4_hdr
switch section below.  You could probably use NEXTHDR_FRAGMENT as the
l4_hdr value if frag_off is non-zero.

> +                               }
> +                               skb_checksum_help(skb);
> +                               goto no_csum;
> +                       }
>                         break;
>                 default:
>                         if (unlikely(net_ratelimit())) {
> @@ -7259,6 +7276,8 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>                                          "partial checksum but version=%d\n",
>                                          network_hdr.ipv4->version);
>                         }
> +                       skb_checksum_help(skb);
> +                       goto no_csum;
>                 }

Perhaps this can be coalesced into one warning message below in the
l4_hdr check section.  The l4_hdr won't be updated anyway so it will
fall through to the error case there.

>
>                 switch (l4_hdr) {
> @@ -7282,13 +7301,15 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>                                  "partial checksum but l4 proto=%x!\n",
>                                  l4_hdr);
>                         }

The bit up here could probably be updated to include the L3 protocol
type.  With the L3 and L4 protocol values you should be able to get
the same amount of error data as you could with the previous messages.
Basically we just want to avoid adding too much unnecessary code to
handle exceptions that aren't likely to happen.

> -                       break;
> +                       skb_checksum_help(skb);
> +                       goto no_csum;
>                 }
>
>                 /* update TX checksum flag */
>                 first->tx_flags |= IXGBE_TX_FLAGS_CSUM;
>         }
>
> +no_csum:
>         /* vlan_macip_lens: MACLEN, VLAN tag */
>         vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
>
>
