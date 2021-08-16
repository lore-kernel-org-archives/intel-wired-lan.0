From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 16 Aug 2021 23:59:54 +0000
Subject: [Intel-wired-lan] [PATCH intel-next 3/4] ice: Add support for
 SMA control multiplexer
In-Reply-To: <20210816102729.1266522-4-maciej.machnikowski@intel.com>
References: <20210816102729.1266522-1-maciej.machnikowski@intel.com>
 <20210816102729.1266522-4-maciej.machnikowski@intel.com>
Message-ID: <27c204aad2d51f207999b4b869805a3dfb6b0b86.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-08-16 at 12:27 +0200, Maciej Machnikowski wrote:
> E810-T adapters have two external bidirectional SMA connectors and
> two internal
> unidirectional U.FL connectors. Multiplexing between U.FL and SMA and
> SMA direction
> is controlled using the PCA9575 expander.
> 
> Add support for the PCA9575 detection and control of the respective
> pins
> of the SMA/U.FL multiplexer using the GPIO AQ API.
> 
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---

<snip>

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 0e1567e4296f..ebbd5e074297 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -3139,3 +3139,158 @@ int ice_ptp_init_phc(struct ice_hw *hw)
>  	else
>  		return ice_ptp_init_phc_e822(hw);
>  }
> +
> +/* E810T SMA functions
> + *
> + * The following functions operate specifically on E810T hardware
> and are used
> + * to access the extended GPIOs available.
> + */
> +
> +/**
> + * ice_get_pca9575_handle
> + * @hw: pointer to the hw struct
> + * @pca9575_handle: GPIO controller's handle
> + *
> + * Find and return the GPIO controller's handle in the netlist.
> + * When found - the value will be cached in the hw structure and
> following calls
> + * will return cached value
> + */
> +static int
> +ice_get_pca9575_handle(struct ice_hw *hw, __le16 *pca9575_handle)
> +{
> +	struct ice_aqc_get_link_topo *cmd;
> +	struct ice_aq_desc desc;
> +	int status;
> +	u8 idx;
> +
> +	if (!hw || !pca9575_handle)
> +		return ICE_ERR_PARAM;
> +
> +	/* If handle was read previously return cached value */
> +	if (hw->io_expander_handle) {
> +		*pca9575_handle = hw->io_expander_handle;
> +		return 0;
> +	}
> +
> +	/* If handle was not detected read it from the netlist */
> +	cmd = &desc.params.get_link_topo;
> +	ice_fill_dflt_direct_cmd_desc(&desc,
> ice_aqc_opc_get_link_topo);
> +
> +	/* Set node type to GPIO controller */
> +	cmd->addr.topo_params.node_type_ctx =
> +		(ICE_AQC_LINK_TOPO_NODE_TYPE_M &
> +		 ICE_AQC_LINK_TOPO_NODE_TYPE_GPIO_CTRL);
> +
> +#define SW_PCA9575_SFP_TOPO_IDX		2
> +#define SW_PCA9575_QSFP_TOPO_IDX	1
> +
> +	/* Check if the SW IO expander controlling SMA exists in the
> netlist. */
> +	if (hw->device_id == ICE_DEV_ID_E810C_SFP)
> +		idx = SW_PCA9575_SFP_TOPO_IDX;
> +	else if (hw->device_id == ICE_DEV_ID_E810C_QSFP)
> +		idx = SW_PCA9575_QSFP_TOPO_IDX;
> +	else
> +		return ICE_ERR_NOT_SUPPORTED;
> +
> +	cmd->addr.topo_params.index = idx;
> +
> +	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
> +	if (status)
> +		return ICE_ERR_NOT_SUPPORTED;
> +
> +	/* Verify if we found the right IO expander type */
> +	if (desc.params.get_link_topo.node_part_num !=
> +		ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575)
> +		return ICE_ERR_NOT_SUPPORTED;
> +
> +	/* If present save the handle and return it */
> +	hw->io_expander_handle = desc.params.get_link_topo.addr.handle;
> +	*pca9575_handle = hw->io_expander_handle;
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_read_sma_ctrl_e810t
> + * @hw: pointer to the hw struct
> + * @data: pointer to data to be read from the GPIO controller
> + *
> + * Read the SMA controller state. It is connected to pins 3-7 of
> Port 1 of the
> + * PCA9575 expander, so only bits 3-7 in data are valid.
> + */
> +int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data)
> +{
> +	int status;
> +	u16 handle;
> +	u8 i;
> +
> +	status = ice_get_pca9575_handle(hw, &handle);
> +	if (status)
> +		return status;
> +
> +	*data = 0;
> +
> +	for (i = ICE_SMA_MIN_BIT_E810T; i <= ICE_SMA_MAX_BIT_E810T;
> i++) {
> +		bool pin;
> +
> +		status = ice_aq_get_gpio(hw, handle, i +
> ICE_PCA9575_P1_OFFSET,
> +					 &pin, NULL);
> +		if (status)
> +			break;
> +		*data |= (u8)(!pin) << i;
> +	}
> +
> +	return status;
> +}
> +
> +/**
> + * ice_write_sma_ctrl_e810t
> + * @hw: pointer to the hw struct
> + * @data: data to be written to the GPIO controller
> + *
> + * Write the data to the SMA controller. It is connected to pins 3-7 
> of Port 1
> + * of the PCA9575 expander, so only bits 3-7 in data are valid.
> + */
> +int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data)
> +{
> +	int status;
> +	u16 handle;
> +	u8 i;
> +
> +	status = ice_get_pca9575_handle(hw, &handle);
> +	if (status)
> +		return status;
> +
> +	for (i = ICE_SMA_MIN_BIT_E810T; i <= ICE_SMA_MAX_BIT_E810T;
> i++) {
> +		bool pin;
> +
> +		pin = !(data & (1 << i));
> +		status = ice_aq_set_gpio(hw, handle, i +
> ICE_PCA9575_P1_OFFSET,
> +					 pin, NULL);
> +		if (status)
> +			break;
> +	}
> +
> +	return status;
> +}
> +
> +/**
> + * ice_is_pca9575_present
> + * @hw: pointer to the hw struct
> + *
> + * Check if the SW IO expander is present in the netlist
> + */
> +bool ice_is_pca9575_present(struct ice_hw *hw)
> +{
> +	int status;
> +	__le16 handle = 0;
> +
> +	if (!ice_is_e810t(hw))
> +		return false;
> +
> +	status = ice_get_pca9575_handle(hw, &handle);
> +	if (!status && handle)
> +		return true;
> +
> +	return false;
> +}

A couple here as well:
> ../drivers/net/ethernet/intel/ice/ice_ptp_hw.c:3227:46: warning:
incorrect type in argument 2 (different base types)
> ../drivers/net/ethernet/intel/ice/ice_ptp_hw.c:3227:46:    expected
restricted __le16 [usertype] *pca9575_handle
> ../drivers/net/ethernet/intel/ice/ice_ptp_hw.c:3227:46:    got
unsigned short *
> ../drivers/net/ethernet/intel/ice/ice_ptp_hw.c:3260:46: warning:
incorrect type in argument 2 (different base types)
> ../drivers/net/ethernet/intel/ice/ice_ptp_hw.c:3260:46:    expected
restricted __le16 [usertype] *pca9575_handle
> ../drivers/net/ethernet/intel/ice/ice_ptp_hw.c:3260:46:    got
unsigned short *

