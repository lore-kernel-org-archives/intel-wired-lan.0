From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:45:20 +0000
Subject: [Intel-wired-lan] [net-next PATCH 22/25] ice: introduce
 ICE_VF_RESET_LOCK flag
In-Reply-To: <20220223002712.2771809-23-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-23-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629E29B74090D43C009CC41AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 22/25] ice: introduce
> ICE_VF_RESET_LOCK flag
> 
> The ice_reset_vf function performs actions which must be taken only while
> holding the VF configuration lock. Some flows already acquired the lock,
> while other flows must acquire it just for the reset function. Add the
> ICE_VF_RESET_LOCK flag to the function so that it can handle taking and
> releasing the lock instead at the appropriate scope.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   |  4 +---
>  drivers/net/ethernet/intel/ice/ice_sriov.c  | 12 +++---------
> drivers/net/ethernet/intel/ice/ice_vf_lib.c | 18 ++++++++++++++----
> drivers/net/ethernet/intel/ice/ice_vf_lib.h |  1 +
>  4 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 9d5fa9840004..4f35eb039d9f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1957,9 +1957,7 @@ static void ice_handle_mdd_event(struct ice_pf
> *pf)
>  				 * reset, so print the event prior to reset.
>  				 */
>  				ice_print_vf_rx_mdd_event(vf);
> -				mutex_lock(&vf->cfg_lock);
> -				ice_reset_vf(vf, 0);
> -				mutex_unlock(&vf->cfg_lock);
> +				ice_reset_vf(vf, ICE_VF_RESET_LOCK);
>  			}
>  		}
>  	}
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 46d656d385c4..f74474f8af99 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1366,12 +1366,9 @@ void ice_process_vflr_event(struct ice_pf *pf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
