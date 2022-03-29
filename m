From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 29 Mar 2022 14:00:01 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Fix logic of getting XSK
 pool associated with Tx queue
In-Reply-To: <20220329102752.1481125-1-ivecera@redhat.com>
References: <20220329102752.1481125-1-ivecera@redhat.com>
Message-ID: <YkL0wfgyCq5s8vdu@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 29, 2022 at 12:27:51PM +0200, Ivan Vecera wrote:
> Function ice_tx_xsk_pool() used to get XSK buffer pool associated
> with XDP Tx queue returns NULL when number of ordinary Tx queues
> is not equal to num_possible_cpus().
> 
> The function computes XDP Tx queue ID as an expression
> `ring->q_index - vsi->num_xdp_txq` but this is wrong because
> XDP Tx queues are placed after ordinary ones so the correct
> formula is `ring->q_index - vsi->alloc_txq`.
> 
> Prior commit 792b2086584f ("ice: fix vsi->txq_map sizing") number
> of XDP Tx queues was equal to number of ordinary Tx queues so
> the bug in mentioned function was hidden.
> 
> Reproducer:
> host# ethtool -L ens7f0 combined 1
> host# ./xdpsock -i ens7f0 -q 0 -t -N
> samples/bpf/xdpsock_user.c:kick_tx:794: errno: 6/"No such device or address"
> 
>  sock0 at ens7f0:0 txonly xdp-drv
>                 pps         pkts        0.00
> rx              0           0
> tx              0           0
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Fixes: 792b2086584f ("ice: fix vsi->txq_map sizing")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks for this fix! I did exactly the same patch yesterday and it's
already applied to bpf tree:

https://lore.kernel.org/bpf/20220328142123.170157-5-maciej.fijalkowski at intel.com/T/#u

Maciej

> ---
>  drivers/net/ethernet/intel/ice/ice.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index b0b27bfcd7a2..d4f1874df7d0 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -710,7 +710,7 @@ static inline struct xsk_buff_pool *ice_tx_xsk_pool(struct ice_tx_ring *ring)
>  	struct ice_vsi *vsi = ring->vsi;
>  	u16 qid;
>  
> -	qid = ring->q_index - vsi->num_xdp_txq;
> +	qid = ring->q_index - vsi->alloc_txq;
>  
>  	if (!ice_is_xdp_ena_vsi(vsi) || !test_bit(qid, vsi->af_xdp_zc_qps))
>  		return NULL;
> -- 
> 2.34.1
> 
