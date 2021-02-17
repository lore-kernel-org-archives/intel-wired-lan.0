From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 17 Feb 2021 22:26:06 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix NULL ptr dereference
 on VSI filter sync
In-Reply-To: <1613561124-15464-1-git-send-email-michal.maloszewski@intel.com>
References: <1613561124-15464-1-git-send-email-michal.maloszewski@intel.com>
Message-ID: <e423d17ef916b7e81dbbca4eb81f746babbfdf1a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-02-17 at 11:25 +0000, Micha? Ma?oszewski wrote:
> Remove the reason of null pointer dereference in sync vsi filters.
> Added new I40E_VSI_RELEASING flag to signalize deleting and releasing
> of VSI resources to sync this thread with sync filters subtask.
> Without this patch it is possible to start update the vsi filter list
> after vsi is removed, that's causing a kernel oops.
> 
> Fixes: 17652c6336fd("i40e: remove unused argument")
> Reviewed-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> Reviewed-by: Fijalkowski, WitoldX <witoldx.fijalkowski@intel.com>
> Reviewed-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 79
> +++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 60 ++++++++++++++++---
> ---
>  2 files changed, 124 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 425d620..558b0ae 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -158,6 +158,7 @@ enum i40e_vsi_state_t {
>  	__I40E_VSI_OVERFLOW_PROMISC,
>  	__I40E_VSI_REINIT_REQUESTED,
>  	__I40E_VSI_DOWN_REQUESTED,
> +	__I40E_VSI_RELEASING,
>  	/* This must be last as it determines the size of the BITMAP */
>  	__I40E_VSI_STATE_SIZE__,
>  };
> @@ -425,6 +426,8 @@ struct i40e_channel {
>  	struct i40e_vsi *parent_vsi;
>  };
>  
> +struct i40e_ptp_pins_settings;
> +
>  static inline bool i40e_is_channel_macvlan(struct i40e_channel *ch)
>  {
>  	return !!ch->fwd;
> @@ -641,12 +644,83 @@ struct i40e_pf {
>  	struct i40e_rx_pb_config pb_cfg; /* Current Rx packet buffer
> config */
>  	struct i40e_dcbx_config tmp_cfg;
>  
> +/* GPIO defines used by PTP */
> +#define I40E_SDP3_2			18
> +#define I40E_SDP3_3			19

...

There's a lot of code here that isn't related to the patch and not
mentioned in the commit message. It also wasn't in your v1. It looks
like pieces of other patches. Please review your patch before sending
it.

Thanks,
Tony
