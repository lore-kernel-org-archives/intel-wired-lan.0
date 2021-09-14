From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 14 Sep 2021 23:37:34 +0000
Subject: [Intel-wired-lan] [PATCH intel-next 1/2] ice: add i2c
 read/write read commands
In-Reply-To: <20210913101108.17927-1-karol.kolacinski@intel.com>
References: <20210913101108.17927-1-karol.kolacinski@intel.com>
Message-ID: <41417ec2e162d70d207d4a5539fb53e4c48a9e43.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-09-13 at 12:11 +0200, Karol Kolacinski wrote:
> Add I2C read/write AQ commands. They are now required for controlling
> the external physical connectors via external I2C port expander on
> E810-T adapters.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 29 ++++++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 94
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |  8 ++
>  3 files changed, 131 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 0f64fbc9d3e8..89448e61c3dd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1341,6 +1341,31 @@ struct ice_aqc_get_link_topo {
>  	u8 rsvd[9];
>  };
>  
> +/* Read/Write I2C (direct, 0x06E2/0x06E3) */
> +struct ice_aqc_i2c {
> +	struct ice_aqc_link_topo_addr topo_addr;
> +	__le16 i2c_addr;
> +	u8 i2c_params;
> +#define ICE_AQC_I2C_DATA_SIZE_S		0
> +#define ICE_AQC_I2C_DATA_SIZE_M		(0xF <<
> ICE_AQC_I2C_DATA_SIZE_S)
> +#define ICE_AQC_I2C_ADDR_TYPE_M		BIT(4)
> +#define ICE_AQC_I2C_ADDR_TYPE_7BIT	0
> +#define ICE_AQC_I2C_ADDR_TYPE_10BIT	ICE_AQC_I2C_ADDR_TYPE_M
> +#define ICE_AQC_I2C_DATA_OFFSET_S	5
> +#define ICE_AQC_I2C_DATA_OFFSET_M	(0x3 <<
> ICE_AQC_I2C_DATA_OFFSET_S)
> +#define ICE_AQC_I2C_USE_REPEATED_START	BIT(7)

Not all of these defines are being used.

> +	u8 rsvd;
> +	__le16 i2c_bus_addr;
> +#define ICE_AQC_I2C_ADDR_7BIT_MASK	0x7F
> +#define ICE_AQC_I2C_ADDR_10BIT_MASK	0x3FF

nor these.

> +	u8 i2c_data[4]; /* Used only by write command, reserved in
> read. */
> +};

<snip>

> +/**
> + * ice_aq_write_i2c
> + * @hw: pointer to the hw struct
> + * @topo_addr: topology address for a device to communicate with
> + * @bus_addr: 7-bit I2C bus address
> + * @addr: I2C memory address (I2C offset) with up to 16 bits
> + * @params: I2C parameters: bit [4] - I2C address type, bits [3:0] -
> data size to write (0-7 bytes)
> + * @data: pointer to data (0 to 4 bytes) to be written to the I2C
> device
> + * @cd: pointer to command details structure or NULL
> + *
> + * Write I2C (0x06E3)
> + */
> +enum ice_status
> +ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr
> topo_addr,
> +		 u16 bus_addr, __le16 addr, u8 params, u8 *data,
> +		 struct ice_sq_cd *cd)

If write functionality will be introduced in the future don't include
the write implementations until you use them.

It may make sense to squash this with patch 2 after this. Just a
suggestion though.
