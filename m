From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 8 Dec 2021 17:43:47 +0000
Subject: [Intel-wired-lan] [PATCH intel-next] ice: add TTY for GNSS
 module for E810T device
In-Reply-To: <20211208154333.179459-1-karol.kolacinski@intel.com>
References: <20211208154333.179459-1-karol.kolacinski@intel.com>
Message-ID: <f68d7a724f366deb5fbb7a1160561c71eb158392.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-12-08 at 16:43 +0100, Karol Kolacinski wrote:
> Add a new ice_gnss.c file for holding the basic GNSS module
> functions.
> If the device supports GNSS module, call the new ice_gnss_init and
> ice_gnss_release functions where appropriate.
> 
> Implement basic functionality for reading the data from GNSS module
> using TTY device.
> 
> Add I2C read AQ command. It is now required for controlling the
> external
> physical connectors via external I2C port expander on E810-T
> adapters.
> 
> Future changes will introduce write functionality.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Sudhansu Sekhar Mishra <sudhansu.mishra@intel.com>
> ---

Please add/increment the version with change log.

<snip>

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index e8b5bb815dcf..84a47f2576c3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -570,6 +570,12 @@ ice_prepare_for_reset(struct ice_pf *pf, enum
> ice_reset_req reset_type)
> ????????if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
> ????????????????ice_ptp_release(pf);
> ?
> +???????if (ice_is_feature_supported(pf, ICE_F_GNSS))
> +???????????????ice_gnss_exit(pf);
> +
> +???????if (ice_is_feature_supported(pf, ICE_F_GNSS))
> +???????????????ice_gnss_exit(pf);
> +

An extra by mistake?

> ????????if (hw->port_info)
> ????????????????ice_sched_clear_port(hw->port_info);
> 
?
> @@ -6724,6 +6735,12 @@ static void ice_rebuild(struct ice_pf *pf,
> enum ice_reset_req reset_type)
> ????????if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
> ????????????????ice_ptp_init(pf);
> ?
> +???????if (ice_is_feature_supported(pf, ICE_F_GNSS))
> +???????????????ice_gnss_init(pf);
> +
> +???????if (ice_is_feature_supported(pf, ICE_F_GNSS))
> +???????????????ice_gnss_init(pf);
> +

An extra by mistake?

> ????????/* rebuild PF VSI */
> ????????err = ice_vsi_rebuild_by_type(pf, ICE_VSI_PF);
> ????????if (err) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index ec8450f034e6..463044ae5fcc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -3250,6 +3250,39 @@ int ice_write_sma_ctrl_e810t(struct ice_hw
> *hw, u8 data)
> ????????return status;
> ?}
> ?
> +/**
> + * ice_read_pca9575_reg_e810t
> + * @hw: pointer to the hw struct
> + * @offset: GPIO controller register offset
> + * @data: pointer to data to be read from the GPIO controller
> + *
> + * Read the register from the GPIO controller
> + */
> +int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8
> *data)
> +{
> +???????struct ice_aqc_link_topo_addr link_topo;
> +???????__le16 addr;
> +???????u16 handle;
> +???????int err;
> +
> +???????memset(&link_topo, 0, sizeof(link_topo));
> +
> +???????err = ice_get_pca9575_handle(hw, &handle);
> +???????if (err)
> +???????????????return err;
> +
> +???????link_topo.handle = cpu_to_le16(handle);
> +???????link_topo.topo_params.node_type_ctx =
> +???????????????(ICE_AQC_LINK_TOPO_NODE_CTX_PROVIDED <<
> +??????????????? ICE_AQC_LINK_TOPO_NODE_CTX_S);
> +
> +???????addr = cpu_to_le16((u16)offset);
> +
> +???????err = ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data, NULL);
> +
> +???????return err;

This can be 'return ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data,
NULL);'

