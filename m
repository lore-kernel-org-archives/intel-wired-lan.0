From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 7 Aug 2017 10:18:40 -0700
Subject: [Intel-wired-lan] [next PATCH S78-V4 01/12] i40e: use admin
 queue for setting LEDs behavior
In-Reply-To: <20170804135222.46684-1-alice.michael@intel.com>
References: <20170804135222.46684-1-alice.michael@intel.com>
Message-ID: <c79a0ea6-ff95-8107-6f60-933de6091efc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/4/2017 6:52 AM, Alice Michael wrote:
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> Instead of accessing register directly, use newly added AQC in
> order to blink LEDs. Introduce and utilize a new flag to prevent
> excessive API version checking.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq.c |   6 ++
>   drivers/net/ethernet/intel/i40e/i40e_common.c | 148 ++++++++++++++++++++------
>   drivers/net/ethernet/intel/i40e/i40e_type.h   |   1 +
>   drivers/net/ethernet/intel/i40evf/i40e_type.h |   2 +
>   4 files changed, 122 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> index ba04988..340e5a2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> @@ -607,6 +607,12 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
>   			   &oem_lo);
>   	hw->nvm.oem_ver = ((u32)oem_hi << 16) | oem_lo;
>   
> +	if (hw->mac.type ==  I40E_MAC_XL710 &&

Extra space after ==

> +	    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
> +	    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
> +		hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
> +	}
> +
>   	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
>   		ret_code = I40E_ERR_FIRMWARE_API_VERSION;
>   		goto init_adminq_free_arq;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index e4e86e0..e9f30b8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -4849,24 +4849,38 @@ i40e_status i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
>   	u16 temp_addr;
>   	u8 port_num;
>   	u32 i;
> -
> -	temp_addr = I40E_PHY_LED_PROV_REG_1;
> -	i = rd32(hw, I40E_PFGEN_PORTNUM);
> -	port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
> -	phy_addr = i40e_get_phy_address(hw, port_num);
> -
> -	for (gpio_led_port = 0; gpio_led_port < 3; gpio_led_port++,
> -	     temp_addr++) {
> -		status = i40e_read_phy_register_clause45(hw,
> +	u32 reg_val_aq;
> +
> +	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
> +		status =
> +		      i40e_aq_get_phy_register(hw,
> +					       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
> +					       I40E_PHY_COM_REG_PAGE,
> +					       I40E_PHY_LED_PROV_REG_1,
> +					       &reg_val_aq, NULL);

Since this call doesn't exist yet, please re-order this patchset so that 
"i40e: Add support for 'ethtool -m'" comes first.

> +		if (status)
> +			return status;
> +		*val = (u16)reg_val_aq;

The diffs below would be greatly simplified by doing the return here and 
not shifting the rest into an else block.  Something like this and the 
rest can be left alone:

		if (!status)
			*val = (u16)reg_val_aq;
		return status;
	}


> +	} else {
> +		temp_addr = I40E_PHY_LED_PROV_REG_1;
> +		i = rd32(hw, I40E_PFGEN_PORTNUM);
> +		port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
> +		phy_addr = i40e_get_phy_address(hw, port_num);
> +
> +		for (gpio_led_port = 0; gpio_led_port < 3; gpio_led_port++,
> +		     temp_addr++) {
> +			status =
> +			 i40e_read_phy_register_clause45(hw,
>   							 I40E_PHY_COM_REG_PAGE,
>   							 temp_addr, phy_addr,
>   							 &reg_val);
> -		if (status)
> -			return status;
> -		*val = reg_val;
> -		if (reg_val & I40E_PHY_LED_LINK_MODE_MASK) {
> -			*led_addr = temp_addr;
> -			break;
> +			if (status)
> +				return status;
> +			*val = reg_val;
> +			if (reg_val & I40E_PHY_LED_LINK_MODE_MASK) {
> +				*led_addr = temp_addr;
> +				break;
> +			}
>   		}
>   	}
>   	return status;
> @@ -4884,51 +4898,115 @@ i40e_status i40e_led_set_phy(struct i40e_hw *hw, bool on,
>   			     u16 led_addr, u32 mode)
>   {
>   	i40e_status status = 0;
> -	u16 led_ctl = 0;
> -	u16 led_reg = 0;
> +	u32 led_ctl = 0;
> +	u32 led_reg = 0;
>   	u8 phy_addr = 0;
>   	u8 port_num;
>   	u32 i;
>   
> -	i = rd32(hw, I40E_PFGEN_PORTNUM);
> -	port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
> -	phy_addr = i40e_get_phy_address(hw, port_num);
> -	status = i40e_read_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
> -						 led_addr, phy_addr, &led_reg);
> +	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
> +		status =
> +		      i40e_aq_get_phy_register(hw,
> +					       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
> +					       I40E_PHY_COM_REG_PAGE,
> +					       I40E_PHY_LED_PROV_REG_1,
> +					       &led_reg, NULL);
> +	} else {
> +		i = rd32(hw, I40E_PFGEN_PORTNUM);
> +		port_num = (u8)(i & I40E_PFGEN_PORTNUM_PORT_NUM_MASK);
> +		phy_addr = i40e_get_phy_address(hw, port_num);
> +		status = i40e_read_phy_register_clause45(hw,
> +							 I40E_PHY_COM_REG_PAGE,
> +							 led_addr, phy_addr,
> +							 (u16 *)&led_reg);
> +	}
>   	if (status)
>   		return status;
>   	led_ctl = led_reg;
>   	if (led_reg & I40E_PHY_LED_LINK_MODE_MASK) {
>   		led_reg = 0;
> -		status = i40e_write_phy_register_clause45(hw,
> -							  I40E_PHY_COM_REG_PAGE,
> -							  led_addr, phy_addr,
> -							  led_reg);
> +		if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
> +		    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {

Why are you not using the I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE here?

> +			status = i40e_aq_set_phy_register(hw,
> +					I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
> +					I40E_PHY_COM_REG_PAGE,
> +					I40E_PHY_LED_PROV_REG_1,
> +					led_reg, NULL);
> +		} else {
> +			status = i40e_write_phy_register_clause45(hw,
> +							I40E_PHY_COM_REG_PAGE,
> +							led_addr, phy_addr,
> +							(u16)led_reg);
> +		}
>   		if (status)
>   			return status;
>   	}
> -	status = i40e_read_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
> -						 led_addr, phy_addr, &led_reg);
> +	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
> +		status =
> +		      i40e_aq_get_phy_register(hw,
> +					       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
> +					       I40E_PHY_COM_REG_PAGE,
> +					       I40E_PHY_LED_PROV_REG_1,
> +					       &led_reg, NULL);
> +	} else {
> +		status = i40e_read_phy_register_clause45(hw,
> +							 I40E_PHY_COM_REG_PAGE,
> +							 led_addr, phy_addr,
> +							 (u16 *)&led_reg);
> +	}

Please abstract these read/write structures into helper functions 
instead of repeating this if/else so many times.

>   	if (status)
>   		goto restore_config;
>   	if (on)
>   		led_reg = I40E_PHY_LED_MANUAL_ON;
>   	else
>   		led_reg = 0;
> -	status = i40e_write_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
> -						  led_addr, phy_addr, led_reg);
> +
> +	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
> +		status =
> +		      i40e_aq_set_phy_register(hw,
> +					       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
> +					       I40E_PHY_COM_REG_PAGE,
> +					       I40E_PHY_LED_PROV_REG_1,
> +					       led_reg, NULL);
> +	} else {
> +		status =
> +		    i40e_write_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
> +						     led_addr, phy_addr,
> +						     (u16)led_reg);
> +	}
>   	if (status)
>   		goto restore_config;
>   	if (mode & I40E_PHY_LED_MODE_ORIG) {
>   		led_ctl = (mode & I40E_PHY_LED_MODE_MASK);
> -		status = i40e_write_phy_register_clause45(hw,
> -						 I40E_PHY_COM_REG_PAGE,
> -						 led_addr, phy_addr, led_ctl);
> +		if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
> +			status = i40e_aq_set_phy_register(hw,
> +					I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
> +					I40E_PHY_COM_REG_PAGE,
> +					I40E_PHY_LED_PROV_REG_1,
> +					led_ctl, NULL);
> +		} else {
> +			status = i40e_write_phy_register_clause45(hw,
> +							 I40E_PHY_COM_REG_PAGE,
> +							 led_addr, phy_addr,
> +							 (u16)led_ctl);
> +		}
>   	}
>   	return status;
>   restore_config:
> -	status = i40e_write_phy_register_clause45(hw, I40E_PHY_COM_REG_PAGE,
> -						  led_addr, phy_addr, led_ctl);
> +	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
> +		status =
> +		      i40e_aq_set_phy_register(hw,
> +					       I40E_AQ_PHY_REG_ACCESS_EXTERNAL,
> +					       I40E_PHY_COM_REG_PAGE,
> +					       I40E_PHY_LED_PROV_REG_1,
> +					       led_ctl, NULL);
> +	} else {
> +		status =
> +			i40e_write_phy_register_clause45(hw,
> +							 I40E_PHY_COM_REG_PAGE,
> +							 led_addr, phy_addr,
> +							 (u16)led_ctl);
> +	}
>   	return status;
>   }
>   
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index fd4bbdd..78fda11 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -598,6 +598,7 @@ struct i40e_hw {
>   	struct i40e_dcbx_config desired_dcbx_config; /* CEE Desired Cfg */
>   
>   #define I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE BIT_ULL(0)
> +#define I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE  BIT_ULL(2)
>   	u64 flags;
>   
>   	/* debug mask */
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
> index 2ea919d..412a32c 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
> @@ -556,6 +556,8 @@ struct i40e_hw {
>   	/* LLDP/DCBX Status */
>   	u16 dcbx_status;
>   
> +#define I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE  BIT_ULL(2)
> +
>   	/* DCBX info */
>   	struct i40e_dcbx_config local_dcbx_config; /* Oper/Local Cfg */
>   	struct i40e_dcbx_config remote_dcbx_config; /* Peer Cfg */
> 
