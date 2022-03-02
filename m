From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:46:29 +0000
Subject: [Intel-wired-lan] [net-next PATCH 19/25] ice: convert
 ice_reset_vf to standard error codes
In-Reply-To: <20220223002712.2771809-20-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-20-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56295DE4D6BC0840CEC1B0A8AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 19/25] ice: convert ice_reset_vf
> to standard error codes
> 
> The ice_reset_vf function returns a boolean value indicating whether or not
> the VF reset. This is a bit confusing since it means that callers need to know
> how to interpret the return value when needing to indicate an error.
> 
> Refactor the function and call sites to report a regular error code. We still
> report success (i.e. return 0) in cases where the reset is in progress or is
> disabled.
> 
> Existing callers don't care because they do not check the return value.
> We keep the error code anyways instead of a void return because we expect
> future code which may care about or at least report the error value.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 15 ++++++++-------
> drivers/net/ethernet/intel/ice/ice_vf_lib.h |  6 +++---
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index 6f9e8383c69b..d37232197bde 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -446,10 +446,11 @@ void ice_reset_all_vfs(struct ice_pf *pf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
