From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 13 Nov 2015 13:26:16 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Handle extended IPv6 headers
 in tx path
In-Reply-To: <20151105010227.984.84717.stgit@mdrustad-wks.jf.intel.com>
References: <20151105010227.984.84717.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <56465578.3080801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/04/2015 05:02 PM, Mark D Rustad wrote:
> Check for and handle IPv6 extended headers so that tx checksum
> offload can be done. Thanks to Tom Herbert for noticing this
> problem. Note that the goto back to process the final protocol
> value can never result in a loop, because it cannot be yet
> another extended header. Handling them in this manner avoids
> adding further checks to the non-extended header hot path.
>
> Reported-by: Tom Herbert <tom@herbertland.com>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 1ffbe85eab7b..f5730ddbee96 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7261,6 +7261,7 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>   			}
>   		}
>   
> +again:
>   		switch (l4_hdr) {
>   		case IPPROTO_TCP:
>   			type_tucmd |= IXGBE_ADVTXD_TUCMD_L4T_TCP;
> @@ -7277,7 +7278,23 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>   					IXGBE_ADVTXD_L4LEN_SHIFT;
>   			break;
>   		default:
> -			if (unlikely(net_ratelimit())) {
> +			if (network_hdr.ipv4->version == 6 &&
> +			    ipv6_ext_hdr(l4_hdr)) {

Instead of testing for ipv6_ext_hdr why not just test with
    if ((transport_hdr.raw - network_hdr.raw) != sizeof(struct ipv6hdr))

> +				unsigned int offset = 0;
> +				int ret;
> +
> +				ret = ipv6_find_hdr(skb, &offset, -1, NULL,
> +						    NULL);
> +				if (ret > 0) {
> +					l4_hdr = ret;
> +					goto again;
> +				}
> +				if (unlikely(net_ratelimit())) {
> +					dev_warn(tx_ring->dev,
> +						 "ipv6_find_hdr returned %d\n",
> +						 ret);
> +				}
> +			} else if (unlikely(net_ratelimit())) {
>   				dev_warn(tx_ring->dev,
>   				 "partial checksum but l4 proto=%x!\n",
>   				 l4_hdr);
>

You could also avoid most of this loop code if you just moved all this 
up into the IPv6 portion of the L3 processing.

- Alex
