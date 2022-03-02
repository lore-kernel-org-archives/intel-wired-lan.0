From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:01:50 +0000
Subject: [Intel-wired-lan] [net-next PATCH 09/25] ice: cleanup error
 logging for ice_ena_vfs
In-Reply-To: <20220223002712.2771809-10-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-10-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629E384A197A60694B64C96AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 09/25] ice: cleanup error logging
> for ice_ena_vfs
> 
> The ice_ena_vfs function and some of its sub-functions like
> ice_set_per_vf_res use a "if (<function>) { <print error> ; <exit> }"
> flow. This flow discards specialized errors reported by the called function.
> 
> This style is generally not preferred as it makes tracing error sources more
> difficult. It also means we cannot log the actual error received properly.
> 
> Refactor several calls in the ice_ena_vfs function that do this to catch the
> error in the 'ret' variable. Report this in the messages, and then return the
> more precise error value.
> 
> Doing this reveals that ice_set_per_vf_res returns -EINVAL or -EIO in places
> where -ENOSPC makes more sense. Fix these calls up to return the more
> appropriate value.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 32 +++++++++++++---------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index eebff1824be2..b695d479dfb1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1275,12 +1275,16 @@ static int ice_set_per_vf_res(struct ice_pf *pf,

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
