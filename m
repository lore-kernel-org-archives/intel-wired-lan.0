From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 17 Aug 2017 12:43:49 -0700
Subject: [Intel-wired-lan] [PATCH v2 5/6] [net-next]net: i40e: Refactor
 VF BW rate limiting function to be reused on the PF as well
In-Reply-To: <150296407028.16167.6134503766227542081.stgit@anamdev.jf.intel.com>
References: <150296373549.16167.14331445560838257351.stgit@anamdev.jf.intel.com>
 <150296407028.16167.6134503766227542081.stgit@anamdev.jf.intel.com>
Message-ID: <260851c3-a339-5459-5d82-152db54ffb60@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/17/2017 3:01 AM, Amritha Nambiar wrote:
> This patch refactors the BW rate limiting for Tx traffic
> on the VF to be reused in the next patch for rate limiting Tx
> traffic for the VSIs on the PF as well.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h             |    5 ++
>   drivers/net/ethernet/intel/i40e/i40e_main.c        |   63 ++++++++++++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   45 +-------------
>   3 files changed, 70 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 2565280..304921e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -128,6 +128,10 @@
>   /* default to trying for four seconds */
>   #define I40E_TRY_LINK_TIMEOUT	(4 * HZ)
>   
> +/* BW rate limiting */
> +#define I40E_BW_CREDIT_DIVISOR		50 /* 50Mbps per BW credit */
> +#define I40E_MAX_BW_INACTIVE_ACCUM	4  /* accumulate 4 credits max */
> +
>   /* driver state flags */
>   enum i40e_state_t {
>   	__I40E_TESTING,
> @@ -1042,4 +1046,5 @@ static inline bool i40e_enabled_xdp_vsi(struct i40e_vsi *vsi)
>   }
>   
>   int i40e_create_queue_channel(struct i40e_vsi *vsi, struct i40e_channel *ch);
> +int i40e_set_bw_limit(struct i40e_vsi *vsi, u16 seid, u64 max_tx_rate);
>   #endif /* _I40E_H_ */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 5b783fc..fcf563a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -5405,6 +5405,69 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
>   }
>   
>   /**
> + * i40e_get_link_speed - Returns link speed for the interface
> + * @vsi: VSI to be configured
> + *
> + **/
> +int i40e_get_link_speed(struct i40e_vsi *vsi)
> +{
> +	struct i40e_pf *pf = vsi->back;
> +
> +	switch (pf->hw.phy.link_info.link_speed) {
> +	case I40E_LINK_SPEED_40GB:
> +		return 40000;
> +	case I40E_LINK_SPEED_25GB:
> +		return 25000;
> +	case I40E_LINK_SPEED_20GB:
> +		return 20000;
> +	case I40E_LINK_SPEED_10GB:
> +		return 10000;
> +	case I40E_LINK_SPEED_1GB:
> +		return 1000;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * i40e_set_bw_limit - setup BW limit for Tx traffic based on max_tx_rate
> + * @vsi: VSI to be configured
> + * @seid: seid of the channel/VSI
> + * @max_tx_rate: max TX rate to be configured as BW limit
> + *
> + * Helper function to set BW limit for a given VSI
> + **/
> +int i40e_set_bw_limit(struct i40e_vsi *vsi, u16 seid, u64 max_tx_rate)
> +{
> +	struct i40e_pf *pf = vsi->back;
> +	int speed = 0;
> +	int ret = 0;
> +
> +	speed = i40e_get_link_speed(vsi);
> +	if (max_tx_rate > speed) {
> +		dev_err(&pf->pdev->dev,
> +			"Invalid max tx rate %llu specified for VSI seid %d.",
> +			max_tx_rate, seid);
> +		return -EINVAL;
> +	}
> +	if ((max_tx_rate < 50) && (max_tx_rate > 0)) {

if (max_tx_rate && (max_tx_rate < 50)) {

> +		dev_warn(&pf->pdev->dev,
> +			 "Setting max tx rate to minimum usable value of 50Mbps.\n");
> +		max_tx_rate = 50;
> +	}
> +
> +       /* Tx rate credits are in values of 50Mbps, 0 is disabled*/

This should be indented with a tab, not spaces

> +	ret = i40e_aq_config_vsi_bw_limit(&pf->hw, seid,
> +					  max_tx_rate / I40E_BW_CREDIT_DIVISOR,
> +					  I40E_MAX_BW_INACTIVE_ACCUM, NULL);
> +	if (ret)
> +		dev_err(&pf->pdev->dev,
> +			"Failed set tx rate (%llu Mbps) for vsi->seid %u, error code %d.\n",
> +			max_tx_rate, seid, ret);

Please do the AQ error decode here with i40e_stat_str() and i40e_aq_str()

> +	return ret;
> +}
> +
> +/**
>    * i40e_remove_queue_channels - Remove queue channels for the TCs
>    * @vsi: VSI to be configured
>    *
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 92fe06d..a1d2391 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3061,8 +3061,6 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
>   	return ret;
>   }
>   
> -#define I40E_BW_CREDIT_DIVISOR 50     /* 50Mbps per BW credit */
> -#define I40E_MAX_BW_INACTIVE_ACCUM 4  /* device can accumulate 4 credits max */
>   /**
>    * i40e_ndo_set_vf_bw
>    * @netdev: network interface device structure
> @@ -3078,7 +3076,6 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
>   	struct i40e_pf *pf = np->vsi->back;
>   	struct i40e_vsi *vsi;
>   	struct i40e_vf *vf;
> -	int speed = 0;
>   	int ret = 0;
>   
>   	/* validate the request */
> @@ -3103,48 +3100,10 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
>   		goto error;
>   	}
>   
> -	switch (pf->hw.phy.link_info.link_speed) {
> -	case I40E_LINK_SPEED_40GB:
> -		speed = 40000;
> -		break;
> -	case I40E_LINK_SPEED_25GB:
> -		speed = 25000;
> -		break;
> -	case I40E_LINK_SPEED_20GB:
> -		speed = 20000;
> -		break;
> -	case I40E_LINK_SPEED_10GB:
> -		speed = 10000;
> -		break;
> -	case I40E_LINK_SPEED_1GB:
> -		speed = 1000;
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	if (max_tx_rate > speed) {
> -		dev_err(&pf->pdev->dev, "Invalid max tx rate %d specified for VF %d.\n",
> -			max_tx_rate, vf->vf_id);
> -		ret = -EINVAL;
> +	ret = i40e_set_bw_limit(vsi, vsi->seid, max_tx_rate);
> +	if (ret)
>   		goto error;
> -	}
>   
> -	if ((max_tx_rate < 50) && (max_tx_rate > 0)) {
> -		dev_warn(&pf->pdev->dev, "Setting max Tx rate to minimum usable value of 50Mbps.\n");
> -		max_tx_rate = 50;
> -	}
> -
> -	/* Tx rate credits are in values of 50Mbps, 0 is disabled*/
> -	ret = i40e_aq_config_vsi_bw_limit(&pf->hw, vsi->seid,
> -					  max_tx_rate / I40E_BW_CREDIT_DIVISOR,
> -					  I40E_MAX_BW_INACTIVE_ACCUM, NULL);
> -	if (ret) {
> -		dev_err(&pf->pdev->dev, "Unable to set max tx rate, error code %d.\n",
> -			ret);
> -		ret = -EIO;
> -		goto error;
> -	}
>   	vf->tx_rate = max_tx_rate;
>   error:
>   	return ret;
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
