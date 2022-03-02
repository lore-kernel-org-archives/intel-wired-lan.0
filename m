From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:02:55 +0000
Subject: [Intel-wired-lan] [net-next PATCH 07/25] ice: refactor spoofchk
 control code in ice_sriov.c
In-Reply-To: <20220223002712.2771809-8-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-8-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629B5F86B4E0AC1D232851BAB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 07/25] ice: refactor spoofchk
> control code in ice_sriov.c
> 
> The API to control the VSI spoof checking for a VF VSI has three
> functions: enable, disable, and set. The set function takes the VSI and the VF
> and decides whether to call enable or disable based on the
> vf->spoofchk field.
> 
> In some flows, vf->spoofchk is not yet set, such as the function used to
> control the setting for a VF. (vf->spoofchk is only updated after a success).
> 
> Simplify this API by refactoring ice_vf_set_spoofchk_cfg to be
> "ice_vsi_apply_spoofchk" which takes the boolean and allows all callers to
> avoid having to determine whether to call enable or disable themselves.
> 
> This matches the expected callers better, and will prevent the need to
> export more than one function when this code must be called from another
> file.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7cd910bb7a7a..8d22b5d94706 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -985,16 +985,15 @@ static int ice_vsi_dis_spoofchk(struct ice_vsi *vsi)  }
> 

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
