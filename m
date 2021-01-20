From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 20 Jan 2021 01:28:08 +0000
Subject: [Intel-wired-lan] [PATCH net v4 2/2] i40e: refactor repeated
 link state reporting code
In-Reply-To: <20210118193454.275037-3-arkadiusz.kubalewski@intel.com>
References: <20210118193454.275037-1-arkadiusz.kubalewski@intel.com>
 <20210118193454.275037-3-arkadiusz.kubalewski@intel.com>
Message-ID: <f23fd8587047f3c61a25b6ac5876778ff8ac197f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-01-18 at 19:34 +0000, Arkadiusz Kubalewski wrote:
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Refactor repeated link state reporting code into a separate helper
> functions:
> i40e_set_vf_link_state() i40e_vc_link_speed2mbps().

As this is refactoring, this is should be for net-next.

> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
> v2: improve commit message
> v3: net tree target
> v4: split into 2 patches
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 108 +++++++++++-----
> --
>  1 file changed, 69 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 1b6ec9b..6621943 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -39,6 +39,66 @@ static void i40e_vc_vf_broadcast(struct i40e_pf
> *pf,
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
> +				   struct virtchnl_pf_event *pfe,
> struct i40e_link_status *ls)
> +{
> +	u8 link_status = ls->link_info & I40E_AQ_LINK_UP;
> +
> +	if (vf->link_forced)
> +		link_status = vf->link_up;
> +
> +	if (vf->driver_caps & VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
> +		pfe->event_data.link_event_adv.link_speed = link_status
> ?
> +			i40e_vc_link_speed2mbps(ls->link_speed) : 0;
> +		pfe->event_data.link_event_adv.link_status =
> link_status;
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
>  			       0, (u8 *)&pfe, sizeof(pfe), NULL);
>  }
> @@ -1940,6 +1993,7 @@ static int i40e_vc_get_vf_resources_msg(struct
> i40e_vf *vf, u8 *msg)
>  				  VIRTCHNL_VF_OFFLOAD_VLAN;
>  
>  	vfres->vf_cap_flags = VIRTCHNL_VF_OFFLOAD_L2;
> +	vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_ADV_LINK_SPEED;

There is no mention about addding this capability in the commit
message.
