From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:47:35 +0000
Subject: [Intel-wired-lan] [net-next PATCH 17/25] ice: drop is_vflr
 parameter from ice_reset_all_vfs
In-Reply-To: <20220223002712.2771809-18-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-18-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629BCF8504F2D6738B21B2EAB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 17/25] ice: drop is_vflr parameter
> from ice_reset_all_vfs
> 
> The ice_reset_all_vfs function takes a parameter to handle whether its
> operating after a VFLR event or not. This is not necessary as every caller
> always passes true. Simplify the interface by removing the parameter.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 5 ++---
> drivers/net/ethernet/intel/ice/ice_vf_lib.h | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index a628fa9f1442..af4befb22d0d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -768,7 +768,7 @@ static void ice_do_reset(struct ice_pf *pf, enum

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
