From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 5 Jan 2021 13:20:53 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix for link-flapping
In-Reply-To: <20210105103550.17075-1-mateusz.palczewski@intel.com>
References: <20210105103550.17075-1-mateusz.palczewski@intel.com>
Message-ID: <20210105122053.GA13327@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 05, 2021 at 10:35:50AM +0000, Mateusz Palczewski wrote:
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Instead of just simply sending out PF link state,
> the driver was using vf->queue_enable as a condition

queues_enabled

> to decide what link-state it would send out.
> This broke the VNF implementation and caused a link flap.

And how are you fixing this?

You're also pulling out a bunch of code onto two helper functions and not
mentioning it in the commit message.

> 
> Fixes: 2ad1274fa ("i40e: don't report link up for a VF who hasn't enabled")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 115 ++++++++++--------
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   1 -
>  2 files changed, 67 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 7efc61a..a4e0f8c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -39,6 +39,66 @@ static void i40e_vc_vf_broadcast(struct i40e_pf *pf,
>  	}
>  }
>  
> +/**
> + * i40e_vc_link_speed2mbpsd

typo with 'd' and the end

> + * to integer value of Mbps

This description seems incomplete.

> + * @link_speed: the speed to convert
> + *
> + * return the speed as direct value of Mbps.
> + **/
> +static u32
> +i40e_vc_link_speed2mbps(enum i40e_aq_link_speed link_speed)
> +{
> +	switch (link_speed) {
> +	case I40E_LINK_SPEED_100MB:
> +		return SPEED_100;
> +	case I40E_LINK_SPEED_1GB:
> +		return SPEED_1000;
> +	case I40E_LINK_SPEED_2_5GB:
> +		return SPEED_2500;
> +	case I40E_LINK_SPEED_5GB:
> +		return SPEED_5000;
> +	case I40E_LINK_SPEED_10GB:
> +		return SPEED_10000;
> +	case I40E_LINK_SPEED_20GB:
> +		return SPEED_20000;
> +	case I40E_LINK_SPEED_25GB:
> +		return SPEED_25000;
> +	case I40E_LINK_SPEED_40GB:
> +		return SPEED_40000;
> +	case I40E_LINK_SPEED_UNKNOWN:
> +		return SPEED_UNKNOWN;
> +	}
> +	return SPEED_UNKNOWN;
> +}
> +
> +/**
> + * i40e_set_vf_link_state
> + * @vf: pointer to the VF structure
> + * @pfe: pointer to PF event structure
> + * @ls: pointer to link status structure
> + *
> + * set a link state on a single vf
> + **/
> +static void i40e_set_vf_link_state(struct i40e_vf *vf,
> +				   struct virtchnl_pf_event *pfe, struct i40e_link_status *ls)
> +{
> +	u8 link_status = ls->link_info & I40E_AQ_LINK_UP;
> +
> +	if (vf->link_forced)
> +		link_status = vf->link_up;
> +
> +	if (vf->driver_caps & VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
> +		pfe->event_data.link_event_adv.link_speed = link_status ?
> +			i40e_vc_link_speed2mbps(ls->link_speed) : 0;
> +		pfe->event_data.link_event_adv.link_status = link_status;
> +	} else {
> +		pfe->event_data.link_event.link_speed = link_status ?
> +			i40e_virtchnl_link_speed(ls->link_speed) : 0;
> +		pfe->event_data.link_event.link_status = link_status;
> +	}
> +}
> +
>  /**
>   * i40e_vc_notify_vf_link_state
>   * @vf: pointer to the VF structure
> @@ -56,20 +116,7 @@ static void i40e_vc_notify_vf_link_state(struct i40e_vf *vf)
>  	pfe.event = VIRTCHNL_EVENT_LINK_CHANGE;
>  	pfe.severity = PF_EVENT_SEVERITY_INFO;
>  
> -	/* Always report link is down if the VF queues aren't enabled */
> -	if (!vf->queues_enabled) {
> -		pfe.event_data.link_event.link_status = false;
> -		pfe.event_data.link_event.link_speed = 0;
> -	} else if (vf->link_forced) {
> -		pfe.event_data.link_event.link_status = vf->link_up;
> -		pfe.event_data.link_event.link_speed =
> -			(vf->link_up ? i40e_virtchnl_link_speed(ls->link_speed) : 0);
> -	} else {
> -		pfe.event_data.link_event.link_status =
> -			ls->link_info & I40E_AQ_LINK_UP;
> -		pfe.event_data.link_event.link_speed =
> -			i40e_virtchnl_link_speed(ls->link_speed);
> -	}
> +	i40e_set_vf_link_state(vf, &pfe, ls);
>  
>  	i40e_aq_send_msg_to_vf(hw, abs_vf_id, VIRTCHNL_OP_EVENT,
>  			       0, (u8 *)&pfe, sizeof(pfe), NULL);
> @@ -1946,6 +1993,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
>  				  VIRTCHNL_VF_OFFLOAD_VLAN;
>  
>  	vfres->vf_cap_flags = VIRTCHNL_VF_OFFLOAD_L2;
> +	vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_ADV_LINK_SPEED;
>  	vsi = pf->vsi[vf->lan_vsi_idx];
>  	if (!vsi->info.pvid)
>  		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_VLAN;
> @@ -2443,8 +2491,6 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
>  		}
>  	}
>  
> -	vf->queues_enabled = true;
> -
>  error_param:
>  	/* send the response to the VF */
>  	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_ENABLE_QUEUES,
> @@ -2466,9 +2512,6 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg)
>  	struct i40e_pf *pf = vf->pf;
>  	i40e_status aq_ret = 0;
>  
> -	/* Immediately mark queues as disabled */
> -	vf->queues_enabled = false;
> -
>  	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
>  		aq_ret = I40E_ERR_PARAM;
>  		goto error_param;
> @@ -3698,26 +3741,8 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
>  	}
>  
>  	/* get link speed in MB to validate rate limit */
> -	switch (ls->link_speed) {
> -	case VIRTCHNL_LINK_SPEED_100MB:
> -		speed = SPEED_100;
> -		break;
> -	case VIRTCHNL_LINK_SPEED_1GB:
> -		speed = SPEED_1000;
> -		break;
> -	case VIRTCHNL_LINK_SPEED_10GB:
> -		speed = SPEED_10000;
> -		break;
> -	case VIRTCHNL_LINK_SPEED_20GB:
> -		speed = SPEED_20000;
> -		break;
> -	case VIRTCHNL_LINK_SPEED_25GB:
> -		speed = SPEED_25000;
> -		break;
> -	case VIRTCHNL_LINK_SPEED_40GB:
> -		speed = SPEED_40000;
> -		break;
> -	default:
> +	speed = i40e_vc_link_speed2mbps(ls->link_speed);
> +	if (speed == SPEED_UNKNOWN) {
>  		dev_err(&pf->pdev->dev,
>  			"Cannot detect link speed\n");
>  		aq_ret = I40E_ERR_PARAM;
> @@ -4466,23 +4491,17 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
>  	switch (link) {
>  	case IFLA_VF_LINK_STATE_AUTO:
>  		vf->link_forced = false;
> -		pfe.event_data.link_event.link_status =
> -			pf->hw.phy.link_info.link_info & I40E_AQ_LINK_UP;
> -		pfe.event_data.link_event.link_speed =
> -			(enum virtchnl_link_speed)
> -			pf->hw.phy.link_info.link_speed;
> +		i40e_set_vf_link_state(vf, &pfe, ls);
>  		break;
>  	case IFLA_VF_LINK_STATE_ENABLE:
>  		vf->link_forced = true;
>  		vf->link_up = true;
> -		pfe.event_data.link_event.link_status = true;
> -		pfe.event_data.link_event.link_speed = i40e_virtchnl_link_speed(ls->link_speed);
> +		i40e_set_vf_link_state(vf, &pfe, ls);
>  		break;
>  	case IFLA_VF_LINK_STATE_DISABLE:
>  		vf->link_forced = true;
>  		vf->link_up = false;
> -		pfe.event_data.link_event.link_status = false;
> -		pfe.event_data.link_event.link_speed = 0;
> +		i40e_set_vf_link_state(vf, &pfe, ls);
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> index 5491215..091e32c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> @@ -98,7 +98,6 @@ struct i40e_vf {
>  	unsigned int tx_rate;	/* Tx bandwidth limit in Mbps */
>  	bool link_forced;
>  	bool link_up;		/* only valid if VF link is forced */
> -	bool queues_enabled;	/* true if the VF queues are enabled */
>  	bool spoofchk;
>  	u16 num_vlan;
>  
> -- 
> 2.17.1
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
> Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
>  
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
