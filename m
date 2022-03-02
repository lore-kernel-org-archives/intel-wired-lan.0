From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:03:24 +0000
Subject: [Intel-wired-lan] [net-next PATCH 06/25] ice: rename
 ICE_MAX_VF_COUNT to avoid confusion
In-Reply-To: <20220223002712.2771809-7-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-7-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56294813AD405EDA94E6F227AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 06/25] ice: rename
> ICE_MAX_VF_COUNT to avoid confusion
> 
> The ICE_MAX_VF_COUNT field is defined in ice_sriov.h. This count is true for
> SR-IOV but will not be true for all VF implementations, such as when the ice
> driver supports Scalable IOV.
> 
> Rename this definition to clearly indicate ICE_MAX_SRIOV_VFS.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c  | 2 +-
> drivers/net/ethernet/intel/ice/ice_sriov.c | 8 ++++----
> drivers/net/ethernet/intel/ice/ice_sriov.h | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 133860071174..a628fa9f1442 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3868,7 +3868,7 @@ static void ice_set_pf_caps(struct ice_pf *pf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
