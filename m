From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Wed, 9 Oct 2019 17:39:19 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] i40e: Add UDP segmentation
 offload support
In-Reply-To: <1570658777-13459-4-git-send-email-johunt@akamai.com>
References: <1570658777-13459-1-git-send-email-johunt@akamai.com>
 <1570658777-13459-4-git-send-email-johunt@akamai.com>
Message-ID: <5f4af1c5-c2d1-d643-3fb2-fe4bd0e7e8cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 10/9/2019 3:06 PM, Josh Hunt wrote:
> Based on a series from Alexander Duyck this change adds UDP segmentation
> offload support to the i40e driver.
> 
> CC: Alexander Duyck <alexander.h.duyck@intel.com>
> CC: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6031223eafab..56f8c52cbba1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -12911,6 +12911,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
>   			  NETIF_F_GSO_IPXIP6		|
>   			  NETIF_F_GSO_UDP_TUNNEL	|
>   			  NETIF_F_GSO_UDP_TUNNEL_CSUM	|
> +			  NETIF_F_GSO_UDP_L4		|
>   			  NETIF_F_SCTP_CRC		|
>   			  NETIF_F_RXHASH		|
>   			  NETIF_F_RXCSUM		|
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index e3f29dc8b290..0b32f04a6255 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2960,10 +2960,16 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
>   
>   	/* remove payload length from inner checksum */
>   	paylen = skb->len - l4_offset;
> -	csum_replace_by_diff(&l4.tcp->check, (__force __wsum)htonl(paylen));
>   
> -	/* compute length of segmentation header */
> -	*hdr_len = (l4.tcp->doff * 4) + l4_offset;
> +	if (skb->csum_offset == offsetof(struct tcphdr, check)) {

Isn't it more relevant to check for gso_type rather than base this on 
the csum_offset?


> +		csum_replace_by_diff(&l4.tcp->check, (__force __wsum)htonl(paylen));
> +		/* compute length of segmentation header */
> +		*hdr_len = (l4.tcp->doff * 4) + l4_offset;
> +	} else {
> +		csum_replace_by_diff(&l4.udp->check, (__force __wsum)htonl(paylen));
> +		/* compute length of segmentation header */
> +		*hdr_len = sizeof(*l4.udp) + l4_offset;
> +	}
>   
>   	/* pull values out of skb_shinfo */
>   	gso_size = skb_shinfo(skb)->gso_size;
> 
