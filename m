From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 19 Mar 2021 12:00:23 +0100
Subject: [Intel-wired-lan] [PATCH intel-net] i40e: fix receiving of
 single packets in xsk zero-copy mode
In-Reply-To: <20210319094410.3633-1-magnus.karlsson@gmail.com>
References: <20210319094410.3633-1-magnus.karlsson@gmail.com>
Message-ID: <20210319110023.GA20353@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 19, 2021 at 10:44:10AM +0100, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix so that single packets are received immediately instead of in
> batches of 8. If you sent 1 pss to a system, you received 8 packets

pps?

> every 8 seconds instead of 1 packet every second. The problem behind
> this was that the work_done reporting from the Tx part of the driver
> was broken. The work_done reporting in i40e controls not only the
> reporting back to the napi logic but also the setting of the interrupt
> throttling logic. When Tx or Rx reports that it has more to do,
> interrupts are throttled or coalesced and when they both report that
> they are done, interrupts are armed right away. If the wrong work_done
> value is returned, the logic will start to throttle interrupts in a
> situation where it should have just enabled them. This leads to the
> undesired batching behavior seen in user-space.
> 
> Fix this by returning the correct boolean value from the Tx xsk
> zero-copy path. Return true if there is nothing to do or if we got
> fewer packets to process than we asked for. Return false if we got as
> many packets as the budget since there might be more packets we can
> process.
> 
> Fixes: 3106c580fb7c ("i40e: Use batched xsk Tx interfaces to increase performance")
> Reported-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index fc32c5019b0f..12ca84113587 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -471,7 +471,7 @@ static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
>  
>  	nb_pkts = xsk_tx_peek_release_desc_batch(xdp_ring->xsk_pool, descs, budget);
>  	if (!nb_pkts)
> -		return false;
> +		return true;
>  
>  	if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
>  		nb_processed = xdp_ring->count - xdp_ring->next_to_use;
> @@ -488,7 +488,7 @@ static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
>  
>  	i40e_update_tx_stats(xdp_ring, nb_pkts, total_bytes);
>  
> -	return true;
> +	return nb_pkts < budget;
>  }
>  
>  /**
> 
> base-commit: c79a707072fe3fea0e3c92edee6ca85c1e53c29f
> -- 
> 2.29.0
> 
