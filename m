From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 31 Jan 2016 16:00:30 +0100
Subject: [Intel-wired-lan] [PATCH] net: i40e: prevent access to
	uninitilized variables in i40e_tx_enable_csum()
In-Reply-To: <56ACE928.3080108@virtuozzo.com>
References: <56ACD7C6.1010808@virtuozzo.com> <56ACE928.3080108@virtuozzo.com>
Message-ID: <2765946.QCanWNG0gi@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Saturday 30 January 2016 19:47:36 Vasily Averin wrote:
> Patch makes safe an access to 'oiph' and 'oudph' variables
> if they was not initilized.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 47bd8b3..779f77e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2363,7 +2363,8 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
>                 }
>                 if ((tx_ring->flags & I40E_TXR_FLAGS_OUTER_UDP_CSUM) &&
>                     (l4_tunnel == I40E_TXD_CTX_UDP_TUNNELING)        &&
> -                   (*cd_tunneling & I40E_TXD_CTX_QW0_EXT_IP_MASK)) {
> +                   (*cd_tunneling & I40E_TXD_CTX_QW0_EXT_IP_MASK)   &&
> +                   oudph && oiph) {
>                         oudph->check = ~csum_tcpudp_magic(oiph->saddr,
>                                         oiph->daddr,
>                                         (skb->len - skb_transport_offset(skb)),

If we can actually get here with oudph==NULL or oiph==NULL, we should back
my patch instead and fix it another way.

In the version we have in net-next, that is not possible.

	Arnd
