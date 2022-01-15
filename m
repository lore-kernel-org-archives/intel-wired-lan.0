From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sat, 15 Jan 2022 08:54:52 +0100
Subject: [Intel-wired-lan] [PATCH net v1] ice: fix IPIP and SIT TSO
 offload
In-Reply-To: <20220114233839.67979-1-jesse.brandeburg@intel.com>
References: <20220114233839.67979-1-jesse.brandeburg@intel.com>
Message-ID: <434da5fe-62cb-7ad6-0cb7-e117c6f716eb@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jesse,


Am 15.01.22 um 00:38 schrieb Jesse Brandeburg:
> The driver was avoiding offload for IPIP (at least) frames due to
> parsing the inner header offsets incorrectly when trying to check
> lengths.
> 
> This length check works for VXLAN frames but fails on IPIP frames
> because skb_transport_offset points to the inner header in IPIP
> frames, which meant the subtraction of transport_header from
> inner_network_header returns a negative value (-20).
> 
> With the code before this patch, everything continued to work, but GSO
> was being used to segment, causing throughputs of 1.5Gb/s per thread.
> After this patch, throughput is more like 10Gb/s per thread for IPIP
> traffic.

Would be nice to reflow for 75 characters per line.

> Fixes: e94d44786693 ("ice: Implement filter sync, NDO operations and bump version")

Wow present since Linux 4.17.

> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> --
> Testing Hints: test IPIP tunnel and VXLAN tunnel, both should use TSO.

Do you have a script to test it? Would be nice to have in the commit 
message.

> ---
>   .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  1 +
>   drivers/net/ethernet/intel/ice/ice_main.c     | 25 +++++++++++++------
>   2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> index d981dc6f2323..85a612838a89 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> @@ -568,6 +568,7 @@ struct ice_tx_ctx_desc {
>   			(0x3FFFFULL << ICE_TXD_CTX_QW1_TSO_LEN_S)
>   
>   #define ICE_TXD_CTX_QW1_MSS_S	50
> +#define ICE_TXD_CTX_MIN_MSS	64
>   
>   #define ICE_TXD_CTX_QW1_VSI_S	50
>   #define ICE_TXD_CTX_QW1_VSI_M	(0x3FFULL << ICE_TXD_CTX_QW1_VSI_S)
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 73c61cdb036f..105b62b5e7cb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -8540,6 +8540,7 @@ ice_features_check(struct sk_buff *skb,
>   		   struct net_device __always_unused *netdev,
>   		   netdev_features_t features)
>   {
> +	bool gso = skb_is_gso(skb);

Maybe name it `is_gso`, so it?s clear it?s a boolean, and make it const?

>   	size_t len;
>   
>   	/* No point in doing any of this if neither checksum nor GSO are
> @@ -8552,24 +8553,32 @@ ice_features_check(struct sk_buff *skb,
>   	/* We cannot support GSO if the MSS is going to be less than
>   	 * 64 bytes. If it is then we need to drop support for GSO.
>   	 */
> -	if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_size < 64))
> +	if (gso && (skb_shinfo(skb)->gso_size < ICE_TXD_CTX_MIN_MSS))
>   		features &= ~NETIF_F_GSO_MASK;
>   
> -	len = skb_network_header(skb) - skb->data;
> +	len = skb_network_offset(skb);
>   	if (len > ICE_TXD_MACLEN_MAX || len & 0x1)
>   		goto out_rm_features;
>   
> -	len = skb_transport_header(skb) - skb_network_header(skb);
> +	len = skb_network_header_len(skb);

Ok, for networking unfamiliar, this is refactoring.

>   	if (len > ICE_TXD_IPLEN_MAX || len & 0x1)
>   		goto out_rm_features;
>   
>   	if (skb->encapsulation) {
> -		len = skb_inner_network_header(skb) - skb_transport_header(skb);
> -		if (len > ICE_TXD_L4LEN_MAX || len & 0x1)
> -			goto out_rm_features;
> +		/* this must work for vxlan frames AND IPIP/SIT frames, and in
> +		 * the case of IPIP frames, the transport header pointer is
> +		 * after the inner header! So check to make sure that this
> +		 * is a GRE or UDP_TUNNEL frame before doing that math.
> +		 */
> +		if (gso && (skb_shinfo(skb)->gso_type &
> +			    (SKB_GSO_GRE | SKB_GSO_UDP_TUNNEL))) {
> +			len = skb_inner_network_header(skb) -
> +			      skb_transport_header(skb);


> +			if (len > ICE_TXD_L4LEN_MAX || len & 0x1)
> +				goto out_rm_features;
> +		}
>   
> -		len = skb_inner_transport_header(skb) -
> -		      skb_inner_network_header(skb);
> +		len = skb_inner_network_header_len(skb);

Just refactoring.

>   		if (len > ICE_TXD_IPLEN_MAX || len & 0x1)
>   			goto out_rm_features;
>   	}

Next time, I?d prefer a separate patch doing the refactorings.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>.


Kind regards,

Paul


PS: Is this also needed for i40e 
(`drivers/net/ethernet/intel/i40e/i40e_main.c`)?
