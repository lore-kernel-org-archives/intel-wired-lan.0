From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 27 Mar 2017 23:41:55 +0000
Subject: [Intel-wired-lan] [next PATCH S65 07/13] i40e: remove
 extraneous loop in i40e_vsi_wait_queues_disabled
In-Reply-To: <20170327094759.58321-8-alice.michael@intel.com>
References: <20170327094759.58321-1-alice.michael@intel.com>
 <20170327094759.58321-8-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857DE7ABE@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

> -----Original Message-----
> From: Michael, Alice
> Sent: Monday, March 27, 2017 2:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S65 07/13] i40e: remove extraneous loop in
> i40e_vsi_wait_queues_disabled
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We can simply check both Tx and Rx queues in a single loop, rather than
> repeating the loop twice.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ic06f26b0e3c2620e0e33c1a2999edda488e647ad
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 992dec1..cecbb5d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4431,7 +4431,7 @@ static void i40e_pf_unquiesce_all_vsi(struct i40e_pf
> *pf)
>   * i40e_vsi_wait_queues_disabled - Wait for VSI's queues to be disabled
>   * @vsi: the VSI being configured
>   *
> - * This function waits for the given VSI's queues to be disabled.
> + * Wait until all queues on a given VSI have been disabled.
>   **/
>  static int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
>  {
> @@ -4440,7 +4440,7 @@ static int i40e_vsi_wait_queues_disabled(struct
> i40e_vsi *vsi)
> 
>  	pf_q = vsi->base_queue;
>  	for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
> -		/* Check and wait for the disable status of the queue */
> +		/* Check and wait for the Tx queue */
>  		ret = i40e_pf_txq_wait(pf, pf_q, false);
>  		if (ret) {
>  			dev_info(&pf->pdev->dev,
> @@ -4448,11 +4448,7 @@ static int i40e_vsi_wait_queues_disabled(struct
> i40e_vsi *vsi)
>  				 vsi->seid, pf_q);
>  			return ret;
>  		}
> -	}
> -
> -	pf_q = vsi->base_queue;
> -	for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
> -		/* Check and wait for the disable status of the queue */
> +		/* Check and wait for the Tx queue */
>  		ret = i40e_pf_rxq_wait(pf, pf_q, false);
>  		if (ret) {
>  			dev_info(&pf->pdev->dev,
> --
> 2.9.3

