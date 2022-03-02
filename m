From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:01:21 +0000
Subject: [Intel-wired-lan] [net-next PATCH 11/25] ice: use
 ice_is_vf_trusted helper function
In-Reply-To: <20220223002712.2771809-12-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-12-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629C7A8756E8EE25A7858A9AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 11/25] ice: use ice_is_vf_trusted
> helper function
> 
> The ice_vc_cfg_promiscuous_mode_msg function directly checks
> ICE_VIRTCHNL_VF_CAP_PRIVILEGE, instead of using the existing helper
> function ice_is_vf_trusted. Switch this to use the helper function so that all
> trusted checks are consistent. This aids in any potential future refactor by
> ensuring consistent code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index d41fce16ddfb..432841ab4352 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -3148,6 +3148,15 @@ int ice_set_vf_spoofchk(struct net_device

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
