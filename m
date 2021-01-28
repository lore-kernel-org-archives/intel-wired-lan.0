From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Thu, 28 Jan 2021 10:48:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5] i40e: refactor repeated
 link state reporting code
In-Reply-To: <20210127105836.18944-1-aleksandr.loktionov@intel.com>
References: <20210127105836.18944-1-aleksandr.loktionov@intel.com>
Message-ID: <CY4PR11MB15762421DD7D7F75A7CFEEEDABBA9@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Aleksandr Loktionov
> Sent: ?roda, 27 stycznia 2021 11:59
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v5] i40e: refactor repeated link
> state reporting code
> 
> Refactor repeated link state reporting code into a separate helper
> functions: i40e_set_vf_link_state() i40e_vc_link_speed2mbps().
> Add support of VIRTCHNL_VF_CAP_ADV_LINK_SPEED;
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2: improve commit message
> v3: net tree target
> v4: split into 2 patches
> v5: separate refactor commit
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 108 +++++++++++-------
>  1 file changed, 69 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 1b6ec9b..6621943 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -39,6 +39,66 @@ static void i40e_vc_vf_broadcast(struct i40e_pf *pf,
>  	}
>  }
> 
> +/**
> + * i40e_vc_link_speed2mbps
> + * converts i40e_aq_link_speed to integer value of Mbps
> + * @link_speed: the speed to convert
> + *
> + * return the speed as direct value of Mbps.
> + **/
> +static u32
> +i40e_vc_link_speed2mbps(enum i40e_aq_link_speed link_speed) {
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
> +				   struct virtchnl_pf_event *pfe, struct
> i40e_link_status *ls) {
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
> @@ -55,16 +115,9 @@ static void i40e_vc_notify_vf_link_state(struct
> i40e_vf *vf)
> 
>  	pfe.event = VIRTCHNL_EVENT_LINK_CHANGE;
>  	pfe.severity = PF_EVENT_SEVERITY_INFO;
> -	if (vf->link_forced) {
> -		pfe.event_data.link_event.link_status = vf->link_up;
> -		pfe.event_data.link_event.link_speed =
> -			(vf->link_up ? i40e_virtchnl_link_speed(ls-
> >link_speed) : 0);
> -	} else {
> -		pfe.event_data.link_event.link_status =
> -			ls->link_info & I40E_AQ_LINK_UP;
> -		pfe.event_data.link_event.link_speed =
> -			i40e_virtchnl_link_speed(ls->link_speed);
> -	}
> +
> +	i40e_set_vf_link_state(vf, &pfe, ls);
> +
>  	i40e_aq_send_msg_to_vf(hw, abs_vf_id, VIRTCHNL_OP_EVENT,
>  			       0, (u8 *)&pfe, sizeof(pfe), NULL);  } @@ -1940,6
> +1993,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8
> *msg)
>  				  VIRTCHNL_VF_OFFLOAD_VLAN;
> 
>  	vfres->vf_cap_flags = VIRTCHNL_VF_OFFLOAD_L2;
> +	vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_ADV_LINK_SPEED;
>  	vsi = pf->vsi[vf->lan_vsi_idx];
>  	if (!vsi->info.pvid)
>  		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_VLAN; @@
> -3687,26 +3741,8 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8
> *msg)
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
> @@ -4455,23 +4491,17 @@ int i40e_ndo_set_vf_link_state(struct
> net_device *netdev, int vf_id, int link)
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
> -		pfe.event_data.link_event.link_speed =
> i40e_virtchnl_link_speed(ls->link_speed);
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
> --
> 2.18.4

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

