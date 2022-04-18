From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 18 Apr 2022 13:39:48 -0400
Subject: [Intel-wired-lan] [PATCH 1/2] Fix race in igc_xdp_xmit_zc
In-Reply-To: <20220415210421.11217-1-jeff.evanson@qsc.com>
References: <20220415210421.11217-1-jeff.evanson@qsc.com>
Message-ID: <871qxu5lzv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

Jeff Evanson <jeff.evanson@gmail.com> writes:

> in igc_xdp_xmit_zc, initialize next_to_use while holding the netif_tx_lock
> to prevent racing with other users of the tx ring

Some style things to change:
 - Some more details on what is the effect of the race condition, and
 perhaps the conditions to reproduce it (what I could imagine is that
 you would need two applications (one using AF_XDP and another one using
 AF_PACKET, for example) sending packets to the same queue.
 - I think this patch is solving a real problem, so directing this patch
 to the net-queue (using 'PATCH net-queue' as subject prefix) would make
 sense.
 - Please add the 'Fixes:' tag so this commit can be applied to any
 stable tree that makes sense.

Apart from those style changes, the code looks good.

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

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
>  	struct xdp_desc xdp_desc;
>  	u16 budget;
>  
> @@ -2607,6 +2607,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  
>  	__netif_tx_lock(nq, cpu);
>  
> +	ntu = ring->next_to_use;
> +
>  	budget = igc_desc_unused(ring);
>  
>  	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> -- 
> 2.17.1
>

-- 
Vinicius
