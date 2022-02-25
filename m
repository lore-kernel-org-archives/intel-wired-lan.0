From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:24:43 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 10/11] ice: introduce VF
 accessor functions
In-Reply-To: <20220216213738.3826664-11-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-11-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56298A8E20222A49FB43B61BAB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 16, 2022 10:38 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH v2 10/11] ice: introduce VF
> accessor functions
> 
> Before we switch the VF data structure storage mechanism to a hash,
> introduce new accessor functions to define the new interface.
> 
> * ice_get_vf_by_id is a function used to obtain a reference to a VF from
>   the table based on its VF ID
> * ice_has_vfs is used to quickly check if any VFs are configured
> * ice_get_num_vfs is used to get an exact count of how many VFs are
>   configured
> 
> We can drop the old ice_validate_vf_id function, since every caller was just
> going to immediately access the VF table to get a reference anyways. This
> way we simply use the single ice_get_vf_by_id to both validate the VF ID is
> within range and that there exists a VF with that ID.
> 
> This change enables us to more easily convert the codebase to the hash table
> since most callers now properly use the interface.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |   6 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   4 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 133 +++++++++++-------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  25 ++++
>  5 files changed, 116 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 7bcba782f74c..c27013afcadb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -182,10 +182,10 @@ static void

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
