From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 16 Apr 2021 12:27:17 +0000
Subject: [Intel-wired-lan] [PATCH S55 13/14] ice: Advertise virtchnl UDP
 segmentation offload capability
In-Reply-To: <20210302181213.51718-13-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
 <20210302181213.51718-13-anthony.l.nguyen@intel.com>
Message-ID: <CY4PR11MB15769D5E52551F641BA8669EAB4C9@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: wtorek, 2 marca 2021 19:12
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S55 13/14] ice: Advertise virtchnl UDP
> segmentation offload capability
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> As the hardware is capable of supporting UDP segmentation offload, add a
> capability bit to virtchnl.h to communicate this and have the driver advertise
> its support.
> 
> Suggested-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 +++
>  include/linux/avf/virtchnl.h                     | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index f09367eb242a..43d309aa9efe 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -2126,6 +2126,9 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf,
> u8 *msg)
>  	if (vf->driver_caps & VIRTCHNL_VF_CAP_ADV_LINK_SPEED)
>  		vfres->vf_cap_flags |=
> VIRTCHNL_VF_CAP_ADV_LINK_SPEED;
> 
> +	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_USO)
> +		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_USO;
> +
>  	vfres->num_vsis = 1;
>  	/* Tx and Rx queue are equal for VF */
>  	vfres->num_queue_pairs = vsi->num_txq; diff --git
> a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h index
> 228b90ef3361..ddcff6219b61 100644
> --- a/include/linux/avf/virtchnl.h
> +++ b/include/linux/avf/virtchnl.h
> @@ -252,6 +252,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16,
> virtchnl_vsi_resource);
>  #define VIRTCHNL_VF_OFFLOAD_RX_ENCAP_CSUM	0X00400000
>  #define VIRTCHNL_VF_OFFLOAD_ADQ			0X00800000
>  #define VIRTCHNL_VF_OFFLOAD_FDIR_PF		0X10000000
> +#define VIRTCHNL_VF_OFFLOAD_USO			0X02000000
> 
>  /* Define below the capability flags that are not offloads */
>  #define VIRTCHNL_VF_CAP_ADV_LINK_SPEED		0x00000080
> --
> 2.20.1
> 
Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
