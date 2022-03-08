From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue,  8 Mar 2022 13:51:59 +0100
Subject: [Intel-wired-lan] [PATCH intel-net] ice: fix NULL pointer
 dereference in ice_update_vsi_tx_ring_stats()
In-Reply-To: <20220307174739.55899-1-maciej.fijalkowski@intel.com>
References: <20220307174739.55899-1-maciej.fijalkowski@intel.com>
Message-ID: <20220308125159.1843373-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 7 Mar 2022 18:47:39 +0100

> It is possible to do NULL pointer dereference in routine that updates
> Tx ring stats. Currently only stats and bytes are updated when ring
> pointer is valid, but later on ring is accessed to propagate gathered Tx
> stats onto VSI stats.
> 
> Change the existing logic to move to next ring when ring is NULL.
> 
> Fixes: e72bba21355d ("ice: split ice_ring onto Tx/Rx separate structs")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 289e5c99e313..d3f8b6468b92 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6145,8 +6145,9 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
>  		u64 pkts = 0, bytes = 0;
>  
>  		ring = READ_ONCE(rings[i]);
> -		if (ring)
> -			ice_fetch_u64_stats_per_ring(&ring->syncp, ring->stats, &pkts, &bytes);
> +		if (!ring)
> +			continue;
> +		ice_fetch_u64_stats_per_ring(&ring->syncp, ring->stats, &pkts, &bytes);

Nice catch, thanks!

Acked-by: Alexander Lobakin <alexandr.lobakin@intel.com>

>  		vsi_stats->tx_packets += pkts;
>  		vsi_stats->tx_bytes += bytes;
>  		vsi->tx_restart += ring->tx_stats.restart_q;

                                   ^^^^
                                   lol

> -- 
> 2.33.1

Al
