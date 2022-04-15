From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 15 Apr 2022 18:36:31 +0200
Subject: [Intel-wired-lan] [PATCH net v1] ice: fix PTP stale Tx
 timestamps cleanup
In-Reply-To: <20220414102358.13486-1-michal.michalik@intel.com>
References: <20220414102358.13486-1-michal.michalik@intel.com>
Message-ID: <280c31b8-9f70-a0b5-2450-510903bd0d4e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Michal,


Thank you for your patch.

Am 14.04.22 um 12:23 schrieb Michal Michalik:
> Read stale PTP Tx timestamps from PHY on cleanup.
> 
> After running out of Tx timestamps request handlers hardware (HW) stops
> reporting finished requests. Function ice_ptp_tx_tstamp_cleanup() used
> to only cleanup stale handlers in driver and was leaving the hardware

Nit: clean up

> registers not read. Not reading stale PTP Tx timestamps prevents next
> interrupts from arriving and makes timestamping not usable.

Nit: unusable

Do you have a method, how to force the network device to run out of 
timestamps request handlers?

> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a1cd332..826a508 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2287,6 +2287,7 @@ ice_ptp_init_tx_e810(struct ice_pf *pf, struct ice_ptp_tx *tx)
>   
>   /**
>    * ice_ptp_tx_tstamp_cleanup - Cleanup old timestamp requests that got dropped
> + * @hw: pointer to the hw struct
>    * @tx: PTP Tx tracker to clean up
>    *
>    * Loop through the Tx timestamp requests and see if any of them have been
> @@ -2295,7 +2296,7 @@ ice_ptp_init_tx_e810(struct ice_pf *pf, struct ice_ptp_tx *tx)
>    * timestamp will never be captured. This might happen if the packet gets
>    * discarded before it reaches the PHY timestamping block.
>    */
> -static void ice_ptp_tx_tstamp_cleanup(struct ice_ptp_tx *tx)
> +static void ice_ptp_tx_tstamp_cleanup(struct ice_hw *hw, struct ice_ptp_tx *tx)
>   {
>   	u8 idx;
>   
> @@ -2304,11 +2305,15 @@ static void ice_ptp_tx_tstamp_cleanup(struct ice_ptp_tx *tx)
>   
>   	for_each_set_bit(idx, tx->in_use, tx->len) {
>   		struct sk_buff *skb;
> +		u64 raw_tstamp;
>   
>   		/* Check if this SKB has been waiting for too long */
>   		if (time_is_after_jiffies(tx->tstamps[idx].start + 2 * HZ))
>   			continue;
>   
> +		ice_read_phy_tstamp(hw, tx->quad, idx + tx->quad_offset,
> +				    &raw_tstamp);
> +

Are compilers or code analyzer going to complain, that nothing will be 
done with `raw_tstamp`? Is there some attribute, that it?s unused? Maybe 
also add a comment, this is just to read the value, and it?s not going 
to be used.

>   		spin_lock(&tx->lock);
>   		skb = tx->tstamps[idx].skb;
>   		tx->tstamps[idx].skb = NULL;
> @@ -2330,7 +2335,7 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
>   
>   	ice_ptp_update_cached_phctime(pf);
>   
> -	ice_ptp_tx_tstamp_cleanup(&pf->ptp.port.tx);
> +	ice_ptp_tx_tstamp_cleanup(&pf->hw, &pf->ptp.port.tx);
>   
>   	/* Run twice a second */
>   	kthread_queue_delayed_work(ptp->kworker, &ptp->work,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
