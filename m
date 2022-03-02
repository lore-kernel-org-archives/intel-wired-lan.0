From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:47:00 +0000
Subject: [Intel-wired-lan] [net-next PATCH 18/25] ice: make
 ice_reset_all_vfs void
In-Reply-To: <20220223002712.2771809-19-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-19-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB562973AB141A7542259A7CF6AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 18/25] ice: make ice_reset_all_vfs
> void
> 
> The ice_reset_all_vfs function returns true if any VFs were reset, and false
> otherwise. However, no callers check the return value.
> 
> Drop this return value and make the function void since the callers do not
> care about this.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 8 +++-----
> drivers/net/ethernet/intel/ice/ice_vf_lib.h | 5 ++---
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index 996d84a3303d..6f9e8383c69b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
