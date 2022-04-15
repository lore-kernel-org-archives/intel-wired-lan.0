From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 15 Apr 2022 15:54:53 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 2/3] ice: add i2c write
 command
In-Reply-To: <20220415103139.794790-2-karol.kolacinski@intel.com>
References: <20220415103139.794790-1-karol.kolacinski@intel.com>
 <20220415103139.794790-2-karol.kolacinski@intel.com>
Message-ID: <76921ca9-07dc-3c26-cf48-a74274a795d0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Karol,


Thank you for your patch.

Am 15.04.22 um 12:31 schrieb Karol Kolacinski:
> Add the possibility to write to connected i2c devices. FW may reject
> the write if the device is not on allowlist.

Did you use a datasheet for implementing this. If so, please mention the 
name and revision.

> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  7 +--
>   drivers/net/ethernet/intel/ice/ice_common.c   | 45 ++++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_common.h   |  4 ++
>   3 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index b25e27c4d887..bedc19f12cbd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1401,7 +1401,7 @@ struct ice_aqc_get_link_topo {
>   	u8 rsvd[9];
>   };
>   
> -/* Read I2C (direct, 0x06E2) */
> +/* Read/Write I2C (direct, 0x06E2/0x06E3) */
>   struct ice_aqc_i2c {
>   	struct ice_aqc_link_topo_addr topo_addr;
>   	__le16 i2c_addr;
> @@ -1411,7 +1411,7 @@ struct ice_aqc_i2c {
>   
>   	u8 rsvd;
>   	__le16 i2c_bus_addr;
> -	u8 rsvd2[4];
> +	u8 i2c_data[4]; /* Used only by write command, reserved in read. */
>   };
>   
>   /* Read I2C Response (direct, 0x06E2) */
> @@ -2130,7 +2130,7 @@ struct ice_aq_desc {
>   		struct ice_aqc_get_link_status get_link_status;
>   		struct ice_aqc_event_lan_overflow lan_overflow;
>   		struct ice_aqc_get_link_topo get_link_topo;
> -		struct ice_aqc_i2c read_i2c;
> +		struct ice_aqc_i2c read_write_i2c;
>   		struct ice_aqc_read_i2c_resp read_i2c_resp;
>   	} params;
>   };
> @@ -2247,6 +2247,7 @@ enum ice_adminq_opc {
>   	ice_aqc_opc_set_mac_lb				= 0x0620,
>   	ice_aqc_opc_get_link_topo			= 0x06E0,
>   	ice_aqc_opc_read_i2c				= 0x06E2,
> +	ice_aqc_opc_write_i2c				= 0x06E3,
>   	ice_aqc_opc_set_port_id_led			= 0x06E9,
>   	ice_aqc_opc_set_gpio				= 0x06EC,
>   	ice_aqc_opc_get_gpio				= 0x06ED,
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 9619bdb9e49a..85dd30f99814 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -4823,7 +4823,7 @@ ice_aq_read_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
>   	int status;
>   
>   	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_read_i2c);
> -	cmd = &desc.params.read_i2c;
> +	cmd = &desc.params.read_write_i2c;
>   
>   	if (!data)
>   		return -EINVAL;
> @@ -4850,6 +4850,49 @@ ice_aq_read_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
>   	return status;
>   }
>   
> +/**
> + * ice_aq_write_i2c
> + * @hw: pointer to the hw struct
> + * @topo_addr: topology address for a device to communicate with
> + * @bus_addr: 7-bit I2C bus address
> + * @addr: I2C memory address (I2C offset) with up to 16 bits
> + * @params: I2C parameters: bit [4] - I2C address type, bits [3:0] - data size to write (0-7 bytes)
> + * @data: pointer to data (0 to 4 bytes) to be written to the I2C device
> + * @cd: pointer to command details structure or NULL

Also document the return value?

> + *
> + * Write I2C (0x06E3)
> + */
> +int
> +ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
> +		 u16 bus_addr, __le16 addr, u8 params, u8 *data,
> +		 struct ice_sq_cd *cd)
> +{
> +	struct ice_aq_desc desc = { 0 };
> +	struct ice_aqc_i2c *cmd;
> +	u8 i, data_size;

The loop variable should be a native type.

> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_write_i2c);
> +	cmd = &desc.params.read_write_i2c;
> +
> +	data_size = FIELD_GET(ICE_AQC_I2C_DATA_SIZE_M, params);
> +
> +	/* data_size limited to 4 */
> +	if (data_size > 4)
> +		return -EINVAL;
> +
> +	cmd->i2c_bus_addr = cpu_to_le16(bus_addr);
> +	cmd->topo_addr = topo_addr;
> +	cmd->i2c_params = params;
> +	cmd->i2c_addr = addr;
> +
> +	for (i = 0; i < data_size; i++) {
> +		cmd->i2c_data[i] = *data;
> +		data++;
> +	}
> +
> +	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
> +}
> +
>   /**
>    * ice_aq_set_driver_param - Set driver parameter to share via firmware
>    * @hw: pointer to the HW struct
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
> index 872ea7d2332d..61b7c60db689 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> @@ -214,5 +214,9 @@ int
>   ice_aq_read_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
>   		u16 bus_addr, __le16 addr, u8 params, u8 *data,
>   		struct ice_sq_cd *cd);
> +int
> +ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
> +		 u16 bus_addr, __le16 addr, u8 params, u8 *data,
> +		 struct ice_sq_cd *cd);
>   bool ice_fw_supports_report_dflt_cfg(struct ice_hw *hw);
>   #endif /* _ICE_COMMON_H_ */


Kind regards,

Paul
