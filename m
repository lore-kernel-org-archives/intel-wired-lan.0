From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:45:55 +0000
Subject: [Intel-wired-lan] [net-next PATCH 20/25] ice: convert
 ice_reset_vf to take flags
In-Reply-To: <20220223002712.2771809-21-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-21-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629CC15840245A001E0D6BCAB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 20/25] ice: convert ice_reset_vf
> to take flags
> 
> The ice_reset_vf function takes a boolean parameter which indicates
> whether or not the reset is due to a VFLR event.
> 
> This is somewhat confusing to read because readers must interpret what
> "true" and "false" mean when seeing a line of code like "ice_reset_vf(vf,
> false)".
> 
> We will want to add another toggle to the ice_reset_vf in a following change.
> To avoid proliferating many arguments, convert this function to take flags
> instead. ICE_VF_RESET_VFLR will indicate if this is a VFLR reset. A value of 0
> indicates no flags.
> 
> One could argue that "ice_reset_vf(vf, 0)" is no more readable than
> "ice_reset_vf(vf, false)".. However, this type of flags interface is somewhat
> common and using 0 to mean "no flags" makes sense in this context. We
> could bother to add a define for "ICE_VF_RESET_PLAIN" or something
> similar, but this can be confusing since its not an actual bit flag.
> 
> This paves the way to add another flag to the function in a following change.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   | 2 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c  | 6 +++---
> drivers/net/ethernet/intel/ice/ice_vf_lib.c | 9 ++++++---
> drivers/net/ethernet/intel/ice/ice_vf_lib.h | 9 +++++++--
>  4 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index af4befb22d0d..9d5fa9840004 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
