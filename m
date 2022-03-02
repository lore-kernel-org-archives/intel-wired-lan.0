From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:03:54 +0000
Subject: [Intel-wired-lan] [net-next PATCH 05/25] ice: remmove unused
 definitions from ice_sriov.h
In-Reply-To: <20220223002712.2771809-6-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-6-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629BAA5664D17AD6A187F50AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 23, 2022 1:27 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH 05/25] ice: remmove unused
> definitions from ice_sriov.h
> 
> A few more macros exist in ice_sriov.h which are not used anywhere.
> These can be safely removed. Note that ICE_VIRTCHNL_VF_CAP_L2
> capability is set but never checked anywhere in the driver. Thus it is also safe
> to remove.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 1 -
> drivers/net/ethernet/intel/ice/ice_sriov.h | 7 +------
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 8578317ceb8a..205d7e5003d8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -2012,7 +2012,6 @@ static int ice_create_vf_entries(struct ice_pf *pf,
> u16 num_vfs)
> 
>  		vf->vf_sw_id = pf->first_sw;
>  		/* assign default capabilities */
> -		set_bit(ICE_VIRTCHNL_VF_CAP_L2, &vf->vf_caps);
>  		vf->spoofchk = true;
>  		vf->num_vf_qs = pf->vfs.num_qps_per;
>  		ice_vc_set_default_allowlist(vf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h
> b/drivers/net/ethernet/intel/ice/ice_sriov.h
> index 01b6b08a73d8..525e3f0819e8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.h
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
