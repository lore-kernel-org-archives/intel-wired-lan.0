From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:56:27 +0000
Subject: [Intel-wired-lan] [net-next PATCH 16/25] ice: move reset
 functionality into ice_vf_lib.c
In-Reply-To: <20220223002712.2771809-17-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-17-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56299347D8DF754357E24C18AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 16/25] ice: move reset
> functionality into ice_vf_lib.c
> 
> Now that the reset functions do not rely on Single Root specific behavior,
> move the ice_reset_vf, ice_reset_all_vfs, and ice_vf_rebuild_host_cfg
> functions and their dependent helper functions out of ice_sriov.c and into
> ice_vf_lib.c
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c    | 475 ------------------
>  drivers/net/ethernet/intel/ice/ice_sriov.h    |  15 -
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 475 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  12 +
>  .../ethernet/intel/ice/ice_vf_lib_private.h   |   1 +
>  5 files changed, 488 insertions(+), 490 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index b2376e3b746e..4a8cf8f646c8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -466,37 +466,6 @@ void ice_free_vfs(struct ice_pf *pf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
