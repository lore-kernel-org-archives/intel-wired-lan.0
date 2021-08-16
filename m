From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 16 Aug 2021 23:49:04 +0000
Subject: [Intel-wired-lan] [PATCH intel-next 2/4] ice: Implement
 functions for reading and setting GPIO pins
In-Reply-To: <20210816102729.1266522-3-maciej.machnikowski@intel.com>
References: <20210816102729.1266522-1-maciej.machnikowski@intel.com>
 <20210816102729.1266522-3-maciej.machnikowski@intel.com>
Message-ID: <ce429d170c827e21342fabaaba57f1816eeef564.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-08-16 at 12:27 +0200, Maciej Machnikowski wrote:
> Implement ice_aq_get_gpio and ice_aq_set_gpio for reading and
> changing
> the state of GPIO pins described in the topology.
> 
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---

<snip>

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> b/drivers/net/ethernet/intel/ice/ice_common.c
> index 5822589aebdc..d1b81e7fbef4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -4806,6 +4806,64 @@ ice_aq_get_driver_param(struct ice_hw *hw,
> enum ice_aqc_driver_params idx,
>  	return 0;
>  }
>  
> +/**
> + * ice_aq_set_gpio
> + * @hw: pointer to the hw struct
> + * @gpio_ctrl_handle: GPIO controller node handle
> + * @pin_idx: IO Number of the GPIO that needs to be set
> + * @value: SW provide IO value to set in the LSB
> + * @cd: pointer to command details structure or NULL
> + *
> + * Sends 0x06EC AQ command to set the GPIO pin state that's part of
> the topology
> + */
> +enum ice_status
> +ice_aq_set_gpio(struct ice_hw *hw, u16 gpio_ctrl_handle, u8 pin_idx,
> bool value,
> +		struct ice_sq_cd *cd)
> +{
> +	struct ice_aqc_gpio *cmd;
> +	struct ice_aq_desc desc;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_gpio);
> +	cmd = &desc.params.read_write_gpio;
> +	cmd->gpio_ctrl_handle = gpio_ctrl_handle;
> +	cmd->gpio_num = pin_idx;
> +	cmd->gpio_val = value ? 1 : 0;
> +
> +	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
> +}
> +
> +/**
> + * ice_aq_get_gpio
> + * @hw: pointer to the hw struct
> + * @gpio_ctrl_handle: GPIO controller node handle
> + * @pin_idx: IO Number of the GPIO that needs to be set
> + * @value: IO value read
> + * @cd: pointer to command details structure or NULL
> + *
> + * Sends 0x06ED AQ command to get the value of a GPIO signal which
> is part of
> + * the topology
> + */
> +enum ice_status
> +ice_aq_get_gpio(struct ice_hw *hw, u16 gpio_ctrl_handle, u8 pin_idx,
> +		bool *value, struct ice_sq_cd *cd)
> +{
> +	struct ice_aqc_gpio *cmd;
> +	struct ice_aq_desc desc;
> +	enum ice_status status;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_gpio);
> +	cmd = &desc.params.read_write_gpio;
> +	cmd->gpio_ctrl_handle = gpio_ctrl_handle;
> +	cmd->gpio_num = pin_idx;
> +
> +	status = ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
> +	if (status)
> +		return status;
> +
> +	*value = !!cmd->gpio_val;
> +	return 0;
> +}

This introduces new warnings:
> ../drivers/net/ethernet/intel/ice/ice_common.c:4828:31: warning:
incorrect type in assignment (different base types)
> ../drivers/net/ethernet/intel/ice/ice_common.c:4828:31:    expected
restricted __le16 [usertype] gpio_ctrl_handle
> ../drivers/net/ethernet/intel/ice/ice_common.c:4828:31:    got
unsigned short [usertype] gpio_ctrl_handle
> ../drivers/net/ethernet/intel/ice/ice_common.c:4856:31: warning:
incorrect type in assignment (different base types)
> ../drivers/net/ethernet/intel/ice/ice_common.c:4856:31:    expected
restricted __le16 [usertype] gpio_ctrl_handle
> ../drivers/net/ethernet/intel/ice/ice_common.c:4856:31:    got
unsigned short [usertype] gpio_ctrl_handle

