From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:55:40 +0000
Subject: [Intel-wired-lan] [net-next PATCH 21/25] ice: introduce
 ICE_VF_RESET_NOTIFY flag
In-Reply-To: <20220223002712.2771809-22-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-22-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629BD6F16225AF3766AA517AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 21/25] ice: introduce
> ICE_VF_RESET_NOTIFY flag
> 
> In some cases of resetting a VF, the PF would like to first notify the VF that a
> reset is impending. This is currently done via ice_vc_notify_vf_reset. A
> wrapper to ice_reset_vf, ice_vf_reset_vf, is used to call this function first
> before calling ice_reset_vf.
> 
> In fact, every single call to ice_vc_notify_vf_reset occurs just prior to a call to
> ice_vc_reset_vf.
> 
> Now that ice_reset_vf has flags, replace this separate call with an
> ICE_VF_RESET_NOTIFY flag. This removes an unnecessary exported function
> of ice_vc_notify_vf_reset, and also makes there be a single function to reset
> VFs (ice_reset_vf).
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c  | 44 +++------------------
> drivers/net/ethernet/intel/ice/ice_vf_lib.c | 28 +++++++++++++
> drivers/net/ethernet/intel/ice/ice_vf_lib.h |  1 +
>  3 files changed, 34 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index c234e4edc7f0..46d656d385c4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
