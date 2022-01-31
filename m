From: Ismail, Mustafa <mustafa.ismail@intel.com>
Date: Mon, 31 Jan 2022 17:08:18 +0000
Subject: [Intel-wired-lan] [PATCH for-next 1/3] net/ice: add support for
 DSCP QoS for IIDC
In-Reply-To: <20220131165921.1392-2-shiraz.saleem@intel.com>
References: <20220131165921.1392-1-shiraz.saleem@intel.com>
 <20220131165921.1392-2-shiraz.saleem@intel.com>
Message-ID: <MWHPR11MB174244E3BC0008E3921FC2B08B259@MWHPR11MB1742.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extra blank line below.

Mustafa

> -----Original Message-----
> From: Saleem, Shiraz <shiraz.saleem@intel.com>
> Sent: Monday, January 31, 2022 10:59 AM
> To: epg nat hpm dev <epg.nat.hpm.dev@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Ertman, David M <david.m.ertman@intel.com>; Saleem, Shiraz
> <shiraz.saleem@intel.com>
> Subject: [PATCH for-next 1/3] net/ice: add support for DSCP QoS for IIDC
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The ice driver provides QoS information to auxiliary drivers through the
> exported function ice_get_qos_params. This function doesn't currently
> support L3 DSCP QoS.
> 
> Add the necessary defines, structure elements and code to support DSCP
> QoS through the IIDC functions.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_idc.c | 5 +++++
>  include/linux/net/intel/iidc.h           | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c
> b/drivers/net/ethernet/intel/ice/ice_idc.c
> index fc35801..263a2e7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_idc.c
> +++ b/drivers/net/ethernet/intel/ice/ice_idc.c
> @@ -227,6 +227,11 @@ void ice_get_qos_params(struct ice_pf *pf, struct
> iidc_qos_params *qos)
> 
>  	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
>  		qos->tc_info[i].rel_bw = dcbx_cfg->etscfg.tcbwtable[i];
> +
> +	qos->pfc_mode = dcbx_cfg->pfc_mode;
> +	if (qos->pfc_mode == IIDC_DSCP_PFC_MODE)
> +		for (i = 0; i < IIDC_MAX_DSCP_MAPPING; i++)
> +			qos->dscp_map[i] = dcbx_cfg->dscp_map[i];
>  }
>  EXPORT_SYMBOL_GPL(ice_get_qos_params);
> 
> diff --git a/include/linux/net/intel/iidc.h b/include/linux/net/intel/iidc.h
> index 1289593..842ba0d 100644
> --- a/include/linux/net/intel/iidc.h
> +++ b/include/linux/net/intel/iidc.h
> @@ -32,6 +32,9 @@ enum iidc_rdma_protocol {  };
> 
>  #define IIDC_MAX_USER_PRIORITY		8
> +#define IIDC_MAX_DSCP_MAPPING          64
> +#define IIDC_VLAN_PFC_MODE             0x0
> +#define IIDC_DSCP_PFC_MODE             0x1
> 
>  /* Struct to hold per RDMA Qset info */  struct iidc_rdma_qset_params {
> @@ -60,6 +63,9 @@ struct iidc_qos_params {
>  	u8 vport_relative_bw;
>  	u8 vport_priority_type;
>  	u8 num_tc;
> +	u8 pfc_mode;
> +	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
> +
[MKI] Extra blank line 
>  };
> 
>  struct iidc_event {
> --
> 1.8.3.1

