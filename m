From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 20 Apr 2022 12:37:08 +0200
Subject: [Intel-wired-lan] [PATCH 1/2] Fix race in igc_xdp_xmit_zc
In-Reply-To: <20220415210421.11217-1-jeff.evanson@qsc.com>
References: <20220415210421.11217-1-jeff.evanson@qsc.com>
Message-ID: <20220420103708.1841070-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Evanson <jeff.evanson@gmail.com>
Date: Fri, 15 Apr 2022 15:04:21 -0600

> in igc_xdp_xmit_zc, initialize next_to_use while holding the netif_tx_lock
> to prevent racing with other users of the tx ring
> 
> Signed-off-by: Jeff Evanson <jeff.evanson@qsc.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1c00ee310c19..a36a18c84aeb 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2598,7 +2598,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  	struct netdev_queue *nq = txring_txq(ring);
>  	union igc_adv_tx_desc *tx_desc = NULL;
>  	int cpu = smp_processor_id();
> -	u16 ntu = ring->next_to_use;
> +	u16 ntu;

Please don't break the RCT (reverse christmas tree) style here. You
should move it to the bottom of the declaration block, ideally
combine it with the declaration of @budget as they're both u16s.

>  	struct xdp_desc xdp_desc;
>  	u16 budget;
>  
> @@ -2607,6 +2607,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  
>  	__netif_tx_lock(nq, cpu);
>  
> +	ntu = ring->next_to_use;
> +

There's no need for this empty newline I believe.

>  	budget = igc_desc_unused(ring);
>  
>  	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> -- 
> 2.17.1

Thanks,
Al
