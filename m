From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 5 Mar 2021 10:03:58 +0100
Subject: [Intel-wired-lan] [PATCH RESEND][next] ice: Fix fall-through
 warnings for Clang
In-Reply-To: <20210305085257.GA138498@embeddedor>
References: <20210305085257.GA138498@embeddedor>
Message-ID: <833549f5-a191-b532-50bf-4ec343c48dd0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Gustavo,


Thank you for working on that.

Am 05.03.21 um 09:52 schrieb Gustavo A. R. Silva:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of just letting the code
> fall through to the next case.

It would be nice to have a short summary of the discrepancy between GCC 
and clang, and it was decided to go with the ?clang decision?, and not 
have clang adapt to GCC.

> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 02b12736ea80..207f6ee3a7f6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -143,6 +143,7 @@ ice_rx_csum(struct ice_ring *ring, struct sk_buff *skb,
>   	case ICE_RX_PTYPE_INNER_PROT_UDP:
>   	case ICE_RX_PTYPE_INNER_PROT_SCTP:
>   		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		break;
>   	default:
>   		break;
>   	}


Kind regards,

Paul
